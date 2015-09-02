open Mach.Exports
open B2J_Json

(*
(* "If the flags is EXPORT_SYMBOL_FLAGS_STUB_AND_RESOLVER, then following the flags is two uleb128s: the stub offset and the resolver offset. The stub is used by non-lazy pointers.  The resolver is used by lazy pointers and must be called to get the actual address to use." *)
type stub_symbol_info = {stub_offset: int; resolver_offset: int; flags: int}

(* if lib_symbol_name None then same symbol name, otherwise reexport of lib_symbol_name with name in the trie *)
(* "If the string is zero length, then the symbol is re-export from the specified dylib with the same name" *)
type reexport_symbol_info =
  {lib: string; lib_symbol_name: string option; flags: int}
type regular_symbol_info = {address: int; flags: int}

type export_info = 
  | Regular of regular_symbol_info
  | Reexport of reexport_symbol_info
  | Stub of stub_symbol_info

type export =
  {
    info: export_info;
    name: string;
    size: int;
    offset: int;
  }
 *)

let export_info_to_json (ei:Mach.Exports.export_info) =
  let info = match ei with
    | Regular sym ->
      [
        (* "_kind", `String (get_symbol_kind sym.flags |> Mach.Exports.symbol_kind_to_string); *)
        "_type", `String "regular";
        "address", to_hex sym.address;
        "flags", to_hex sym.flags
      ]
    | Reexport sym ->
      let libSymbolName = match sym.lib_symbol_name with
        | Some s -> s
        | None -> ""
      in
      [
        "_type", `String "reexport";
        "lib", `String sym.lib;
        "libSymbolName", `String libSymbolName;
        "flags", to_hex sym.flags
      ]
    | Stub sym ->
      [
        "_type", `String "stubAndResolver";
        "stubOffset", to_hex sym.stub_offset;
        "resolverOffset", to_hex sym.resolver_offset;
        "flags", to_hex sym.flags
      ]
  in `O info

let export_to_json (e:Mach.Exports.export) =
  `O [
    "info" , export_info_to_json e.info;
    "name", `String e.name;
    "_offset", to_hex e.offset;
    "_size", to_hex e.size;
    (*     "_string", `String (Mach.Exports.export_to_string e) *)
  ]

let to_json exports =
  let meta = 
    [
      ("computedPrefix", `String "_")
    ] 
  in
  let json = List.map export_to_json exports in
  `O [
    "value", `A json;
    "meta", `O meta;
  ]

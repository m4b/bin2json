open Mach.Imports
open B2J_Json

(* 
type bind_information = {
  seg_index: int;
  seg_offset: int;
  bind_type: int;
  symbol_library_ordinal: int;
  symbol_name: string;
  symbol_flags: int;
  addend: int;
  special_dylib: int; (* seeing self = 0 assuming this means the symbol is imported from itself, because its... libSystem.B.dylib? *)
}

type import = {
  bi: bind_information;
  dylib: string;
  is_lazy: bool;
  offset: int;
  size: int;
}
*)

let bind_information_to_json bi =
  `O [
    "segIndex", to_hex bi.seg_index;
    "segOffset", to_hex bi.seg_offset;
    "bindType", to_hex bi.bind_type;
    "symbolLibraryOrdinal", to_hex bi.symbol_library_ordinal;
    "symbolName", `String bi.symbol_name;
    "symbolFlags", to_hex bi.symbol_flags;
    "addend", to_hex bi.addend;
    "_specialDylib", to_hex bi.special_dylib;
  ]

let import_to_json i =
  `O [
    "bindInformation" , bind_information_to_json i.bi;
    "_dylib", `String i.dylib;
    "_is_lazy", `Bool i.is_lazy;
    "_offset", to_hex i.offset;
    "_name", `String i.bi.symbol_name;
    "size", to_hex i.size
  ]

let to_json imports =
  let meta =
    [
      ("computedPrefix", `String "_")
    ] 
  in
  let json = List.map import_to_json imports in
  `O [
    "value", `A json;
    "meta", `O meta;
  ]


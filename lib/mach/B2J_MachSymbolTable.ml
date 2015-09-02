open Mach.SymbolTable
open B2J_Json

(*
type nlist = {
  n_strx: int; (* 4 *)
  n_type: int; (* 1 *)
  n_sect: int; (* 1 *)
  n_desc: int; (* 2 *)
  n_value: int; (* 8 *)
}
*)

let nlist_to_json (nlist,name) =
  `O [
    "n_strx", to_hex nlist.n_strx;
    "n_type", to_hex nlist.n_type;
    "n_sect", to_hex nlist.n_sect;
    "n_desc", to_hex nlist.n_desc;
    "n_value", to_hex nlist.n_value;
    "_name", `String name;
    "_type", `String (n_type_to_string nlist.n_type);
  ]

let to_json imports =
  let meta =
    [
      "bytes", to_byte_array [
        4; 1; 1; 2; 8
      ];
      "prefix", `String "n_";
      "computedPrefix", `String "_";
    ] 
  in
  let json = List.map nlist_to_json imports in
  `O [
    "value", `A json;
    "meta", `O meta;
  ]


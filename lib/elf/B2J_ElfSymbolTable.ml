open Elf.SymbolTable
open B2J_Json

let sym2json sym = 
  `O [
    "st_name" , to_hex sym.st_name;
    "st_info" , to_hex sym.st_info;
    "st_other" , to_hex sym.st_other;
    "st_shndx" , to_hex sym.st_shndx;
    "st_value" , to_hex sym.st_value;
    "st_size" , to_hex sym.st_size;
    "name", `String (sym.name);
    "visibility", `String (get_visibility sym.st_other
                           |> symbol_visibility_to_string);
    "bind", `String (get_bind sym.st_info 
                     |> symbol_bind_to_string);
    "type", `String (get_type sym.st_info
                     |> symbol_type_to_string);
  ]

let to_json syms = 
  let json = List.map sym2json syms in
  let meta = 
    [
      "bytes", to_byte_array [4; 1; 1; 2; 8; 8;];
      "prefix", `String "st_";
    ] in
  `O [
    "value",`A json;
    "meta", `O meta;
  ]


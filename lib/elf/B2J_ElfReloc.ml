open Elf.Reloc
open B2J_Json

let rela2json rela = 
  `O [
    "r_offset" , to_hex rela.r_offset;
    "r_info" , to_hex rela.r_info;
    "r_addend" , to_hex rela.r_addend;
    "index", to_hex rela.symindex;
    "type", to_hex rela.symtype;
  ]

let to_json relocs = 
  let json = List.map rela2json relocs in
  let meta = 
    [
      "bytes", to_byte_array [8; 8; 8;];
      "prefix", `String "r_";
    ] in
  `O [
    "value",`A json;
    "meta", `O meta;
  ]


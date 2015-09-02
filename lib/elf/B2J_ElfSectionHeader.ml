open Elf.SectionHeader
open B2J_Json

let section_header2json sh =
  `O [
    "sh_type" , to_hex sh.sh_type;
    "sh_flags", to_hex sh.sh_flags;
    "sh_addr", to_hex sh.sh_addr;
    "sh_offset", to_hex sh.sh_offset;
    "sh_size", to_hex sh.sh_size;
    "sh_link", to_hex sh.sh_link;
    "sh_info", to_hex sh.sh_info;
    "sh_addralign", to_hex sh.sh_addralign;
    "sh_entsize", to_hex sh.sh_entsize;
    "name", `String sh.name;
    "type", `String (shtype_to_string sh.sh_type);
  ]

let to_json shs = 
  let json = Array.map section_header2json shs |> Array.to_list in
  let meta = 
    [
      "bytes", to_byte_array [4; 4; 8; 8; 8; 8; 4; 4; 8; 8;];
      "prefix", `String "sh_";
    ] in
  `O [
    "value",`A json;
    "meta", `O meta;
  ]


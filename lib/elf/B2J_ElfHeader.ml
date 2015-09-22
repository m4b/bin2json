open Elf.Header
open B2J_Json

let ident2json ident =
  let json = 
    [
      "ei_magic", to_hex ident.ei_magic;
      "ei_class", to_hex ident.ei_class;
      "ei_data", to_hex ident.ei_data;
      "ei_version", to_hex ident.ei_version;
      "ei_osabi", to_hex ident.ei_osabi;
      "ei_abiversion", to_hex ident.ei_abiversion;
      "ei_pad", to_hex ident.ei_pad;
    ] in
  `O json

let to_json header = 
  let ident = "e_ident", ident2json header.e_ident in
  let meta = 
    [
      "bytes", to_byte_array
        [16; 2; 2; 4; 8; 8;
         8; 4; 2; 2; 2; 2; 2; 2;];
      "prefix", `String "e_";
      "computedPrefix", `String "_";
    ] in
  let json =
    [
      ident;
      "e_type" , to_hex header.e_type;
      "e_machine", to_hex header.e_machine;
      "e_version", to_hex header.e_version;
      "e_entry", to_hex header.e_entry;
      "e_phoff", to_hex header.e_phoff;
      "e_shoff", to_hex header.e_shoff;
      "e_flags", to_hex header.e_flags;
      "e_ehsize", to_hex header.e_ehsize;
      "e_phentsize", to_hex header.e_phentsize;
      "e_phnum", to_hex header.e_phnum;
      "e_shentsize", to_hex header.e_shentsize;
      "e_shnum", to_hex header.e_shnum;
      "e_shstrndx", to_hex header.e_shstrndx;
      "_type", `String (Elf.Constants.etype_to_string header.e_type);
    ] in
  `O [
    "value", `O json;
    "meta", `O meta;
  ]

open PE.SectionTable
open B2J_Json

let section_table_to_json (x:section_table) =
  `O
    [
      ("name", (`String x.name));
      ("virtualSize", (to_hex x.virtual_size));
      ("virtualAddress", (to_hex x.virtual_address));
      ("sizeOfRawData", (to_hex x.size_of_raw_data));
      ("pointerToRawData", (to_hex x.pointer_to_raw_data));
      ("pointerToRelocations", (to_hex x.pointer_to_relocations));
      ("pointerToLinenumbers", (to_hex x.pointer_to_linenumbers));
      ("numberOfRelocations", (to_hex x.number_of_relocations));
      ("numberOfLinenumbers", (to_hex x.number_of_linenumbers));
      ("characteristics", (to_hex x.characteristics));
    ]

let to_json section_tables =
  let meta =
    [
      "size", to_number sizeof_section_table;
      "bytes", to_byte_array [8; 4; 4; 4; 4; 4; 4; 2; 2; 4];
    ]
  in
  let json =
    List.map section_table_to_json section_tables
  in
  `O [
    "value", `A json;
    "meta", `O meta;
  ]

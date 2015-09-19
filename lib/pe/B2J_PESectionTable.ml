open PE.SectionTable
open B2J_Json

let count = 1

let section_table_to_json (x:section_table) = 
  `O[
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

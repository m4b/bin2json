open PE.Import
open B2J_Json

let hint_name_table_entry_to_json (x:hint_name_table_entry) = 
  `O[
    ("hint", (to_hex x.hint));
    ("name", (`String x.name));
  ]

let synthetic_import_lookup_table_entry_to_json x =
  match x with
  | OrdinalNumber ordinal ->
    `O [
      ("ordinalNumber", to_hex ordinal);
    ]
  | HintNameTableRVA (rva, entry) ->
    `O [
      ("hintNameTableRVA", `O [("rva", to_hex rva); ("hint", hint_name_table_entry_to_json entry)])
    ]

let import_lookup_table_entry_to_json (x:import_lookup_table_entry) = 
  `O[
    ("bitfield", (to_hex x.bitfield));
    ("_synthetic", (synthetic_import_lookup_table_entry_to_json x._synthetic));
  ]

let import_lookup_table_to_json list = `A (List.map import_lookup_table_entry_to_json list)

let import_directory_entry_to_json (x:import_directory_entry) = 
  `O[
    ("importLookupTableRva", (to_hex x.import_lookup_table_rva));
    ("timeDateStamp", (to_hex x.time_date_stamp));
    ("forwarderChain", (to_hex x.forwarder_chain));
    ("nameRva", (to_hex x.name_rva));
    ("importAddressTableRva", (to_hex x.import_address_table_rva));
  ]

let synthetic_import_directory_entry_to_json (x:synthetic_import_directory_entry) = 
  `O[
    ("importDirectoryEntry", (import_directory_entry_to_json x.import_directory_entry));
  ]

let import_directory_table_to_json list = `A (List.map synthetic_import_directory_entry_to_json list)

let import_data_to_json = import_directory_table_to_json

let import_address_table_to_json list = `A (List.map to_hex list)

let synthetic_import_to_json (x:synthetic_import) = 
  `O[
    ("name", (`String x.name));
    ("dll", (`String x.dll));
    ("ordinal", (to_hex x.ordinal));
    ("offset", (to_hex x.offset));
    ("size", (to_hex x.size));
  ]

let to_json t =
  let meta =
    [
      ("computedPrefix", `String "")
    ]
  in
  let json = List.map synthetic_import_to_json t
  in
    `O [
    "meta", `O meta;
    "value", `A json;
  ]

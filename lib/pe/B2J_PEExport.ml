open PE.Export
open B2J_Json

let export_directory_table_to_json (x:export_directory_table) = 
  `O[
    ("exportFlags", (to_hex x.export_flags));
    ("timeDateStamp", (to_hex x.time_date_stamp));
    ("majorVersion", (to_hex x.major_version));
    ("minorVersion", (to_hex x.minor_version));
    ("nameRva", (to_hex x.name_rva));
    ("ordinalBase", (to_hex x.ordinal_base));
    ("addressTableEntries", (to_hex x.address_table_entries));
    ("numberOfNamePointers", (to_hex x.number_of_name_pointers));
    ("exportAddressTableRva", (to_hex x.export_address_table_rva));
    ("namePointerRva", (to_hex x.name_pointer_rva));
    ("ordinalTableRva", (to_hex x.ordinal_table_rva));
    ]

let export_address_table_entry_to_json x :B2J_Json.t =
    match x with
    | ExportRVA rva ->
      to_hex rva
    | ForwarderRVA rva ->
      to_hex rva

let export_address_table_to_json list :B2J_Json.t =
  `A (List.map export_address_table_entry_to_json list)

let export_name_pointer_table_to_json list :B2J_Json.t =
  `A (List.map to_hex list)

let export_ordinal_table_to_json list :B2J_Json.t =
  `A (List.map to_hex list)

let export_data_to_json (x:export_data) = 
  `O[
    ("exportDirectoryTable", (export_directory_table_to_json x.export_directory_table));
    ("exportNamePointerTable", (export_name_pointer_table_to_json x.export_name_pointer_table));
    ("exportOrdinalTable", (export_ordinal_table_to_json x.export_ordinal_table));
    ("exportAddressTable", (export_address_table_to_json x.export_address_table));
    ("name", (`String x.name));
    ]

let reexport_to_json x =
  let ppf = Format.str_formatter in
  let str = 
    begin
      match x with
      | DLLName (lib,name) ->
        Format.fprintf ppf "@[<h 2>%s.%s@]" lib name
      | DLLOrdinal (lib,ord) ->
        Format.fprintf ppf "@[<h 2>%s[%d]@]" lib ord
    end ; Format.flush_str_formatter()
  in
  `String str

let synthetic_export_to_json (x:synthetic_export) =
  let reexport =
    match x.reexport with
    | Some reexport ->
      reexport_to_json reexport
    | None ->
      `Null
  in
  `O[
    ("name", (`String x.name));
    ("offset", (to_hex x.offset));
    ("size", (to_hex x.size));
    ("reexport", reexport);
    ]

let to_json exports :B2J_Json.t = `A (List.map synthetic_export_to_json exports) 

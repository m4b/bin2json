open PE.Header
open B2J_Json

let count = 5

let dos_header_to_json (x:dos_header) = 
  `O[
    ("signature", (to_hex x.signature));
    ("pePointer", (to_hex x.pe_pointer));
  ]


let coff_header_to_json (x:coff_header) = 
  `O[
    ("signature", (to_hex x.signature));
    ("machine", (to_hex x.machine));
    ("numberOfSections", (to_hex x.number_of_sections));
    ("timeDateStamp", (to_hex x.time_date_stamp));
    ("pointerToSymbolTable", (to_hex x.pointer_to_symbol_table));
    ("numberOfSymbolTable", (to_hex x.number_of_symbol_table));
    ("sizeOfOptionalHeader", (to_hex x.size_of_optional_header));
    ("characteristics", (to_hex x.characteristics));
  ]

let standard_fields_to_json (x:standard_fields) = 
  `O[
    ("magic", (to_hex x.magic));
    ("majorLinkerVersion", (to_hex x.major_linker_version));
    ("minorLinkerVersion", (to_hex x.minor_linker_version));
    ("sizeOfCode", (to_hex x.size_of_code));
    ("sizeOfInitializedData", (to_hex x.size_of_initialized_data));
    ("sizeOfUninitializedData", (to_hex x.size_of_uninitialized_data));
    ("addressOfEntryPoint", (to_hex x.address_of_entry_point));
    ("baseOfCode", (to_hex x.base_of_code));
    ("baseOfData", (to_hex x.base_of_data));
  ]


let windows_fields_to_json (x:windows_fields) = 
  `O[
    ("imageBase", (to_hex x.image_base));
    ("sectionAlignment", (to_hex x.section_alignment));
    ("fileAlignment", (to_hex x.file_alignment));
    ("majorOperatingSystemVersion", (to_hex x.major_operating_system_version));
    ("minorOperatingSystemVersion", (to_hex x.minor_operating_system_version));
    ("majorImageVersion", (to_hex x.major_image_version));
    ("minorImageVersion", (to_hex x.minor_image_version));
    ("majorSubsystemVersion", (to_hex x.major_subsystem_version));
    ("minorSubsystemVersion", (to_hex x.minor_subsystem_version));
    ("win32VersionValue", (to_hex x.win32_version_value));
    ("sizeOfImage", (to_hex x.size_of_image));
    ("sizeOfHeaders", (to_hex x.size_of_headers));
    ("checkSum", (to_hex x.check_sum));
    ("subsystem", (to_hex x.subsystem));
    ("dllCharacteristics", (to_hex x.dll_characteristics));
    ("sizeOfStackReserve", (to_hex x.size_of_stack_reserve));
    ("sizeOfStackCommit", (to_hex x.size_of_stack_commit));
    ("sizeOfHeapReserve", (to_hex x.size_of_heap_reserve));
    ("sizeOfHeapCommit", (to_hex x.size_of_heap_commit));
    ("loaderFlags", (to_hex x.loader_flags));
    ("numberOfRvaAndSizes", (to_hex x.number_of_rva_and_sizes));
  ]

let data_directories_to_json (x:data_directories) = 
  `O[
    ("exportTable", (to_hex x.export_table));
    ("sizeOfExportTable", (to_hex x.size_of_export_table));
    ("importTable", (to_hex x.import_table));
    ("sizeOfImportTable", (to_hex x.size_of_import_table));
    ("resourceTable", (to_hex x.resource_table));
    ("sizeOfResourceTable", (to_hex x.size_of_resource_table));
    ("exceptionTable", (to_hex x.exception_table));
    ("sizeOfExceptionTable", (to_hex x.size_of_exception_table));
    ("certificateTable", (to_hex x.certificate_table));
    ("sizeOfCertificateTable", (to_hex x.size_of_certificate_table));
    ("baseRelocationTable", (to_hex x.base_relocation_table));
    ("sizeOfBaseRelocationTable", (to_hex x.size_of_base_relocation_table));
    ("debug", (to_hex x.debug));
    ("sizeOfDebug", (to_hex x.size_of_debug));
    ("architecture", (to_hex x.architecture));
    ("sizeOfArchitecture", (to_hex x.size_of_architecture));
    ("globalPtr", (to_hex x.global_ptr));
    ("sizeOfGlobalPtr", (to_hex x.size_of_global_ptr));
    ("tlsTable", (to_hex x.tls_table));
    ("sizeOfTlsTable", (to_hex x.size_of_tls_table));
    ("loadConfigTable", (to_hex x.load_config_table));
    ("sizeOfLoadConfigTable", (to_hex x.size_of_load_config_table));
    ("boundImport", (to_hex x.bound_import));
    ("sizeOfBoundImport", (to_hex x.size_of_bound_import));
    ("importAddressTable", (to_hex x.import_address_table));
    ("sizeOfImportAddressTable", (to_hex x.size_of_import_address_table));
    ("delayImportDescriptor", (to_hex x.delay_import_descriptor));
    ("sizeOfDelayImportDescriptor", (to_hex x.size_of_delay_import_descriptor));
    ("clrRuntimeHeader", (to_hex x.clr_runtime_header));
    ("sizeOfClrRuntimeHeader", (to_hex x.size_of_clr_runtime_header));
    ("reserved", (to_hex x.reserved));
  ]

let optional_header_to_json (x:optional_header) = 
  `O[
    ("standardFields", (standard_fields_to_json x.standard_fields));
    ("windowsFields", (windows_fields_to_json x.windows_fields));
    ("dataDirectories", (data_directories_to_json x.data_directories));
  ]

let to_json (x:PE.Header.t) =
  let meta =
    [
      "coffHeader", 
      `O [
        "size", to_number sizeof_coff_header;
        "bytes", to_byte_array
          [4; 2; 2; 4; 4; 4; 2; 2;];
      ];
      "standardFields",
      `O [
        "size", to_number sizeof_standard_fields;
        "bytes", to_byte_array
          [2; 1; 1; 4; 4; 4; 4; 4; 4;];
      ];
      "windowsFields",
      `O [
        "size", to_number sizeof_windows_fields;
        "bytes", to_byte_array
          [4; 4; 4; 2; 2; 2; 2; 2; 2; 4; 4; 
           4; 4; 2; 2; 4; 4; 4; 4; 4; 4;];
      ];
      "dataDirectory", `O [
        "size", to_number 8;
        "bytes", to_byte_array [4; 4]
      ];
      "computedPrefix", `String "_"
    ] in
  let optional_header =
    match x.optional_header with
    | Some optional_header ->
      optional_header_to_json optional_header
    | None ->
      `Null
  in
  let json = [
    ("dosHeader", (dos_header_to_json x.dos_header));
    ("coffHeader", (coff_header_to_json x.coff_header));
    ("optionalHeader", optional_header);
    "_type", `String 
      (PE.Characteristic.show_type x.coff_header.characteristics);
  ]
  in
  `O [
    "value", `O json;
    "meta", `O meta;
  ]

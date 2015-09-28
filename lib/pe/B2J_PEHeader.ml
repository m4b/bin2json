open PE.Header
open PE.OptionalHeader
open PE.DataDirectories
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

let _dd = [
    ("exportTable","sizeOfExportTable");
    ("importTable","sizeOfImportTable");
    ("resourceTable","sizeOfResourceTable");
    ("exceptionTable","sizeOfExceptionTable");
    ("certificateTable","sizeOfCertificateTable");
    ("baseRelocationTable","sizeOfBaseRelocationTable");
    ("debug","sizeOfDebug");
    ("architecture","sizeOfArchitecture");
    ("globalPtr","sizeOfGlobalPtr");
    ("tlsTable","sizeOfTlsTable");
    ("loadConfigTable","sizeOfLoadConfigTable");
    ("boundImport","sizeOfBoundImport");
    ("importAddressTable","sizeOfImportAddressTable");
    ("delayImportDescriptor","sizeOfDelayImportDescriptor");
    ("clrRuntimeHeader","sizeOfClrRuntimeHeader");
    ("reserved","sizeOfReserved");
  ]

let data_directories_to_json (x:PE.DataDirectories.t) =
  `O ((List.mapi
         (fun i dd ->
          Printf.printf "%d\n" i;
          let va,sz = List.nth _dd i in
          [(va, to_hex dd.virtual_address);(sz, to_hex dd.size)])
         x) |> List.flatten)

let optional_header_to_json (x:PEOptionalHeader.t) =
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
      "_type",
      `String
       (PE.Characteristic.show_type x.coff_header.characteristics);
    ]
  in
  `O [
     "value", `O json;
     "meta", `O meta;
   ]

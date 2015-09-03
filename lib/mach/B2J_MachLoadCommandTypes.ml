open Mach.LoadCommand.Types
open B2J_Json

let lc_count = 43

let load_command_to_json (lc:load_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ]


let lc_str_to_json (lc:lc_str) = 
  `O[
    ("offset", (to_hex lc.offset));
    ("_str", (`String lc.str));
    ]


let section_to_json (lc:section) = 
  `O[
    ("sectname", (`String lc.sectname));
    ("segname", (`String lc.segname));
    ("addr", (to_hex lc.addr));
    ("size", (to_hex lc.size));
    ("offset", (to_hex lc.offset));
    ("align", (to_hex lc.align));
    ("reloff", (to_hex lc.reloff));
    ("nreloc", (to_hex lc.nreloc));
    ("flags", (to_hex lc.flags));
    ("reserved1", (to_hex lc.reserved1));
    ("reserved2", (to_hex lc.reserved2));
    ]


let section_64_to_json (lc:section_64) = 
  `O[
    ("sectname", (`String lc.sectname));
    ("segname", (`String lc.segname));
    ("addr", (to_hex lc.addr));
    ("size", (to_hex lc.size));
    ("offset", (to_hex lc.offset));
    ("align", (to_hex lc.align));
    ("reloff", (to_hex lc.reloff));
    ("nreloc", (to_hex lc.nreloc));
    ("flags", (to_hex lc.flags));
    ("reserved1", (to_hex lc.reserved1));
    ("reserved2", (to_hex lc.reserved2));
    ("reserved3", (to_hex lc.reserved3));
    ]


let segment_command_to_json (lc:segment_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("segname", (`String lc.segname));
    ("vmaddr", (to_hex lc.vmaddr));
    ("vmsize", (to_hex lc.vmsize));
    ("fileoff", (to_hex lc.fileoff));
    ("filesize", (to_hex lc.filesize));
    ("maxprot", (to_hex lc.maxprot));
    ("initprot", (to_hex lc.initprot));
    ("nsects", (to_hex lc.nsects));
    ("flags", (to_hex lc.flags));
    ("sections", (`A (List.map section_to_json lc.sections)));
    ]


let segment_command_64_to_json (lc:segment_command_64) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("segname", (`String lc.segname));
    ("vmaddr", (to_hex lc.vmaddr));
    ("vmsize", (to_hex lc.vmsize));
    ("fileoff", (to_hex lc.fileoff));
    ("filesize", (to_hex lc.filesize));
    ("maxprot", (to_hex lc.maxprot));
    ("initprot", (to_hex lc.initprot));
    ("nsects", (to_hex lc.nsects));
    ("flags", (to_hex lc.flags));
    ("sections", (`A (List.map section_64_to_json lc.sections)));
    ]


let fvmlib_to_json (lc:fvmlib) = 
  `O[
    ("name", (lc_str_to_json lc.name));
    ("minorVersion", (to_hex lc.minor_version));
    ("headerAddr", (to_hex lc.header_addr));
    ]


let fvmlib_command_to_json (lc:fvmlib_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("fvmlib", (fvmlib_to_json lc.fvmlib));
    ]


let dylib_to_json (lc:dylib) = 
  `O[
    ("name", (lc_str_to_json lc.name));
    ("timestamp", (to_hex lc.timestamp));
    ("currentVersion", (to_hex lc.current_version));
    ("compatibilityVersion", (to_hex lc.compatibility_version));
    ]


let dylib_command_to_json (lc:dylib_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("dylib", (dylib_to_json lc.dylib));
    ]


let sub_framework_command_to_json (lc:sub_framework_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("umbrella", (lc_str_to_json lc.umbrella));
    ]


let sub_client_command_to_json (lc:sub_client_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("client", (lc_str_to_json lc.client));
    ]


let sub_umbrella_command_to_json (lc:sub_umbrella_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("subUmbrella", (lc_str_to_json lc.sub_umbrella));
    ]


let sub_library_command_to_json (lc:sub_library_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("subLibrary", (lc_str_to_json lc.sub_library));
    ]


let prebound_dylib_command_to_json (lc:prebound_dylib_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("name", (lc_str_to_json lc.name));
    ("nmodules", (to_hex lc.nmodules));
    ("linkedModules", (lc_str_to_json lc.linked_modules));
    ]


let dylinker_command_to_json (lc:dylinker_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("name", (lc_str_to_json lc.name));
    ]


let thread_command_to_json (lc:thread_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ]


let routines_command_to_json (lc:routines_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("initAddress", (to_hex lc.init_address));
    ("initModule", (to_hex lc.init_module));
    ("reserved1", (to_hex lc.reserved1));
    ("reserved2", (to_hex lc.reserved2));
    ("reserved3", (to_hex lc.reserved3));
    ("reserved4", (to_hex lc.reserved4));
    ("reserved5", (to_hex lc.reserved5));
    ("reserved6", (to_hex lc.reserved6));
    ]


let routines_command_64_to_json (lc:routines_command_64) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("initAddress", (to_hex lc.init_address));
    ("initModule", (to_hex lc.init_module));
    ("reserved1", (to_hex lc.reserved1));
    ("reserved2", (to_hex lc.reserved2));
    ("reserved3", (to_hex lc.reserved3));
    ("reserved4", (to_hex lc.reserved4));
    ("reserved5", (to_hex lc.reserved5));
    ("reserved6", (to_hex lc.reserved6));
    ]


let symtab_command_to_json (lc:symtab_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("symoff", (to_hex lc.symoff));
    ("nsyms", (to_hex lc.nsyms));
    ("stroff", (to_hex lc.stroff));
    ("strsize", (to_hex lc.strsize));
    ]


let dysymtab_command_to_json (lc:dysymtab_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("ilocalsym", (to_hex lc.ilocalsym));
    ("nlocalsym", (to_hex lc.nlocalsym));
    ("iextdefsym", (to_hex lc.iextdefsym));
    ("nextdefsym", (to_hex lc.nextdefsym));
    ("iundefsym", (to_hex lc.iundefsym));
    ("nundefsym", (to_hex lc.nundefsym));
    ("tocoff", (to_hex lc.tocoff));
    ("ntoc", (to_hex lc.ntoc));
    ("modtaboff", (to_hex lc.modtaboff));
    ("nmodtab", (to_hex lc.nmodtab));
    ("extrefsymoff", (to_hex lc.extrefsymoff));
    ("nextrefsyms", (to_hex lc.nextrefsyms));
    ("indirectsymoff", (to_hex lc.indirectsymoff));
    ("nindirectsyms", (to_hex lc.nindirectsyms));
    ("extreloff", (to_hex lc.extreloff));
    ("nextrel", (to_hex lc.nextrel));
    ("locreloff", (to_hex lc.locreloff));
    ("nlocrel", (to_hex lc.nlocrel));
    ]


let dylib_table_of_contents_to_json (lc:dylib_table_of_contents) = 
  `O[
    ("symbolIndex", (to_hex lc.symbol_index));
    ("moduleIndex", (to_hex lc.module_index));
    ]


let dylib_module_to_json (lc:dylib_module) = 
  `O[
    ("moduleName", (to_hex lc.module_name));
    ("iextdefsym", (to_hex lc.iextdefsym));
    ("nextdefsym", (to_hex lc.nextdefsym));
    ("irefsym", (to_hex lc.irefsym));
    ("nrefsym", (to_hex lc.nrefsym));
    ("ilocalsym", (to_hex lc.ilocalsym));
    ("nlocalsym", (to_hex lc.nlocalsym));
    ("iextrel", (to_hex lc.iextrel));
    ("nextrel", (to_hex lc.nextrel));
    ("iinitIterm", (to_hex lc.iinit_iterm));
    ("ninitNterm", (to_hex lc.ninit_nterm));
    ("objcModuleInfoAddr", (to_hex lc.objc_module_info_addr));
    ("objcModuleInfoSize", (to_hex lc.objc_module_info_size));
    ]


let dylib_module_64_to_json (lc:dylib_module_64) = 
  `O[
    ("moduleName", (to_hex lc.module_name));
    ("iextdefsym", (to_hex lc.iextdefsym));
    ("nextdefsym", (to_hex lc.nextdefsym));
    ("irefsym", (to_hex lc.irefsym));
    ("nrefsym", (to_hex lc.nrefsym));
    ("ilocalsym", (to_hex lc.ilocalsym));
    ("nlocalsym", (to_hex lc.nlocalsym));
    ("iextrel", (to_hex lc.iextrel));
    ("nextrel", (to_hex lc.nextrel));
    ("iinitIterm", (to_hex lc.iinit_iterm));
    ("ninitNterm", (to_hex lc.ninit_nterm));
    ("objcModuleInfoSize", (to_hex lc.objc_module_info_size));
    ("objcModuleInfoAddr", (to_hex lc.objc_module_info_addr));
    ]


let dylib_reference_to_json (lc:dylib_reference) = 
  `O[
    ("isym", (to_hex lc.isym));
    ("flags", (to_hex lc.flags));
    ]


let twolevel_hints_command_to_json (lc:twolevel_hints_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("offset", (to_hex lc.offset));
    ("nhints", (to_hex lc.nhints));
    ]


let twolevel_hint_to_json (lc:twolevel_hint) = 
  `O[
    ("isubImage", (to_hex lc.isub_image));
    ("itoc", (to_hex lc.itoc));
    ]


let prebind_cksum_command_to_json (lc:prebind_cksum_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("cksum", (to_hex lc.cksum));
    ]


let uuid_command_to_json (lc:uuid_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("uuid", (`String lc.uuid));
    ]


let rpath_command_to_json (lc:rpath_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("path", (lc_str_to_json lc.path));
    ]


let linkedit_data_command_to_json (lc:linkedit_data_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("dataoff", (to_hex lc.dataoff));
    ("datasize", (to_hex lc.datasize));
    ]


let encryption_info_command_to_json (lc:encryption_info_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("cryptoff", (to_hex lc.cryptoff));
    ("cryptsize", (to_hex lc.cryptsize));
    ("cryptid", (to_hex lc.cryptid));
    ]


let encryption_info_command_64_to_json (lc:encryption_info_command_64) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("cryptoff", (to_hex lc.cryptoff));
    ("cryptsize", (to_hex lc.cryptsize));
    ("cryptid", (to_hex lc.cryptid));
    ("pad", (to_hex lc.pad));
    ]


let version_min_command_to_json (lc:version_min_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("version", (to_hex lc.version));
    ("sdk", (to_hex lc.sdk));
    ]


let dyld_info_command_to_json (lc:dyld_info_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("rebaseOff", (to_hex lc.rebase_off));
    ("rebaseSize", (to_hex lc.rebase_size));
    ("bindOff", (to_hex lc.bind_off));
    ("bindSize", (to_hex lc.bind_size));
    ("weakBindOff", (to_hex lc.weak_bind_off));
    ("weakBindSize", (to_hex lc.weak_bind_size));
    ("lazyBindOff", (to_hex lc.lazy_bind_off));
    ("lazyBindSize", (to_hex lc.lazy_bind_size));
    ("exportOff", (to_hex lc.export_off));
    ("exportSize", (to_hex lc.export_size));
    ]


let linker_option_command_to_json (lc:linker_option_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("count", (to_hex lc.count));
    ]


let symseg_command_to_json (lc:symseg_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("offset", (to_hex lc.offset));
    ("size", (to_hex lc.size));
    ]


let ident_command_to_json (lc:ident_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ]


let fvmfile_command_to_json (lc:fvmfile_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("name", (lc_str_to_json lc.name));
    ("headerAddr", (to_hex lc.header_addr));
    ]


let entry_point_command_to_json (lc:entry_point_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("entryoff", (to_hex lc.entryoff));
    ("stacksize", (to_hex lc.stacksize));
    ]


let source_version_command_to_json (lc:source_version_command) = 
  `O[
    ("cmd", (to_hex lc.cmd));
    ("_cmd", (`String (cmd_int_to_string lc.cmd)));
    ("cmdsize", (to_hex lc.cmdsize));
    ("version", (to_hex lc.version));
    ]


let data_in_code_entry_to_json (lc:data_in_code_entry) = 
  `O[
    ("offset", (to_hex lc.offset));
    ("length", (to_hex lc.length));
    ("kind", (to_hex lc.kind));
    ]

let lc_to_json lc =
  match lc.t with
    | LC_SEGMENT lc ->
      segment_command_to_json lc
    | LC_SYMTAB lc ->
      symtab_command_to_json lc
    | LC_SYMSEG lc ->
      symseg_command_to_json lc
    | LC_THREAD lc ->
      thread_command_to_json lc
    | LC_UNIXTHREAD lc ->
      thread_command_to_json lc
    | LC_LOADFVMLIB lc ->
      fvmlib_command_to_json lc
    | LC_IDFVMLIB lc ->
      fvmlib_command_to_json lc
    | LC_IDENT lc ->
      ident_command_to_json lc
    | LC_FVMFILE lc ->
      fvmfile_command_to_json lc
    | LC_PREPAGE lc ->
      load_command_to_json lc
    | LC_DYSYMTAB lc ->
      dysymtab_command_to_json lc
    | LC_LOAD_DYLIB lc ->
      dylib_command_to_json lc
    | LC_ID_DYLIB lc ->
      dylib_command_to_json lc
    | LC_LOAD_DYLINKER lc ->
      dylinker_command_to_json lc
    | LC_ID_DYLINKER lc ->
      dylinker_command_to_json lc
    | LC_PREBOUND_DYLIB lc ->
      prebound_dylib_command_to_json lc
    | LC_ROUTINES lc ->
      routines_command_to_json lc
    | LC_SUB_FRAMEWORK lc ->
      sub_framework_command_to_json lc
    | LC_SUB_UMBRELLA lc ->
      sub_umbrella_command_to_json lc
    | LC_SUB_CLIENT lc ->
      sub_client_command_to_json lc
    | LC_SUB_LIBRARY lc ->
      sub_library_command_to_json lc
    | LC_TWOLEVEL_HINTS lc ->
      twolevel_hints_command_to_json lc
    | LC_PREBIND_CKSUM lc ->
      prebind_cksum_command_to_json lc
    | LC_LOAD_WEAK_DYLIB lc ->
      dylib_command_to_json lc
    | LC_SEGMENT_64 lc ->
      segment_command_64_to_json lc
    | LC_ROUTINES_64 lc ->
      routines_command_64_to_json lc
    | LC_UUID lc ->
      uuid_command_to_json lc
    | LC_RPATH lc ->
      rpath_command_to_json lc
    | LC_CODE_SIGNATURE lc ->
      linkedit_data_command_to_json lc
    | LC_SEGMENT_SPLIT_INFO lc ->
      linkedit_data_command_to_json lc
    | LC_REEXPORT_DYLIB lc ->
      dylib_command_to_json lc
    | LC_LAZY_LOAD_DYLIB lc ->
      dylib_command_to_json lc
    | LC_ENCRYPTION_INFO lc ->
      encryption_info_command_to_json lc
    | LC_DYLD_INFO lc ->
      dyld_info_command_to_json lc
    | LC_DYLD_INFO_ONLY lc ->
      dyld_info_command_to_json lc
    | LC_LOAD_UPWARD_DYLIB lc ->
      dylib_command_to_json lc
    | LC_VERSION_MIN_MACOSX lc ->
      version_min_command_to_json lc
    | LC_VERSION_MIN_IPHONEOS lc ->
      version_min_command_to_json lc
    | LC_FUNCTION_STARTS lc ->
      linkedit_data_command_to_json lc
    | LC_DYLD_ENVIRONMENT lc ->
      dylinker_command_to_json lc
    | LC_MAIN lc ->
      entry_point_command_to_json lc
    | LC_DATA_IN_CODE lc ->
      linkedit_data_command_to_json lc
    | LC_SOURCE_VERSION lc ->
      source_version_command_to_json lc
    | LC_DYLIB_CODE_SIGN_DRS lc ->
      linkedit_data_command_to_json lc
    | LC_ENCRYPTION_INFO_64 lc ->
      encryption_info_command_64_to_json lc
    | LC_LINKER_OPTION lc ->
      linkedit_data_command_to_json lc
    | LC_LINKER_OPTIMIZATION_HINT lc ->
      linkedit_data_command_to_json lc
    | LC_UNIMPLEMENTED lc ->
      load_command_to_json lc


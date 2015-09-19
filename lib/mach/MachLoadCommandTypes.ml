
type load_command = {
  cmd: int;                        
  cmdsize: int;                   
}

let sizeof_load_command = 8

type lc_str = {
  offset: int;                  
  str: string;                 
}

let sizeof_lc_str = 4

type section = {
  sectname: string;		
  segname: string;		
  
  addr: int;
  size: int;
  offset: int;
  align: int;
  reloff: int;
  nreloc: int;
  flags: int;
  reserved1: int;
  reserved2: int;
}

let sizeof_section = 68

type section_64 = {
  sectname: string;		
  segname: string;		
  addr: int;			
  size: int;			
  
  offset: int;
  align: int;
  reloff: int;
  nreloc: int;
  flags: int;
  reserved1: int;
  reserved2: int;
  reserved3: int;
}

let sizeof_section_64 = 80 

type segment_command = {
  cmd: int;
  cmdsize: int;
  segname: string;
  vmaddr: int;
  vmsize: int;
  fileoff: int;
  filesize: int;
  maxprot: int;
  initprot: int;
  nsects: int;
  flags: int;
  sections: section list;
}

let sizeof_segment_command_64 = 56

type segment_command_64 = {
  cmd: int;
  cmdsize: int;
  segname: string; 
  vmaddr: int; 
  vmsize: int; 
  fileoff: int; 
  filesize: int; 
  maxprot: int;  
  initprot: int; 
  nsects: int;   
  flags: int;    
  sections: section_64 list; 	
}

let sizeof_segment_command_64 = 72

type fvmlib = {
  name: lc_str;		
  minor_version: int;	
  header_addr: int; 
}

let sizeof_fvmlib = 12

type fvmlib_command = {
  cmd: int;	
  cmdsize: int;	
  fvmlib: fvmlib;		
}

let sizeof_fvmlib_command = 20


type dylib = {
  name: lc_str;   
  timestamp: int;   
  current_version: int;  
  compatibility_version: int; 
}

let sizeof_dylib = 16

type dylib_command = 
  {
    cmd: int; 
    cmdsize: int; 
    dylib: dylib; 
  }

let sizeof_dylib_command = 20 

type sub_framework_command = {
  cmd: int;	
  cmdsize: int;	
  umbrella: lc_str; 
}

let sizeof_sub_framework_command= 12

type sub_client_command = {
  cmd: int;	
  cmdsize: int;	
  client: lc_str;	
}

let sizeof_sub_client_command = 12

type sub_umbrella_command = {
  cmd: int;       
  cmdsize: int;   
  sub_umbrella: lc_str; 
}

let sizeof_sub_umbrella_command = 12


type sub_library_command = {
  cmd: int;       
  cmdsize: int;	
  sub_library: lc_str; 
}

let sizeof_sub_library_command = 12


type prebound_dylib_command = {
  cmd: int;	
  cmdsize: int;	
  name: lc_str;	
  nmodules: int;	
  linked_modules: lc_str;	
}

let sizeof_prebound_dylib_command = 20

type dylinker_command = {
  cmd: int;
  cmdsize: int;
  name: lc_str;
}

let sizeof_dylinker_command = 12

type thread_command = {
  cmd: int;		
  cmdsize: int;	
}

type routines_command =  { 
  cmd: int;		
  cmdsize: int;	
  init_address: int;	
  init_module: int;	
  
  reserved1: int;
  reserved2: int;
  reserved3: int;
  reserved4: int;
  reserved5: int;
  reserved6: int;
}


type routines_command_64 = { 
  cmd: int;       
  cmdsize: int;	
  init_address: int;	
  init_module: int;	
  
  
  reserved1: int;
  reserved2: int;
  reserved3: int;
  reserved4: int;
  reserved5: int;
  reserved6: int;
}

type symtab_command = {
  cmd: int;
  cmdsize: int;
  
  symoff: int;
  nsyms: int;
  stroff: int;
  strsize: int;
}

let sizeof_symtab_command = 24

type dysymtab_command  = {
  cmd: int;
  cmdsize: int;
  ilocalsym: int; 
  nlocalsym: int; 

  iextdefsym: int;    
  nextdefsym: int;    

  iundefsym: int; 
  nundefsym: int; 

  tocoff: int; 
  ntoc: int; 
  modtaboff: int; 
  nmodtab: int; 

  extrefsymoff: int; 
  nextrefsyms: int; 

  indirectsymoff: int; 
  nindirectsyms: int;  
  extreloff: int; 
  nextrel: int; 
  locreloff: int; 
  nlocrel: int; 
}

let sizeof_dysymtab_command = 80 



type dylib_table_of_contents = {
  symbol_index: int;
		
  module_index: int;

}	



type dylib_module = {
  module_name: int;	

  iextdefsym: int;	
  nextdefsym: int;	
  irefsym: int;		
  nrefsym: int;		
  ilocalsym: int;		
  nlocalsym: int;		

  iextrel: int;		
  nextrel: int;		

  iinit_iterm: int;
		   
		   
  ninit_nterm: int;
		   
		   

  
  objc_module_info_addr: int;  
  
  objc_module_info_size: int;	
}	



type dylib_module_64 = {
  module_name: int;	

  iextdefsym: int;	
  nextdefsym: int;	
  irefsym: int;		
  nrefsym: int;		
  ilocalsym: int;		
  nlocalsym: int;		
  iextrel: int;		
  nextrel: int;		
  iinit_iterm: int;
  ninit_nterm: int;
  objc_module_info_size: int;	
  objc_module_info_addr: int;	
}


type dylib_reference = {
  
  
  isym: int;		
  
  flags: int;	
}


type twolevel_hints_command = {
  cmd: int;	
  cmdsize: int;	
  offset: int;	
  nhints: int;	
}



type twolevel_hint = {
  
  
  isub_image: int;	
  
  itoc: int;	
}



type prebind_cksum_command = {
  cmd: int;	
  cmdsize: int;	
  cksum: int;	
}

type uuid_command = {
  cmd: int;		
  cmdsize: int;	
  uuid: bytes;	
}

let sizeof_uuid_command = 24

type rpath_command = {
  cmd: int; 
  cmdsize: int; 
  path: lc_str; 
}

let sizeof_rpath_command = 12

type linkedit_data_command = {
  cmd: int;
  cmdsize: int;	
  dataoff: int;	
  datasize: int;	
}

let sizeof_linkedit_data_command = 16


type encryption_info_command = {
  cmd: int;		
  cmdsize: int;	
  cryptoff: int;	
  cryptsize: int;	
  cryptid: int;	
}

let sizeof_encryption_info_command = 20

type encryption_info_command_64 = {
  cmd: int;		
  cmdsize: int;	
  cryptoff: int;	
  cryptsize: int;	
  cryptid: int;	
  pad: int;		
}

let sizeof_encryption_info_command_64 = 24


type version_min_command = {
  cmd: int;
  cmdsize: int;
  version: int; 
  sdk: int;  
}

let sizeof_version_min_command = 16 


type dyld_info_command = 
  {
    cmd: int;
    cmdsize: int;
    
    rebase_off: int;
    rebase_size: int;
    bind_off: int;
    bind_size: int;
    weak_bind_off: int;
    weak_bind_size: int;
    lazy_bind_off: int;
    lazy_bind_size: int;
    export_off: int;
    export_size: int;
  }

let sizeof_dylib_info_command = 48


type linker_option_command = {
  cmd: int;	
  cmdsize: int;    
  count: int;	

}

let sizeof_linker_option_command = 12

type symseg_command =  {
  cmd: int;		
  cmdsize: int;	
  offset: int;		
  size: int;		
}

let sizeof_symseg_command = 16

type ident_command = {
  cmd: int;		
  cmdsize: int;	
}

let sizeof_ident_command = 8

type fvmfile_command = {
  cmd: int;		
  cmdsize: int;		
  name: lc_str;		
  header_addr: int;	
}

let sizeof_fvmfile_command = 16


type entry_point_command = {
  cmd: int;
  cmdsize: int;
  entryoff: int; 
  stacksize: int ;
}

let sizeof_entry_point_command = 24 

type source_version_command = {
  cmd: int;     
  cmdsize: int; 
  version: int; 
}


type data_in_code_entry = {
  offset: int;  
  length: int;  
  kind: int;    
}

let kLC_REQ_DYLD = 0x80000000
let kLC_LOAD_WEAK_DYLIB = 0x18 lor kLC_REQ_DYLD
let kLC_RPATH = 0x1c lor kLC_REQ_DYLD
let kLC_REEXPORT_DYLIB = 0x1f lor kLC_REQ_DYLD
let kLC_DYLD_INFO_ONLY = 0x22 lor kLC_REQ_DYLD
let kLC_LOAD_UPWARD_DYLIB = 0x23 lor kLC_REQ_DYLD
let kLC_MAIN = 0x28 lor kLC_REQ_DYLD

exception Bad_load_command of int * string

type cmd =
  | LC_SEGMENT
  | LC_SYMTAB
  | LC_SYMSEG
  | LC_THREAD
  | LC_UNIXTHREAD
  | LC_LOADFVMLIB
  | LC_IDFVMLIB
  | LC_IDENT
  | LC_FVMFILE
  | LC_PREPAGE
  | LC_DYSYMTAB
  | LC_LOAD_DYLIB
  | LC_ID_DYLIB
  | LC_LOAD_DYLINKER
  | LC_ID_DYLINKER
  | LC_PREBOUND_DYLIB
  | LC_ROUTINES
  | LC_SUB_FRAMEWORK
  | LC_SUB_UMBRELLA
  | LC_SUB_CLIENT
  | LC_SUB_LIBRARY
  | LC_TWOLEVEL_HINTS
  | LC_PREBIND_CKSUM
  | LC_LOAD_WEAK_DYLIB
  | LC_SEGMENT_64
  | LC_ROUTINES_64
  | LC_UUID
  | LC_RPATH
  | LC_CODE_SIGNATURE
  | LC_SEGMENT_SPLIT_INFO
  | LC_REEXPORT_DYLIB
  | LC_LAZY_LOAD_DYLIB
  | LC_ENCRYPTION_INFO
  | LC_DYLD_INFO
  | LC_DYLD_INFO_ONLY
  | LC_LOAD_UPWARD_DYLIB
  | LC_VERSION_MIN_MACOSX
  | LC_VERSION_MIN_IPHONEOS
  | LC_FUNCTION_STARTS
  | LC_DYLD_ENVIRONMENT
  | LC_MAIN
  | LC_DATA_IN_CODE
  | LC_SOURCE_VERSION
  | LC_DYLIB_CODE_SIGN_DRS
  | LC_ENCRYPTION_INFO_64
  | LC_LINKER_OPTION
  | LC_LINKER_OPTIMIZATION_HINT

let cmd_int_to_string =
  function
  | 0x1 -> "LC_SEGMENT"
  | 0x2 -> "LC_SYMTAB"
  | 0x3 -> "LC_SYMSEG"
  | 0x4 -> "LC_THREAD"
  | 0x5 -> "LC_UNIXTHREAD"
  | 0x6 -> "LC_LOADFVMLIB"
  | 0x7 -> "LC_IDFVMLIB"
  | 0x8 -> "LC_IDENT"
  | 0x9 -> "LC_FVMFILE"
  | 0xa -> "LC_PREPAGE"
  | 0xb -> "LC_DYSYMTAB"
  | 0xc -> "LC_LOAD_DYLIB"
  | 0xd -> "LC_ID_DYLIB"
  | 0xe -> "LC_LOAD_DYLINKER"
  | 0xf -> "LC_ID_DYLINKER"
  | 0x10 -> "LC_PREBOUND_DYLIB"
  | 0x11 -> "LC_ROUTINES"
  | 0x12 -> "LC_SUB_FRAMEWORK"
  | 0x13 -> "LC_SUB_UMBRELLA"
  | 0x14 -> "LC_SUB_CLIENT"
  | 0x15 -> "LC_SUB_LIBRARY"
  | 0x16 -> "LC_TWOLEVEL_HINTS"
  | 0x17 -> "LC_PREBIND_CKSUM"
  | cmd when cmd = kLC_LOAD_WEAK_DYLIB -> "LC_LOAD_WEAK_DYLIB"
  | 0x19 -> "LC_SEGMENT_64"
  | 0x1a -> "LC_ROUTINES_64"
  | 0x1b -> "LC_UUID"
  | cmd when cmd = kLC_RPATH -> "LC_RPATH"
  | 0x1d -> "LC_CODE_SIGNATURE"
  | 0x1e -> "LC_SEGMENT_SPLIT_INFO"
  | cmd when cmd = kLC_REEXPORT_DYLIB -> "LC_REEXPORT_DYLIB"
  | 0x20 -> "LC_LAZY_LOAD_DYLIB"
  | 0x21 -> "LC_ENCRYPTION_INFO"
  | 0x22 -> "LC_DYLD_INFO"
  | cmd when cmd = kLC_DYLD_INFO_ONLY -> "LC_DYLD_INFO_ONLY"
  | cmd when cmd = kLC_LOAD_UPWARD_DYLIB -> "LC_LOAD_UPWARD_DYLIB"
  | 0x24 -> "LC_VERSION_MIN_MACOSX"
  | 0x25 -> "LC_VERSION_MIN_IPHONEOS"
  | 0x26 -> "LC_FUNCTION_STARTS"
  | 0x27 -> "LC_DYLD_ENVIRONMENT"
  | cmd when cmd = kLC_MAIN -> "LC_MAIN"
  | 0x29 -> "LC_DATA_IN_CODE"
  | 0x2A -> "LC_SOURCE_VERSION"
  | 0x2B -> "LC_DYLIB_CODE_SIGN_DRS"
  | 0x2C -> "LC_ENCRYPTION_INFO_64"
  | 0x2D -> "LC_LINKER_OPTION"
  | 0x2E -> "LC_LINKER_OPTIMIZATION_HINT"
  | cmd -> Printf.sprintf "UKNOWN LOAD COMMAND 0x%x" cmd

let to_cmd =
  function
  | 0x1 -> LC_SEGMENT
  | 0x2 -> LC_SYMTAB
  | 0x3 -> LC_SYMSEG
  | 0x4 -> LC_THREAD
  | 0x5 -> LC_UNIXTHREAD
  | 0x6 -> LC_LOADFVMLIB
  | 0x7 -> LC_IDFVMLIB
  | 0x8 -> LC_IDENT
  | 0x9 -> LC_FVMFILE
  | 0xa -> LC_PREPAGE
  | 0xb -> LC_DYSYMTAB
  | 0xc -> LC_LOAD_DYLIB
  | 0xd -> LC_ID_DYLIB
  | 0xe -> LC_LOAD_DYLINKER
  | 0xf -> LC_ID_DYLINKER
  | 0x10 -> LC_PREBOUND_DYLIB
  | 0x11 -> LC_ROUTINES
  | 0x12 -> LC_SUB_FRAMEWORK
  | 0x13 -> LC_SUB_UMBRELLA
  | 0x14 -> LC_SUB_CLIENT
  | 0x15 -> LC_SUB_LIBRARY
  | 0x16 -> LC_TWOLEVEL_HINTS
  | 0x17 -> LC_PREBIND_CKSUM
  | cmd when cmd = kLC_LOAD_WEAK_DYLIB -> LC_LOAD_WEAK_DYLIB
  | 0x19 -> LC_SEGMENT_64
  | 0x1a -> LC_ROUTINES_64
  | 0x1b -> LC_UUID
  | cmd when cmd = kLC_RPATH -> LC_RPATH
  | 0x1d -> LC_CODE_SIGNATURE
  | 0x1e -> LC_SEGMENT_SPLIT_INFO
  | cmd when cmd = kLC_REEXPORT_DYLIB -> LC_REEXPORT_DYLIB
  | 0x20 -> LC_LAZY_LOAD_DYLIB
  | 0x21 -> LC_ENCRYPTION_INFO
  | 0x22 -> LC_DYLD_INFO
  | cmd when cmd = kLC_DYLD_INFO_ONLY -> LC_DYLD_INFO_ONLY
  | cmd when cmd = kLC_LOAD_UPWARD_DYLIB -> LC_LOAD_UPWARD_DYLIB
  | 0x24 -> LC_VERSION_MIN_MACOSX
  | 0x25 -> LC_VERSION_MIN_IPHONEOS
  | 0x26 -> LC_FUNCTION_STARTS
  | 0x27 -> LC_DYLD_ENVIRONMENT
  | cmd when cmd = kLC_MAIN -> LC_MAIN
  | 0x29 -> LC_DATA_IN_CODE
  | 0x2A -> LC_SOURCE_VERSION
  | 0x2B -> LC_DYLIB_CODE_SIGN_DRS
  | 0x2C -> LC_ENCRYPTION_INFO_64
  | 0x2D -> LC_LINKER_OPTION
  | 0x2E -> LC_LINKER_OPTIMIZATION_HINT
  | cmd -> raise @@ Bad_load_command (cmd,(Printf.sprintf "0x%x" cmd))

let cmd_to_int =
  function
  | LC_SEGMENT -> 0x1
  | LC_SYMTAB -> 0x2
  | LC_SYMSEG -> 0x3
  | LC_THREAD -> 0x4
  | LC_UNIXTHREAD -> 0x5
  | LC_LOADFVMLIB -> 0x6
  | LC_IDFVMLIB -> 0x7
  | LC_IDENT -> 0x8
  | LC_FVMFILE -> 0x9
  | LC_PREPAGE -> 0xa
  | LC_DYSYMTAB -> 0xb
  | LC_LOAD_DYLIB -> 0xc
  | LC_ID_DYLIB -> 0xd
  | LC_LOAD_DYLINKER -> 0xe
  | LC_ID_DYLINKER -> 0xf
  | LC_PREBOUND_DYLIB -> 0x10
  | LC_ROUTINES -> 0x11
  | LC_SUB_FRAMEWORK -> 0x12
  | LC_SUB_UMBRELLA -> 0x13
  | LC_SUB_CLIENT -> 0x14
  | LC_SUB_LIBRARY -> 0x15
  | LC_TWOLEVEL_HINTS -> 0x16
  | LC_PREBIND_CKSUM -> 0x17
  | LC_LOAD_WEAK_DYLIB -> kLC_LOAD_WEAK_DYLIB
  | LC_SEGMENT_64 -> 0x19
  | LC_ROUTINES_64 -> 0x1a
  | LC_UUID -> 0x1b
  | LC_RPATH -> kLC_RPATH
  | LC_CODE_SIGNATURE -> 0x1d
  | LC_SEGMENT_SPLIT_INFO -> 0x1e
  | LC_REEXPORT_DYLIB -> kLC_REEXPORT_DYLIB
  | LC_LAZY_LOAD_DYLIB -> 0x20
  | LC_ENCRYPTION_INFO -> 0x21
  | LC_DYLD_INFO -> 0x22
  | LC_DYLD_INFO_ONLY -> kLC_DYLD_INFO_ONLY
  | LC_LOAD_UPWARD_DYLIB -> kLC_LOAD_UPWARD_DYLIB
  | LC_VERSION_MIN_MACOSX -> 0x24
  | LC_VERSION_MIN_IPHONEOS -> 0x25
  | LC_FUNCTION_STARTS -> 0x26
  | LC_DYLD_ENVIRONMENT -> 0x27
  | LC_MAIN -> kLC_MAIN
  | LC_DATA_IN_CODE -> 0x29
  | LC_SOURCE_VERSION -> 0x2A
  | LC_DYLIB_CODE_SIGN_DRS -> 0x2B
  | LC_ENCRYPTION_INFO_64 -> 0x2C
  | LC_LINKER_OPTION -> 0x2D
  | LC_LINKER_OPTIMIZATION_HINT -> 0x2E

let cmd_to_string cmd = cmd_to_int cmd |> cmd_int_to_string

type lc_t =
  
  | LC_SEGMENT of segment_command
  | LC_SYMTAB of symtab_command
  | LC_SYMSEG of symseg_command
  | LC_THREAD of thread_command
  | LC_UNIXTHREAD of thread_command
  | LC_LOADFVMLIB of fvmlib_command
  | LC_IDFVMLIB of fvmlib_command
  | LC_IDENT of ident_command
  | LC_FVMFILE of fvmfile_command
  | LC_PREPAGE of load_command
  | LC_DYSYMTAB of dysymtab_command
  | LC_LOAD_DYLIB of dylib_command
  | LC_ID_DYLIB of dylib_command
  | LC_LOAD_DYLINKER of dylinker_command
  | LC_ID_DYLINKER of dylinker_command
  | LC_PREBOUND_DYLIB of prebound_dylib_command
  | LC_ROUTINES of routines_command
  | LC_SUB_FRAMEWORK of sub_framework_command
  | LC_SUB_UMBRELLA of sub_umbrella_command
  | LC_SUB_CLIENT of sub_client_command
  | LC_SUB_LIBRARY of sub_library_command
  | LC_TWOLEVEL_HINTS of twolevel_hints_command
  | LC_PREBIND_CKSUM of prebind_cksum_command
  | LC_LOAD_WEAK_DYLIB of dylib_command
  | LC_SEGMENT_64	of segment_command_64
  | LC_ROUTINES_64 of routines_command_64
  | LC_UUID of uuid_command
  | LC_RPATH of rpath_command
  | LC_CODE_SIGNATURE of linkedit_data_command
  | LC_SEGMENT_SPLIT_INFO of linkedit_data_command
  | LC_REEXPORT_DYLIB of dylib_command
  | LC_LAZY_LOAD_DYLIB of dylib_command 
  | LC_ENCRYPTION_INFO of encryption_info_command
  | LC_DYLD_INFO of dyld_info_command
  | LC_DYLD_INFO_ONLY of dyld_info_command
  | LC_LOAD_UPWARD_DYLIB of dylib_command 
  | LC_VERSION_MIN_MACOSX of version_min_command
  | LC_VERSION_MIN_IPHONEOS of version_min_command
  | LC_FUNCTION_STARTS of linkedit_data_command
  | LC_DYLD_ENVIRONMENT of dylinker_command
  | LC_MAIN of entry_point_command
  | LC_DATA_IN_CODE of linkedit_data_command
  | LC_SOURCE_VERSION of source_version_command
  | LC_DYLIB_CODE_SIGN_DRS of linkedit_data_command
  | LC_ENCRYPTION_INFO_64 of encryption_info_command_64
  | LC_LINKER_OPTION of linkedit_data_command
  | LC_LINKER_OPTIMIZATION_HINT of linkedit_data_command
  | LC_UNIMPLEMENTED of load_command

type lc = {
  cmd: cmd;                        
  cmdsize: int;                   
  t: lc_t;
}

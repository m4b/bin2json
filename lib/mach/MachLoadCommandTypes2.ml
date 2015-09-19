



type load_command = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
}

let sizeof_load_command = 8


type lc_str = {
  offset: int [@size 4];
  str: string [@computed];
}

let sizeof_lc_str = 4

(*
struct section_64 { 
 char  sectname[16]; 
 char  segname[16]; 
 uint64_t addr;  
 uint64_t size;  
 uint32_t offset;  
 uint32_t align;  
 uint32_t reloff;  
 uint32_t nreloc;  
 uint32_t flags;  
 uint32_t reserved1; 
 uint32_t reserved2; 
 uint32_t reserved3; 
};
*)

type section = {
  sectname: string [@size 16];
  segname: string [@size 16];
  
  addr: int [@size 4];
  size: int [@size 4];
  offset: int [@size 4];
  align: int [@size 4];
  reloff: int [@size 4];
  nreloc: int [@size 4];
  flags: int [@size 4];
  reserved1: int [@size 4];
  reserved2: int [@size 4];
}

let sizeof_section = 68	

type section_64 = {
  sectname: string [@size 16];
  segname: string [@size 16];
  addr: int [@size 8];
  size: int [@size 8];
  offset: int [@size 4];
  align: int [@size 4];
  reloff: int [@size 4];
  nreloc: int [@size 4];
  flags: int [@size 4];
  reserved1: int [@size 4];
  reserved2: int [@size 4];
  reserved3: int [@size 4];
}

let sizeof_section_64 = 80 

type segment_command = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
  segname: string [@size 16];
  vmaddr: int [@size 4];
  vmsize: int [@size 4];
  fileoff: int [@size 4];
  filesize: int [@size 4];
  maxprot: int [@size 4];
  initprot: int [@size 4];
  nsects: int [@size 4];
  flags: int [@size 4];
  sections: section list [@computed nsects];
}

let sizeof_segment_command_64 = 56

type segment_command_64 = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
  segname: string [@size 16];
  vmaddr: int [@size 8];
  vmsize: int [@size 8];
  fileoff: int [@size 8];
  filesize: int [@size 8];
  maxprot: int [@size 4];
  initprot: int [@size 4];
  nsects: int [@size 4];
  flags: int [@size 4];
  sections: section_64 list [@computed nsects];
}

let sizeof_segment_command_64 = 72

(*
 * Fixed virtual memory shared libraries are identified by two things.  The
 * target pathname (the name of the library as found for execution), and the
 * minor version number.  The address of where the headers are loaded is in
 * header_addr. (THIS IS OBSOLETE and no longer supported).
 *)
type fvmlib = {
  name: lc_str [@size 4]; 
  minor_version: int [@size 4];	
  header_addr: int [@size 4]; 
}

let sizeof_fvmlib = 12

(*
 * A fixed virtual shared library (filetype == MH_FVMLIB in the mach header)
 * contains a fvmlib_command (cmd == LC_IDFVMLIB) to identify the library.
 * An object that uses a fixed virtual shared library also contains a
 * fvmlib_command (cmd == LC_LOADFVMLIB) for each library it uses.
 * (THIS IS OBSOLETE and no longer supported).
 *)
type fvmlib_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  fvmlib: fvmlib [@size 4]; 
}

let sizeof_fvmlib_command = 20

(*
*
 * Dynamicly linked shared libraries are identified by two things.  The
 * pathname (the name of the library as found for execution), and the
 * compatibility version number.  The pathname must match and the compatibility
 * number in the user of the library must be greater than or equal to the
 * library being used.  The time stamp is used to record the time a library was
 * built and copied into user so it can be use to determined if the library used
 * at runtime is exactly the same as used to built the program.
 *
struct dylib {
    union lc_str  name;   
    uint32_t timestamp;   
    uint32_t current_version;  
    uint32_t compatibility_version; 
};
 *)

(*
 *
 * A dynamically linked shared library (filetype == MH_DYLIB in the mach header)
 * contains a dylib_command (cmd == LC_ID_DYLIB) to identify the library.
 * An object that uses a dynamically linked shared library also contains a
 * dylib_command (cmd == LC_LOAD_DYLIB, LC_LOAD_WEAK_DYLIB, or
 * LC_REEXPORT_DYLIB) for each library it uses.
 *
 *)

type dylib = {
  name: lc_str [@size 4]; 
  timestamp: int [@size 4]; 
  current_version: int [@size 4]; 
  compatibility_version: int [@size 4]; 
}

let sizeof_dylib = 16

type dylib_command = 
  {
    cmd: int [@size 4]; 
    cmdsize: int [@size 4]; 
    dylib: dylib [@size 16]; 
  }

let sizeof_dylib_command = 20 

(*
 * A dynamically linked shared library may be a subframework of an umbrella
 * framework.  If so it will be linked with "-umbrella umbrella_name" where
 * Where "umbrella_name" is the name of the umbrella framework. A subframework
 * can only be linked against by its umbrella framework or other subframeworks
 * that are part of the same umbrella framework.  Otherwise the static link
 * editor produces an error and states to link against the umbrella framework.
 * The name of the umbrella framework for subframeworks is recorded in the
 * following structure.
 *)
type sub_framework_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  umbrella: lc_str [@size 4]; 
}

let sizeof_sub_framework_command= 12

(*
 * For dynamically linked shared libraries that are subframework of an umbrella
 * framework they can allow clients other than the umbrella framework or other
 * subframeworks in the same umbrella framework.  To do this the subframework
 * is built with "-allowable_client client_name" and an LC_SUB_CLIENT load
 * command is created for each -allowable_client flag.  The client_name is
 * usually a framework name.  It can also be a name used for bundles clients
 * where the bundle is built with "-client_name client_name".
 *)
type sub_client_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  client: lc_str [@size 4]; 
}

let sizeof_sub_client_command = 12

(*
 * A dynamically linked shared library may be a sub_umbrella of an umbrella
 * framework.  If so it will be linked with "-sub_umbrella umbrella_name" where
 * Where "umbrella_name" is the name of the sub_umbrella framework.  When
 * staticly linking when -twolevel_namespace is in effect a twolevel namespace 
 * umbrella framework will only cause its subframeworks and those frameworks
 * listed as sub_umbrella frameworks to be implicited linked in.  Any other
 * dependent dynamic libraries will not be linked it when -twolevel_namespace
 * is in effect.  The primary library recorded by the static linker when
 * resolving a symbol in these libraries will be the umbrella framework.
 * Zero or more sub_umbrella frameworks may be use by an umbrella framework.
 * The name of a sub_umbrella framework is recorded in the following structure.
 *)
type sub_umbrella_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  sub_umbrella: lc_str [@size 4]; 
}

let sizeof_sub_umbrella_command = 12

(*
 * A dynamically linked shared library may be a sub_library of another shared
 * library.  If so it will be linked with "-sub_library library_name" where
 * Where "library_name" is the name of the sub_library shared library.  When
 * staticly linking when -twolevel_namespace is in effect a twolevel namespace 
 * shared library will only cause its subframeworks and those frameworks
 * listed as sub_umbrella frameworks and libraries listed as sub_libraries to
 * be implicited linked in.  Any other dependent dynamic libraries will not be
 * linked it when -twolevel_namespace is in effect.  The primary library
 * recorded by the static linker when resolving a symbol in these libraries
 * will be the umbrella framework (or dynamic library). Zero or more sub_library
 * shared libraries may be use by an umbrella framework or (or dynamic library).
 * The name of a sub_library framework is recorded in the following structure.
 * For example /usr/lib/libobjc_profile.A.dylib would be recorded as "libobjc".
 *)
type sub_library_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  sub_library: lc_str [@size 4]; 
}

let sizeof_sub_library_command = 12

(*
 * A program (filetype == MH_EXECUTE) that is
 * prebound to its dynamic libraries has one of these for each library that
 * the static linker used in prebinding.  It contains a bit vector for the
 * modules in the library.  The bits indicate which modules are bound (1) and
 * which are not (0) from the library.  The bit for module 0 is the low bit
 * of the first byte.  So the bit for the Nth module is:
 * (linked_modules[N/8] >> N%8) & 1
 *)
type prebound_dylib_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  name: lc_str [@size 4]; 
  nmodules: int [@size 4]; 
  linked_modules: lc_str [@size 4]; 
}

let sizeof_prebound_dylib_command = 20

type dylinker_command = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
  name: lc_str [@size 4];
}

let sizeof_dylinker_command = 12

(*
 * Thread commands contain machine-specific data structures suitable for
 * use in the thread state primitives.  The machine specific data structures
 * follow the struct thread_command as follows.
 * Each flavor of machine specific data structure is preceded by an unsigned
 * long constant for the flavor of that data structure, an uint32_t
 * that is the count of longs of the size of the state data structure and then
 * the state data structure follows.  This triple may be repeated for many
 * flavors.  The constants for the flavors, counts and state data structure
 * definitions are expected to be in the header file <machine/thread_status.h>.
 * These machine specific data structures sizes must be multiples of
 * 4 bytes  The cmdsize reflects the total size of the thread_command
 * and all of the sizes of the constants for the flavors, counts and state
 * data structures.
 *
 * For executable objects that are unix processes there will be one
 * thread_command (cmd == LC_UNIXTHREAD) created for it by the link-editor.
 * This is the same as a LC_THREAD, except that a stack is automatically
 * created (based on the shell's limit for the stack size).  Command arguments
 * and environment variables are copied onto that stack.
 *)
(* unimplemented, see machine/thread_status.h for rest of values:
   uint32_t flavor		   flavor of thread state
   uint32_t count		   count of longs in thread state
   struct XXX_thread_state state   thread state for this flavor
   ... *)

type thread_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
}

(*
 * The routines command contains the address of the dynamic shared library 
 * initialization routine and an index into the module table for the module
 * that defines the routine.  Before any modules are used from the library the
 * dynamic linker fully binds the module that defines the initialization routine
 * and then calls it.  This gets called before any module initialization
 * routines (used for C++ static constructors) in the library.
 *)
type routines_command =  { 
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  init_address: int [@size 4]; 
  init_module: int [@size 4]; 
  reserved1: int [@size 4];
  reserved2: int [@size 4];
  reserved3: int [@size 4];
  reserved4: int [@size 4];
  reserved5: int [@size 4];
  reserved6: int [@size 4];
}

(*
 * The 64-bit routines command.  Same use as above.
 *)
type routines_command_64 = { 
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  init_address: int [@size 8];
  init_module: int [@size 8]; 
  reserved1: int [@size 8];
  reserved2: int [@size 8];
  reserved3: int [@size 8];
  reserved4: int [@size 8];
  reserved5: int [@size 8];
  reserved6: int [@size 8];
}

type symtab_command = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
  symoff: int [@size 4];
  nsyms: int [@size 4];
  stroff: int [@size 4];
  strsize: int [@size 4];
}

let sizeof_symtab_command = 24

(*
 * This is the second set of the symbolic information which is used to support
 * the data structures for the dynamically link editor.
 *
 * The original set of symbolic information in the symtab_command which contains
 * the symbol and string tables must also be present when this load command is
 * present.  When this load command is present the symbol table is organized
 * into three groups of symbols:
 * local symbols (static and debugging symbols) - grouped by module
 * defined external symbols - grouped by module (sorted by name if not lib)
 * undefined external symbols (sorted by name if MH_BINDATLOAD is not set,
 *             and in order the were seen by the static
 *        linker if MH_BINDATLOAD is set)
 * In this load command there are offsets and counts to each of the three groups
 * of symbols.
 *
 * This load command contains a the offsets and sizes of the following new
 * symbolic information tables:
 * table of contents
 * module table
 * reference symbol table
 * indirect symbol table
 * The first three tables above (the table of contents, module table and
 * reference symbol table) are only present if the file is a dynamically linked
 * shared library.  For executable and object modules, which are files
 * containing only one module, the information that would be in these three
 * tables is determined as follows:
 *  table of contents - the defined external symbols are sorted by name
 * module table - the file contains only one module so everything in the
 *         file is part of the module.
 * reference symbol table - is the defined and undefined external symbols
 *
 * For dynamically linked shared library files this load command also contains
 * offsets and sizes to the pool of relocation entries for all sections
 * separated into two groups:
 * external relocation entries
 * local relocation entries
 * For executable and object modules the relocation entries continue to hang
 * off the section structures.
 *)
type dysymtab_command  = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
  ilocalsym: int [@size 4]; 
  nlocalsym: int [@size 4]; 

  iextdefsym: int [@size 4]; 
  nextdefsym: int [@size 4]; 

  iundefsym: int [@size 4]; 
  nundefsym: int [@size 4]; 

  tocoff: int [@size 4]; 
  ntoc: int [@size 4]; 
  modtaboff: int [@size 4]; 
  nmodtab: int [@size 4]; 

  extrefsymoff: int [@size 4]; 
  nextrefsyms: int [@size 4]; 

  indirectsymoff: int [@size 4]; 
  nindirectsyms: int [@size 4];  
  extreloff: int [@size 4]; 
  nextrel: int [@size 4]; 
  locreloff: int [@size 4]; 
  nlocrel: int [@size 4]; 
}

let sizeof_dysymtab_command = 80 



type dylib_table_of_contents = {
  symbol_index: int [@size 4]; 
  module_index: int [@size 4]; 
}	



type dylib_module = {
  module_name: int [@size 4]; 

  iextdefsym: int [@size 4]; 
  nextdefsym: int [@size 4]; 
  irefsym: int [@size 4]; 
  nrefsym: int [@size 4]; 
  ilocalsym: int [@size 4]; 
  nlocalsym: int [@size 4]; 

  iextrel: int [@size 4]; 
  nextrel: int [@size 4]; 

  iinit_iterm: int [@size 4]; 
  ninit_nterm: int [@size 4]; 
  objc_module_info_addr: int [@size 4]; 
  objc_module_info_size: int [@size 4]; 
}	



type dylib_module_64 = {
  module_name: int [@size 4]; 

  iextdefsym: int [@size 4]; 
  nextdefsym: int [@size 4]; 
  irefsym: int [@size 4]; 
  nrefsym: int [@size 4]; 
  ilocalsym: int [@size 4]; 
  nlocalsym: int [@size 4]; 

  iextrel: int [@size 4]; 
  nextrel: int [@size 4]; 

  iinit_iterm: int [@size 4]; 
  ninit_nterm: int [@size 4]; 

  objc_module_info_size: int [@size 4]; 
  objc_module_info_addr: int [@size 8]; 
}

(* 
 * The entries in the reference symbol table are used when loading the module
 * (both by the static and dynamic link editors) and if the module is unloaded
 * or replaced.  Therefore all external symbols (defined and undefined) are
 * listed in the module's reference table.  The flags describe the type of
 * reference that is being made.  The constants for the flags are defined in
 * <mach-o/nlist.h> as they are also used for symbol table entries.
 *)

type dylib_reference = {
  isym: bytes [@size 24]; 
  flags: int [@size 8]; 
}

(*
 * The twolevel_hints_command contains the offset and number of hints in the
 * two-level namespace lookup hints table.
 *)

type twolevel_hints_command = {
  cmd: int [@size 4];
  cmdsize: int [@size 4]; 
  offset: int [@size 4]; 
  nhints: int [@size 4]; 
}

(*
 * The entries in the two-level namespace lookup hints table are twolevel_hint
 * structs.  These provide hints to the dynamic link editor where to start
 * looking for an undefined symbol in a two-level namespace image.  The
 * isub_image field is an index into the sub-images (sub-frameworks and
 * sub-umbrellas list) that made up the two-level image that the undefined
 * symbol was found in when it was built by the static link editor.  If
 * isub-image is 0 the the symbol is expected to be defined in library and not
 * in the sub-images.  If isub-image is non-zero it is an index into the array
 * of sub-images for the umbrella with the first index in the sub-images being
 * 1. The array of sub-images is the ordered list of sub-images of the umbrella
 * that would be searched for a symbol that has the umbrella recorded as its
 * primary library.  The table of contents index is an index into the
 * library's table of contents.  This is used as the starting point of the
 * binary search or a directed linear search.
 *)

type twolevel_hint = {
  isub_image: int [@size 8]; 
  itoc: bytes [@size 24]; 
}

(*
 * The prebind_cksum_command contains the value of the original check sum for
 * prebound files or zero.  When a prebound file is first created or modified
 * for other than updating its prebinding information the value of the check sum
 * is set to zero.  When the file has it prebinding re-done and if the value of
 * the check sum is zero the original check sum is calculated and stored in
 * cksum field of this load command in the output file.  If when the prebinding
 * is re-done and the cksum field is non-zero it is left unchanged from the
 * input file.
 *)

type prebind_cksum_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  cksum: int [@size 4]; 
}

(*
 * The uuid load command contains a single 128-bit unique random number that
 * identifies an object produced by the static link editor.
 *)
type uuid_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  uuid: bytes [@size 16]; 
}

let sizeof_uuid_command = 24

(*
 * The rpath_command contains a path which at runtime should be added to
 * the current run path used to find @rpath prefixed dylibs.
 *)
type rpath_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  path: lc_str [@size 4]; 
}

let sizeof_rpath_command = 12

(*
 * The linkedit_data_command contains the offsets and sizes of a blob
 * of data in the __LINKEDIT segment.  
 *)
type linkedit_data_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  dataoff: int [@size 4]; 
  datasize: int [@size 4]; 
}

let sizeof_linkedit_data_command = 16

(*
 * The encryption_info_command contains the file offset and size of an
 * of an encrypted segment.
 *)
type encryption_info_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  cryptoff: int [@size 4]; 
  cryptsize: int [@size 4]; 
  cryptid: int [@size 4]; 
}

let sizeof_encryption_info_command = 20

(*
 * The encryption_info_command_64 contains the file offset and size of an
 * of an encrypted segment (for use in x86_64 targets).
 *)
type encryption_info_command_64 = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  cryptoff: int [@size 4]; 
  cryptsize: int [@size 4]; 
  cryptid: int [@size 4]; 
  pad: int [@size 4]; 
}

let sizeof_encryption_info_command_64 = 24

(*
 * The version_min_command contains the min OS version on which this 
 * binary was built to run.
 *
 * LC_VERSION_MIN_MACOSX or LC_VERSION_MIN_IPHONEOS  *)
type version_min_command = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
  version: int [@size 4]; 
  sdk: int [@size 4]; 
}

let sizeof_version_min_command = 16 

(*
struct dyld_info_command {
    uint32_t   cmd;  
    uint32_t   cmdsize;  
    uint32_t   rebase_off; 
    uint32_t   rebase_size; 
    uint32_t   bind_off; 
    uint32_t   bind_size; 
    uint32_t   weak_bind_off; 
    uint32_t   weak_bind_size;  
    uint32_t   lazy_bind_off; 
    uint32_t   lazy_bind_size;  
    uint32_t   export_off; 
    uint32_t   export_size; 
};
 *)

type dyld_info_command = 
  {
    cmd: int [@size 4];
    cmdsize: int [@size 4];
    rebase_off: int [@size 4];
    rebase_size: int [@size 4];
    bind_off: int [@size 4];
    bind_size: int [@size 4];
    weak_bind_off: int [@size 4];
    weak_bind_size: int [@size 4];
    lazy_bind_off: int [@size 4];
    lazy_bind_size: int [@size 4];
    export_off: int [@size 4];
    export_size: int [@size 4];
  }

let sizeof_dylib_info_command = 48

(*
 * The linker_option_command contains linker options embedded in object files.
 *)
type linker_option_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4];
  count: int [@size 4];	
}

let sizeof_linker_option_command = 12

(*
 * The symseg_command contains the offset and size of the GNU style
 * symbol table information as described in the header file <symseg.h>.
 * The symbol roots of the symbol segments must also be aligned properly
 * in the file.  So the requirement of keeping the offsets aligned to a
 * multiple of a 4 bytes translates to the length field of the symbol
 * roots also being a multiple of a long.  Also the padding must again be
 * zeroed. (THIS IS OBSOLETE and no longer supported).
 *)
type symseg_command =  {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  offset: int [@size 4]; 
  size: int [@size 4]; 
}

let sizeof_symseg_command = 16

(*
 * The ident_command contains a free format string table following the
 * ident_command structure.  The strings are null terminated and the size of
 * the command is padded out with zero bytes to a multiple of 4 bytes/
 * (THIS IS OBSOLETE and no longer supported).
 *)
type ident_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
}

let sizeof_ident_command = 8

(*
 * The fvmfile_command contains a reference to a file to be loaded at the
 * specified virtual address.  (Presently, this command is reserved for
 * internal use.  The kernel ignores this command when loading a program into
 * memory).
 *)
type fvmfile_command = {
  cmd: int [@size 4]; 
  cmdsize: int [@size 4]; 
  name: lc_str [@size 4]; 
  header_addr: int [@size 4]; 
}

let sizeof_fvmfile_command = 16

(*
 * The entry_point_command is a replacement for thread_command.
 * It is used for main executables to specify the location (file offset)
 * of main().  If -stack_size was used at link time, the stacksize
 * field will contain the stack size need for the main thread.
 *)
type entry_point_command = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
  entryoff: int [@size 8]; 
  stacksize: int  [@size 8];
}

let sizeof_entry_point_command = 24 

(*
 * The source_version_command is an optional load command containing
 * the version of the sources used to build the binary.
 *)
type source_version_command = {
  cmd: int [@size 4];
  cmdsize: int [@size 4];
  version: int [@size 8];
}

(*
 * The LC_DATA_IN_CODE load commands uses a linkedit_data_command 
 * to point to an array of data_in_code_entry entries. Each entry
 * describes a range of data in a code section.
 *)
type data_in_code_entry = {
  offset: int [@size 4]; 
  length: int [@size 2]; 
  kind: int [@size 2]; 
}






(* 
type unimplemented_command = {
  cmd: int;                     
  cmdsize: int;                 (* 4 we'll just read past the cmdsize and hope that it actually has a cmdsize value...*) 
}
 *)

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

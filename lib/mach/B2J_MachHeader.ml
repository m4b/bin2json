open Mach.Header
open B2J_Json

(* 
type t = {
  magic:int;
  cputype:int;
  cpusubtype:int;
  caps:int;
  filetype:int;
  ncmds:int;
  sizeofcmds:int;
  flags:int;
  reserved:int;
}
 *)

let to_json (header) = 
  let meta = 
    [
      "size", to_number sizeof_mach_header;
      "bytes", to_byte_array
        [4; 4; 2; 2; 2; 4;
         4; 4; 4; 4;];
      ("computedPrefix", `String "_")
    ] in

  let json =
    [
      "magic" , to_hex header.magic;
      "cputype", to_hex header.cputype;
      "cpusubtype", to_hex header.cpusubtype;
      "caps", to_hex header.caps;
      "filetype", to_hex header.filetype;
      "ncmds", to_hex header.ncmds;
      "sizeofcmds", to_hex header.sizeofcmds;
      "flags", to_hex header.flags;
      "reserved", to_hex header.reserved;
      "_type", `String (Mach.Header.filetype_to_string header.filetype);
      (* "_flagString", `String (Mach.Header.flag_to_string header.flags); *)
    ] in
  `O [
    "value", `O json;
    "meta", `O meta;
  ]



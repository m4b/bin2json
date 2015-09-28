module Json = B2J_Json
module Config = B2J_Config
module Coverage = B2J_ByteCoverage

module Header = B2J_ElfHeader
module ProgramHeader = B2J_ElfProgramHeader
module SectionHeader = B2J_ElfSectionHeader
module SymbolTable = B2J_ElfSymbolTable
module Dynamic = B2J_ElfDynamic
module Reloc = B2J_ElfReloc

let sort symbols =
  List.sort (fun a b ->
      Pervasives.compare a.Elf.SymbolTable.st_value b.Elf.SymbolTable.st_value
    ) symbols

let slide_sectors_to_json ss =
  `A (List.map (fun elem ->
      `O [("begin", Json.to_hex elem.Elf.ProgramHeader.start_sector);
          ("end", Json.to_hex elem.Elf.ProgramHeader.end_sector);
          ("slide", Json.to_hex elem.Elf.ProgramHeader.slide);
         ]
    ) ss)

let keys = [
  (* elf keys *)
  "programHeaders";
  "sectionHeaders";
  "_dynamic";
  "dynamicSymbols";
  "symbolTable";
  "relocations";
  "interpreter";
  "slideSectors";]

let to_json binary config =
  let elf = Elf.get ~meta_only:true binary in
  let header = Header.to_json elf.Elf.header in
  let program_headers = ProgramHeader.to_json elf.Elf.program_headers in
  let section_headers = SectionHeader.to_json  elf.Elf.section_headers in
  let _dynamic = Dynamic.to_json elf.Elf._dynamic in
  let dynamic_symbols = Dynamic.dynamic_symbols2json (elf.Elf.dynamic_symbols |> sort) in
  let symbol_table = SymbolTable.to_json (elf.Elf.symbol_table |> sort)in
  let relocs = Reloc.to_json elf.Elf.relocations in
  let libraries = `A (List.map (fun lib -> `String lib)
                        elf.Elf.libraries)
  in
  let slide_sectors = Elf.ProgramHeader.get_slide_sectors elf.Elf.program_headers
                      |> slide_sectors_to_json in
  let coverage = if (config.Config.include_coverage) then
      Coverage.to_json elf.Elf.byte_coverage
    else
      `Null
  in
  let b64 = if (config.Config.include_base64) then
      `String (B64.encode binary)
    else
      `Null
  in
  let architecture =
    Elf.Constants.machine_to_string
      elf.Elf.header.Elf.Header.e_machine
  in
  let json =
    `O [
      "header", header;
      "programHeaders", program_headers;
      "sectionHeaders", section_headers;
      "_dynamic", _dynamic;
      "dynamicSymbols", dynamic_symbols;
      "symbolTable", symbol_table;
      "relocations", relocs;
      "slideSectors", slide_sectors;
      "libraries", libraries;
      "container", `String "ELF";
      "architecture", `String architecture;
      "arch", `String (B2J_Utils.get_arch architecture);
      "mode", Json.to_number (B2J_Utils.get_mode architecture);
      "soname", `String elf.Elf.soname;
      "name", `String elf.Elf.soname;
      "interpreter", `String elf.Elf.interpreter;
      "isLib", `Bool elf.Elf.is_lib;
      "is64", `Bool elf.Elf.is_64;
      "size", Json.to_number elf.Elf.size;
      "entry", Json.i64_to_hex elf.Elf.entry;
      "coverage", coverage;
      "base64", b64;
    ]
  in json

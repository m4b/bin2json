module Json = B2J_Json
module Config = B2J_Config
module Coverage = B2J_ByteCoverage

module Header = B2J_MachHeader
module Export = B2J_MachExport
module Import = B2J_MachImport
module LoadCommand = B2J_MachLoadCommand
module SymbolTable = B2J_MachSymbolTable
(* 
let sort symbols =
  List.sort (fun a b ->
      Pervasives.compare a.Elf.SymbolTable.st_value b.Elf.SymbolTable.st_value
    ) symbols
 *)

let keys = [
  (* elf keys *)
  "loadCommands";
  "exports";
  "imports";
  "symbols";]

let to_json binary config =
  let mach = Mach.get binary in
  let header = Header.to_json mach.Mach.header in
  let load_commands = LoadCommand.to_json mach.Mach.load_commands in
  let libraries = `A ((Array.map (fun lib -> `String lib)
                        mach.Mach.libraries) |> Array.to_list |> List.tl)
  in
  let exports = Export.to_json mach.Mach.exports in
  let imports = Import.to_json mach.Mach.imports in
  let symbols = SymbolTable.to_json mach.Mach.nlist in
  let coverage = if (config.Config.include_coverage) then
      Coverage.to_json mach.Mach.byte_coverage
    else
      `Null
  in
  let b64 = if (config.Config.include_base64) then
      `String (B64.encode binary)
    else
      `Null
  in
  let json =
    `O [
      "header", header;
      "loadCommands", load_commands;
      "exports", exports;
      "imports", imports;
      "symbols", symbols;
      "libraries", libraries;
      "container", `String "Mach-o";
      "arch", `String (MachCpuTypes.cpu_type_to_string mach.Mach.header.Mach.Header.cputype);
      "soname", `String mach.Mach.name;
      "isLib", `Bool mach.Mach.is_lib;
      "is64", `Bool true;       (* fix this? *)
      "size", Json.to_number mach.Mach.size;
      "coverage", coverage;
      "base64", b64;
    ]
 in json

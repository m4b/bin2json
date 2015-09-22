module Json = B2J_Json
module Config = B2J_Config
module Coverage = B2J_ByteCoverage

module Header = B2J_PEHeader
module SectionTable = B2J_PESectionTable
module Export = B2J_PEExport
module Import = B2J_PEImport

let keys = [
  (* pe keys *)
  "sectionTable";
  "exports";
  "imports";
]

let to_json binary config =
  let pe = PE.get binary in
  let header = Header.to_json pe.PE.header in
  let sections = SectionTable.to_json pe.PE.sections in
  let libraries = `A (List.map (fun lib -> `String lib)
                         pe.PE.libraries)
  in
  let exports = Export.to_json pe.PE.exports in
  let imports = Import.to_json pe.PE.imports in
  (*   let symbols = SymbolTable.to_json pe.PE.nlist in *)
  let coverage = if (config.Config.include_coverage) then
      Coverage.to_json pe.PE.byte_coverage
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
      "sections", sections;
      "exports", exports;
      "imports", imports;
      (*       "symbols", symbols; *)
      "libraries", libraries;
      "container", `String "PE32";
      "arch", `String (PE.MachineType.show_machine pe.PE.header.PEHeader.coff_header.PEHeader.machine);
      "name", `String pe.PE.name;
      "isLib", `Bool pe.PE.is_lib;
      "is64", `Bool false;      (* fix this? *)
      "size", Json.to_number pe.PE.size;
      "coverage", coverage;
      "base64", b64;
      "entry", Json.i64_to_hex pe.PE.entry
    ]
 in json

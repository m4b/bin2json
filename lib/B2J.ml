module Json = B2J_Json
module Config = B2J_Config
module Coverage = B2J_ByteCoverage
module Elf = B2J_Elf
module Mach = B2J_Mach
module PE = B2J_PE

let commonKeys = [
  "header";
  "libraries";
  "container";
  "arch";
  "soname";
  "isLib";
  "is64";
  "size";
  "coverage";
  "base64"]

let keys = commonKeys @ Elf.keys @ Mach.keys @ PE.keys

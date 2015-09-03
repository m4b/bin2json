open Mach.LoadCommand.Types
open B2J_MachLoadCommandTypes
open B2J_Json

let to_json (lcs:Mach.LoadCommand.t) :B2J_Json.t =
  let meta = `O
    [
      "computedPrefix", `String "_"
    ]
  in
  `O [
    "value", `A (List.map lc_to_json lcs);
    "meta", meta;
  ]

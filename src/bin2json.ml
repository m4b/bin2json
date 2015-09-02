open LibRdr.Utils
open LibRdr.Object
open B2J.Json
open B2J.Config

let version = "v1.0.0"

let get_json config :B2J.Json.t =
  let result = LibRdr.Object.get config.install_name in
  begin
  match result with
  | Elf binary ->
    B2J.Elf.to_json binary config
  | Mach binary ->
    B2J.Mach.to_json binary config
  | Unknown (filename, error) ->
    begin
      B2J.Json.print ~minify:false
        (`O ["error",
             `String error]);
      exit 1
    end
  | PE binary ->
    begin
      B2J.Json.print ~minify:false
        (`O ["error",
             `String "Unsupported binary format"]);
      exit 1
    end
  end
  |> add_key "version" (`String version)

let print_version = ref false
let minify = ref false
let include_coverage = ref false
let include_base64 = ref false
let binary = ref ""
let only = ref ""
let set_anon_argument string =
  binary := string
let set_only symbol =
  only := symbol

let init_config () =
  let install_name =
    if (Filename.is_relative !binary) then
      (Sys.getcwd()) ^ Filename.dir_sep ^ !binary
    else
      !binary
  in
  let name = Filename.basename install_name in
  {
    B2J.Config.minify = !minify; 
    include_coverage = !include_coverage; 
    include_base64 = !include_base64;
    install_name;
    only = !only <> "";
    name
  }

let rec get_only_it (key:string) json =
  match json with
  | [] -> `O ["error" , `String ("key '" ^ !only ^ "' does not exist in binary")]
  | (k,value)::rest ->
    if (key = k) then
      `O [(k,value)]
    else
      get_only_it key rest

let get_only output_only (json:B2J.Json.t) =
  if (output_only) then 
    match json with 
    | `O fields -> get_only_it !only fields
    | _ -> invalid_arg "Malformed JSON in output"
  else json

let main =
  let speclist = 
    [("-m", Arg.Set minify, "Minify the json output; default false");
     ("--minify", Arg.Set minify, "Minify the json output; default false");
     ("-b", Arg.Set include_base64, "Include the binary as a base64 encoded string; default false");
     ("--base64", Arg.Set include_base64, "Include the binary as a base64 encoded string; default false");
     ("-c", Arg.Set include_coverage, "Output data from the byte coverage algorithm; default false");
     ("--coverage", Arg.Set include_coverage, "Output data from the byte coverage algorithm; default false");
     ("-v", Arg.Set print_version, "Prints the version");
     ("-o", Arg.Symbol ("version"::B2J.keys, set_only), "Only print a particular key in the JSON object");
     ("--only", Arg.Symbol ("version"::B2J.keys, set_only), "Only print a particular key in the JSON object");
    ] in
  let usage_msg = "usage: bin2json [-m --minify] [-b --base64] [-c --coverage] <path_to_binary>\noptions:" in
  Arg.parse speclist set_anon_argument usage_msg;
  let config = init_config() in
  if (!print_version) then
    Printf.printf "%s\n" @@ version
  else
  if (!binary = "") then
    begin
      Printf.eprintf "Error: no path to binary given\n";
      Arg.usage speclist usage_msg;
      exit 1
    end
  else
    get_json config
    |> get_only config.only
    |> B2J.Json.print ~minify:config.minify

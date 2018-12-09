module L = List
module YB = Yojson.Basic
module YBU = YB.Util

let extract json util field = json |> YBU.member field |> util
let string_of_bool_option = function
    | None -> "<unknown>"
    | Some true -> "True"
    | Some false -> "False"

let () =
    let json = YB.from_file "example.json" in
    let extr_json util field = extract json util field in

    let title = extr_json YBU.to_string "title" in
    let pages = string_of_int @@ extr_json YBU.to_int "pages" in
    let is_ol = string_of_bool @@ extr_json YBU.to_bool "is_online" in
    let is_tr =
        string_of_bool_option
        @@ extr_json YBU.to_bool_option "is_translated" in
    let tags = extr_json YBU.to_list "tags" |> YBU.filter_string in

    let nested_json = extr_json YBU.to_list "authors" in
    let authors =
        L.map
            (fun author -> extract author YBU.to_string "name") nested_json in

    let output = (title::pages::is_ol::is_tr::tags) @ authors in
    L.iter (fun str -> print_endline str) output

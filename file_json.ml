module L = List
module YB = Yojson.Basic
module YBU = Yojson.Basic.Util

let extract json util field = json |> YBU.member field |> util
let string_of_bool_option = function
    | None -> "<unknown>"
    | Some true -> "True"
    | Some false -> "False"

let () =
    let json = YB.from_file "example.json" in

    let title = extract json YBU.to_string "title" in
    let pages = string_of_int @@ extract json YBU.to_int "pages" in
    let is_tr =
        string_of_bool_option
        @@ extract json YBU.to_bool_option "is_translated" in
    let is_ol =
        string_of_bool_option
        @@ extract json YBU.to_bool_option "is_online" in
    let tags = extract json YBU.to_list "tags" |> YBU.filter_string in

    let nested_json = extract json YBU.to_list "authors" in
    let authors =
        L.map
            (fun author -> extract author YBU.to_string "name") nested_json in

    let output = (title::pages::is_tr::is_ol::tags) @ authors in
    L.iter (fun str -> print_endline str) output

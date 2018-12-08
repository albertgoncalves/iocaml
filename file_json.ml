module L = List
module YB = Yojson.Basic
module YBU = Yojson.Basic.Util

let extract json util field = json |> YBU.member field |> util

let () =
    let json = YB.from_file "example.json" in

    let title = extract json YBU.to_string "title" in
    let authors =
        L.map
            (fun author -> extract author YBU.to_string "name")
        @@ extract json YBU.to_list "authors" in
    let pages = string_of_int @@ extract json YBU.to_int "pages" in

    L.iter (fun str -> print_endline str) (title::pages::authors)

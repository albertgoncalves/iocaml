module L = List
module BF = BatFile
module BE = BatEnum
module S = Str

let parse p str n =
    if S.string_match p str 0 then S.matched_group n str
    else "[INFO] no match found"

let () =
    let filename = "example.txt" in
    let p = S.regexp "\\(.*\\.\\) \\(.*\\)" in
    let print_group i =
        let lines = BF.lines_of filename in
        let lambda line = print_endline @@ parse p line i in
        BE.iter lambda lines;
        print_newline () in
    L.iter print_group [1;2]

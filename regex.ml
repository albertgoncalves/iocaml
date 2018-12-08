module BF = BatFile
module BE = BatEnum
module S = Str

let parse p str n =
    if S.string_match p str 0 then S.matched_group n str
    else "[INFO] \"No match found.\""

let () =
    let filename = "example.txt" in
    let p = S.regexp "\\(.*\\.\\) \\(.*\\)" in
    let print_group i =
        let lines = BF.lines_of filename in
        BE.iter (fun line -> print_endline @@ parse p line i) lines;
        print_newline () in
    List.iter (fun i -> print_group i) [1;2]

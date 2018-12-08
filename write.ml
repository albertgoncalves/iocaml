module L = List
module P = Printf

let write_to_file ~filename strs =
    let out_channel = open_out filename in
    L.iter (fun str -> P.fprintf out_channel "%s\n" str) strs;
    close_out out_channel

let () =
    let strs = [ "Message from inside the Camel."
               ; "Seems like it works."
               ] in
    let filename = "output.txt" in
    write_to_file filename strs

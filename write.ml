module L = List
module P = Printf

let finally (f : unit -> 'a) (resolve : unit -> 'b) : 'a =
    let f_exception =
        try f () with error ->
            resolve ();
            raise error in
    resolve ();
    f_exception

let write_lines (out_channel : out_channel) : (string -> unit) =
    P.fprintf out_channel "%s\n"

let write_and_close (strings : string list) (out_channel : out_channel)
    : unit =
    finally
        (fun () -> L.iter (write_lines out_channel) strings)
        (fun () -> close_out out_channel)

let write_to_file (filename : string) (strings : string list) : unit =
    let out_channel = open_out filename in
    write_and_close strings out_channel

let append_to_file (filename : string) (strings : string list) : unit =
    let mode = [Open_wronly; Open_append; Open_creat; Open_text] in
    let permission = 0o666 in
    let out_channel = open_out_gen mode permission filename in
    write_and_close strings out_channel

let () =
    let strings =
        [ "Message from inside the Camel."
        ; "Seems like it works."
        ] in
    let filename = "output.txt" in
    L.iter
        (fun f -> f ())
        [ (fun () -> write_to_file filename strings)
        ; (fun () -> append_to_file filename strings)
        ]

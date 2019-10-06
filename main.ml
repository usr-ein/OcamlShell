(*
    Ocaml Shell V0.1
    sam1902 2019-10-05T23:47
    Suicide hotline: 1-800-273-8255
*)


(* 
opam install Core Unix;
echo "eval `opam config env`" >> ~/.zshrc;
Then add the following (with the #) to ~/.ocamlinit file:

#use "topfind"
#camlp4o
#thread
#require "core.top"
#require "core.syntax"

*)

(* open Core *)
open Unix

let split_str (str: string) (chara: char) : string list = 
    str
    |> String.split_on_char chara
    |> List.filter (fun s -> s <> "");;

let advanced_error_handling (exc: string) =
    let _ = Random.self_init () in
    let msg = match ((Random.int 100) mod 2) with
    | 0 -> "osh: ZANGO LE DOZO \n"
    | 1 -> "osh: OCaml fatal error \n"
    | _ -> "How ? \n" in 
    let _ = Unix.system (String.concat "" ["cowsay "; msg]) in
    0


let rec run (a: int) =
    let _ = (Printf.printf "OcAmL sHeLl $ ") in 
    let command = read_line () in
    let splitted = (split_str command ' ') in
    (* Checks for empty command *)
    let _ = if (List.length splitted) < 1 then (run a) else 1 in
    let prog = (List.nth splitted 0) in
    let _ = 
        match prog with
        | "cd" -> 
            let _ =
                if ((List.length splitted) < 2) || ((List.nth splitted 1) = "-") then
                    Unix.chdir "."
                else
                    Unix.chdir (List.nth splitted 1) in
            (run a)
        | "exit" ->
            let _ = Printf.printf "OcAmL IS THE BEST LANGUAGE\n" in
            exit 0
        | _ -> 1
    in
    let args = (Array.of_list splitted) in
    let cpid = Unix.fork () in
    if cpid != 0 then
        let _ = (Unix.waitpid [] cpid) in
        (run a)
    else
        let _ = () in
        try
            (Unix.execvp prog args)
        with
        | _ -> let _ = advanced_error_handling "Unix error" in exit 1
        
;;

run 42;;

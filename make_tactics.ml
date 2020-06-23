let re = Str.regexp "For \\([^ ]+\\) ->.*"

let read_db () =
  let rec loop acc =
    try
      let s = read_line () in
      let acc = if Str.string_match re s 0 then
                  Str.replace_matched "\\1" s :: acc
                else acc in
      loop acc
    with End_of_file -> List.rev acc in
  loop []

let print_db db =
  print_endline "  cbv [";
  List.iter (Printf.printf "    %s\n") db;
  print_endline "]."

let _ =
  print_endline "From deriving Require Import base ind.";
  print_endline "Declare Reduction deriving_compute :=";
  let db = read_db () in
  print_db db;
  print_endline "Ltac deriving_compute :=";
  print_db db

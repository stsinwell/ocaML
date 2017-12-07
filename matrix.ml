open Lacaml.S
open Str

type t = Mat.t

let mat_const m n c =
  Mat.random m n ~from:(c) ~range:(0.0)

let mat_random m n =
  Mat.random m n ~from:(-1.0) ~range:(2.0)

let mat_ones m n =
  Mat.random m n ~from:(1.0) ~range:(0.0)

let mat_zeros m n =
  Mat.random m n ~from:(0.0) ~range:(0.0)

let to_list m =
  Mat.to_list m

(* [floats_to_str l] converts a list of floats [l] to a string.*)
let floats_to_str (l : float list) =
  let rec loop acc = function
    | [] -> acc
    | h::t -> loop (acc ^ " " ^ string_of_float h) t
  in loop "" l

(* [strs_to_str l] converts a list of strings [l] to a string, where each
 * string is separated by a newline. *)
let strs_to_str (l : string list) =
  let rec loop acc = function
    | [] -> acc
    | h::t -> loop (acc ^ " " ^ h ^ "\n") t
in loop "" l

let save m =
  let file_no = ref 0 in
  let file = open_out ("./matrices/matrix" ^ string_of_int !file_no ^ ".txt") in
  Printf.fprintf file "%s" (to_list m
                            |> List.map (fun x -> floats_to_str x)
                            |> strs_to_str);
  close_out file;
  incr file_no

(* [file_to_list filename] reads a file and creates a list of its contents,
 * where each line is a list within the larger list. *)
let file_to_list filename =
  let ch = open_in filename in
  let rec parse_file ch acc =
    match input_line ch with
    | exception End_of_file -> close_in ch; acc
    | line -> parse_file ch (Str.split (regexp " ") line::acc)
  in parse_file ch []

let load filename =
  file_to_list filename
  |> List.map (fun x -> List.map (fun y -> float_of_string y) x)
  |> Mat.of_list

open OUnit2
open Gui

let rec print_list = function
  | [] -> ()
  | h::t -> print_float h; print_string ","; print_list t

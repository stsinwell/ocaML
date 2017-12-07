open Model 
open Layer
open Lacaml.S
open Lacaml.Io
open Actv
open Matrix
let network = [(new_layer 784 64 sigmoid);
(new_layer 64 32 sigmoid);
(new_layer 32 10 sigmoid)]


let input = mat_random 784 1

let out = propagate network input



let () = 
  let rec helper y = 
    match y with
    |[] -> ()
    | h::t -> let a = h in
          let rows, cols = (Mat.dim1 a), (Mat.dim2 a) in
          Format.printf "@[<2>This is an indented random matrix:@\n@\n%a@]@."
            (Lacaml.Io.pp_lfmat
              ~row_labels:
                (Array.init rows (fun i -> Printf.sprintf "Row %d" (i + 1)))
              ~col_labels:
                (Array.init cols (fun i -> Printf.sprintf "Col %d" (i + 1)))
              ~vertical_context:(Some (Context.create 2))
              ~horizontal_context:(Some (Context.create 3))
              ~ellipsis:"*"
              ~print_right:false
              ~print_foot:false ())
            a; helper t in
    helper out


(* let () =
  let a =  in
  let rows, cols = (Mat.dim1 a), (Mat.dim2 a) in
  Format.printf "@[<2>This is an indented random matrix:@\n@\n%a@]@."
    (Lacaml.Io.pp_lfmat
      ~row_labels:
        (Array.init rows (fun i -> Printf.sprintf "Row %d" (i + 1)))
      ~col_labels:
        (Array.init cols (fun i -> Printf.sprintf "Col %d" (i + 1)))
      ~vertical_context:(Some (Context.create 2))
      ~horizontal_context:(Some (Context.create 3))
      ~ellipsis:"*"
      ~print_right:false
      ~print_foot:false ())
    a

let () =
  let a = input in
  let rows, cols = (Mat.dim1 a), (Mat.dim2 a) in
  Format.printf "@[<2>This is an indented random matrix:@\n@\n%a@]@."
    (Lacaml.Io.pp_lfmat
      ~row_labels:
        (Array.init rows (fun i -> Printf.sprintf "Row %d" (i + 1)))
      ~col_labels:
        (Array.init cols (fun i -> Printf.sprintf "Col %d" (i + 1)))
      ~vertical_context:(Some (Context.create 2))
      ~horizontal_context:(Some (Context.create 3))
      ~ellipsis:"*"
      ~print_right:false
      ~print_foot:false ())
    a *)
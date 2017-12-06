open Model 
open Layer
open Lacaml.S
open Lacaml.Io
open Actv

let network = [(new_layer 2 2 sigmoid);
               (new_layer 2 2 sigmoid);
               (new_layer 2 2 sigmoid)
               ]


let input = Mat.random 2 10

let y = propagate network input




let () =
  let a = y in
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
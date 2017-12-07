open Model 
open Layer
open Lacaml.S
open Lacaml.Io
open Actv
open Matrix
open Loss

let print m = 
  let () =
      let a = m in
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
      m in ()



let model= [
  (new_layer 5 5 sigmoid);
  (new_layer 5 2 sigmoid)

]

let network = {
    model = model;
    loss = cat_crossentropy
}


(*data and labels*)
let x = mat_random 5 1 
let y = mat_const 2 1 1.0
let x1 = mat_random 5 1 
let y1 = mat_const 2 1 0.0

let fwd1 = propagate network.model x
let new_net = full_pass network x y 

let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 
let new_net = full_pass new_net x y 
let new_net = full_pass new_net x1 y1 

let fwd1 = propagate new_net.model x
let fwd2 = propagate new_net.model x1






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
    helper fwd1;

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
    helper fwd2 in ();

   
  


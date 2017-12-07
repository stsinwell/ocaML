open Model
open Layer
open Lacaml.D
open Lacaml.Io
open Actv
open Matrix
open Loss
open Dsfo
open Bigarray

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
  (new_layer 784 64 sigmoid);
  (new_layer 64 10 sigmoid)

]

let network = {
  model = model;
  loss = cat_crossentropy
}


let decode dt i =
  let w = 784 in
  let v = Array2.slice_right dt i in
  let m =
    Array1.sub v 1 w |> genarray_of_array1 in
  let m = (reshape_2 m w 1) in

  let label = Array1.sub v (w + 1) 10 |> genarray_of_array1 in
  let label = (reshape_2 label 10 1) in m, label


let train_set = Mnist.data `Train

let x, y = decode train_set 2

let new_net = train network train_set 10 1 ~id:"mnist" ()

let () = print y
let fst = infer (snd new_net) (save_weights "x" x)

let () = print_int fst

(* Save/load tests *)
(* let layer0 = {a = sigmoid; w = mat_ones 5 5; b = mat_ones 5 1}
   let layer1 = {a = sigmoid; w = mat_zeros 4 2; b = mat_ones 4 1}
   let model_test = [layer0; layer1]
   let _ = save_m "./matrices/model_test5" model_test |> load_m
        |> save_m "./matrices/model_test6"

   let network_test = { model = model_test; loss = cat_crossentropy }
   let _ = save_net "model_test0" network_test
        |> load_net cat_crossentropy
        |> save_net "model_test1" *)

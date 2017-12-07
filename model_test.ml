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
         ~vertical_context:(Some (Context.create 784))
         ~horizontal_context:(Some (Context.create 784))
         ~ellipsis:"*"
         ~print_right:false
         ~print_foot:false ())
      m in ()

let model= [
  (new_layer 784 64 sigmoid);
  (new_layer 64 32 sigmoid);
  (new_layer 32 10 sigmoid)
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
    let temp = (reshape_2 m 28 28) in
    print temp;
    let m = Mat.transpose_copy temp in
    let m = genarray_of_array2 m in
  let m = (reshape_2 m 784 1) in

  let label = Array1.sub v (w + 1) 10 |> genarray_of_array1 in
  let label = (reshape_2 label 10 1) in m, label

let train_set = Mnist.data `Train

let x, y = decode train_set 408

let () = print y

let new_net = train network train_set 2000 1 ~id:"mnist" ()

let fst = infer (snd new_net) (save_weights "x" x)

let () = print_int fst

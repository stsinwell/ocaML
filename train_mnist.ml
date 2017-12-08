open Model
open Layer
open Lacaml.D
open Lacaml.Io
open Actv
open Matrix
open Loss
open Dsfo
open Bigarray

(* [print m] prints the layer to the console in a readable format. *)
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

(* A model with three layers. *)
let model = [
  (new_layer 784 64 sigmoid);
  (new_layer 64 32 sigmoid);
  (new_layer 32 10 sigmoid)
]

(* Initialize network with the previously defined model and a loss function. *)
let network = {
  model = model;
  loss = cat_crossentropy
}

(* [decode dt i] decodes the MNIST dataset. *)
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

(* [x] is the datapoint and [y] is the label for that datapoint. The output of
 * the neural network classification, below, can be checked for correctness
 * against its actual label [y]. *)
let x, y = decode train_set 8000

(* Train the network. The step and epoch parameters can be changed for varying
 * results. *)
let new_net = train network train_set 200 1 ~id:"mnist" ()

(* Infer what digit data point [x] is *)
let fst = infer (fst new_net) x

let () = print_int fst
let () = print y

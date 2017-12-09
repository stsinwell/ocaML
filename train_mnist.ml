open Model
open Layer
open Lacaml.D
open Lacaml.Io
open Actv
open Matrix
open Loss
open Dsfo
open Bigarray


let rec print_model m =
    match m with
    | [] -> ()
    | h::t -> print h.w; print_model t 

(* A model with three layers. *)
let model = [
  (new_layer 784 32 softplus);
  (new_layer 32 10 softmax)
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
let x, y = decode train_set 5490

(* Train the network. The step and epoch parameters can be changed for varying
 * results. *)
let new_net = train network train_set 60000 1 ~id:"mnist" ()


let out1 = infer (fst new_net) x

let d = "."^Filename.dir_sep^"matrices"^Filename.dir_sep
let load_mnist =
  let layer1 = load_layer softplus
               (d^"saved_net-mnist-model-0wgt.txt")
               (d^"saved_net-mnist-model-0bias.txt") in
  let layer2 = load_layer softmax
               (d^"saved_net-mnist-model-1wgt.txt")
               (d^"saved_net-mnist-model-1bias.txt") in
  let model = [layer1; layer2] in
  { model = model; loss = Loss.cat_crossentropy}

let out = infer load_mnist x
let () = print y
let () = print_int out
let () = print_int out1
(* Infer what digit data point [x] is *)
(* let fst = infer (fst new_net) x *)

(* let () = print_int fst
let () = print y *)

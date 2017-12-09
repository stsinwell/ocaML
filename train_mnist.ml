open Model
open Layer
open Actv
open Loss
open Dsfo


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

let train_set = Mnist.data `Train



let train_set = Mnist.data `Train 
let net = train network train_set 60000 3 ~id:"mnist" ()

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


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
let _ = train network train_set 60000 1 ~id:"mnist" ()

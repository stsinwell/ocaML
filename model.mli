open Lacaml.D
open Layer
open Matrix
open Loss

type matrix = Matrix.t
type layer = Layer.t
type loss = Loss.t

(* [model] represents the entire neural network, which is a
 * list of layers. *)
type model = layer list

type network  = {
  model : model;
  loss : loss
}

(* [propagate model matrix] propagates [matrix] through the neural
 * network represented by [model] and returns the activation matrix list.
 * requires: the column space of [matrix] must match the row space
             of the first layer in [model] *)
val propagate: model -> matrix -> matrix list

(* [backpropagate model m1 m2 loss] performs the backpropagation
 * algorithm on [model], given the reference matrix [m1] and the
 * entire model's output matrix [m2]. *)
val backpropagate: model -> matrix list -> matrix -> matrix list

(* [get_category m] is the index of the max value in the probability
 * distribution given by matrix [m].
 * requires: [m] is a vector. *)
(* val get_category: matrix -> int *)

val full_pass: network -> matrix -> matrix -> network


val train: network -> matrix -> int -> int -> ?id:string -> unit ->
  (network * ((string * string) list))

(* [infer n m] is the index of the max value in the probability
 * distribution given by matrix [m].
 * requires: [m] is a vector. *)
(* val get_category: matrix -> int *)
val infer: (string * string) list -> string -> int

(* [save_m m id] saves the weights and biases of all the layers in model [m] as
 * matrix text files. It returns an association list of (weight file names,
   bias file names). The saved files have id [id]. *)
val save_m: string -> model -> (string * string) list

(* [load_m m] takes in an association list of (weight file names, bias file
 * names) and creates a model based off of them where each pair is a layer. *)
val load_m: (string * string) list -> model

(* [save_net id n] saves the model in network [n] to files with id [id]. *)
val save_net: string -> network -> (string * string) list

(* [load_net l files] is a network with a model loaded from [files] and loss
 * function [l]. ]*)
val load_net: loss -> (string * string) list -> network

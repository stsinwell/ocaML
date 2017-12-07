open Lacaml.S
open Layer
open Matrix
open Loss

type matrix = Matrix.t
type layer = Layer.t

(* [model] represents the entire neural network, which is a
 * list of layers. *)
type model = layer list

type network  = {
  model : model;
  loss : Loss.t
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
val get_category: matrix -> int


val full_pass: network -> matrix -> matrix -> network


val train: model -> matrix -> matrix

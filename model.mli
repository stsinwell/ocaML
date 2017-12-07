(* model.mli *)
open Lacaml.S
open Layer
open Matrix
open Loss

type matrix
type layer
(* [model] represents the entire neural network, which is a
 * list of layers. *)
type model
type network


(* [propagate model matrix] propagates [matrix] through the neural
 * network represented by [model] and returns the activation (the
 * output from the last layer).
 * requires: the column space of [matrix] must match the row space
             of the first layer in [model] *)
val propagate: model -> matrix -> matrix list

(* [backpropagate model m1 m2 loss] performs the backpropagation
 * algorithm on [model], given the reference matrix [m1] and the
 * entire model's output matrix [m2]. *)
val backpropagate: model -> matrix -> matrix -> matrix list

(* [get_category m] is the index of the max value in the probability
 * distribution given by matrix [m].
 * requires: [m] is a vector. *)
val get_category: matrix -> int


val full_pass: network -> matrix -> network


val train: model -> matrix -> matrix

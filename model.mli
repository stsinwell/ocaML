(* model.mli *)
open Layer
open Nlmf
open Matrix


(* [model] represents the entire neural network, which is a 
 * list of layers. *)
type model = 
  {layers : layer list;
  cost : nlmf}

(* [add_layer model matrix] adds a matrix layer [matrix] to the 
 * neural network represented by [model]. 
 * requires: column space of last layer in [model] must equal
 *           row space of [matrix] *)
val add_layer: model -> matrix -> matrix

(* [propagate model matrix] propagates [matrix] through the neural
 * network represented by [model] and returns the activation (the
 * output from the last layer).
 * requires: the column space of [matrix] must match the row space
             of the first layer in [model] *)
val propagate: model -> matrix -> matrix

(* [backpropagate model m1 m2 loss] performs the backpropagation 
 * algorithm on [model], given the reference matrix [m1] and the
 * entire model's output matrix [m2]. *)
val backpropagate: model -> matrix -> matrix -> matrix

(* [get_category m] is the index of the max value in the probability 
 * distribution given by matrix [m].
 * requires: [m] is a vector. *)
val get_category: matrix -> int


val train: model -> matrix -> matrix

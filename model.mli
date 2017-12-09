open Lacaml.D
open Layer
open Matrix
open Loss
open Actv

type matrix = Matrix.t
type layer = Layer.t
type loss = Loss.t

(* [model] represents a list of layers. *)
type model = layer list

(* [network] represents the entire neural network, which includes a model
 * and a loss function. *)
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

(* [full_pass n x y] performs gradient update on the model weights and biases
 * by propagating some input, calculating the gradient for the output loss,
 * and backpropagating the gradient to update the weights and biases. It
 * returns the network updated with these weights and biases. [x] is the
 * data point, and [y] is that data point's label. *)
val full_pass : network -> matrix -> matrix -> network

(* [train n x steps epoch ?id] samples over the inputted dataset [x] and updates
 * the network [n] iteratively in memory. Its output is the network and a list
 * of saved files that enable later loading of the network. The network iterates
 * [epoch] times, where each epoch consists of a number of [steps]. The optional
 * argument [?id] can be used to save the network with a specific ID tag. *)
val train: network -> matrix -> int -> int -> ?id:string -> unit ->
  (network * ((string * string) list))

(* [infer n m] is the index of the max value in the probability
 * distribution given by matrix [m].
 * requires: [m] is a vector. *)
val infer: network -> matrix -> int

(* [save_m m id] saves the weights and biases of all the layers in model [m] as
 * matrix text files. It returns an association list of (weight file names,
   bias file names). The saved files have id [id]. *)
val save_m: string -> model -> (string * string) list


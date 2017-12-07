open Lacaml.D
open Actv
open Matrix

type matrix = Matrix.t
type actv = Actv.t

(* [t] represents a layer. A layer consists of an activation type [a], a
 * matrix of weights [w], and a matrix of biases [b]. *)
type t = {
  a : actv;
  w : matrix;
  b : matrix;
}

(* [new_layer m n a1] creates a new layer with activation function [a1], a
 * random weight matrix of size nxm, and a random bias matrix of size nx1. *)
val new_layer : int -> int -> actv -> t

(* [load_layer act wf bf] is a layer with activation function [act], weights
 * loaded from the matrix file [wf], and biases loaded from the matrix file
 * [bf]. *)
val load_layer: actv -> string -> string -> t

(* [update_w_and_b l a g] updates the weights and biases of layer [l] using an
 * activation of weights [a] and backprop gradients [g]. *)
val update_w_and_b: t -> matrix -> matrix -> t

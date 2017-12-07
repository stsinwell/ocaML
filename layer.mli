open Lacaml.D
open Actv
open Matrix

type matrix = Matrix.t
type actv = Actv.t

type t = {
  a : actv;
  w : matrix;
  b : matrix;
}

val new_layer : int -> int -> actv -> t

(* [load_layer act wf bf] is a layer with activation function [act], weights
 * loaded from the matrix file [wf], and biases loaded from the matrix file
 * [bf]. *)
val load_layer: actv -> string -> string -> t


val update_w_and_b: t -> matrix -> matrix -> t

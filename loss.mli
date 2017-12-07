open Lacaml.D
open Matrix

type matrix = Matrix.t

(* [t] represents a loss function [f] and its derivative [f']. *)
type t = {
  f: matrix -> matrix -> float;
  f': matrix -> matrix -> matrix;
}

(* Categorical cross-entropy is a loss function, which is the difference in
 * probability distributions between two vectors. The derivative of categorical
 * cross-entropy is the difference vector. *)
val cat_crossentropy : t

open Matrix
open Lacaml.S

type matrix = Matrix.t

(* [t] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
type t = {
    f: matrix -> matrix;
    f': matrix -> matrix
}

val sigmoid : t

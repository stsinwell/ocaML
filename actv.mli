open Matrix
open Lacaml.D

type matrix = Matrix.t

(* [t] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
type t = {
    f: matrix -> matrix;
    f': matrix -> matrix
}

(* Sigmoid is an activation function.
 * S(x) = e^x / (1 + e^x)
 * S'(x) = S(x) * (1 - S(x)) *)
val sigmoid : t

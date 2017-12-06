open Matrix
open Lacaml.S

(* [t] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
type t = {
    f: Mat.t -> Mat.t;
    f': Mat.t -> Mat.t
}

val sigmoid : t

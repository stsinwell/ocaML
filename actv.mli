open Matrix
open Lacaml.D

type matrix = Matrix.t

(* [t] is an activation function, which can be either sigmoid,
 * softmax, or softplus. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
type t = {
    f: matrix -> matrix;
    f': matrix -> matrix
}

(* Sigmoid:
 * S(x) = e^x / (1 + e^x)
 * S'(x) = S(x) * (1 - S(x)) *)
val sigmoid : t

(* Softplus:
 * f(x) = log(1 + exp x)
 * f'(x) = 1/(1 + exp(-x)) *)
val softplus : t

(* Softmax:
 * f(x_i) = exp(x_i) / (sum_{j=0}^k exp(x_j)) for i = 0, 1, 2, ... k
 * f'(x_i) = x_i(1 - x_i) *)
val softmax : t

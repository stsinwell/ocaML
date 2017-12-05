open Matrix

(* [nlmf] is a nonlinear matrix function with a derivative *)
type nlmf = {
  val f : matrix -> matrix;
  val f' : matrix -> matrix;
}

(* [actv] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
type actv =
  | Sigmoid of nlmf
  | ReLU of nlmf
  | Softmax of nlmf

(* [layer] is a layer in the neural network. It consists of a
 * matrix and an activation function. *)
type layer = matrix * actv

(* [init rows cols actv] initalizes a new layer with
 * a row space of [rows], column space of [cols], and
 * activation function [actv]. *)
val init: int -> int -> actv -> layer

(* [perf_actv layer] performs elementwise activation on [layer],
 * returning a matrix of the same dimension as [layer]. *)
val perf_actv: layer -> matrix

(* [valid_op l1 l2] is true if performing a matrix multiplication
 *  on the two layers [l1] and [l2] is possible. *)
val valid_op: layer -> layer -> bool

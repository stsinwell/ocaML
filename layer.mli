open Lacaml

(* [matrix] is an abstract type representing a matrix. *)
type matrix

(* [tensor] is an abstract type representing a tensor, which is
 * a three-dimensional matrix. *)
type tensor

(* [actv] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
type actv =
  | Sigmoid | ReLU | Softmax

(* [layer] is a layer in the neural network. It consists of a
 * matrix and an activation function. *)
type layer = matrix * actv

(* [init rows cols actv] initalizes a new layer with
 * a row space of [rows], column space of [cols], and 
 * activation function [actv]. *)
val init: int -> int -> actv -> layer

(* [row_space m] returns the number of dimensions of the row space of [m]. *)
val row_space: matrix -> int

(* [col_space m] returns the number of dimensions of the column space of [m]. *)
val col_space: matrix -> int

(* [matrix_multiply (m1, m2)] returns a matrix representing m1 * m2.
 * requires: the column space of m1 must equal the row space of m2. *)
val matrix_multiply: matrix * matrix -> matrix

(* [perf_actv layer] performs elementwise activation on [layer],
 * returning a matrix of the same dimension as [layer]. *)
val perf_actv: layer -> matrix

(* [valid_op l1 l2] is true if performing a matrix multiplication
 *  on the two layers [l1] and [l2] is possible. *)
val valid_op: layer -> layer -> bool

open Lacaml

(* [matrix] is a list of float lists representing a matrix. *)
type matrix = float list list

(* [tensor] represents a three-dimensional matrix. We are
 * undecided as of yet if we will be implementing
 * everything with tensors vs. matrices. *)
type tensor float list list list

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

(* [row_space matrix] returns the number of dimensions of the row space. *)
val row_space: matrix -> int

(* [col_space matrix] returns the number of dimensions of the column space. *)
val col_space: matrix -> int

(* [matrix_multiply (m1, m2)] returns a matrix representing m1 * m2.
 * requires: the column space of m1 must equal the row space of m2. *)
val matrix_multiply: matrix * matrix -> matrix

(* [perf_actv layer] performs elementwise activation on [layer],
 * returning a matrix of the same dimension as [layer]. *)
val perf_actv: layer -> matrix

(* [valid_op layer layer] is true if performing a matrix multiplication
 *  on the two layers is possible. *)
val valid_op: layer -> layer -> bool

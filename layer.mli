open Matrix
open Nlmf

(* [actv] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
module type Activation = sig
  module Mat : Matrix
  type t

  val f : Mat.t -> Mat.t
  val f' : Mat.t -> Mat.t
end

module Sigmoid : Activation
module ReLU : Activation
module Softmax : Activation

(* [layer] is a layer in the neural network. It consists of a
 * matrix and an activation function. *)
module type Layer = sig
  module Mat : Matrix
  module Actv : Activation

  val size : int * int

  type matrix = Mat.t
  type actv = Activation.t
  type t

  val a : actv
  val w : matrix
  val b : matrix

  (* [init rows cols actv] initalizes a new layer with
   * a row space of [rows], column space of [cols], and
   * activation function [actv]. *)
  val init: int -> int -> actv -> t

  (* [perf_actv layer] performs elementwise activation on [layer],
   * returning a matrix of the same dimension as [layer]. *)

  (* why should this even exist? *)
  (* val perf_actv: t -> Mat.t *)

  (* [valid_op l1 l2] is true if performing a matrix multiplication
   *  on the two layers [l1] and [l2] is possible. *)
  val valid_op: t -> t -> bool
end

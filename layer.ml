open Matrix
open Nlmf



(* [layer] is a layer in the neural network. It consists of a
 * matrix and an activation function. *)
module type Layer = sig
  module ActvMtx : ActivationMatrix

  val size : int * int

  type matrix = ActvMtx.t
  type actv = matrix -> matrix
  type t ={
    a : actv;
    a' : actv;
    w : matrix;
    b : matrix;
  }

  (* [init rows cols actv] initalizes a new layer with
   * a row space of [rows], column space of [cols], and
   * activation function [actv]. *)
  val init: int -> int -> t

  (* [perf_actv layer] performs elementwise activation on [layer],
   * returning a matrix of the same dimension as [layer]. *)

  (* why should this even exist? *)
  (* val perf_actv: t -> Mat.t *)

  (* [valid_op l1 l2] is true if performing a matrix multiplication
   *  on the two layers [l1] and [l2] is possible. *)
  val valid_op: t -> t -> bool
end

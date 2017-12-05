open Matrix
open Nlmf

module type Layer = sig
  module Mat : Matrix
  module Actv : Activation
  val size : int * int
  type matrix = Mat.t
  type actv = matrix -> matrix
  type t = {
    a : actv;
    w : matrix;
    b : matrix;
  }
  val init: int -> int -> actv -> t
  val valid_op: t -> t -> bool
end

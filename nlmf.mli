open Matrix

(* [actv] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
module type Activation = sig
  module Mtx : Matrix
  type matrix = Mtx.t

  val f : matrix -> matrix
  val f' : matrix -> matrix
end

module LacamlSigmoid : Activation with module Mtx = LacamlMatrix
(* module LacamlReLU : Activation *)
(* module LacamlSoftmax : Activation *)

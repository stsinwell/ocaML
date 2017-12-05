open Matrix

(* [actv] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
module type ActivationMatrix = sig
  include Matrix

  val f : t -> t
  val f' : t -> t
end

module type LossMatrix = sig
  include Matrix

  val f : t -> t -> t
  val f' : t -> t -> t
end

module LacamlSigmoid : ActivationMatrix
module LacamlCrossentropy : LossMatrix

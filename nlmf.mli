open Matrix

(* [actv] is an activation function, which can be either sigmoid,
 * ReLU, or softmax. These are non-linear activation functions on
 * the output of a layer, which allows neural networks to model
 * non-linear functions. *)
module type Activation = sig
  module Mat : Matrix
  type matrix

  val f : matrix -> matrix
  val f' : matrix -> matrix
end

module type Loss = sig
  module Mat : Matrix
  type matrix

  val f : matrix -> matrix -> matrix
  val f' : matrix -> matrix -> matrix
end

module LacamlSigmoid : Activation
module LacamlReLU : Activation
module LacamlSoftmax : Activation
module LacamlCrossentropy : Loss

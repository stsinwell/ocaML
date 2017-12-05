open Lacaml.S
open Matrix

module type Activation = sig
  module Mtx : Matrix
  type matrix = Mtx.t

  val f : matrix -> matrix
  val f' : matrix -> matrix
end

module type Loss = sig
  module Mtx : Matrix
  type matrix = Mtx.t
  val f : matrix -> matrix -> matrix
  val f' : matrix -> matrix -> matrix
end



module LacamlSigmoid = struct
  open Lacaml.S
  module Mtx = LacamlMatrix
  type matrix = Mtx.t
  (*Sigmoid S(x) is e^x / (1 + e^x*)
  let f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x)))

  (*derivative of sigmoid is S(x)(1-S(x)*)
  let f' =
    let f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x))) in
            (fun x -> gemm (f x) (Mat.add_const 1.0 (Mat.neg (f x))));


end

module LacamlCrossentropy = struct
  open Lacaml.S
  module Mtx = LacamlMatrix
  type matrix = Mtx.t
  (*categorical cross entropy is summation over elementwise x * log(x') *)
  let f = (fun x x' -> Mat.sum (gemm x (Mat.log x')))

  (*derivative of categorical cross entropy is difference vector*)
  let f' = (fun x x' -> Mat.sub x' x)


end

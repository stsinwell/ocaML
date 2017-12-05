open Lacaml.S
open Matrix

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


module LacamlSigmoid = struct
  open Lacaml.S
  include LacamlMatrix
  type t = Mat.t
  (*Sigmoid S(x) is e^x / (1 + e^x*)
  let f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x)))

  (*derivative of sigmoid is S(x)(1-S(x)*)
  let f' =
    let f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x))) in
            (fun x -> gemm (f x) (Mat.add_const 1.0 (Mat.neg (f x))));
end

module LacamlCrossentropy = struct
  open Lacaml.S
  include LacamlMatrix
  (*categorical cross entropy is summation over elementwise x * log(x') *)
  let f = (fun x x' -> Mat.sum (gemm x (Mat.log x')))

  (*derivative of categorical cross entropy is difference vector*)
  let f' = (fun x x' -> Mat.sub x' x)
end

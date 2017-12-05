open Lacaml.S
open Matrix

type matrix = Lacaml.S.Mat.t
module type Activation = sig
  module Mat : Matrix
  type matrix = Mat.t
  val f : matrix -> matrix
  val f' : matrix -> matrix
end

module type Actv = sig
  type matrix
  val f: matrix -> matrix
  val f_dir: matrix -> matrix
end

module type Loss = sig
  type matrix
  val f: matrix -> matrix -> matrix
  val f_dir: matrix -> matrix -> matrix
end

type actv = {
  f : matrix -> matrix;
  f_dir : matrix -> matrix;
}

type loss = {
    f : matrix -> matrix -> matrix;
    f_dir : matrix -> matrix -> matrix;
  }

module LacamlSigmoid = struct
  open Lacaml.S
  type matrix = Mat.t
  (*Sigmoid S(x) is e^x / (1 + e^x*)
  let f = fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x));

  (*derivative of sigmoid is S(x)(1-S(x)*)
  let f_dir m =
    let f = fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x)) in
                    gemm (f x) (Mat.add_const (-1.0) (f x));

  module Mat = LacamlMatrix
end

module LacamlCrossentropy = struct
  open Lacmal.S
  type matrix = Mat.t 
  (*categorical cross entropy is summation over elementwise x * log(x') *)
  f = (fun x x' -> Mat.sum (gemm x (Mat.log x')));

  (*derivative of categorical cross entropy is difference vector*)
  f_dir = (fun x x' -> Mat.sub x' x)
}

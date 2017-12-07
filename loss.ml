open Lacaml.D
open Matrix

type matrix = Matrix.t

type t = {
  f: matrix -> matrix -> float;
  f': matrix -> matrix -> matrix;
}

let cat_crossentropy = {
  (* TODO: fix summation; make negative *)
  f = (fun x x' -> Mat.sum (gemm x (Mat.log x')));

  (*derivative of categorical cross entropy is difference vector*)
    f' = (fun x x' -> Mat.sub x x')
}

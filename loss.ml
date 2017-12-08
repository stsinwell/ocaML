open Lacaml.D
open Matrix

type matrix = Matrix.t

type t = {
  f: matrix -> matrix -> float;
  f': matrix -> matrix -> matrix;
}

let cat_crossentropy = {
  f = (fun x x' -> (Mat.sum (Mat.neg (gemm x (Mat.log x')))));

  (*derivative of categorical cross entropy is difference vector*)
  f' = (fun x x' -> Mat.sub x' x)
}

(* let kl_divergence =
  {
      f = (fun x x' -> let f = (fun a e1 e2 -> a +. e2 *. log (e2 /. e1)) in fold_left2 f 0. x x');
      f' = (fun x x' -> Mat.div x' x)
  } *)

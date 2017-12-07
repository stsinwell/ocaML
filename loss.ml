open Lacaml.D

type t = {
  f: Mat.t -> Mat.t -> float;
  f': Mat.t -> Mat.t -> Mat.t;
}

let cat_crossentropy = {
  (* TODO: fix summation; make negative *)
  f = (fun x x' -> Mat.sum (gemm x (Mat.log x')));

  (*derivative of categorical cross entropy is difference vector*)
    f' = (fun x x' -> Mat.sub x x')
}

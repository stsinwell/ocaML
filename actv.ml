open Matrix
open Lacaml.D

type matrix = Matrix.t

type t = {
  f: matrix -> matrix;
  f': matrix -> matrix
}

let sigmoid = {
  (* sigmoid S(x) = e^x / (1 + e^x) *)
  f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x)));

  (* derivative of sigmoid = S(x)*(1-S(x) *)
  f' = let f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x))) in
       (fun x -> Mat.mul (f x) (Mat.add_const 1.0 (Mat.neg (f x))));
}

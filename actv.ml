open Matrix
open Lacaml.D

type matrix = Matrix.t

type t = {
  f: matrix -> matrix;
  f': matrix -> matrix
}

let sigmoid = {
  f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x)));

  f' = let f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x))) in
       (fun x -> Mat.mul (f x) (Mat.add_const 1.0 (Mat.neg (f x))));
}

let softplus = {
  f = (fun x -> Mat.softplus x);

  f' = (fun x -> let ones = mat_ones (Mat.dim1 x) 1 in
        Mat.div ones (Mat.add_const 1.0 (Mat.exp (Mat.neg x))))
}

let softmax = {
  f = (fun x -> Mat.div (Mat.exp x) (mat_const (Mat.dim1 x) 1
                (Mat.sum (Mat.exp x))));

  f' = (fun x -> Mat.mul x (Mat.add_const 1.0 (Mat.neg x)))
}

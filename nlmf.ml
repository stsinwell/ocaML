open Lacaml.S

type nlmf = {
  val f : matrix -> matrix;
  val f' : matrix -> matrix;
}

let sigmoid = {
  (*Sigmoid S(x) is e^x / (1 + e^x*)
  f = fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x));
  (*derivative of sigmoid is S(x)(1-S(x)*)
  f' = 
      let f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x))) in 
      fun x -> gemm (f x) (Mat.add_const (-1.0) (f x))
}

let cat_cross_entropy = {
  (*categorical cross entropy is summation over elementwise x * log(x') *)
  f = fun x x' -> Mat.sum (gemm x (Mat.log x'));

  (*derivative of categorical cross entropy is difference vector*)
  f' = fun x x' -> Mat.sub x' x;;
}
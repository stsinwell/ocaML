<<<<<<< HEAD

module type Matrix = sig
  type matrix
  val mul: matrix -> matrix -> matrix
  val to_list: matrix -> float list list
  val size: matrix -> int * int
=======
module type Matrix = sig
  type t
  val mul: t -> t -> t
  val ij: t -> (int*int) -> float
  val to_list: t -> float list list
  val size: t -> int * int
>>>>>>> 4ca9c76d4c93c12a9911c9ebe87e0ff46d0b7309
end

module LacamlMatrix : Matrix = struct
  open Lacaml.S
<<<<<<< HEAD
  type matrix = Lacaml.S.Mat.t
=======
  type t = Mat.t
>>>>>>> 4ca9c76d4c93c12a9911c9ebe87e0ff46d0b7309

  let size m =
    (Mat.dim2 m), Mat.dim1 m

  let mul m1 m2 =
    gemm m1 m2
    
  let to_list m =
    Mat.to_list m
<<<<<<< HEAD

end


=======
end
>>>>>>> 4ca9c76d4c93c12a9911c9ebe87e0ff46d0b7309

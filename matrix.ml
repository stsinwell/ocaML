module type Matrix = sig
  type t
  val mul: t -> t -> t
  val ij: t -> (int*int) -> float
  val to_list: t -> float list list
  val size: t -> int * int
end

module LacamlMatrix : Matrix = struct
  open Lacaml.S
  type t = Mat.t

  let size m =
    (Mat.dim2 m), Mat.dim1 m

  let mul m1 m2 =
    gemm m1 m2

  let ij m (i, j) =
    m.{i+1, j+1}

  let row m j =
    Mat.row m j+1

  let col m i =
    Mat.col m i+1

  let to_list m =
    Mat.to_list m
end

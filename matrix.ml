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

  let ij m (i, j) =
    m.{i,j}

  let size m =
    (Mat.dim2 m), Mat.dim1 m

  let mul m1 m2 =
    gemm m1 m2
    
  let to_list m =
    Mat.to_list m
end

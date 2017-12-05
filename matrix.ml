module type Matrix : sig
  type matrix
  val mul: matrix -> matrix -> matrix
  val ij: matrix -> (int*int) -> float
  val col: matrix -> int -> vector
  val row: matrix -> int -> vector
  val to_list: matrix -> float list list
  val size: matrix -> int * int
end

module type Vector : sig
  type vector
  val i: vector -> float
  val row_space: matrix -> int
  val col_space: matrix -> int
  val length: vector -> int
  val v_to_list: vector -> float list
end

module LacamlMatrix : Matrix = struct
  open Lacaml.S
  type matrix = Mat.t

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

module LacamlVector : Vector = struct
  open Lacaml.S
  type vector = Vec.t

  let i v i =
    v.{i+1}

  let to_list v =
    Vec.to_list v

  let length v =
    Vec.dim v
end

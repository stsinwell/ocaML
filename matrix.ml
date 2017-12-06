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

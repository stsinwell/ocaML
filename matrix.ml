open Lacaml.S

type matrix = Mat.t

type vector = Vec.t

let row_space m =
  failwith("Unimplemented")

let col_space m =
  failwith("Unimplemented")

let mm_mul m1 m2 =
  S.gemm m1 m2

let m_ij m (i, j) =
  m.{i+1, j+1}

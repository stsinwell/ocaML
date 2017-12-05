
module type Matrix = sig
  type matrix
  val mul: matrix -> matrix -> matrix
  val to_list: matrix -> float list list
  val size: matrix -> int * int
end

module LacamlMatrix : Matrix = struct
  open Lacaml.S
  type matrix = Lacaml.S.Mat.t

  let size m =
    (Mat.dim2 m), Mat.dim1 m

  let mul m1 m2 =
    gemm m1 m2
    
  let to_list m =
    Mat.to_list m

end



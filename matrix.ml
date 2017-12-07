open Lacaml.S

type t = Mat.t

let mat_random m n = 
  Mat.random m n ~from:(-1.0) ~range:(2.0)

let mat_ones m n = 
  Mat.random m n ~from:(1.0) ~range:(0.0)

let mat_zeros m n = 
  Mat.random m n ~from:(0.0) ~range:(0.0)
    
let to_list m =
  Mat.to_list m

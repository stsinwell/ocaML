open Dsfo
open BigarrayExt

let decode dt i =
  let w = 784 in
  let v = Array2.slice_right dt i in
  let m =
    Array1.sub v 1 w |> genarray_of_array1 in
  let m = (reshape_2 m w 1) in

  let label = Array1.sub v (w + 1) 10 |> genarray_of_array1 in
  let label = (reshape_2 label 10 1) in m, label

open Lacaml.S
open Actv
open Matrix

type matrix = Mat.t

type t = {
  a : Actv.t;
  w : Mat.t;
  b : Mat.t;
}

let new_layer (m: int) (n: int) (a1: Actv.t) = {
    a = a1;
    w = mat_random n m;
    b = mat_random n 1
  }
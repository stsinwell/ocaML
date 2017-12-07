open Lacaml.S
open Actv
open Matrix

type matrix = Mat.t

type t = {
  a : Actv.t;
  w : Mat.t;
  b : Mat.t;
}

val new_layer : int -> int -> Actv.t -> t
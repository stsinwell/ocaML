open Lacaml.D

type t = {
  f: Mat.t -> Mat.t -> float;
  f': Mat.t -> Mat.t -> Mat.t;
}

val cat_crossentropy : t

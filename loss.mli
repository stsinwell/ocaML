open Lacaml.S

type t = {
  f: Mat.t -> Mat.t -> float;
  f': Mat.t -> Mat.t -> Mat.t;
}


val cat_crossentropy : t
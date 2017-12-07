open Lacaml.S


type t

val mat_random : int -> int -> Mat.t

val mat_ones : int -> int -> Mat.t

val mat_zeros : int -> int -> Mat.t

val to_list : t -> float list list
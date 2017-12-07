open Lacaml.S

type t = Mat.t

val mat_const : int -> int -> float -> Mat.t

val mat_random : int -> int -> Mat.t

val mat_ones : int -> int -> Mat.t

val mat_zeros : int -> int -> Mat.t

val to_list : t -> float list list

(* [save m] saves the matrix [m] as a text file.*)
val save: t -> unit

(* [load filename] loads the matrix saved at [filename]. *)
val load: string -> t

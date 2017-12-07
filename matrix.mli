open Lacaml.S

type t = Mat.t

val mat_const : int -> int -> float -> t

val mat_random : int -> int -> t

val mat_ones : int -> int -> t

val mat_zeros : int -> int -> t

val to_list : t -> float list list

(* [save path m] saves the matrix [m] as a text file at [path] and returns
 * the file name.*)
val save: string -> t -> string

(* [load path] loads the matrix saved at [path]. *)
val load: string -> t

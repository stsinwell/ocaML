open Lacaml.D

type t = Mat.t

val mat_const : int -> int -> float -> t

val mat_random : int -> int -> t

val mat_ones : int -> int -> t

val mat_zeros : int -> int -> t

val mat_const : int -> int -> float -> Mat.t

val to_list : t -> float list list

(* [floats_to_str l] converts a list of floats [l] to a string.*)
val floats_to_str : float list -> string

(* [strs_to_str l] converts a list of strings [l] to a string, where each
 * string is separated by a newline. *)
val strs_to_str : string list -> string

(* [save path m] saves the matrix [m] as a text file at [path] and returns
 * the file name.*)
val save_weights: string -> t -> string

(* [load path] loads the matrix saved at [path]. *)
val load_weights: string -> t

val print: t -> unit
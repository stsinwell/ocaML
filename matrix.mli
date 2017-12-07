open Lacaml.D

(* [t] represents a matrix. We have chosen to use the Lacaml matrix type to
 * represent our matrices. Occasionally, we use float list lists, which can
 * be converted to Lacaml matrix types. *)
type t = Mat.t

(* [mat_const m n c] creates a mxn matrix where every element is [c]. *)
val mat_const : int -> int -> float -> t

(* [mat_random m n] creates a mxn matrix where every element is a random
 * float. *)
val mat_random : int -> int -> t

(* [mat_ones m n] creates a mxn matrix where every element is 1.0. *)
val mat_ones : int -> int -> t

(* [mat_zeros m n] creates a mxn matrix where every element is 0.0. *)
val mat_zeros : int -> int -> t

(* [to_list m] is the float list list that represents matrix [m]. *)
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

(* [print m] prints out the matrix and its weights. *)
val print: t -> unit

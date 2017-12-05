open Lacaml.S

(* [matrix] is an abstract type representing a matrix. *)
type matrix

(* [vector] is an abstract type representing a vector. *)
type vector

(* [row_space m] returns the number of dimensions of the row space of [m]. *)
val row_space: matrix -> int

(* [col_space m] returns the number of dimensions of the column space of [m]. *)
val col_space: matrix -> int

(* [mm_mul (m1, m2)] returns a matrix representing the product of m1 and m2.
 * requires: the column space of m1 must equal the row space of m2. *)
val mm_mul: matrix -> matrix -> matrix

(* [m_ij (i,j)] returns the element of m at position i,j *)
val m_ij: matrix -> (int*int) -> float

(* [m_i m i] is the ith column vector of matrix m *)
val m_i: matrix -> int -> vector

(* [m_j m j] is the jth row vector of matrix m *)
val m_j: matrix -> int -> vector

val v_i: vector -> int -> float

val m_arctan: matrix -> matrix

val m_relu: matrix -> matrix

val m_softmax: matrix -> matrix

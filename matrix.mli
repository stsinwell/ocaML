<<<<<<< HEAD
type matrix

module type Matrix = sig

  (* [matrix] is an abstract type representing a zero-indexed matrix. *)
  type matrix

  (* [mm_mul m1 m2] returns a matrix representing the product of m1 and m2.
=======
module type Matrix = sig

  (* [t] is an abstract type representing a zero-indexed t. *)
  type t
  (* [mm_mul m1 m2] returns a Matrix representing the product of m1 and m2.
>>>>>>> 4ca9c76d4c93c12a9911c9ebe87e0ff46d0b7309
   * requires: the column space of m1 must equal the row space of m2. *)
  val mul: t -> t -> t

  (* [m_ij (i,j)] returns the element of m at position i,j (zero indexed) *)
  val ij: t -> (int*int) -> float

<<<<<<< HEAD
  (* [m_i m i] is the ith column vector of matrix m (zero indexed) *)
  val col: matrix -> int -> matrix

  (* [m_j m j] is the jth row vector of matrix m (zero indexed) *)
  val row: matrix -> int -> matrix

  val to_list: matrix -> float list list

  val size: matrix -> int * int
=======
  val to_list: t -> float list list

  val size: t -> int * int
>>>>>>> 4ca9c76d4c93c12a9911c9ebe87e0ff46d0b7309

end

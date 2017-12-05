module type Matrix : sig

  (* [matrix] is an abstract type representing a zero-indexed matrix. *)
  type matrix
  (* [mm_mul m1 m2] returns a matrix representing the product of m1 and m2.
   * requires: the column space of m1 must equal the row space of m2. *)
  val mul: matrix -> matrix -> matrix

  (* [m_ij (i,j)] returns the element of m at position i,j (zero indexed) *)
  val ij: matrix -> (int*int) -> float

  (* [m_i m i] is the ith column vector of matrix m (zero indexed) *)
  val col: matrix -> int -> vector

  (* [m_j m j] is the jth row vector of matrix m (zero indexed) *)
  val row: matrix -> int -> vector

  val to_list: matrix -> float list list

  val size: matrix -> int * int

end

module type Vector : sig

  (* [vector] is an abstract type representing a zero-indexed vector. *)
  type vector

  val i: vector -> float
  (* [row_space m] returns the number of dimensions of the row space of [m]. *)
  val row_space: matrix -> int

  (* [col_space m] returns the number of dimensions of the column space of [m]. *)
  val col_space: matrix -> int

  val length: vector -> int

  val v_to_list: vector -> float list

end

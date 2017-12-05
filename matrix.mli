module type Matrix = sig

  (* [t] is an abstract type representing a zero-indexed t. *)
  type t
  (* [mm_mul m1 m2] returns a Matrix representing the product of m1 and m2.
   * requires: the column space of m1 must equal the row space of m2. *)
  val mul: t -> t -> t

  (* [m_ij (i,j)] returns the element of m at position i,j (zero indexed) *)
  val ij: t -> (int*int) -> float

  val to_list: t -> float list list

  val size: t -> int * int

end

module type LacamlMatrixSig = Matrix with type t = Lacaml.S.Mat.t

module LacamlMatrix : LacamlMatrixSig

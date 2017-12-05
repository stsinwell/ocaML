(* loss.mli *)
open Matrix

(* [distf] is a distance function with a derivative *)
type distf = {
  val f: matrix -> matrix -> float;
  val f': matrix -> matrix -> float;
}

(* [loss] represents a loss function. L2 is the Euclidean distance
 * between two vectors, L1 is the Manhattan distance between two
 * vectors, and categorical cross-entropy is the difference in
 * probability distributions of the two vectors, where each
 * element in the vectors is a probability distribution of a
 * category. *)
type loss =
  | L2_loss of distf
  | L1_loss of distf
  | Categorical_crossentropy of distf

(* [l2_loss m1 m2] performs the L2_loss of the given matrices. *)
val l2_loss: matrix -> matrix -> float

(* [l1_loss m1 m2] performs the l1_loss of the given matrices. *)
val l1_loss: matrix -> matrix -> float

(* [crossentropy m1 m2] performs the categorical cross-entropy of
 * the given matrices. *)
val crossentropy: matrix -> matrix -> float

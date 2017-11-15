loss.mli

type loss = | L2_loss | L1_loss | Categorical_crossentropy

(*[l2_loss matrix matrix] performs the l2_loss of the given matrices*)
val l2_loss: matrix matrix -> matrix

(*[l1_loss matrix matrix] performs the l1_loss of the given matrices*)
val l1_loss: matrix matrix -> matrix

(*[categorical_crossentropy matrix matrix] performs
the categorical crossentropy of the given matrices*)
val categorical_crossentropy matrix matrix -> matrix

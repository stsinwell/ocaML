#model.mli

open layer.mli

type model = layer list
type loss = | l2_loss | l1_loss | categorical_crossentropy

(*[add_layer model matrix] adds layer to matrix list
  precondition: column space of last layer in matrix must equal
  row space of new layer*)
val add_layer: model matrix -> matrix

(*[propagate model matrix] propagates the inputted matrix through the model and returns the activation
  precondition: the input matrix must *)
val propagate: model matrix -> matrix

(*[backpropagate model matrix matrix loss] performs the backpropagation algorithm on the model,
  given the  *)
val backpropagate model matrix matrix -> matrix

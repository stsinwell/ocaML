#layer.mli

type matrix = float list list
(*We are undecided as of yet if we will be implementing
  everything with tensors vs matrices*)
type tensor float list list list

type actv =
  | Sigmoid | ReLU | Softmax

type layer = matrix * actv

(*[initialize int1 int2 actv] initalizes a new layer with
  a row space of int1 and column space of int2*)
type initialize: int int actv -> layer

(*[row_space matrix] returns the number of dimensions of the row space*)
val row_space: matrix -> int

(*[col_space matrix] returns the number of dimensions of the column space*)
val col_space: matrix -> int

(*[matrix_multiply (matrix1, matrix2)] returns a matrix representing
  matrix1 * matrix2
  Precondition: the column space of matrix 1 must equal the row space of matrix2*)
val matrix_multiply: matrix * matrix -> matrix

(*[perf_actv layer] performs elementwise activation on matrix given,
return a matrix of the same dimension as the input matrix*)
val perf_actv: layer -> matrix



(*[valid_op layer layer] returns a boolean indicating whether performing
a matrix multiply on the two layers is possible*)
val valid_op: layer layer -> bool

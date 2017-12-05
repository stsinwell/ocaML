(* [nlmf] is a nonlinear matrix function with a derivative *)
type nlmf = {
  val f : matrix -> matrix;
  val f' : matrix -> matrix;
}

val sigmoid -> nlmf

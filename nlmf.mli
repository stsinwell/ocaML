open Matrix

(* [nlmf] is a nonlinear matrix function with a derivative *)
type actv
type loss

val sigmoid : actv

val cat_cross_entropy : loss

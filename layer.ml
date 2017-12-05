open Nlmf
open Matrix

type layer = {
  weights: matrix;
  bias: matrix;
  actv: actv
}

let init m n actv = failwith("Unimplemented") 

(* let perf_actv lay =
  let f = snd lay in f (fst lay) *)

let valid_op l1 l2 = failwith("Unimplemented")



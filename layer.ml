open Lacaml.S
open Actv
open Matrix

type matrix = Matrix.t
type actv = Actv.t

type t = {
  a : actv;
  w : matrix;
  b : matrix;
}

let new_layer (m: int) (n: int) (a1: Actv.t) = {
    a = a1;
    w = mat_random n m;
    b = mat_random n 1
  }

(*
- l is layer we are updating
- a is activation of weights for some input
- g is backprop gradients for some input
*)
let update_w_and_b (l: t) (a: matrix) (g: matrix) =
    (*bp - a vector of same dimension 
    as g with a hyperparameter for gradient updates*)
    let bp = 
        let const = (0.2) *. float_of_int (Mat.dim1 g) in
        Mat.random (Mat.dim1 g) 1 ~from:(const) ~range:(0.0) in

    let new_w w a g = 
      Mat.Add w (Mat.Neg (Mat.Mul bp 

let new_weight e f b l =
  l.weight <<<->>> ((e /. (scale b)) <*>>> (f <<*|>> b))

let new_bias e b l =
  l.bias <<->> ((e /. (scale b)) <*>> b)

let load_layer act wf bf =
  {a = act;
   w = Matrix.load wf;
   b = Matrix.load bf}

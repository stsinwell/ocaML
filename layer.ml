open Lacaml.D
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

let update_w_and_b (l: t) (a: matrix) (g: matrix) =
    (* weight_hp - a matrix of same dimension
     * as w with a hyperparameter for gradient update s*)
    let weight_hp =
        let const = (0.01) *. float_of_int (Mat.dim1 l.w) in
        Mat.random (Mat.dim1 l.w) (Mat.dim2 l.w) ~from:(const) ~range:(0.0) in

    (* weight_hp - a matrix of same dimension
     * as w with a hyperparameter for gradient updates *)
    let bias_hp =
      let const = (0.01) *. float_of_int (Mat.dim1 l.w) in
      Mat.random (Mat.dim1 l.w) 1 ~from:(const) ~range:(0.0) in

    (* weight - const mult f * b^T *)
    let new_w w a g =
      Mat.add w (Mat.neg (Mat.mul weight_hp (gemm g a ~transb:`T))) in

    (*bias = bias - const mult b *)
    let new_b b g =
      Mat.add b (Mat.neg (Mat.mul bias_hp b)) in
      {
        a = l.a;
        w = new_w l.w a g;
        b = new_b l.b g
      }

let load_layer act wf bf =
  {a = act;
   w = Matrix.load_weights wf;
   b = Matrix.load_weights bf}

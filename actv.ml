open Lacaml.S

type t = {
  f: Mat.t -> Mat.t;
  f': Mat.t -> Mat.t
}

let sigmoid = {
 (*Sigmoid S(x) is e^x / (1 + e^x*)
  f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x)));
 
   (*derivative of sigmoid is S(x)(1-S(x)*)
  f' =
     let f = (fun x -> Mat.div (Mat.exp x) (Mat.add_const 1.0 (Mat.exp x))) in
             (fun x -> gemm (f x) (Mat.add_const 1.0 (Mat.neg (f x))));

}

 




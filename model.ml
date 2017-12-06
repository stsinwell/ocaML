open Lacaml.S
open Layer
open Nlmf
open Matrix
open Actv

type matrix = Mat.t
type layer = Layer.t
type model = layer list


let backpropagate m m1 m2 = failwith "SDfjdlwfew"

let get_category m = failwith "sdfhdsfds"

let train m m1 = failwith "sdfjdslf"

let propagate (m: model) (input: matrix) =
    List.fold_left 
    (fun x layer -> layer.a.f (Mat.add (gemm layer.w x) layer.w)) input m

let backpropagate (m: model) (input: matrix) = failwith "sdfjdslf"






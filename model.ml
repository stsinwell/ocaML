open Lacaml.S
open Layer
open Nlmf
open Matrix
open Actv

type matrix = Mat.t
type layer = Layer.t
type model = layer list


let get_category m = failwith "sdfhdsfds"

let train m m1 = failwith "sdfjdslf"

let propagate (m: model) (input: matrix) =

    let rec store_weights m i wl =
        let prop_layer x layer = layer.a.f (Mat.add (gemm layer.w x) layer.b) in

        match m with 
        | [] -> wl
        | h::t -> let out = prop_layer i h in
                    store_weights t out (out::wl)
        in
    store_weights m input []
        
    (* List.fold_left 
    (fun x layer -> let layer_out = layer.a.f (Mat.add (gemm layer.w x) layer.b) in
                    
                    ) input m *)

let backpropagate (m: model) (input: matrix) = 
    let rev_net = List.rev m in
    let layer_update l l' e i = 
        Mat.mul (gemm l.w e ~transa:`T) (l.a.f' i) in
        
    (*updates *)
    let network_update n f e = () in failwith "ff"







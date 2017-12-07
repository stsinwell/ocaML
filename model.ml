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

let backpropagate (m: model) (input: matrix) (l: matrix) = 
    let rev_net = List.rev m in
    let layer_update l l' c i = 
        Mat.mul (gemm l.w c ~transa:`T) (l.a.f' i) in
        
    (*updates *)
    (*
    - a is the weight list from running input through model
    - w is the weights of the model *)
    let network_update (a: model) (l:matrix) = 
        let rec store_weights (a: model)  w l wl = 
            (*CHANGE*)
            (*
            - wl is the accumulator that collects 
              the result of applying layer_update*)
            match (a, w) with
            | (ha1::ha2::ta, hl1::hl2::tl) ->
                let out = layer_update hl2 hl1 l ha2
                in
                store_weights (ha2::ta) (hl2::tl) out (out::wl)
            | _ -> wl in
        let wl = store_weights a rev_net l [] in 
        List.rev (l::(List.rev wl)) in 

    network_update m l








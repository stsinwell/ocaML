open Lacaml.S
open Layer
open Matrix
open Actv
open Loss

type matrix = Matrix.t
type layer = Layer.t

type model = layer list

type network  = {
    model : model;
    loss : Loss.t
  }

let get_category m = failwith "sdfhdsfds"

let train m m1 = failwith "sdfjdslf"

let propagate (m: model) (input: matrix) =

    let rec store_weights m i wl =
      let prop_layer x layer =
        layer.a.f (Mat.add (gemm layer.w x) layer.b) in

        match m with
        | [] -> wl
        | h::t -> let out = prop_layer i h in
                    store_weights t out (out::wl)
        in
    store_weights m input []

let backpropagate (m: model) (input: matrix) (l: matrix) =
    let rev_net = List.rev m in
    let layer_update l l' c i =
        Mat.mul (gemm l.w c ~transa:`T) (l.a.f' i.w) in

    (*updates *)
    (*
    - a is the weight list from running input through model
    - w is the weights of the model *)
    let network_update (a: model) (l:matrix) =
        let rec store_weights (a: model)  w l wl =

            (*CHANGE*)
            (*
            - wl is the accumulator that collects
              the result of applying layer_update
              *)
            match (a, w) with
            | (ha1::ha2::ta, hl1::hl2::tl) ->
                let out = layer_update hl2 hl1 l ha2
                in
                store_weights (ha2::ta) (hl2::tl) out (out::wl)
            | _ -> wl in
        let wl = store_weights a rev_net l [] in
        List.rev (l::(List.rev wl)) in

    network_update m l


let full_pass (n: network) (x: matrix) (y: matrix) =
    let forward = propagate n.model x in
    let cost = n.loss.f' x y in
    let b_net = backpropagate n.model x in

    let rec helper f b l r =
        match (f, b, l) with
                | (hf::tf, hb::tb, hl::tl) ->
                let new_layer =
                    {
                        a = hl.a;
                        w = new_weight n.eta hf hb hl;
                        b = new_bias n.eta hb hl;
                    }
                in
                single_aux tf tb tl (layer::r)
            | _ -> r








    network_update m l *)

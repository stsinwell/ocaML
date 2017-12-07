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


    (*
    - m is model list
    - a is an activation model for m given some input
    - l is the gradient of loss function
    *)
let backpropagate (m: model) (a:matrix list) (l: matrix) =

    let layer_update l l' c i =
        let a = (gemm l'.w c ~transa:`T) in 
        let x = (l.a.f' i) in
        Mat.mul a x in

    (*
    - w is the weights of the model 
    *)
    let network_update (m: model) (a: matrix list) (l:matrix) = 
        let rec store_weights a w l wl = 
            (*
              - wl is the accumulator that collects 
              the result of applying layer_update
              *)
            match (a, w) with
            | (a1::a2::ta, w1::w2::tl) ->
                let out = layer_update w2 w1 l a2 in
                
                store_weights (a2::ta) (w2::tl) out (out::wl)
            | _ -> wl in

        let wl = store_weights a (List.rev m) l [] in

        List.rev (l::(List.rev wl)) in

    network_update m a l




let full_pass (n: network) (x: matrix) (y: matrix) =
    let forward = propagate n.model x in
    let output = List.hd forward in
    let cost = n.loss.f' output y in
    let g = backpropagate n.model forward cost in

    let rec update_layers a g l wl =
        (*
        - a is activation matrix list
        - g is gradient matrix list
        - l is layer list
        *)
        match (a, g, l) with
                | (a::na, g::gn, l::nl) ->
                    let new_layer = update_w_and_b l a g in
                    update_layers na gn nl (new_layer::wl)
                | _ -> wl in

        let add_input f i = i::(List.rev (List.tl (List.rev f))) in
        let new_model = update_layers (add_input (List.rev forward) x) g n.model [] in
        {
            model = List.rev new_model;
            loss = n.loss
        }











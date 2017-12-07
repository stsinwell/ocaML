open Lacaml.D
open Layer
open Matrix
open Actv
open Loss
open Dsfo
open BigarrayExt

type matrix = Matrix.t
type layer = Layer.t
type loss = Loss.t

type model = layer list

type network  = {
  model : model;
  loss : loss
}

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

(* m is model list
 * a is an activation model for m given some input
 * l is the gradient of loss function *)
let backpropagate (m: model) (a:matrix list) (l: matrix) =
  let layer_update l l' c i =
    let a = (gemm l'.w c ~transa:`T) in
    let x = (l.a.f' i) in
    Mat.mul a x in

  (* w is the weights of the model *)
  let network_update (m: model) (a: matrix list) (l:matrix) =
   (* wl is the accumulator that collects
    * the result of applying layer_update *)
    let rec store_weights a w l wl =
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
    (* a is activation matrix list
     * g is gradient matrix list
     * l is layer list *)
    match (a, g, l) with
    | (a::na, g::gn, l::nl) ->
      let new_layer = update_w_and_b l a g in
      update_layers na gn nl (new_layer::wl)
    | _ -> wl in
  let add_i f i = i::(List.rev (List.tl f)) in
  let new_model = update_layers (add_i forward x) g n.model [] in
  {
    model = List.rev new_model;
    loss = n.loss
  }

  let decode dt i =
    let w = 784 in
    let v = Array2.slice_right dt i in
    let m =
      Array1.sub v 1 w |> genarray_of_array1 in
      let temp = (reshape_2 m 28 28) in
      let m = Mat.transpose_copy temp in
      let m = genarray_of_array2 m in
    let m = (reshape_2 m 784 1) in

    let label = Array1.sub v (w + 1) 10 |> genarray_of_array1 in
    let label = (reshape_2 label 10 1) in m, label


let save_m id (m : model) =
  let n = ref 0 in
  let weights = List.map (fun l ->
      let wn = id^"-model-"^string_of_int !n^"wgt.txt" in
      incr n;
      save_weights wn l.w) m in
  n := 0;
  let biases = List.map (fun l ->
      let bn = id^"-model-"^string_of_int !n^"bias.txt" in
      incr n;
      save_weights bn l.b) m in
  List.combine weights biases

let load_m (files : (string * string) list) =
  let actv = Actv.sigmoid in
  List.map (fun (wn,bn) -> { a = actv;
                             w = load_weights wn;
                             b = load_weights bn } ) files

let save_net id n =
  let d = Filename.dir_sep in
  let path = "."^d^"matrices"^d^"saved_net-"^id in
  save_m path n.model

let load_net (l : loss) files =
  { model = load_m files;
    loss = l }

let train (n: network) (x: matrix) (steps: int) (epoch: int) ?(id="train") () =
  let network = ref n in
  for i = 1 to epoch do
    for j = 1 to steps do
      let x, y = decode x j in
      network := full_pass !network x y
    done;
  done;
  (!network, (save_net "mnist" !network))

let infer ndir xpath =
  let n = load_net cat_crossentropy ndir in
  let x = load_weights xpath in
  let weight_list = propagate n.model x in
  let out = List.hd weight_list in
  let out_list = List.flatten (Mat.to_list out) in

  let rec max_index l i max maxi =
    match l with
    | [] -> maxi
    | h::t -> if h > max then max_index t (i+1) h i
              else max_index t (i+1) max maxi in

  max_index out_list 0 (-1.0) (-1)

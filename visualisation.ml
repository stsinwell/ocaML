open GMain
open GMisc
open Graphics
open Matrix
open Lacaml.S

(*[fill_color node] sets the current color according to the  
 * weight (value) of [node]*)
 let fill_color node =
  (*specify color to fill in node with according to node's weight*)
  let shade = 
  if node < 0.1 
  then 0xffffff
  else if (node >= 0.1) && (node < 0.2) 
  then 0xe6e6e6 
  else if (node >= 0.2) && (node < 0.3)
  then 0xcccccc
  else if (node >= 0.3) && (node < 0.4)
  then 0xb3b3b3
  else if (node >= 0.4) && (node < 0.5)
  then 0x999999
  else if (node >= 0.5) && (node < 0.6)
  then 0x808080
  else if (node >= 0.6) && (node < 0.7)
  then 0x666666
  else if (node >= 0.7) && (node < 0.8)
  then 0x4d4d4d
  else if (node >= 0.8) && (node < 0.9)
  then 0x333333
  else if (node >= 0.9) && (node < 1.0)
  then 0x1a1a1a
  else 0x000000 in 
  set_color shade

(*[draw_circles node_lst spacing x_pos y_pos] draws the circles
 * for a single layer of nodes *)
let rec draw_circles (node_lst : float list) spacing x_pos y_pos =  
match List.rev node_lst with 
| [] -> draw_circle 0 0 0 
| h :: t -> set_color 0x000000;
           draw_circle x_pos y_pos 10;
           fill_color h;
           fill_circle x_pos y_pos 10;
           draw_circles t spacing x_pos (y_pos + spacing)


(*[insert_layer] draws the nodes of a single layer
 * onto the window *)
let insert_layer (node_lst: float list) x_pos =
  let num_nodes = List.length node_lst in
  let offset = 50 in
  let spacing = (size_y() - 2 * offset) / num_nodes in
  draw_circles node_lst spacing x_pos offset

  (*[get_startpoints layers_lst] returns a list of the 
   * coordinates of each node for each of the n layers in 
   * [layers_lst] except for the nth layer. 
   * Helper function to [connect_layers].*)
let get_startpoints layers_lst = 
  failwith "Unimplemented"

  (*[get_endpoints layers_lst] returns a list of the 
   * coordinates of each node or each of the n layers in 
   * [layers_lst] except for the 0th layer. 
   * Helper function to [connect_layers].*)
let get_endpoints layers_lst =
  failwith "Unimplemented"

(*[connect_layers] draws lines symbolizing
 * all of the different possible paths through
 * the neural network *)
let connect_layers (layers_lst : Mat.t list) = 
  let startpoints = get_startpoints layers_lst in
  let endpoints = get_endpoints layers_lst in 
  set_color 0x000000


let arrange_layers (layer_lst : float list list ) =
  (*let transformed = to_list layer_lst in*)
  (**********)
  let transformed = layer_lst in
  (**************)
  (*determine spacing between layer representations*)
  let num_layers = List.length transformed in
  let offset = 50 in
  let x_spacing = (size_x() - 2*offset) / num_layers in 

  (*send each layer off to be drawn*)
  let rec insert_layers (transformed: float list list) x_pos = 
    match transformed with
    | [] -> draw_circle 0 0 0
    | h :: t -> insert_layer h offset; (insert_layers t (x_pos + x_spacing))
  in
  insert_layers transformed x_spacing

let main () =
  let window = open_graph " 1000 * 800" in
  set_window_title "Network Visualization";
  let sample = [[0.1;0.5;1.0]; [1.0;0.8;0.9]; [0.1;0.2]] in 
  arrange_layers sample;
  
  (*wait for user input//keep window running*)
  ignore (Graphics.read_key ())


(* Run the GUI *)
let () = main ()

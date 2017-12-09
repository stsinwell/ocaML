open GMain
open GMisc
open Graphics
open Lacaml.D
open Model

(*[fill_color node] sets the current color according to the
 * weight (value) of [node]*)
 let fill_color node =
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

(*[line_color weight] sets the current color according to the
 * value of [weight] *)
 let line_color weight =
  let shade =
  if (weight >= 0.0) && (weight < (0.1))
  then 0xff0000
  else if (weight >= 0.1) && (weight < (0.2))
  then 0xff3333
  else if (weight >= 0.2) && (weight < 0.3)
  then 0xff6666
  else if (weight >= 0.3) && (weight < (0.4))
  then 0xff9999
  else if (weight >= (0.4)) && (weight < (0.5))
  then 0xffcccc
  else if (weight >= (0.5)) && (weight < (0.6))
  then 0xffffff
  else if (weight >= (0.6)) && (weight < (0.7))
  then 0xe6ffcc
  else if (weight >= 0.7) && (weight < 0.8)
  then 0xccff99
  else if (weight >= 0.8) && (weight < 0.9)
  then 0xb3ff66
  else if (weight >= 0.9) && (weight < 1.0)
  then 0x99ff33
  else
  0x80ff00 in
  set_color shade

(* returns: [take_rev n xs acc] is [lst1 @ acc], where [lst] is
 *   the first [n] elements of [xs] (or just [xs] if [xs] has
 *   fewer than [n] elements) in reverse order. Taken from 3110 lab.
 * requires: [n >= 0] *)
 let rec take_rev n xs acc =
  if n = 0 then acc else match xs with
    | [] -> acc
    | x::xs' -> take_rev (n-1) xs' (x::acc)

(* returns:  [take n lst] is the first [n] elements of [lst], or
 *   just [lst] if [lst] has fewer than [n] elements. Taken from
 *   3110 lab.
 * requires: [n >= 0]
 *)
let take n lst =
  take_rev n lst [] |> List.rev

(* returns:  [drop n lst] is all but the first [n] elements of [lst],
 *   or just [[]] if [lst] has fewer than [n] elements. Takne from
 *   3110 lab.
 * requires: [n >= 0]
 *)
 let rec drop n lst =
  if n = 0 then lst else match lst with
    | [] -> []
    | x::xs -> drop (n-1) xs

(*[draw_circles node_lst spacing x_pos y_pos] draws the circles
 * for a single layer of nodes *)
let rec draw_circles (node_lst : float list) spacing x_pos y_pos =
match node_lst with
| [] -> draw_circle 0 0 0
| h :: t -> set_color 0x000000;
           draw_circle x_pos y_pos 10;
           fill_color h;
           fill_circle x_pos y_pos 10;
           draw_circles t spacing x_pos (y_pos + spacing)

(*[insert_layer] draws the nodes of a single layer
 * onto the window *)
let insert_layer (node_lst: float list) x_pos=
  let num_nodes = List.length node_lst in
  let offset = 50 in
  let spacing = (size_y() - 2 * offset) / num_nodes in
  draw_circles node_lst spacing x_pos offset

(*[get_points_helper] returns a list of the
 * [x],[y] positions in [node_lst] where [x] is always
 * [x_pos] *)
let get_points_helper node_lst x_pos =
 let num_nodes = List.length node_lst in
 let offset = 50 in
 let spacing = (size_y() - 2 * offset) / num_nodes in
 let rec helper node_lst offset' =
  match node_lst with
  | [] -> []
  | h :: t -> (x_pos, offset') :: helper t (offset' + spacing)
  in
  helper node_lst offset

(*[connect_one_node s e] connects a single neuron in layer [s] to
 * each neuron in layer [e] by drawing a line between the neurons.*)
 let rec connect_one_node s e =
  match s with
  | (x,y) :: t -> List.map (fun (x', y') -> moveto x y;
                                        line_color (Random.float 1.0);
                                         lineto x' y') e;
                                         connect_one_node t e;
  | _ -> ()

(* [match_points_node] draws a line from the node at position ([sx],[sy])
 * to each of the nodes in the list [end_lst]*)
let rec match_points points =
  match points with
  | h :: m :: t -> connect_one_node h m; match_points (m :: t)
  | h :: t :: [] -> connect_one_node h t
  | _ -> ()

  (*[get_startendpoints layers_lst] returns a list of the
   * coordinates of each node for each of the n layers in
   * [layers_lst]. Helper function to [connect_layers].*)
let rec get_startendpoints layers_lst =
  let num_layers = List.length layers_lst in
  let offset = 50 in
  let x_spacing = (size_x() - 100) / num_layers in
  let rec helper layers_lst offset' =
    match layers_lst with
    | [] -> []
    | h :: t -> get_points_helper h offset' ::  (helper t (offset' + x_spacing))
  in
  helper layers_lst offset

(*[connect_layers] draws lines symbolizing
 * all of the different possible paths through
 * the neural network *)
let connect_layers (layers_lst : float list list) =
  let startendpoints = get_startendpoints layers_lst in
  set_color 0x000000;
  match_points startendpoints


(*[arrange_layers] determines the spacing for all of the
 * layers within the window, and sends for every layer
 * of neurons to be drawn *)
let arrange_layers (layer_lst : float list list ) =
  let num_layers = List.length layer_lst in
  let offset = 50 in
  let x_spacing = (size_x() - 100) / num_layers in

  (*send each layer off to be drawn*)
  let rec insert_layers (layer_lst: float list list) x_pos =
    match layer_lst with
    | [] -> draw_circle 0 0 0
    | h :: t -> insert_layer h x_pos; (insert_layers t (x_pos + x_spacing))
  in
  insert_layers layer_lst offset

let main () =
  try
    open_graph " 1000x500";
    set_window_title "Network Visualization";
    let sample = [[0.1;0.5;1.0; 0.3; 0.4;0.2;0.8;1.0;0.0];
                  [1.0;0.5;0.9;0.3;0.4];
                  [1.0;0.2;0.4;0.5;0.4];
                  [0.1;0.2]] in
    connect_layers sample;
    arrange_layers sample;


    (*wait for user input//keep window running*)
    ignore (Graphics.read_key ())
  with
  | Graphics.Graphic_failure _ -> close_graph ()

(* Run the GUI *)
let () = main ()

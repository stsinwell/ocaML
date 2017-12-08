open GMain
open GMisc
open Graphics
open Lacaml.D
(* open Model *)

(*[fill_color neuron] sets the current color according to the  
 * activation (value) of [neuron]*)
 let fill_color neuron =
  let shade = 
  if neuron < 0.1 
  then 0xffffff
  else if (neuron >= 0.1) && (neuron < 0.2) 
  then 0xe6e6e6 
  else if (neuron >= 0.2) && (neuron < 0.3)
  then 0xcccccc
  else if (neuron >= 0.3) && (neuron < 0.4)
  then 0xb3b3b3
  else if (neuron >= 0.4) && (neuron < 0.5)
  then 0x999999
  else if (neuron >= 0.5) && (neuron < 0.6)
  then 0x808080
  else if (neuron >= 0.6) && (neuron < 0.7)
  then 0x666666
  else if (neuron >= 0.7) && (neuron < 0.8)
  then 0x4d4d4d
  else if (neuron >= 0.8) && (neuron < 0.9)
  then 0x333333
  else if (neuron >= 0.9) && (neuron < 1.0)
  then 0x1a1a1a
  else 0x000000 in 
  set_color shade

(*[line_color weight] sets the current color according to the
 * value of [weight] *)
let line_color weight = 
  let shade = 
  if (weight >= -1.) && (weight < (-0.8))
  then 0xff0000
  else if (weight >= -0.8) && (weight < (-0.6))
  then 0xff3333
  else if (weight >= -0.6) && (weight < (-0.4))
  then 0xff6666
  else if (weight >= (-0.4)) && (weight < (-0.2))
  then 0xff9999
  else if (weight >= (-0.2)) && (weight < (0.0))
  then 0xffcccc
  else if (weight >= (0.0)) && (weight < (0.2))
  then 0xffffff
  else if (weight >= (0.2)) && (weight < (0.4))
  then 0xe6ffcc
  else if (weight >= 0.4) && (weight < 0.6)
  then 0xccff99
  else if (weight >= 0.6) && (weight < 0.8)
  then 0xb3ff66
  else if (weight >= 0.8) && (weight < 1.0)
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

(* (* returns:  [take n lst] is the first [n] elements of [lst], or
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

(*[draw_neurons neuron_lst spacing x_pos y_pos] draws the circles
 * for a single layer of neurons *)
let rec draw_neurons (neuron_lst : float list) spacing x_pos y_pos =  
match neuron_lst with 
| [] -> draw_circle 0 0 0 
| h :: t -> set_color 0x000000;
           draw_circle x_pos y_pos 10;
           fill_color h;
           fill_circle x_pos y_pos 10;
           draw_neurons t spacing x_pos (y_pos + spacing)

(*[insert_layer] draws the neurons of a single layer
 * onto the window *)
let insert_layer (neuron_lst: float list) x_pos=
  let num_neurons = List.length neuron_lst in
  let offset = 50 in
  let spacing = (size_y() - 2 * offset) / num_neurons in
  draw_neurons neuron_lst spacing x_pos offset

let get_points_helper neuron_lst x_pos =
 let num_neurons = List.length neuron_lst in 
 let offset = 50 in 
 let spacing = (size_y() - 2 * offset) / num_neurons in
 let rec helper neuron_lst offset' =
  match neuron_lst with
  | [] -> [] 
  | h :: t -> (x_pos, offset') :: helper t (offset' + spacing)
  in
  helper neuron_lst offset


 let rec connect_one_neuron s e =
  match s with
  | (x,y) :: t -> List.map (fun (x', y') -> moveto x y; lineto x' y') e; connect_one_neuron t e;
  | _ -> () 

(* [match_points_neuron] draws a line from the neuron at position ([sx],[sy])
 * to each of the neurons in the list [end_lst]*)
let rec match_points points =
  match points with
  | h :: m :: t -> connect_one_neuron h m; match_points (m :: t) 
  | h :: t :: [] -> connect_one_neuron h t
  | _ -> ()

  (*[get_startendpoints layers_lst] returns a list of the 
   * coordinates of each neuron for each of the n layers in 
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
let connect_layers layers_lst = 
  let startendpoints = get_startendpoints layers_lst in
  set_color 0x000000;
  match_points startendpoints
*)
let arrange_layers (mat: float list list) num_layers =
  (*determine spacing between layer representations*)
  let offset = 50 in
  let x_spacing = (size_x() - 100) / num_layers in

  (*determine spacing between nodes*)
  let num_nodes =
    match mat with
    | [] -> 0
    | h :: t -> List.length h
  in 
  let y_spacing = (size_y() - 100) / num_nodes in
  let layer = List.hd mat in 
  let rec draw_layer lst x y = 
    match lst with 
    | [] -> ()
    | h :: t -> draw_circle x y 10; draw_layer t x (y + y_spacing)
  in
  draw_layer layer offset (offset + x_spacing * count)

let get_lengths mat = 
  match mat with
  | [] -> [0]
  | h :: t -> 

(*[get_matrices network] gets each matrix within
 * [network] and sends it to be drawn in the GUI.*)
 let rec get_dim network =
  match network with 
  | [] -> []
  | (h :: _) :: t -> [List.length h] :: get_dim t
  | [] :: t -> []

let build_nodes network = 
  let num_layers = List.length network in 
  

let get_input () = 
  failwith "Unimplemented"

let main () =
  open_graph " 1000x500";
  set_window_title "Network Visualization";
  let sample = [
                 [[0.1;(-0.5);(-1.0);0.4;0.2]; 
                 [1.0;0.5;0.9;(-0.6);(-0.2);(-0.3)]; 
                 [0.1;0.2;0.3;0.4;0.5;0.6]] ;
                (*layer 2 to layer 3*)
               [[0.3;(-0.15);0.3];
               [0.4; 0.01; (-0.9)]]
               ]in 
  get_matrices sample;
  (* connect_layers sample;
  arrange_layers sample;
   *)
  
  (*wait for user input//keep window running*)
  ignore (Graphics.read_key ())


(* Run the GUI *)
let () = main ()


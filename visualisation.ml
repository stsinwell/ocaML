open GMain
open GMisc
open Graphics
open Lacaml.D
open Train_mnist
open Model
include Matrix

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

let rec match_neurons start_lst x_space sy_space ey_space = 
    match start_lst with 
    | [] -> ()
    | h :: t -> moveto x_space sy_space; 
               fill_color h; 
               fill_circle x_space (50 + sy_space) 5; 
               line_color h; 
               lineto ( x_space * 2 - 50) ey_space;
               match_neurons t x_space (sy_space * 2) ey_space
  

(*[connect_layers] draws lines symbolizing
 * all of the different possible paths through
 * the neural network *)
let connect_layers mat x_spacing =
  let num_sneurons = List.length (List.hd mat) in   
  let num_eneurons = List.length mat in 
  let sy_spacing = (size_y() - 100) / num_sneurons in 
  let ey_spacing = (size_y() - 100) / num_eneurons in 
  let rec connect_layers_help mat y_space = 
    match mat with 
    | [] -> ()
    | h :: t -> match_neurons h x_spacing sy_spacing ey_spacing; connect_layers_help t (y_space + ey_spacing)
  in
  connect_layers_help mat 50

(*[get_matrices network] gets each matrix within
 * [network] and sends it to be drawn in the GUI.*)
 let rec get_dim network =
  match network with 
  | [] -> []
  | (h :: _) :: t -> List.length h :: get_dim t
  | [] :: t -> []

let draw_neurons num_neurons x_spacing = 
  let offset = 50 in 
  let y_spacing = (size_y() - 100) / num_neurons in
  for i = 1 to num_neurons do begin 
    draw_circle x_spacing (offset + (i-1) * y_spacing) 5;
    set_color black;
    fill_circle x_spacing (offset + (i-1)* y_spacing) 5
  end
done

let build_nodes network = 
  let num_layers = List.length network in 
  let layer_lens = get_dim network in 
  
  let offset = 50 in 
  let x_spacing = (size_x() - 100) / num_layers in
  let rec send_matrix network = 
    match network with 
    | [] -> ()
    | h :: t -> connect_layers h x_spacing; send_matrix t
  in
  send_matrix network;

  let rec build_layer layer_lens x_pos =
    match layer_lens with
    | [] -> ()
    | h :: t -> draw_neurons h x_pos; build_layer t (x_pos + x_spacing)
  in
  build_layer layer_lens offset

let get_input () = 
  failwith "Unimplemented"

let main () =
  open_graph " 1100x700";
  set_window_title "Network Visualization";
  let sample = [
                 [[0.1;(-0.5);(-1.0);0.4;0.2]; 
                 [1.0;0.5;0.9;(-0.6);(-0.2);(-0.3)]; 
                 [0.1;0.2;0.3;0.4;0.5;0.6]] ;
                (*layer 2 to layer 3*)
               [[0.3;(-0.15);0.3];
               [0.4; 0.01; (-0.9)]]
               ]in 
  (* let mat = Matrix.load_weights "."^Filename.dir_sep^"matrices"^Filename.dir_sep^"matrix_user.txt" in 
  build_nodes (propagate (fst Train_mnist.new_net).model mat) *)
  build_nodes sample;
  (* connect_layers sample;
  arrange_layers sample;
   *)
  
  (*wait for user input//keep window running*)
  ignore (Graphics.read_key ())


(* Run the GUI *)
let () = main ()


open GMain
open GMisc
open Layer

(* [to_matrix img] converts the input [img] to a matrix. The image
 * is initially dumped as a color array array, where entries are RGB
 * values from 0-255. The output matrix will have entries between
 * 0 and 1 to be usable by the neural network. *)
val to_matrix: image -> matrix

(* [classify] processes a click of the classify button. 
 * It takes the image in the drawing pane, converts it to a matrix, 
 * and classifies it as a digit with the neural network.
 * The classification occurs when the classify button is pressed, and  
 * the output given by the neural network is displayed in a text field
 * on the window. *)
val classify: unit -> unit

(* [reset] processes a click of the reset button. 
 * It clears the drawing pane and the text field with the output
 * of the neural network when the reset button is pressed. *)
val reset: unit -> unit

(* [draw] allows the user to draw points or free-form lines on the
 * drawing canvas using a white, fixed-width drawing tool. *)
val draw: unit -> unit

(* [main] makes the window and adds the graphical components to it.
 * The graphical components include the drawing pane, classification
 * text field, and buttons to classify and reset. *)
val main: unit -> unit



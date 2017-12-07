open GMain
open GMisc
open Images
open Graphics

(* [classify] processes a click of the classify button.
 * It takes the image in the drawing pane, converts it to a matrix,
 * and classifies it as a digit with the neural network.
 * The classification occurs when the classify button is pressed, and
 * the output given by the neural network is displayed in a text field
 * on the window. *)
val classify: drawing_area -> unit

(* [main] makes the window and adds the graphical components to it.
 * The graphical components include the drawing pane, classification
 * text field, and buttons to classify and reset. *)
val main: unit -> unit

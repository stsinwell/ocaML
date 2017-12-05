open GMain
open GMisc
<<<<<<< HEAD
open Layer
open Matrix
=======
(* open Matrix *)
>>>>>>> 4ca9c76d4c93c12a9911c9ebe87e0ff46d0b7309

(* [to_matrix img] converts the input [img] to a matrix with entries between
 * 0 and 1 to be used by the neural network. *)
val to_matrix: GDraw.drawable -> int list

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

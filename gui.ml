open GMain
open GMisc
open Images
open Bmp

(* [save_img c dir] saves the image drawn in drawing area [c] to the current
 * directory as "num.bmp". It returns the path to the file as a string. *)
let save_img (c:drawing_area) =
  let mnist_pb = ref (GdkPixbuf.create ~width:28 ~height:28 ()) in
  let pb = ref (GdkPixbuf.create ~width:280 ~height:280 ()) in
  let drawing = c#misc#realize (); new GDraw.drawable (c#misc#window) in
  drawing#get_pixbuf ~src_x:0 ~src_y:0 ~dest_x:0 ~dest_y:0 !pb;
  GdkPixbuf.scale ~dest:!mnist_pb ~scale_x:0.1 ~scale_y:0.1 !pb;
  GdkPixbuf.save ~filename:"num.png" ~typ:"png" !mnist_pb;
  "./num.png"

(* [load_img filepath] loads the image at [filepath].*)
  Bmp.load_bmp filepath

(* [rgb_to_bw rgb] converts a RGB value to a black/white value, based on
 * weights applied to each of the individual RGB values. *)
let rgb_to_bw (rgb : Color.rgb) =
  (0.2989 *. (float rgb.r)) +.
  (0.5870 *. (float rgb.g)) +.
  (0.1140 *. (float rgb.b))

let to_matrix (img : Bmp.bmp) =
  let rgb_array = img.bmpRgbQuad in
  Array.to_list rgb_array |> List.map (fun r -> rgb_to_bw r)

(* TODO: save -> load -> to_matrix -> send to backend *)
let classify (c:drawing_area) =
  save_img c |> load_img |> to_matrix; ()

(* [draw_square x y size white c pm] draws a square of size [size*size] at
 * coordinates ([x], [y]) in canvas [c]. If [white] is true, the square is
 * white; otherwise, it is black. The default value is true (white).
 * The drawing itself is done on the backing pixmap given by [pm]. *)
let draw_square x y size ?(white=true) (c:drawing_area) (pm:GDraw.pixmap ref) =
  if white then !pm#set_foreground `WHITE
  else !pm#set_foreground `BLACK;
  !pm#rectangle ~x ~y ~width:size ~height:size ~filled:true ();
  c#misc#realize ();
  (new GDraw.drawable (c#misc#window))#
    put_pixmap ~x ~y ~xsrc:x ~ysrc:y !pm#pixmap

(* [process_click c pm e] processes a click on drawing area [c] after event [e].
 * The drawing area is backed by the pixmap [pm]. *)
let process_click (c:drawing_area) (pm:GDraw.pixmap ref) e =
  let brush_size = 10 in
  let mouse_x = GdkEvent.Button.x e |> int_of_float in
  let mouse_y = GdkEvent.Button.y e |> int_of_float in
  draw_square mouse_x mouse_y brush_size c pm;
  true

(* [process_move c pm e] processes the movement of the mouse on drawing area
 * [c] after event [e]. If the event [e] was a mouse click, the movement of
 * the mouse is drawn on [c], which is backed by the pixmap [pm]. *)
let process_move (c:drawing_area) (pm:GDraw.pixmap ref) e =
  let brush_size = 10 in
  let mouse_x = GdkEvent.Motion.x e |> int_of_float in
  let mouse_y = GdkEvent.Motion.y e |> int_of_float in
  if GdkEvent.Motion.state e |> Gdk.Convert.test_modifier `BUTTON1
  then draw_square mouse_x mouse_y brush_size c pm;
  true

(* [repaint c pm e] repaints the updated areas of the canvas [c] using its
 *  backing pixmap [pm], after event [e]. *)
let repaint (c:drawing_area) (pm:GDraw.pixmap ref) e =
  let repaint_area = GdkEvent.Expose.area e in
  let x = Gdk.Rectangle.x repaint_area in
  let y = Gdk.Rectangle.y repaint_area in
  (new GDraw.drawable (c#misc#window))#
    put_pixmap ~x ~y ~xsrc:x ~ysrc:y !pm#pixmap;
  false

(* [reset] processes a click of the reset button.
 * It clears the drawing pane and TODO: the text field with the output
 * of the neural network. *)
let reset (c:drawing_area) (pm:GDraw.pixmap ref) =
  let canvas_size = 280 in
  draw_square 0 0 canvas_size ~white:false c pm

let main () =
  ignore (GtkMain.Main.init ());

  (* top-level window & box to contain components *)
  let window = GWindow.window ~width:280 ~height:410 ~title:"OcaML" () in
  window#set_resizable false;
  ignore (window#connect#destroy ~callback:Main.quit);
  let vbox = GPack.vbox ~packing:window#add () in

  (* drawing canvas & its backing pixmap *)
  let canvas = drawing_area ~width:280 ~height:280 ~packing:vbox#add () in
  let pm = ref (GDraw.pixmap ~width:280 ~height:280 ~mask:true ()) in
  canvas#event#add [`BUTTON_PRESS; `BUTTON1_MOTION; `EXPOSURE];
  ignore (canvas#event#connect#configure ~callback:(fun _ -> reset canvas pm;
                                                             true));
  ignore (canvas#event#connect#button_press ~callback:(process_click canvas pm));
  ignore (canvas#event#connect#motion_notify ~callback:(process_move canvas pm));
  ignore (canvas#event#connect#expose ~callback:(repaint canvas pm));

  (* reset button *)
  let resetbtn = GButton.button ~label:"Reset" ~packing:vbox#add () in
  ignore (resetbtn#connect#clicked ~callback:(fun () -> reset canvas pm));

  (* classify button *)
  let classifybtn = GButton.button ~label:"Classify" ~packing:vbox#add () in
  ignore (classifybtn#connect#clicked ~callback:(fun () -> classify canvas));

  (* output of classification *)
  let output = label ~markup:"\n<b><u>OUTPUT</u>:</b>\n" ~packing:vbox#add () in
  let vis_window = GWindow.window ~width:400 ~height:410 ~title: "visualisation" () in 
  vis_window#set_resizable false;
  let vis_vbox = GPack.vbox ~packing:vis_window#add () in

  (* display GUI, enter event loop *)
  window#show ();
  Main.main ()

(* Run the GUI *)
(* let () = main () *)

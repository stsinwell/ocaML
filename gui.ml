open GMain
open GMisc
(* open Matrix *)

(* [save_img c dir] saves the image drawn in drawing area [c] to directory [dir]
 * as "num.jpg". *)
let save_img (c:drawing_area) dir =
  let mnist_pb = ref (GdkPixbuf.create ~width:28 ~height:28 ~colorspace:`RGB
                                       ~has_alpha:true ()) in
  let pb = ref (GdkPixbuf.create ~width:280 ~height:280 ~colorspace:`RGB
                                 ~has_alpha:true ()) in
  c#misc#realize ();
  GdkPixbuf.get_from_drawable
    ~dest:!pb ~dest_x:0 ~dest_y:0 ~width:280 ~height:280
    ~src_x:0 ~src_y:0 ~colormap:(c#misc#colormap) (c#misc#window);
  GdkPixbuf.scale ~dest:!mnist_pb ~scale_x:0.1 ~scale_y:0.1 !pb;
  GdkPixbuf.save ~filename:"num.bmp" ~typ:"bmp" !mnist_pb

let load_img () = ()

let to_matrix img =
  failwith "unimplemented"

(* TODO: save -> load -> to_matrix -> send to backend *)
let classify (c:drawing_area) =
  save_img c ".";
  ()

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
  if GdkEvent.Button.button e = 1
  then draw_square mouse_x mouse_y brush_size c pm;
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
 * It clears the drawing pane and the text field with the output
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
  ignore (canvas#event#connect#button_press ~callback:(process_click canvas pm));
  ignore (canvas#event#connect#motion_notify ~callback:(process_move canvas pm));
  ignore (canvas#event#connect#expose ~callback:(repaint canvas pm));

  (* reset button *)
  let resetbtn = GButton.button ~label:"\nReset\n" ~packing:vbox#add () in
  ignore (resetbtn#connect#clicked ~callback:(fun () -> reset canvas pm));

  (* classify button *)
  let classifybtn = GButton.button ~label:"\nClassify\n" ~packing:vbox#add () in
  ignore (classifybtn#connect#clicked ~callback:(fun () -> classify canvas));

  (* output of classification *)
  let output = label ~markup:"\n<b><u>OUTPUT</u>:</b>\n" ~packing:vbox#add () in

  (* display GUI, enter event loop *)
  window#show ();
  Main.main ()

(* Run the GUI *)
let () = main ()

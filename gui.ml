open GMain
open GMisc
open Images
open Graphics

(* [img_no] is a constant to keep track of how many drawings can be saved.
 * This allows multiple drawings to be saved into the [images] directory.
 * This number is reset whenever a new drawing session is started (i.e.
 * whenever the GUI is restarted). *)
let img_no = ref 0

(* [save_img c dir] saves the image drawn in drawing area [c] to the current
 * directory as "num.bmp". It returns the path to the file as a string. *)
let save_img (c:drawing_area) =
  let filename = "./images/num" ^ string_of_int !img_no ^ ".bmp" in
  let mnist_pb = ref (GdkPixbuf.create ~width:28 ~height:28 ()) in
  let pb = ref (GdkPixbuf.create ~width:280 ~height:280 ()) in
  let drawing = c#misc#realize (); new GDraw.drawable (c#misc#window) in
  drawing#get_pixbuf ~src_x:0 ~src_y:0 ~dest_x:0 ~dest_y:0 !pb;
  GdkPixbuf.scale ~dest:!mnist_pb ~scale_x:0.1 ~scale_y:0.1 !pb;
  GdkPixbuf.save ~filename ~typ:"bmp" !mnist_pb;
  incr img_no;
  filename

(* [process_color c] is a float between 0.0 and 1.0 that represents the RGB
 * color value given in [c]. *)
let process_color (c : int) =
  let red = ((c lsr 16)) land 0xff in
  let green = ((c lsr 8)) land 0xff in
  let blue = c land 0xff in
  float (((red + green + blue) / 3) land 0xff) /. 255.0

let to_matrix (img:Images.t) =
  let matrix = ref [] in
  (match img with
   | Rgb24 bmp ->
       begin for i = 0 to (bmp.Rgb24.height - 1) do
         (for j = 0 to (bmp.Rgb24.width - 1) do
            let {r = r; g = g; b = b} = Rgb24.get bmp j i
            in matrix := [Graphics.rgb r g b]::(!matrix)
          done)
       done
       end
   | _ -> failwith "invalid filetype");
  List.rev !matrix
  |> List.map (fun el -> List.map (fun e -> process_color e) el)

(* TODO: save -> load -> to_matrix -> send to backend *)
let classify (c:drawing_area) =
  load (save_img c) []
  |> to_matrix; ()

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
  let brush_size = 100 in
  let mouse_x = GdkEvent.Button.x e |> int_of_float in
  let mouse_y = GdkEvent.Button.y e |> int_of_float in
  draw_square mouse_x mouse_y brush_size c pm;
  true

(* [process_move c pm e] processes the movement of the mouse on drawing area
 * [c] after event [e]. If the event [e] was a mouse click, the movement of
 * the mouse is drawn on [c], which is backed by the pixmap [pm]. *)
let process_move (c:drawing_area) (pm:GDraw.pixmap ref) e =
  let brush_size = 100 in
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

  (* display GUI, enter event loop *)
  window#show ();
  Main.main ()

(* Run the GUI *)
let () = main ()

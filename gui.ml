open GMain
open GMisc
open Matrix

let to_matrix img =
  failwith "unimplemented"

let classify () = ()

let reset () = ()


(*** CANVAS ***)
(* [update_pm w pm e] updates the pixmap [pm] on window [w] after event [e].*)
let update_pm (w:GWindow.window) (pm:GDraw.pixmap ref) e =
  let pm' = GDraw.pixmap
      ~width:(GdkEvent.Configure.width e)
      ~height:(GdkEvent.Configure.height e)
      ~window:w () in
  pm'#set_foreground `BLACK;
  pm'#rectangle ~x:10 ~y:10 ~width:280 ~height:280 ~filled:true ();
  pm := pm';
  true

(* [draw_square x y c pm] draws a square at coordinates ([x], [y]) in canvas
 * [c]. The drawing itself is done on the backing pixmap given by [pm]. *)
let draw_square x y (c:drawing_area) (pm:GDraw.pixmap ref) =
  true

(* [process_click c pm e] processes a click on drawing area [c] after event [e].
 * The drawing area is backed by the pixmap [pm]. *)
let process_click (c:drawing_area) (pm:GDraw.pixmap ref) e =
  true

(* [process_click c pm e] processes the movement of the mouse on drawing area
 * [c] after event [e]. The drawing area is backed by the pixmap [pm]. *)
let process_move (c:drawing_area) (pm:GDraw.pixmap ref) e =
  true

(* [repaint c pm e] repaints the canvas [c] using its backing pixmap [pm],
 * after event [e]. *)
let repaint (c:drawing_area) (pm:GDraw.pixmap ref) e =
  let event_area = GdkEvent.Expose.area e in
  let fill_x = Gdk.Rectangle.x event_area in
  let fill_y = Gdk.Rectangle.y event_area in
  let fill_wh = Gdk.Rectangle.width event_area in
  c#misc#realize ();
  (new GDraw.drawable (c#misc#window))#put_pixmap ~x:fill_x ~y:fill_y
                                                  ~width:fill_wh ~height:fill_wh
                                                  !pm#pixmap;
  false

(*** MAIN GUI ***)
let main () =
  ignore (GtkMain.Main.init ());

  (* top-level window & box to contain components *)
  let window = GWindow.window ~width:300 ~height:475 ~title:"OcaML" () in
  ignore (window#connect#destroy ~callback:Main.quit);
  let vbox = GPack.vbox ~packing:window#add () in

  (* drawing canvas & its backing pixmap *)
  let canvas = drawing_area ~width:280 ~height:280 ~packing:vbox#add () in
  let pixback = ref (GDraw.pixmap ~width:280 ~height:280 ~mask:true ()) in
  ignore (canvas#event#connect#configure ~callback:(update_pm window pixback));
  ignore (canvas#event#connect#button_press ~callback:(process_click canvas pixback));
  ignore (canvas#event#connect#motion_notify ~callback:(process_move canvas pixback));
  ignore (canvas#event#connect#expose ~callback:(repaint canvas pixback));

  (* reset button *)
  let resetbtn = GButton.button ~label:"\nReset\n" ~packing:vbox#add () in
  ignore (resetbtn#connect#clicked ~callback:reset);

  (* classify button *)
  let classifybtn = GButton.button ~label:"\nClassify\n" ~packing:vbox#add () in
  ignore (classifybtn#connect#clicked ~callback: classify);

  (* output of classification *)
  let output = label ~markup:"\n<b>OUTPUT</b>\n" ~packing:vbox#add () in

  (* display GUI, enter event loop *)
  window#show ();
  Main.main ()

(* Run the GUI *)
let () = main ()

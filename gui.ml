open GMain
open GMisc
open Layer

let to_matrix img =
  failwith "unimplemented"

let classify () = ()

let reset () = ()

(* [canvas] is a drawing canvas that can be repainted. *)
class canvas packing =
  let vbox = GPack.vbox ~width:280 ~height:280 ~packing:packing ~show:true () in
  let canvas = drawing_area ~width:280 ~height:280 ~show:true ~packing:vbox#add () in
  let drawable = lazy (new GDraw.drawable canvas#misc#window) in

  object (self)
    inherit GObj.widget vbox#as_widget

    initializer
      ignore(canvas#event#connect#expose ~callback:(fun _ -> self#repaint (); false));

    method private repaint () =
      let drawable = Lazy.force drawable in
      let context = drawable#gc in
      drawable#set_background `BLACK;
      drawable#set_foreground `BLACK;
      drawable#rectangle ~x:10 ~y:10 ~width:280 ~height:280 ~filled:true ();
      ()
  end

let draw (dw : GDraw.drawable) =
  dw#rectangle ~x:10 ~y:10 ~width:280 ~height:280 ~filled:true ();
  false

let draw_square (dw : GDraw.drawable) =
  dw#rectangle ~x:10 ~y:10 ~width:10 ~height:10 ~filled:true ();
  false

let main () =
  GtkMain.Main.init ();

  (* top-level window *)
  let window = GWindow.window ~width:300 ~height:475 ~title:"OcaML" () in
  let vbox = GPack.vbox ~packing:window#add () in
  window#connect#destroy ~callback:Main.quit;

  (* drawing canvas *)
  (* let canvas = new canvas vbox#add in *)
  let canvas_area = drawing_area ~width:280 ~height:280 ~show:true ~packing:vbox#add () in
  let canvas = canvas_area#misc#realize ();
               new GDraw.drawable (canvas_area#misc#window) in
  canvas_area#event#connect#expose ~callback: (fun _ -> draw_square canvas);

  (* reset button *)
  let resetbtn = GButton.button ~label:"\nReset\n" ~packing:vbox#add () in
  resetbtn#connect#clicked ~callback:reset;

  (* classify button *)
  let classifybtn = GButton.button ~label:"\nClassify\n" ~packing:vbox#add () in
  classifybtn#connect#clicked ~callback: classify;

  (* output of classification *)
  let output = label ~markup:"\n<b>OUTPUT</b>\n" ~packing:vbox#add () in

  (* display GUI, enter event loop *)
  window#show ();
  Main.main ()

(* Run the GUI *)
let () = main ()

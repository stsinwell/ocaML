open Graphics
open GMain
open GMisc
open GdkKeysyms


let to_matrix img =
  failwith "unimplemented"

let classify () = ()

let reset () = ()

let draw () = ()

let main () =
  GtkMain.Main.init ();

  (* top-level window *)
  let window = GWindow.window ~width:300 ~height:350 ~title:"GUI" () in
  let vbox = GPack.vbox ~packing:window#add () in
  window#connect#destroy ~callback:Main.quit;

  (* drawing canvas *)

  (* reset button *)
  let button = GButton.button ~label:"Reset" ~packing:vbox#add () in
  button#connect#clicked ~callback:classify;

  (* classify button *)

  (* classify output field *)

  (* display GUI *)
  window#show ();
  Main.main ()

let () = main ()

open GMain
open GMisc
open Graphics
open Model


let arrangeLayers (l : Model.model) = 
  let numLayers = List.length l in

  failwith "Unimplemented"



let main () =
  ignore (GtkMain.Main.init ());

  let diff_window = Graphics.open_graph " 800x250" in

  (* top-level window & box to contain components *)
  let window = GWindow.window ~width:1000 ~height:600 ~title:"Visualisation" () in
  window#set_resizable false;
  ignore (window#connect#destroy ~callback:Main.quit);
  let vbox = GPack.vbox ~packing:window#add () in



  (* display GUI, enter event loop *)
  window#show ();
  Main.main ()

(* Run the GUI *)
let () = main ()
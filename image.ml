open GMisc
open Images
open Graphics

(* [process_color c] is a float between 0.0 and 1.0 that represents the RGB
 * color value given in [c]. *)
let process_color (c : int) =
  let red = ((c lsr 16)) land 0xff in
  let green = ((c lsr 8)) land 0xff in
  let blue = c land 0xff in
  float (((red + green + blue) / 3) land 0xff) /. 255.0;;

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

open Model
open Layer
open Actv

let d= "."^Filename.dir_sep^"matrices"^Filename.dir_sep^"mnist"^Filename.dir_sep

let load =
  let layer1 = load_layer softplus
      (d^"saved_net-mnist-model-0wgt.txt")
      (d^"saved_net-mnist-model-0bias.txt") in
  let layer2 = load_layer softmax
      (d^"saved_net-mnist-model-1wgt.txt")
      (d^"saved_net-mnist-model-1bias.txt") in
  let model = [layer1; layer2] in
  { model = model; loss = Loss.cat_crossentropy }

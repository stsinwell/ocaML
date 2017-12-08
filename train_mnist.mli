open Model
open Layer
open Lacaml.D
open Lacaml.Io
open Actv
open Matrix
open Loss
open Dsfo
open Bigarray

(* [new_net] is the network after training and the list of files that are saved
 * after training the network. It can be used to later load the same network. *)
val new_net : (network * ((string * string) list))

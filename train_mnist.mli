open Model
open Layer
open Lacaml.D
open Lacaml.Io
open Actv
open Matrix
open Loss
open Dsfo
open Bigarray

(* [load_mnist] is the network after training on the MNIST dataset. *)
val load_mnist : network

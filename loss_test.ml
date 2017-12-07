open OUnit2
open Loss

let cat_tests = [
  (* "ones_f" >:: (fun _ -> ) *)

]

let suite = "loss test suite" >:::
  cat_tests

let _ = run_test_tt_main suite

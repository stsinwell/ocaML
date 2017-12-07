open OUnit2
open Actv
open Matrix

let sigmoid_tests = [
  (* Square matrices *)
  "ones_f" >:: (fun _ -> assert_equal (mat_const 5 5 0.731058597565)
                         (sigmoid.f (mat_ones 5 5)));
  "zeros_f" >:: (fun _ -> assert_equal (mat_const 100 100 0.5)
                          (sigmoid.f (mat_zeros 100 100)));
  "ones_f'" >:: (fun _ -> assert_equal (mat_const 50 50 0.19661192596)
                          (sigmoid.f' (mat_ones 50 50)));
  "zeros_f'" >:: (fun _ -> assert_equal (mat_const 1000 1000 0.25)
                           (sigmoid.f' (mat_zeros 1000 1000)));

  (* Other constants, non-square *)
  "const0_f" >:: (fun _ -> assert_equal (mat_const 1 700 0.993307173252)
                           (sigmoid.f (mat_const 1 700 5.0)));
  "const0_f'" >:: (fun _ -> assert_equal (mat_const 1 700 0.00664803292602)
                            (sigmoid.f' (mat_const 1 700 5.0)));
  "const1_f" >:: (fun _ -> assert_equal (mat_const 1000 1 1.0)
                     (sigmoid.f (mat_const 1000 1 50.0)));
  "const1_f'" >:: (fun _ -> assert_equal (mat_const 1000 1 0.0)
                      (sigmoid.f' (mat_const 1000 1 50.0)));
]

let suite = "actv test suite" >:::
  sigmoid_tests

let _ = run_test_tt_main suite

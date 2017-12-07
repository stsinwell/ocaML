open OUnit2
open Matrix

let matrix_tests = [
  "const" >:: (fun _ -> assert_equal [[2.0; 2.0; 2.0]; [2.0; 2.0; 2.0]]
                   (mat_const 2 3 2.0 |> to_list));
  "const_sq" >:: (fun _ -> assert_equal [[3.5; 3.5]; [3.5; 3.5]]
                     (mat_const 2 2 3.5 |> to_list));
  "const_vect" >:: (fun _ -> assert_equal [[7.5]; [7.5]; [7.5]]
                       (mat_const 3 1 7.5 |> to_list));
  "ones0" >:: (fun _ -> assert_equal [[1.0]] (mat_ones 1 1 |> to_list));
  "ones1" >:: (fun _ -> assert_equal [[1.0; 1.0]; [1.0; 1.0]; [1.0; 1.0]]
                  (mat_ones 3 2 |> to_list));
  "ones_vect" >:: (fun _ -> assert_equal [[1.0]; [1.0]; [1.0]; [1.0]]
                      (mat_ones 4 1 |> to_list));
  "zeros0" >:: (fun _ -> assert_equal [[0.0]] (mat_zeros 1 1 |> to_list));
  "zeros1" >:: (fun _ -> assert_equal [[0.0; 0.0; 0.0]; [0.0; 0.0; 0.0]]
                         (mat_zeros 2 3 |> to_list));
  "zeros_vect" >:: (fun _ -> assert_equal [[0.0]; [0.0]]
                             (mat_zeros 2 1 |> to_list));
  "saveload0" >:: (fun _ -> assert_equal [[1.75; 1.75]; [1.75; 1.75]; [1.75; 1.75]]
                            (mat_const 3 2 1.75
                             |> save_weights "./matrices/matrix_test0.txt"
                             |> load_weights |> to_list));
  "saveload1" >:: (fun _ -> assert_equal [[2.25; 2.25; 2.25]; [2.25; 2.25; 2.25]]
                      (mat_const 2 3 2.25
                       |> save_weights "./matrices/matrix_test1.txt"
                       |> load_weights |> to_list));
  "saveload_vect" >:: (fun _ -> assert_equal [[2.5]; [2.5]; [2.5]]
                          (mat_const 3 1 2.5
                           |> save_weights "./matrices/matrix_test2.txt"
                           |> load_weights |> to_list));
]

let suite = "matrix test suite" >:::
  matrix_tests

let _ = run_test_tt_main suite

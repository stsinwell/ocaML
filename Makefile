actv_test:
	ocamlbuild -use-ocamlfind actv_test.byte && ./actv_test.byte

loss_test:
	ocamlbuild -use-ocamlfind loss_test.byte && ./loss_test.byte

layer_test:
	ocamlbuild -use-ocamlfind layer_test.byte && ./layer_test.byte

matrix_test:
	ocamlbuild -use-ocamlfind matrix_test.byte && ./matrix_test.byte

visualise:
	ocamlbuild -use-ocamlfind visualisation.byte && ./visualisation.byte

test_model:
	ocamlbuild -use-ocamlfind model_test.byte && ./model_test.byte

gui:
	ocamlbuild -use-ocamlfind matrix.cmo gui.byte && ./gui.byte

base:
	ocamlbuild -use-ocamlfind matrix.cmo layer.cmo model.cmo

compile:
	ocamlbuild -use-ocamlfind gui.cmo image.cmo actv.cmo loss.cmo layer.cmo model.cmo matrix.cmo visualisation.cmo

clean:
	ocamlbuild -clean

actv_test:
	ocamlbuild -cflags -w,-a use-ocamlfind actv_test.byte && ./actv_test.byte

loss_test:
	ocamlbuild -cflags -w,-a -use-ocamlfind loss_test.byte && ./loss_test.byte

layer_test:
	ocamlbuild -cflags -w,-a -use-ocamlfind layer_test.byte && ./layer_test.byte

matrix_test:
	ocamlbuild -cflags -w,-a -use-ocamlfind matrix_test.byte && ./matrix_test.byte

visualise:
	ocamlbuild -cflags -w,-a -use-ocamlfind visualisation.byte && ./visualisation.byte

test_model:
	ocamlbuild -cflags -w,-a -use-ocamlfind model_test.byte && ./model_test.byte

gui:
	ocamlbuild -cflags -w,-a -use-ocamlfind matrix.cmo gui.byte && ./gui.byte

base:
	ocamlbuild -cflags -w,-a -use-ocamlfind matrix.cmo layer.cmo model.cmo

compile:
	ocamlbuild -cflags -w,-a -use-ocamlfind gui.cmo image.cmo actv.cmo loss.cmo layer.cmo model.cmo matrix.cmo visualisation.cmo

clean:
	ocamlbuild -clean

actv_test:
	ocamlbuild -use-ocamlfind actv_test.byte && ./actv_test.byte

matrix_test:
	ocamlbuild -use-ocamlfind matrix_test.byte && ./matrix_test.byte

test_model:
	ocamlbuild -use-ocamlfind model_test.byte && ./model_test.byte

gui:
	ocamlbuild -use-ocamlfind gui.byte && ./gui.byte

base:
	ocamlbuild -use-ocamlfind matrix.cmo layer.cmo model.cmo

compile:
	ocamlbuild -use-ocamlfind gui.cmo actv.cmo loss.cmo layer.cmo model.cmo matrix.cmo

clean:
	ocamlbuild -clean

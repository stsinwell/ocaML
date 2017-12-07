test:
	ocamlbuild -use-ocamlfind gui_test.byte && ./gui_test.byte

gui:
	ocamlbuild -use-ocamlfind gui.byte && ./gui.byte

test_model:
	ocamlbuild -use-ocamlfind model_test.byte && ./model_test.byte

base:
	ocamlbuild -use-ocamlfind matrix.cmo layer.cmo model.cmo

compile:
	ocamlbuild -use-ocamlfind gui.cmo layer.cmo model.cmo matrix.cmo

clean:
	ocamlbuild -clean

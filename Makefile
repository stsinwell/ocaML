test:
	ocamlbuild -use-ocamlfind test_gui.byte && ./test_gui.byte

gui:
	ocamlbuild -use-ocamlfind gui.byte && ./gui.byte

test_model:
	ocamlbuild -use-ocamlfind model_test.byte && ./model_test.byte

base:
	ocamlbuild -use-ocamlfind matrix.cmo layer.cmo nlmf.cmo model.cmo

compile:
	ocamlbuild -use-ocamlfind gui.cmo layer.cmo nlmf.cmo model.cmo matrix.cmo

clean:
	ocamlbuild -clean

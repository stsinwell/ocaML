# test:
# 	ocamlbuild -use-ocamlfind state_test.byte && ./state_test.byte

gui:
	ocamlbuild -use-ocamlfind gui.byte && ./gui.byte

compile:
	ocamlbuild -use-ocamlfind gui.cmo layer.cmo loss.cmo model.cmo

clean:
	ocamlbuild -clean

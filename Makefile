# test:
# 	ocamlbuild -use-ocamlfind state_test.byte && ./state_test.byte

gui:
	ocamlbuild -cflags -w,-S -use-ocamlfind gui.byte && ./gui.byte

base:
	ocamlbuild -use-ocamlfind matrix.cmo layer.cmo loss.cmo model.cmo

compile:
	ocamlbuild -cflags -w,-S -use-ocamlfind gui.cmo layer.cmo loss.cmo model.cmo

clean:
	ocamlbuild -clean

# test:
# 	ocamlbuild -use-ocamlfind state_test.byte && ./state_test.byte

gui:
	ocamlbuild -use-ocamlfind gui.byte && ./gui.byte

base:
	ocamlbuild -use-ocamlfind matrix.cmo layer.cmo nlmf.cmo model.cmo

compile:
	ocamlbuild -cflags -w,-S -use-ocamlfind gui.cmo layer.cmo nlmf.cmo model.cmo matrix.cmo
clean:
	ocamlbuild -clean

# test:
# 	ocamlbuild -use-ocamlfind state_test.byte && ./state_test.byte

gui:
	ocamlbuild -use-ocamlfind gui.byte && ./gui.byte

base:
	ocamlbuild -use-ocamlfind matrix.cmo layer.cmo nlmf.cmo model.cmo

compile:
<<<<<<< HEAD
	ocamlbuild -cflags -w,-S -use-ocamlfind gui.cmo layer.cmo nlmf.cmo model.cmo matrix.cmo
=======
	ocamlbuild -use-ocamlfind matrix.cmo layer.cmo gui.cmo loss.cmo model.cmo

>>>>>>> 4ca9c76d4c93c12a9911c9ebe87e0ff46d0b7309
clean:
	ocamlbuild -clean

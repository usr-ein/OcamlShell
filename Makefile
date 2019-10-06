all:
	ocamlfind opt -o build/osh main.ml -thread -linkpkg -package core
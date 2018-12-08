#!/usr/bin/env bash

ocamlfind ocamlopt -package batteries,yojson -linkpkg $1.ml -o $1
./$1

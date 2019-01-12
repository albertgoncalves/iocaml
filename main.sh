#!/usr/bin/env bash

set -e

ocamlfind ocamlopt -package batteries,yojson -linkpkg $1.ml -o $1
./$1

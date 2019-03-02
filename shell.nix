{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "OCaml";
    buildInputs = [ ocaml-ng.ocamlPackages_4_07.ocaml
                    ocaml-ng.ocamlPackages_4_07.batteries
                    ocaml-ng.ocamlPackages_4_07.yojson
                    ocaml-ng.ocamlPackages_4_07.findlib
                    ocaml-ng.ocamlPackages_4_07.ocp-indent
                    ocaml-ng.ocamlPackages_4_07.utop
                    fzf
                    tmux
                  ];
    shellHook = ''
        strcd() {
            cd "$(dirname $1)"
        }

        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }

        export -f withfzf
        alias cdfzf="withfzf strcd"
        alias vimfzf="withfzf vim"
    '';
}

#!/usr/bin/env ocaml

#directory "pkg";;
#use       "topfind";;
#require   "topkg";;

open Topkg

let opam = Pkg.opam_file ~lint_deps_excluding:(Some [ "ocamlbuild"; "topkg"; "ocaml"; "ocamlfind"; "base-bytes" ]) "checkseum.opam"

let () =
  Pkg.describe ~opams:[opam] "checkseum" @@ fun c ->

  Ok [ Pkg.lib "pkg/META"
     ; Pkg.doc "README.md"
     ; Pkg.doc "CHANGES.md"

     ; Pkg.lib "src/checkseum.cmi" ~dst:"checkseum.cmi"
     ; Pkg.lib "src/checkseum.cmi" ~dst:"c/checkseum.cmi"
     ; Pkg.lib "src/checkseum.cmi" ~dst:"ocaml/checkseum.cmi"
     ; Pkg.clib "src-c/liblaolao_stubs.clib" ~lib_dst_dir:"c"
     ; Pkg.mllib "src-c/checkseum.mllib" ~dst_dir:"c"
     ; Pkg.mllib "src-ocaml/checkseum.mllib" ~dst_dir:"ocaml" ]

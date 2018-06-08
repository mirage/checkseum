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

     ; Pkg.clib "src-c/liblaolao_stubs.clib" ~lib_dst_dir:"c"
     ; Pkg.lib "src/checkseum.cmi" ~dst:"checkseum.cmi"
     ; Pkg.mllib "src/checkseum.mllib"
     ; Pkg.mllib ~api:["Checkseum"] "src-c/checkseum-c.mllib" ~dst_dir:"c"
     ; Pkg.mllib ~api:["Checkseum"] "src-ocaml/checkseum-ocaml.mllib" ~dst_dir:"ocaml" ]

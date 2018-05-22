open Ocamlbuild_plugin

let headers =
  [ "src-c/native/checkseum.h"
  ; "src-c/native/adler32.h" ]

let static = true

let () =
  dispatch @@ function
  | After_rules ->
    dep ["record_checkseum_laolao_stub"] ["src-c/liblaolao_stubs.a"];
    dep ["compile"; "c"] headers;

    flag_and_dep
      ["link"; "ocaml"; "link_checkseum_laolao_stubs"]
      (P "src-c/liblaolao_stubs.a");
    flag ["library"; "ocaml"; "byte"; "record_checkseum_laolao_stubs"]
      (S [ A "-dllib"; A "-llaolao_stubs"]);
    flag ["library"; "ocaml"; "record_checkseum_laolao_stubs"]
      (S [ A "-cclib"; A "-llaolao_stubs"]);
  | _ -> ()

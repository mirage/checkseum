open Ast_mapper
open Ast_helper
open Asttypes
open Parsetree
open Longident

let int ~loc = [%type: int]
let int32 ~loc = [%type: int32]

let name = "optint"

let expand ~loc =
  Caml.Format.printf "!!!! ENTER IN PPX !!!!\n%!";

  if Caml.Sys.int_size = 63
  then int ~loc
  else int32 ~loc

let type_declaration mapper type_declaration = match type_declaration with
  | { ptype_attributes = [ { Location.txt; _ }, _payload ] } ->
     Format.printf "attributes: [ %s ].\n%!" txt;
     default_mapper.type_declaration mapper type_declaration
  | _ -> default_mapper.type_declaration mapper type_declaration

let mapper argv =
  { default_mapper with type_declaration }

let () = register "optint" mapper

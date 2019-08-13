open Mirage

let checkseur =
  foreign "Unikernel.Make"
    (console @-> job)

let packages =
  [ package ~sublibs:["c"] "checkseum"
  ; package "fmt" ]

let () =
  register "checkseur"
    ~packages [ checkseur $ default_console ]

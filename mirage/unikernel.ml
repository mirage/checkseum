module Make (Console : Mirage_types_lwt.CONSOLE)
= struct
  let log console fmt = Fmt.kstrf (Console.log console) fmt

  let start console =
    let c = Checkseum.Adler32.digest_string "" 0 0 Checkseum.Adler32.default in
    log console "%a%!" Checkseum.Adler32.pp c
end

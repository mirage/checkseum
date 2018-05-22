type t = Optint.t

type ba = (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
type st = Bytes.t

type off = int
type len = int

external adler32_bigstring : t -> ba -> off -> len -> t = "caml_checkseum_adler32_ba"
external adler32_bytes     : t -> st -> off -> len -> t = "caml_checkseum_adler32_st"

type t = Optint.t

type ba = (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
type st = Bytes.t

type off = int
type len = int

type bigstring = (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

external adler32_bigstring : t -> ba -> off -> len -> t = "caml_checkseum_adler32_ba"
external adler32_bytes     : t -> st -> off -> len -> t = "caml_checkseum_adler32_st"

module type S =
sig
  type t = Optint.t

  val pp: Format.formatter -> t -> unit
  val equal: t -> t -> bool
  val default: t
  val digest_bytes: Bytes.t -> int -> int -> t -> t
  val digest_bigstring: bigstring -> int -> int -> t -> t
end

module Adler32: S = struct
  type t = Optint.t

  let equal = Optint.equal
  let pp = Optint.pp
  let default = Optint.one
  let digest_bytes bytes off len adler32 =
    adler32_bytes adler32 bytes off len
  let digest_bigstring bigstring off len adler32 =
    adler32_bigstring adler32 bigstring off len
end

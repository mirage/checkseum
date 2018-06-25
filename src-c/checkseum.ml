type t = Optint.t

type ba = (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
type st = Bytes.t

type off = int
type len = int

type bigstring = (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

external adler32_bigstring : t -> ba -> off -> len -> t = "caml_checkseum_adler32_ba"
external adler32_bytes     : t -> st -> off -> len -> t = "caml_checkseum_adler32_st"
external crc32_bigstring   : t -> ba -> off -> len -> t = "caml_checkseum_crc32_ba"
external crc32_bytes       : t -> st -> off -> len -> t = "caml_checkseum_crc32_st"

module type S =
sig
  type t = Optint.t

  val pp: Format.formatter -> t -> unit
  val equal: t -> t -> bool
  val default: t
  val digest_bytes: Bytes.t -> int -> int -> t -> t
  val digest_string: String.t -> int -> int -> t -> t
  val digest_bigstring: bigstring -> int -> int -> t -> t
end

module Adler32: S = struct
  type t = Optint.t

  let equal = Optint.equal
  let pp = Optint.pp
  let default = Optint.one
  let digest_bytes bytes off len adler32 =
    adler32_bytes adler32 bytes off len
  let digest_string string off len adler32 =
    digest_bytes (Bytes.unsafe_of_string string) off len adler32
  let digest_bigstring bigstring off len adler32 =
    adler32_bigstring adler32 bigstring off len
end

module Crc32: S = struct
  type t = Optint.t

  let equal = Optint.equal
  let pp = Optint.pp
  let default = Optint.zero

  let digest_bytes bytes off len crc32 =
    crc32_bytes crc32 bytes off len
  let digest_string string off len crc32 =
    digest_bytes (Bytes.unsafe_of_string string) off len crc32
  let digest_bigstring bigstring off len crc32 =
    crc32_bigstring crc32 bigstring off len

  let%test _ = digest_string "" 0 0 @@ default = (Optint.of_int32 0l)
  let%test _ = digest_string "\x00" 0 1 @@ default = (Optint.of_int32 0x527d5351l)
  let%test _ = digest_string "\x00\x00\x00" 0 3 @@ default = (Optint.of_int32 0x6064a37al)
  let%test _ = digest_string "\xff\xff\xff\xff" 0 4 @@ default = (Optint.of_int 0xffffffff)
  let%test _ = digest_string "123456789" 0 9 @@ default = (Optint.of_int 0xe3069283)
  let%test _ = digest_string "Thou hast made me, and shall thy work decay?" 0 44 @@ default = Optint.of_int 0x866374c0
end

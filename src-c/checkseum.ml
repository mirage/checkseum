type t = Optint.t

type ba = (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t
type st = Bytes.t

type off = int
type len = int

type bigstring = (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

external adler32_bigstring : t -> ba -> off -> len -> t = "caml_checkseum_adler32_ba"
external adler32_bytes     : t -> st -> off -> len -> t = "caml_checkseum_adler32_st"
external adler_crc32c_bigstring
  : t -> ba -> off -> len -> t = "caml_checkseum_adler_crc32c_ba"

module type S =
sig
  type t = Optint.t

  val pp: Format.formatter -> t -> unit
  val equal: t -> t -> bool
  val default: t
  val digest_bytes: Bytes.t -> int -> int -> t -> t
  val digest_bigstring: bigstring -> int -> int -> t -> t
  val crc32c_bigstring: bigstring -> int -> int -> t -> t
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
  let crc32c_bigstring bigstring off len crc32c =
    adler_crc32c_bigstring crc32c bigstring off len

  let crc32c_string str =
    crc32c_bigstring @@ Cstruct.to_bigarray @@ Cstruct.of_string str

  let%test _ = crc32c_string "" 0 0 @@ (Optint.of_int32 0l) = (Optint.of_int32 0l)
  let%test _ = crc32c_string "\x00" 0 1 @@ (Optint.of_int32 0l) = (Optint.of_int32 0x527d5351l)
  let%test _ = crc32c_string "\x00\x00\x00" 0 3 @@ (Optint.of_int32 0l) = (Optint.of_int32 0x6064a37al)
  let%test _ = crc32c_string "\xff\xff\xff\xff" 0 4 @@ (Optint.of_int32 0l) = (Optint.of_int32 0xffffffffl)
  let%test _ = crc32c_string "123456789" 0 9 @@ (Optint.of_int32 0l) = (Optint.of_int32 0xe3069283l)
  let%test _ = crc32c_string "Thou hast made me, and shall thy work decay?" 0 9 @@ Optint.of_int32 0l = Optint.of_int32 0x866374c0l

end

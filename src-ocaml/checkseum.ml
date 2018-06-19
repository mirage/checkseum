type bigstring = (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

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
  let digest_bytes = Gin_adler32.digest_bytes
  let digest_bigstring = Gin_adler32.digest_bigstring
  let crc32c_bigstring = Checkseum_crc32c.crc32c_bigstring
end

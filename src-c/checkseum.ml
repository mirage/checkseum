module type S = Checkseum_sig.S

open Laolao_native

module Adler32 = struct
  type t = Optint.t

  let equal = Optint.equal
  let pp = Optint.pp
  let default = Optint.one
  let digest_bytes bytes off len adler32 = adler32_bytes adler32 bytes off len
  let digest_bigstring bigstring off len adler32 = adler32_bigstring adler32 bigstring off len
end

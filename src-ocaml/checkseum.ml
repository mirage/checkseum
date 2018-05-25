module type S = Checkseum_sig.S

module Adler32 = struct
  type t = Optint.t

  let equal = Optint.equal
  let pp = Optint.pp
  let default = Optint.one
  let digest_bytes = Gin_adler32.digest_bytes
  let digest_bigstring = Gin_adler32.digest_bigstring
end

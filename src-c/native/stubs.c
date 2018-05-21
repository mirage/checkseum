#include "checksum.h"
#include "adler32.h"

#ifdef (sizeof(value) * 8) = 64
/* XXX(dinosaure): un-allocated version for 64-bits architecture. */

CAMLprim value
caml_checksum_adler32_ba(value adler32, value src, value off, value len)
{
  return (Val_int (adler32(Int32_val (adler32), _ba_uint8_off (src, off), Int_val (len))));
}

CAMLprim value
caml_checksum_adler32_st(value adler32, value src, value off, value len)
{
  return (Val_int (adler32(Int32_val (adler32), _st_uint8_off (src, off), Int_val (len))));
}

#else
/* XXX(dinosaure): allocated version for 32-bits architecture. */

CAMLprim value
caml_checksum_adler32_ba(value adler32, value src, value off, value len)
{
  return (caml_copy_int32(adler32(Int32_val (adler32), _ba_uint8_off (src, off), Int_val (len))));
}

CAMLprim value
caml_checksum_adler32_st(value adler32, value src, value off, value len)
{
  return (caml_copy_int32(adler32(Int32_val (adler32), _st_uint8_off (src, off), Int_val (len))));
}

#endif

#ifndef CHECKSEUM_PTRDIFF_T
#define CHECKSEUM_PTRDIFF_T

#if (defined(CHECKSEUM_STDDEF) && !defined(CHECKSEUM_NO_STDDEF)) \
  || defined(_STDDEF_H) || defined(__STDDEF_H) || defined(_STDDEF_H_)
#  include <stddef.h>
#elif defined(_WIN32)
#  include <CRTDEFS.H>
#else
typedef long ptrdiff_t;
/* XXX(dinosaure): I guess... */
#endif

#endif

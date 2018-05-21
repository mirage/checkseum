#ifndef CHECKSUM_ADLER32_H
#define CHECKSUM_ADLER32_H

#include <stdint.h>

typedef unsigned long uLong;
typedef unsigned int  uInt;
typedef unsigned char Byte;
typedef Byte FAR Bytef;

uLong adler32(uLong adler, const Bytef *buf, uInt len);

#endif

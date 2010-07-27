/* sha1sum.c - print SHA-1 Message-Digest Algorithm 
 * Copyright (C) 1998, 1999, 2000, 2001 Free Software Foundation, Inc.
 * Copyright (C) 2004, 2009 g10 Code GmbH
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 3, or (at your option) any
 * later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

/* 
   To build this tool as md5sum    use -DBUILD_MD5SUM
   To build this tool as sha256sum use -DBUILD_SHA256SUM

   SHA-1 code taken from gnupg 1.3.92. 
   MD-5 and SHA-256 code taken from libgcrypt 1.5.0.
   
   Note that this is a simple tool to be used for MS Windows.
   However, it has been written with portability in mind and thus it
   should work on any C-99 system and also on 32 bit C-89 systems.

   2009-10-21 wk  Added -c option.  Switch to GPL-3.  Escape filenames.
   2009-10-22 wk  Support MD5 and SHA256.
   2010-04-16 wk  Add option -0.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <errno.h>
#ifdef _WIN32
# include <fcntl.h>
#endif

#define VERSION "1.2"
#if defined(BUILD_MD5SUM)
# define PGM "md5sum"
# define DIGEST_LENGTH 16
#elif defined(BUILD_SHA256SUM)
# define PGM "sha256sum"
# define DIGEST_LENGTH 32
#else /* default  */
# define PGM "sha1sum"
# define DIGEST_LENGTH 20
#endif


/* Offset where the name starts in the file.  */
#define NAME_OFFSET (DIGEST_LENGTH*2+2)


/* Figure out a 32 bit unsigned integer type.  */
#if (defined __STDC_VERSION__ && __STDC_VERSION__ >= 199901L)
# include <stdint.h>
typedef uint32_t u32;
#else  /* !ISO C-99 */
typedef unsigned int u32;
#endif /* !ISO C-99 */

/* Set to true if this is a big endian host.  Unfortunately there is
   no portable macro to test for it.  Thus we do a runtime test. */
static int big_endian_host;


/*
 * Rotate a 32 bit integer by n bytes
 */
#if defined(__GNUC__) && defined(__i386__)
static inline u32
rol( u32 x, int n)
{
	__asm__("roll %%cl,%0"
		:"=r" (x)
		:"0" (x),"c" (n));
	return x;
}
#else
#define rol(x,n) ( ((x) << (n)) | ((x) >> (32-(n))) )
#endif

#ifdef BUILD_SHA256SUM
#if defined(__GNUC__) && defined(__i386__)
static inline u32
ror(u32 x, int n)
{
	__asm__("rorl %%cl,%0"
		:"=r" (x)
		:"0" (x),"c" (n));
	return x;
}
#else
#define ror(x,n) ( ((x) >> (n)) | ((x) << (32-(n))) )
#endif
#endif /*BUILD_SHA256SUM*/


typedef struct 
{
#if defined(BUILD_MD5SUM)
  u32 A,B,C,D;
#elif defined(BUILD_SHA256SUM)
  u32  h0,h1,h2,h3,h4,h5,h6,h7;
#else /*BUILD_SHA1SUM*/
  u32  h0,h1,h2,h3,h4;
#endif
  u32  nblocks;
  unsigned char buf[64];
  int  count;
} DIGEST_CONTEXT;



static void
digest_init (DIGEST_CONTEXT *hd)
{
#if defined(BUILD_MD5SUM)
  hd->A = 0x67452301;
  hd->B = 0xefcdab89;
  hd->C = 0x98badcfe;
  hd->D = 0x10325476;
#elif defined(BUILD_SHA256SUM)
  hd->h0 = 0x6a09e667;
  hd->h1 = 0xbb67ae85;
  hd->h2 = 0x3c6ef372;
  hd->h3 = 0xa54ff53a;
  hd->h4 = 0x510e527f;
  hd->h5 = 0x9b05688c;
  hd->h6 = 0x1f83d9ab;
  hd->h7 = 0x5be0cd19;
#else /*BUILD_SHA1SUM*/
  hd->h0 = 0x67452301;
  hd->h1 = 0xefcdab89;
  hd->h2 = 0x98badcfe;
  hd->h3 = 0x10325476;
  hd->h4 = 0xc3d2e1f0;
#endif
  hd->nblocks = 0;
  hd->count = 0;
}


#if defined(BUILD_MD5SUM)
/*
 * MD5 transform the message X which consists of 16 32-bit-words
 */
/* These are the four functions used in the four steps of the MD5
   algorithm and defined in the RFC 1321.  The first function is a
   little bit optimized (as found in Colin Plumbs public domain
   implementation).  */
#define FF(b, c, d) (d ^ (b & (c ^ d)))
#define FG(b, c, d) FF (d, b, c)
#define FH(b, c, d) (b ^ c ^ d)
#define FI(b, c, d) (c ^ (b | ~d))
static void
transform (DIGEST_CONTEXT *hd, unsigned char *data )
{
  u32 correct_words[16];
  u32 A = hd->A;
  u32 B = hd->B;
  u32 C = hd->C;
  u32 D = hd->D;
  u32 *cwp = correct_words;
    
  if (big_endian_host)
    { 
      int i;
      unsigned char *p2, *p1;
      for(i=0, p1=data, p2=(unsigned char*)correct_words;
          i < 16; i++, p2 += 4 )
        {
          p2[3] = *p1++;
          p2[2] = *p1++;
          p2[1] = *p1++;
          p2[0] = *p1++;
        }
    }
  else
    memcpy (correct_words, data, 64);

#define OP(a, b, c, d, s, T) \
  do			         	   \
    {					   \
      a += FF (b, c, d) + (*cwp++) + T;    \
      a = rol(a, s);			   \
      a += b;				   \
    }					   \
  while (0)

  /* Before we start, one word about the strange constants.
     They are defined in RFC 1321 as

     T[i] = (int) (4294967296.0 * fabs (sin (i))), i=1..64
  */

  /* Round 1.  */
  OP (A, B, C, D,  7, 0xd76aa478);
  OP (D, A, B, C, 12, 0xe8c7b756);
  OP (C, D, A, B, 17, 0x242070db);
  OP (B, C, D, A, 22, 0xc1bdceee);
  OP (A, B, C, D,  7, 0xf57c0faf);
  OP (D, A, B, C, 12, 0x4787c62a);
  OP (C, D, A, B, 17, 0xa8304613);
  OP (B, C, D, A, 22, 0xfd469501);
  OP (A, B, C, D,  7, 0x698098d8);
  OP (D, A, B, C, 12, 0x8b44f7af);
  OP (C, D, A, B, 17, 0xffff5bb1);
  OP (B, C, D, A, 22, 0x895cd7be);
  OP (A, B, C, D,  7, 0x6b901122);
  OP (D, A, B, C, 12, 0xfd987193);
  OP (C, D, A, B, 17, 0xa679438e);
  OP (B, C, D, A, 22, 0x49b40821);

#undef OP
#define OP(f, a, b, c, d, k, s, T)  \
    do								      \
      { 							      \
	a += f (b, c, d) + correct_words[k] + T;		      \
	a = rol(a, s);						      \
	a += b; 						      \
      } 							      \
    while (0)

  /* Round 2.  */
  OP (FG, A, B, C, D,  1,  5, 0xf61e2562);
  OP (FG, D, A, B, C,  6,  9, 0xc040b340);
  OP (FG, C, D, A, B, 11, 14, 0x265e5a51);
  OP (FG, B, C, D, A,  0, 20, 0xe9b6c7aa);
  OP (FG, A, B, C, D,  5,  5, 0xd62f105d);
  OP (FG, D, A, B, C, 10,  9, 0x02441453);
  OP (FG, C, D, A, B, 15, 14, 0xd8a1e681);
  OP (FG, B, C, D, A,  4, 20, 0xe7d3fbc8);
  OP (FG, A, B, C, D,  9,  5, 0x21e1cde6);
  OP (FG, D, A, B, C, 14,  9, 0xc33707d6);
  OP (FG, C, D, A, B,  3, 14, 0xf4d50d87);
  OP (FG, B, C, D, A,  8, 20, 0x455a14ed);
  OP (FG, A, B, C, D, 13,  5, 0xa9e3e905);
  OP (FG, D, A, B, C,  2,  9, 0xfcefa3f8);
  OP (FG, C, D, A, B,  7, 14, 0x676f02d9);
  OP (FG, B, C, D, A, 12, 20, 0x8d2a4c8a);

  /* Round 3.  */
  OP (FH, A, B, C, D,  5,  4, 0xfffa3942);
  OP (FH, D, A, B, C,  8, 11, 0x8771f681);
  OP (FH, C, D, A, B, 11, 16, 0x6d9d6122);
  OP (FH, B, C, D, A, 14, 23, 0xfde5380c);
  OP (FH, A, B, C, D,  1,  4, 0xa4beea44);
  OP (FH, D, A, B, C,  4, 11, 0x4bdecfa9);
  OP (FH, C, D, A, B,  7, 16, 0xf6bb4b60);
  OP (FH, B, C, D, A, 10, 23, 0xbebfbc70);
  OP (FH, A, B, C, D, 13,  4, 0x289b7ec6);
  OP (FH, D, A, B, C,  0, 11, 0xeaa127fa);
  OP (FH, C, D, A, B,  3, 16, 0xd4ef3085);
  OP (FH, B, C, D, A,  6, 23, 0x04881d05);
  OP (FH, A, B, C, D,  9,  4, 0xd9d4d039);
  OP (FH, D, A, B, C, 12, 11, 0xe6db99e5);
  OP (FH, C, D, A, B, 15, 16, 0x1fa27cf8);
  OP (FH, B, C, D, A,  2, 23, 0xc4ac5665);

  /* Round 4.  */
  OP (FI, A, B, C, D,  0,  6, 0xf4292244);
  OP (FI, D, A, B, C,  7, 10, 0x432aff97);
  OP (FI, C, D, A, B, 14, 15, 0xab9423a7);
  OP (FI, B, C, D, A,  5, 21, 0xfc93a039);
  OP (FI, A, B, C, D, 12,  6, 0x655b59c3);
  OP (FI, D, A, B, C,  3, 10, 0x8f0ccc92);
  OP (FI, C, D, A, B, 10, 15, 0xffeff47d);
  OP (FI, B, C, D, A,  1, 21, 0x85845dd1);
  OP (FI, A, B, C, D,  8,  6, 0x6fa87e4f);
  OP (FI, D, A, B, C, 15, 10, 0xfe2ce6e0);
  OP (FI, C, D, A, B,  6, 15, 0xa3014314);
  OP (FI, B, C, D, A, 13, 21, 0x4e0811a1);
  OP (FI, A, B, C, D,  4,  6, 0xf7537e82);
  OP (FI, D, A, B, C, 11, 10, 0xbd3af235);
  OP (FI, C, D, A, B,  2, 15, 0x2ad7d2bb);
  OP (FI, B, C, D, A,  9, 21, 0xeb86d391);

  /* Put checksum in context given as argument.  */
  hd->A += A;
  hd->B += B;
  hd->C += C;
  hd->D += D;
}

#elif defined(BUILD_SHA256SUM)
/*
 * SHA-256 transform the message X which consists of 16 32-bit-words.
 * See FIPS-180-2 for details.
 */
# define Cho(x,y,z) (z ^ (x & (y ^ z)))      /* (4.2) same as SHA-1's F1 */
# define Maj(x,y,z) ((x & y) | (z & (x|y)))  /* (4.3) same as SHA-1's F3 */
# define Sum0(x) (ror ((x), 2) ^ ror ((x), 13) ^ ror ((x), 22))  /* (4.4) */
# define Sum1(x) (ror ((x), 6) ^ ror ((x), 11) ^ ror ((x), 25))  /* (4.5) */
# define S0(x) (ror ((x), 7) ^ ror ((x), 18) ^ ((x) >> 3))       /* (4.6) */
# define S1(x) (ror ((x), 17) ^ ror ((x), 19) ^ ((x) >> 10))     /* (4.7) */
# define R(a,b,c,d,e,f,g,h,k,w) do                                \
           {                                                      \
            t1 = (h) + Sum1((e)) + Cho((e),(f),(g)) + (k) + (w);  \
            t2 = Sum0((a)) + Maj((a),(b),(c));                    \
            h = g;                                                \
            g = f;                                                \
            f = e;                                                \
            e = d + t1;                                           \
            d = c;                                                \
            c = b;                                                \
            b = a;                                                \
            a = t1 + t2;                                          \
          } while (0)
static void
transform (DIGEST_CONTEXT *hd, unsigned char *data)
{
  static const u32 K[64] = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
    0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
    0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
    0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
    0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
    0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
  };

  u32 a,b,c,d,e,f,g,h,t1,t2;
  u32 x[16];
  u32 w[64];
  int i;
  
  a = hd->h0;
  b = hd->h1;
  c = hd->h2;
  d = hd->h3;
  e = hd->h4;
  f = hd->h5;
  g = hd->h6;
  h = hd->h7;
  
  if (big_endian_host)
    memcpy (x, data, 64);
  else
    { 
      unsigned char *p2;
      
      for (i=0, p2=(unsigned char*)x; i < 16; i++, p2 += 4 ) 
        {
          p2[3] = *data++;
          p2[2] = *data++;
          p2[1] = *data++;
          p2[0] = *data++;
        }
    }

  for (i=0; i < 16; i++)
    w[i] = x[i];
  for (; i < 64; i++)
    w[i] = S1(w[i-2]) + w[i-7] + S0(w[i-15]) + w[i-16];

  for (i=0; i < 64; i++)
    R(a,b,c,d,e,f,g,h,K[i],w[i]);

  hd->h0 += a;
  hd->h1 += b;
  hd->h2 += c;
  hd->h3 += d;
  hd->h4 += e;
  hd->h5 += f;
  hd->h6 += g;
  hd->h7 += h;
}
# undef Cho
# undef Maj
# undef Sum0
# undef Sum1
# undef S0
# undef S1
# undef R

#else /*BUILD_SHA1SUM*/
/*
 * SHA-1 transform the message X which consists of 16 32-bit-words
 */
static void
transform (DIGEST_CONTEXT *hd, unsigned char *data )
{
  u32 a,b,c,d,e,tm;
  u32 x[16];
  
  /* Get values from the chaining vars. */
  a = hd->h0;
  b = hd->h1;
  c = hd->h2;
  d = hd->h3;
  e = hd->h4;

  if (big_endian_host)
    memcpy (x, data, 64);
  else
    { 
      int i;
      unsigned char *p2;
      
      for (i=0, p2=(unsigned char*)x; i < 16; i++, p2 += 4 )
        {
          p2[3] = *data++;
          p2[2] = *data++;
          p2[1] = *data++;
          p2[0] = *data++;
        }
    }
  
#define K1  0x5A827999L
#define K2  0x6ED9EBA1L
#define K3  0x8F1BBCDCL
#define K4  0xCA62C1D6L
#define F1(x,y,z)   ( z ^ ( x & ( y ^ z ) ) )
#define F2(x,y,z)   ( x ^ y ^ z )
#define F3(x,y,z)   ( ( x & y ) | ( z & ( x | y ) ) )
#define F4(x,y,z)   ( x ^ y ^ z )


#define M(i) ( tm =   x[i&0x0f] ^ x[(i-14)&0x0f] \
		    ^ x[(i-8)&0x0f] ^ x[(i-3)&0x0f] \
	       , (x[i&0x0f] = rol(tm,1)) )

#define R(a,b,c,d,e,f,k,m)  do { e += rol( a, 5 )     \
				      + f( b, c, d )  \
				      + k	      \
				      + m;	      \
				 b = rol( b, 30 );    \
			       } while(0)
  R( a, b, c, d, e, F1, K1, x[ 0] );
  R( e, a, b, c, d, F1, K1, x[ 1] );
  R( d, e, a, b, c, F1, K1, x[ 2] );
  R( c, d, e, a, b, F1, K1, x[ 3] );
  R( b, c, d, e, a, F1, K1, x[ 4] );
  R( a, b, c, d, e, F1, K1, x[ 5] );
  R( e, a, b, c, d, F1, K1, x[ 6] );
  R( d, e, a, b, c, F1, K1, x[ 7] );
  R( c, d, e, a, b, F1, K1, x[ 8] );
  R( b, c, d, e, a, F1, K1, x[ 9] );
  R( a, b, c, d, e, F1, K1, x[10] );
  R( e, a, b, c, d, F1, K1, x[11] );
  R( d, e, a, b, c, F1, K1, x[12] );
  R( c, d, e, a, b, F1, K1, x[13] );
  R( b, c, d, e, a, F1, K1, x[14] );
  R( a, b, c, d, e, F1, K1, x[15] );
  R( e, a, b, c, d, F1, K1, M(16) );
  R( d, e, a, b, c, F1, K1, M(17) );
  R( c, d, e, a, b, F1, K1, M(18) );
  R( b, c, d, e, a, F1, K1, M(19) );
  R( a, b, c, d, e, F2, K2, M(20) );
  R( e, a, b, c, d, F2, K2, M(21) );
  R( d, e, a, b, c, F2, K2, M(22) );
  R( c, d, e, a, b, F2, K2, M(23) );
  R( b, c, d, e, a, F2, K2, M(24) );
  R( a, b, c, d, e, F2, K2, M(25) );
  R( e, a, b, c, d, F2, K2, M(26) );
  R( d, e, a, b, c, F2, K2, M(27) );
  R( c, d, e, a, b, F2, K2, M(28) );
  R( b, c, d, e, a, F2, K2, M(29) );
  R( a, b, c, d, e, F2, K2, M(30) );
  R( e, a, b, c, d, F2, K2, M(31) );
  R( d, e, a, b, c, F2, K2, M(32) );
  R( c, d, e, a, b, F2, K2, M(33) );
  R( b, c, d, e, a, F2, K2, M(34) );
  R( a, b, c, d, e, F2, K2, M(35) );
  R( e, a, b, c, d, F2, K2, M(36) );
  R( d, e, a, b, c, F2, K2, M(37) );
  R( c, d, e, a, b, F2, K2, M(38) );
  R( b, c, d, e, a, F2, K2, M(39) );
  R( a, b, c, d, e, F3, K3, M(40) );
  R( e, a, b, c, d, F3, K3, M(41) );
  R( d, e, a, b, c, F3, K3, M(42) );
  R( c, d, e, a, b, F3, K3, M(43) );
  R( b, c, d, e, a, F3, K3, M(44) );
  R( a, b, c, d, e, F3, K3, M(45) );
  R( e, a, b, c, d, F3, K3, M(46) );
  R( d, e, a, b, c, F3, K3, M(47) );
  R( c, d, e, a, b, F3, K3, M(48) );
  R( b, c, d, e, a, F3, K3, M(49) );
  R( a, b, c, d, e, F3, K3, M(50) );
  R( e, a, b, c, d, F3, K3, M(51) );
  R( d, e, a, b, c, F3, K3, M(52) );
  R( c, d, e, a, b, F3, K3, M(53) );
  R( b, c, d, e, a, F3, K3, M(54) );
  R( a, b, c, d, e, F3, K3, M(55) );
  R( e, a, b, c, d, F3, K3, M(56) );
  R( d, e, a, b, c, F3, K3, M(57) );
  R( c, d, e, a, b, F3, K3, M(58) );
  R( b, c, d, e, a, F3, K3, M(59) );
  R( a, b, c, d, e, F4, K4, M(60) );
  R( e, a, b, c, d, F4, K4, M(61) );
  R( d, e, a, b, c, F4, K4, M(62) );
  R( c, d, e, a, b, F4, K4, M(63) );
  R( b, c, d, e, a, F4, K4, M(64) );
  R( a, b, c, d, e, F4, K4, M(65) );
  R( e, a, b, c, d, F4, K4, M(66) );
  R( d, e, a, b, c, F4, K4, M(67) );
  R( c, d, e, a, b, F4, K4, M(68) );
  R( b, c, d, e, a, F4, K4, M(69) );
  R( a, b, c, d, e, F4, K4, M(70) );
  R( e, a, b, c, d, F4, K4, M(71) );
  R( d, e, a, b, c, F4, K4, M(72) );
  R( c, d, e, a, b, F4, K4, M(73) );
  R( b, c, d, e, a, F4, K4, M(74) );
  R( a, b, c, d, e, F4, K4, M(75) );
  R( e, a, b, c, d, F4, K4, M(76) );
  R( d, e, a, b, c, F4, K4, M(77) );
  R( c, d, e, a, b, F4, K4, M(78) );
  R( b, c, d, e, a, F4, K4, M(79) );

  /* Update chaining vars.  */
  hd->h0 += a;
  hd->h1 += b;
  hd->h2 += c;
  hd->h3 += d;
  hd->h4 += e;
}

#endif /*BUILD_SHA1SUM*/


/* Update the message digest with the contents of (DATA,DATALEN).  */
static void
digest_write (DIGEST_CONTEXT *hd, void *data, size_t datalen)
{
  unsigned char *inbuf = data;

  if (hd->count == 64) /* Flush the buffer.  */
    {
      transform ( hd, hd->buf );
      hd->count = 0;
      hd->nblocks++;
    }
  if ( !inbuf )
    return;
  if ( hd->count ) 
    {
      for ( ; datalen && hd->count < 64; datalen-- )
        hd->buf[hd->count++] = *inbuf++;
      digest_write( hd, NULL, 0 );
      if ( !datalen )
        return;
    }
  
  while( datalen >= 64 ) 
    {
      transform( hd, inbuf );
      hd->count = 0;
      hd->nblocks++;
      datalen -= 64;
      inbuf += 64;
    }
  for( ; datalen && hd->count < 64; datalen-- )
    hd->buf[hd->count++] = *inbuf++;
}


/* The routine final terminates the computation and
 * returns the digest.
 * The handle is prepared for a new cycle, but adding bytes to the
 * handle will the destroy the returned buffer.
 * Returns: DIGEST_LENGTH bytes representing the digest.
 */

static void
digest_final(DIGEST_CONTEXT *hd)
{
  u32 t, msb, lsb;
  unsigned char *p;
  
  digest_write(hd, NULL, 0); /* Flush */;
  
  t = hd->nblocks;
  /* Multiply by 64 to make a byte count.  */
  lsb = t << 6;
  msb = t >> 26;
  /* Add the count.  */
  t = lsb;
  if ( (lsb += hd->count) < t )
    msb++;
  /* Multiply by 8 to make a bit count. */
  t = lsb;
  lsb <<= 3;
  msb <<= 3;
  msb |= t >> 29;

  if ( hd->count < 56 ) /* Enough room is available. */
    {
      hd->buf[hd->count++] = 0x80; /* pad */
      while( hd->count < 56 )
        hd->buf[hd->count++] = 0;  /* pad */
    }
  else /* Need one extra block.  */
    {
      hd->buf[hd->count++] = 0x80; /* pad character */
      while ( hd->count < 64 )
        hd->buf[hd->count++] = 0;
      digest_write (hd, NULL, 0);  /* Flush */;
      memset(hd->buf, 0, 56 );     /* Fill next block with zeroes.  */
    }
  /* Append the 64 bit count. */
#if defined(BUILD_MD5SUM)
  hd->buf[56] = lsb;
  hd->buf[57] = lsb >>  8;
  hd->buf[58] = lsb >> 16;
  hd->buf[59] = lsb >> 24;
  hd->buf[60] = msb;
  hd->buf[61] = msb >>  8;
  hd->buf[62] = msb >> 16;
  hd->buf[63] = msb >> 24;
#else
  hd->buf[56] = msb >> 24;
  hd->buf[57] = msb >> 16;
  hd->buf[58] = msb >>  8;
  hd->buf[59] = msb;
  hd->buf[60] = lsb >> 24;
  hd->buf[61] = lsb >> 16;
  hd->buf[62] = lsb >>  8;
  hd->buf[63] = lsb;
#endif

  transform( hd, hd->buf );
  p = hd->buf;
#if defined(BUILD_MD5SUM)
#define X(a) do { *p++ = hd->a      ; *p++ = hd->a >> 8;      \
	          *p++ = hd->a >> 16; *p++ = hd->a >> 24; } while(0)
  X(A);
  X(B);
  X(C);
  X(D);
#else /* Not MD5 */
# define X(a) do { *p++ = hd->h##a >> 24; *p++ = hd->h##a >> 16;         \
		   *p++ = hd->h##a >> 8;  *p++ = hd->h##a; } while(0)
  X(0);
  X(1);
  X(2);
  X(3);
  X(4);
# if defined(BUILD_SHA256SUM) 
  X(5);
  X(6);
  X(7);
# endif /*BUILD_SHA256SUM*/
#endif /*BUILD_SHA1SUM*/
#undef X
}


/* Stats for the check fucntion.  */
static unsigned int filecount;
static unsigned int readerrors;
static unsigned int checkcount;
static unsigned int matcherrors;

/* We need to escape the fname so that included linefeeds etc don't
   mess up the the output file.  On windows we also turn backslashes
   into slashes so that we don't get into conflicts with the escape
   character.  Note that the GNU version escapes the backslash and the
   LF but we also escape the CR.  */
static char *
escapefname (const char *fname, int *escaped)
{
  const char *s;
  char *buffer;
  char *d;
  size_t n;

  *escaped = 0;
  for (n = 0, s = fname; *s; s++)
    {
      if (*s == '\n' || *s == '\r')
        n += 2;
      else if (*s == '\\')
        {
#ifdef _WIN32
          n++;
#else
          n += 2;
#endif
        }
      else
        n++;
    }
  n++;
  buffer = malloc (n);
  if (!buffer)
    {
      fprintf (stderr, PGM": can't allocate buffer: %s\n", strerror (errno));
      exit (2);
    }

  d = buffer;
  for (s = fname; *s; s++)
    {
      if (*s == '\n')
        { 
          *d++ = '\\';
          *d++ = 'n' ;
          *escaped = 1;
        }
      else if (*s == '\r')
        {
          *d++ = '\\';
          *d++ = 'r' ;
          *escaped = 1;
        }
      else if (*s == '\\')
        {
#ifdef _WIN32
          *d++ = '/';
#else
          *d++ = '\\';
          *d++ = '\\' ;
          *escaped = 1;
#endif
        }
      else
        *d++ = *s;
    }
  *d = 0;
  return buffer;
}


/* Revert the escaping in-place.  We handle some more of the standard
   escaping characters but not all. */
static void
unescapefname (char *fname)
{
  char *s, *d;

  for (s=d=fname; *s; s++)
    {
      if (*s == '\\' && s[1])
        {
          s++;
          switch (*s)
            {
            case '\\': *d++ = '\\'; break;
            case 'n': *d++ = '\n'; break;
            case 'r': *d++ = '\r'; break;
            case 'f': *d++ = '\f'; break;
            case 'v': *d++ = '\v'; break;
            case 'b': *d++ = '\b'; break;
            default: *d++ = '\\'; *d++ = *s; break;
            }
        }
      else
        *d++ = *s;
    }
  *d = 0;
}



static int
hash_file (const char *fname, const char *expected)
{
  FILE *fp;
  char buffer[4096];
  size_t n;
  DIGEST_CONTEXT ctx;
  int i;
  char *fnamebuf;
  int escaped;

  filecount++;
  if (!expected && *fname == '-' && !fname[1])
    {
      /* Not in check mode and asked to read from stdin.  */
      fp = stdin;
#ifdef _WIN32
      setmode (fileno (fp), O_BINARY);
#endif
    }
  else
    fp = fopen (fname, "rb");
  if (!fp)
    {
      fprintf (stderr, PGM": can't open `%s': %s\n",
               fname, strerror (errno));
      if (expected)
        printf ("%s: FAILED open\n", fname);
      readerrors++;
      return -1;
    }
  digest_init (&ctx);
  while ( (n = fread (buffer, 1, sizeof buffer, fp)))
    digest_write (&ctx, buffer, n);
  if (ferror (fp))
    {
      fprintf (stderr, PGM": error reading `%s': %s\n",
               fname, strerror (errno));
      if (fp != stdin)
        fclose (fp);
      if (expected)
        printf ("%s: FAILED read\n", fname);
      readerrors++;
      return -1;
    }
  digest_final (&ctx);
  if (fp != stdin)
    fclose (fp);
  
  fnamebuf = escapefname (fname, &escaped);
  fname = fnamebuf;

  checkcount++;
  for (i=0; i < DIGEST_LENGTH; i++)
    snprintf (buffer+2*i, 10, "%02x", ctx.buf[i]);
  if (expected)
    {
      if (strcmp (buffer, expected))
        {
          printf ("%s: FAILED\n", fname);
          matcherrors++;
          return -1;
        }
      printf ("%s: OK\n", fname);
    }
  else
    printf ("%s%s  %s\n", escaped? "\\":"", buffer, fname);
  free (fnamebuf);
  return 0;
}


static int
check_file (const char *fname)
{
  FILE *fp;
  char linebuf[4096];
  char *line;
  char *p;
  size_t n;
  int rc = 0;
  int escaped;
      
  if (*fname == '-' && !fname[1])
    fp = stdin;
  else
    fp = fopen (fname, "r");
  if (!fp)
    {
      fprintf (stderr, PGM": can't open `%s': %s\n",
               fname, strerror (errno));
      return -1;
    }

  while ( fgets (linebuf, sizeof (linebuf)-1, fp) )
    {
      escaped = (*linebuf == '\\'); 
      line = linebuf + escaped;
      n = strlen(line);
      if (!n || line[n-1] != '\n')
        {
          fprintf (stderr, PGM": error reading `%s': %s\n", fname,
                   feof (fp)? "last linefeed missing":"line too long");
          rc = -1;
          break;
        }
      line[--n] = 0;
      if (n && line[n-1] == '\r')
        line[--n] = 0;
      if (!*line)
        continue;  /* Ignore empty lines.  */
      if (n < NAME_OFFSET || line[NAME_OFFSET-2] != ' ')
        {
          fprintf (stderr, PGM": error parsing `%s': %s\n", fname,
                   "invalid line");
          rc = -1;
          continue;
        }
      
      /* Note that we ignore the binary flag ('*') used by GNU
         versions of this tool: It does not make sense to compute a
         digest over some transformation of a file - we always want a
         reliable checksum.  The flag does not work: On Unix a
         checksum file is created without the flag because it is the
         default there.  When checking it on Windows the missing flag
         would indicate that it has been created in text mode and thus
         the checksums will differ.  */

      /* Lowercase the checksum.  */
      line[NAME_OFFSET-2] = 0;
      for (p=line; *p; p++)
        if (*p >= 'A' && *p <= 'Z')
          *p |= 0x20;
      /* Unescape the fname.  */
      if (escaped)
        unescapefname (line+NAME_OFFSET);
      /* Hash the file.  */
      if (hash_file (line+NAME_OFFSET, line))
        rc = -1;
    }

  if (ferror (fp))
    {
      fprintf (stderr, PGM":error reading `%s': %s\n",
               fname, strerror (errno));
      rc = -1;
    }
  if (fp != stdin)
    fclose (fp);
  
  return rc;
}


static int
hash_list (void)
{
  int rc = 0;
  int ready = 0;
  int c;
  char namebuf[4096];
  size_t n = 0;
  unsigned long lastoff = 0;
  unsigned long off = 0;

#ifdef _WIN32
  setmode (fileno (stdin), O_BINARY);
#endif
  do
    {
      if ((c = getc (stdin)) == EOF)
        {
          if (ferror (stdin))
            {
              fprintf (stderr, PGM":error reading `%s' at offset %lu: %s\n",
                       "[stdin]", off, strerror (errno));
              rc = -1;
              break;
            }
          /* Note: The Nul is a delimter and not a terminator.  */
          c = 0;
          ready = 1;
        }
      if (n >= sizeof namebuf)
        {
          fprintf (stderr, PGM": error reading `%s': "
                   "filename at offset %lu too long\n",
                   "[stdin]", lastoff);
          rc = -1;
          break;
        }
      namebuf[n++] = c;
      off++;
      if (!c)
        {
          if (*namebuf && hash_file (namebuf, NULL))
            rc = -1;
          n = 0;
          lastoff = off;
        }
    }
  while (!ready);
  
  return rc;
}


static void
usage (void)
{
  fprintf (stderr, "usage: sha1sum [-c|-0] [--] FILENAMES|-\n");
  exit (1);
}

int 
main (int argc, char **argv)
{
  int check = 0;
  int filelist = 0;
  int rc = 0;

  assert (sizeof (u32) == 4);
  {
    union { u32 u; char b[4]; } foo;
    foo.u = 32;
    big_endian_host = !foo.b[0];
  }

  if (argc)
    {
      argc--; argv++; 
    }

  if (argc && !strcmp (*argv, "--version"))
    {
      fputs (PGM " "VERSION"\n"
             "Copyright (C) 2009 g10 Code GmbH\n"
             "License GPLv3+: GNU GPL version 3 or later "
             "<http://gnu.org/licenses/gpl.html>.\n"
             "This is free software: you are free to change "
             "and redistribute it.\n"
             "There is NO WARRANTY, to the extent permitted by law.\n\n",
             stdout);
      exit (0);
    }
  while (argc && argv[0][0] == '-' && argv[0][1])
    {
      if (!strcmp (*argv, "-c"))
        check = 1;
      else if (argc && !strcmp (*argv, "-0"))
        filelist = 1;
      else if (!strcmp (*argv, "--"))
        {
          argc--; argv++;
          break;
        }
      else
        usage ();
      argc--; argv++;
    }

  if (filelist && check)
    usage ();
  if (!argc)
    usage ();

  if (filelist)
    {
      /* With option -0 a dash must be given as filename.  */
      if (argc != 1 || strcmp (argv[0], "-"))
        usage ();
      if (hash_list ())
        rc = 1;
    }
  else
    {
      for (; argc; argv++, argc--)
        {
          if (check)
            {
              if (check_file (*argv))
                rc = 1;
            }
          else
            {
              if (hash_file (*argv, NULL))
                rc = 1;
            }
        }
    }

  if (check && readerrors)
    fprintf (stderr, PGM": WARNING: %u of %u listed files "
             "could not be read\n", readerrors, filecount);
  if (check && matcherrors)
    fprintf (stderr, PGM": WARNING: %u of %u computed checksums "
             "did NOT match\n", matcherrors, checkcount);

  return rc;
}

/*
Local Variables:
compile-command: "cc -Wall -g -o sha1sum sha1sum.c"
End:
*/

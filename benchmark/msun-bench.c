// modified from https://github.com/JuliaLang/openlibm/blob/master/test/libm-bench.cpp
// Copyright (C) Dahua Lin, 2014. Provided under the MIT license.

// Benchmark on libm functions

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

const long ARR_LEN = 1024;

double a[ARR_LEN];
double b[ARR_LEN];
double r[ARR_LEN];

#define TFUN1(FNAME) \
    void test_##FNAME(long n) { \
        for (int j = 0; j < ARR_LEN; ++j) r[j] = FNAME(a[j]); \
        for(int i = 0; i < n; ++i) { \
            for (int j = 0; j < ARR_LEN; ++j) r[j] = FNAME(a[j]); \
        } \
    }

#define TFUN2(FNAME) \
    void test_##FNAME(long n) { \
        for (int j = 0; j < ARR_LEN; ++j) r[j] = FNAME(a[j], b[j]); \
        for(int i = 0; i < n; ++i) { \
            for (int j = 0; j < ARR_LEN; ++j) r[j] = FNAME(a[j], b[j]); \
        } \
    }


#define TCALL(FNAME) printf("testing %s\n", #FNAME); test_##FNAME(20000)

// define benchmark functions

TFUN2(pow)
TFUN2(hypot)

TFUN1(exp)
TFUN1(log)
TFUN1(log10)
TFUN1(sin)
TFUN1(cos)
TFUN1(tan)
TFUN1(asin)
TFUN1(acos)
TFUN1(atan)
TFUN2(atan2)

int main(int argc, char *argv[])
{
    // initialize array contents
    for (int i = 0; i < ARR_LEN; ++i)
    {
      a[i] = rand() / (double) RAND_MAX;
      b[i] = rand() / (double) RAND_MAX;
    }

    TCALL(pow);
    TCALL(hypot);
    TCALL(exp);
    TCALL(log);
    TCALL(log10);
    TCALL(sin);
    TCALL(cos);
    TCALL(tan);
    TCALL(asin);
    TCALL(acos);
    TCALL(atan);
    TCALL(atan2);

    return 0;
}

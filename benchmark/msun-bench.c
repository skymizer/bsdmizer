// modified from https://github.com/JuliaLang/openlibm/blob/master/test/libm-bench.cpp
// Copyright (C) Dahua Lin, 2014. Provided under the MIT license.

// Benchmark on libm functions

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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


#define TCALL(FNAME) test_##FNAME(20000)

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
    FILE * f;
    f = fopen("data","r");
    if (NULL == f) {
	    printf("file \"data\" not found\n");
	    return 1;
    }
    // initialize array contents
    for (int i = 0; i < ARR_LEN; ++i)
    {
/*
      a[i] = rand() / (double) RAND_MAX;
      b[i] = rand() / (double) RAND_MAX;
*/
        fscanf(f, "%lf %lf", &(a[i]), &(b[i]));
//      printf("%lf %lf\n", a[i], b[i]);
    }
    fclose(f);
    // don't care return :)

    if (argc < 2)
	    printf("Usage: %s <function name>\n", argv[0]);
    else if (strcmp(argv[1], "pow") == 0)
	    TCALL(pow);
    else if (strcmp(argv[1], "hypot") == 0)
	    TCALL(hypot);
    else if (strcmp(argv[1], "exp") == 0)
	    TCALL(exp);
    else if (strcmp(argv[1], "log") == 0)
	    TCALL(log);
    else if (strcmp(argv[1], "log10") == 0)
	    TCALL(log10);
    else if (strcmp(argv[1], "sin") == 0)
	    TCALL(sin);
    else if (strcmp(argv[1], "cos") == 0)
	    TCALL(cos);
    else if (strcmp(argv[1], "tan") == 0)
	    TCALL(tan);
    else if (strcmp(argv[1], "asin") == 0)
	    TCALL(asin);
    else if (strcmp(argv[1], "acos") == 0)
	    TCALL(acos);
    else if (strcmp(argv[1], "atan") == 0)
	    TCALL(atan);
    else if (strcmp(argv[1], "atan2") == 0)
	    TCALL(atan2);
    else
	    printf("Unknown function: %s\n", argv[1]);

    return 0;
}

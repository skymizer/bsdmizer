#!/bin/sh

SRCDIR=`realpath ../../../freebsd`

OBJDIR="`pwd`/obj"
export MAKEOBJDIRPREFIX=${OBJDIR}

#cd ${SRCDIR}/lib/msun
#OBJDIR=`make -V .OBJDIR`
#cd ${SRCDIR}/lib/msun/tests
#env LD_PRELOAD=${OBJDIR}/libm.so.5 kyua test

../../../benchmark/msun-bench.sh sin

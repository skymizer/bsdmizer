#!/bin/sh

SRCDIR=`realpath ../../../freebsd`

OBJDIR="`pwd`/obj"
export MAKEOBJDIRPREFIX=${OBJDIR}
cd ${SRCDIR}/lib/msun
LIBPATH=`make -V .OBJDIR`
cd -

#cd ${SRCDIR}/lib/msun/tests
#env LD_PRELOAD=${OBJDIR}/libm.so.5 kyua test

../../../benchmark/msun-bench.sh exp ${LIBPATH}/libm.so.5

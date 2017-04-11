#!/bin/sh

_BINPATH=`realpath $0`
_DIRNAME=`dirname ${_BINPATH}`
BASEDIR=`realpath ${_DIRNAME}/..`

SRCDIR=${BASEDIR}/freebsd

cd ${SRCDIR}/lib/msun/tests
env LD_PRELOAD=${SRCDIR}/lib/msun/libm.so.5 kyua test

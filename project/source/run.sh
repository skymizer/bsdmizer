#!/bin/sh

_BINPATH=`realpath $0`
_DIRNAME=`dirname ${_BINPATH}`
BASEDIR=`realpath ${_DIRNAME}/..`

SRCDIR=`realpath ../../../freebsd`
export MAKEOBJDIRPREFIX=./obj

cd ${SRCDIR}/lib/msun/tests
env LD_PRELOAD=${SRCDIR}/lib/msun/libm.so.5 kyua test

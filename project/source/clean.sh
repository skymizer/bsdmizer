#!/bin/sh

_BINPATH=`realpath $0`
_DIRNAME=`dirname ${_BINPATH}`
BASEDIR=`realpath ${_DIRNAME}/..`

SRCDIR=`realpath ../../../freebsd`

JFLAG=$(sysctl -n kern.smp.cpus)

export MAKEOBJDIRPREFIX=`realpath ./obj`
cd ${SRCDIR}/lib/msun
make cleandir

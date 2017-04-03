#!/bin/sh

_BINPATH=`realpath $0`
_DIRNAME=`dirname ${_BINPATH}`
BASEDIR=`realpath ${_DIRNAME}/..`

SRCDIR=${BASEDIR}/freebsd

export MAKEOBJDIRPREFIX=${BASEDIR}/obj
MAKECONF=/dev/null
SRCCONF=/dev/null

JFLAG=$(sysctl -n kern.smp.cpus)

TARGET=amd64
TARGET_ARCH=amd64
KERNCONF=GENERIC

cd ${SRCDIR}

make -j ${JFLAG} -DNO_CLEAN buildworld \
        TARGET=${TARGET} \
        TARGET_ARCH=${TARGET_ARCH} \
        __MAKE_CONF=${MAKECONF} \
        SRCCONF=${SRCCONF}
make -j ${JFLAG} -DNO_CLEAN buildkernel \
        TARGET=${TARGET} \
        TARGET_ARCH=${TARGET_ARCH} \
        KERNCONF=${KERNCONF} \
        __MAKE_CONF=${MAKECONF} \
        SRCCONF=${SRCCONF}

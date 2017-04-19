#!/bin/sh

_BINPATH=`realpath $0`
_DIRNAME=`dirname ${_BINPATH}`
BASEDIR=`realpath ${_DIRNAME}/..`

SRCDIR=${BASEDIR}/freebsd

export MAKEOBJDIRPREFIX=${BASEDIR}/obj
MAKECONF=/dev/null
SRCCONF=/dev/null

JFACTOR=1
JFLAG=$(($(sysctl -n kern.smp.cpus) * ${JFACTOR}))

TARGET=amd64
TARGET_ARCH=amd64
KERNCONF=GENERIC

cd ${SRCDIR}

echo -n ">>> $0 starts at: "
date

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
echo -n ">>> $0 ends at: "
date

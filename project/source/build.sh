#!/bin/sh

OPTIONS=$@
SRCDIR=`realpath ../../../freebsd`

JFLAG=$(sysctl -n kern.smp.cpus)
mkdir obj
export MAKEOBJDIRPREFIX=`realpath ./obj`
echo "MAKEOBJDIRPREFIX: ${MAKEOBJDIRPREFIX}"

CROSS_BINUTILS_PREFIX=/usr/local/x86_64-freebsd/bin/

cd ${SRCDIR}/lib/libnetbsd
make -j ${JFLAG} \
	CC=/usr/local/bin/x86_64-unknown-freebsd11.0-gcc \
	CXX=/usr/local/bin/x86_64-unknown-freebsd11.0-g++ \
	CPP=/usr/local/bin/x86_64-unknown-freebsd11.0-cpp \
	AS=${CROSS_BINUTILS_PREFIX}as \
	AR=${CROSS_BINUTILS_PREFIX}ar \
	LD=${CROSS_BINUTILS_PREFIX}ld \
	NM=${CROSS_BINUTILS_PREFIX}nm \
	OBJCOPY=${CROSS_BINUTILS_PREFIX}objcopy \
	RANLIB=${CROSS_BINUTILS_PREFIX}ranlib \
	SIZE=${CROSS_BINUTILS_PREFIX}size \
	COMPILER_TYPE=gcc \
	all

cd ${SRCDIR}/lib/msun
make -j ${JFLAG} \
	CC=/usr/local/bin/x86_64-unknown-freebsd11.0-gcc \
	CXX=/usr/local/bin/x86_64-unknown-freebsd11.0-g++ \
	CPP=/usr/local/bin/x86_64-unknown-freebsd11.0-cpp \
	AS=${CROSS_BINUTILS_PREFIX}as \
	AR=${CROSS_BINUTILS_PREFIX}ar \
	LD=${CROSS_BINUTILS_PREFIX}ld \
	NM=${CROSS_BINUTILS_PREFIX}nm \
	OBJCOPY=${CROSS_BINUTILS_PREFIX}objcopy \
	RANLIB=${CROSS_BINUTILS_PREFIX}ranlib \
	SIZE=${CROSS_BINUTILS_PREFIX}size \
	COMPILER_TYPE=gcc \
	all

if [ $? -eq 0 ]; then
  exit 0;
else
  echo "build failed!!!!";
  exit 1;
fi

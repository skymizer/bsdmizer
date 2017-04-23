#!/bin/sh

OPTIONS=$@
echo "CFLAGS=${OPTIONS}" > make.conf
MAKECONF=`realpath make.conf`

SRCDIR=`realpath ../../../freebsd`

#JFLAG=$(sysctl -n kern.smp.cpus)

CROSS_BINUTILS_PREFIX=/usr/local/x86_64-freebsd/bin/
MAKE="make \
	-D WITHOUT_MAN \
	__MAKE_CONF=${MAKECONF} \
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
	COMPILER_TYPE=gcc"

OBJDIR="`pwd`/obj"
export MAKEOBJDIRPREFIX=${OBJDIR}

#cd ${SRCDIR}/lib/libnetbsd
#${MAKE} obj
#${MAKE} all

cd ${SRCDIR}/lib/msun
${MAKE} obj
${MAKE} all

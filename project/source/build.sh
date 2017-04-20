#!/bin/sh

OPTIONS=$@
SRCDIR=`realpath ../../../freebsd`

JFLAG=$(sysctl -n kern.smp.cpus)
export MAKEOBJDIRPREFIX=./obj

cd ${SRCDIR}/lib/msun
make -j ${JFLAG} \
	CC=/usr/local/bin/x86_64-unknown-freebsd11.0-gcc \
	CXX=/usr/local/bin/x86_64-unknown-freebsd11.0-g++ \
	CPP=/usr/local/bin/x86_64-unknown-freebsd11.0-cpp \
	CROSS_BINUTILS_PREFIX=/usr/local/x86_64-freebsd/bin/ \
	COMPILER_TYPE=gcc \
	all

if [ $? -eq 0 ]; then
  exit 0;
else
  echo "build failed!!!!";
  exit 1;
fi

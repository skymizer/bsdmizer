#!/bin/sh

ITERATION=3
MEDIAN=$(((${ITERATION}+1)/2))

SRCDIR=`realpath ../../../freebsd`

OBJDIR="`pwd`/obj"
export MAKEOBJDIRPREFIX=${OBJDIR}

cd ${SRCDIR}/usr.bin/bzip2
BZIP2_BINDIR=`make -V CANONICALOBJDIR`
cd -

cd ${SRCDIR}/lib/libbz2
BZIP2_LIBDIR=`make -V CANONICALOBJDIR`
cd -

R=""
for i in `jot ${ITERATION}`; do
	T=`sudo LD_PRELOAD=${BZIP2_LIBDIR}/libbz2.so.4 dtrace -s bzip2-bench.d -c "${BZIP2_BINDIR}/bzip2 -k -9 data"`
	#T=`sudo dtrace -s bzip2-bench.d -c "${BZIP2_BINDIR}/bzip2 -k -9 data"`
	diff data.bz2.orig data.bz2
	if [ $? -ne 0 ]; then
		exit 1
	fi
	rm -f data.bz2
	R="${R}${T}\n"
done

printf "${R}" | sort -n | head -n ${MEDIAN} | tail -n 1

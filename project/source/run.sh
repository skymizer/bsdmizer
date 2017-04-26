#!/bin/sh

TARGET=$1

SRCDIR=`realpath ../../../freebsd`

OBJDIR="`pwd`/obj"
export MAKEOBJDIRPREFIX=${OBJDIR}

cd ${SRCDIR}/usr.bin/bzip2
BZIP2_BINDIR=`make -V CANONICALOBJDIR`
cd -

cd ${SRCDIR}/lib/libbz2
BZIP2_LIBDIR=`make -V CANONICALOBJDIR`
cd -

for i in "${BZIP2_LIBDIR}/libbz2.so.4 ${BZIP2_BINDIR}/bzip2 test.sh bzip2-bench.d"
do
	scp $i bsdmizer-2:~/workspace-bzip2
done

ssh bsdmizer-2 "cd ~/workspace-bzip2; ./test.sh"

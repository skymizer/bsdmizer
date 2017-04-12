#!/bin/sh

SVN_REVISION=316730
SRCDIR=freebsd

JFLAG=$(sysctl -n kern.smp.cpus)

svn co svn://svn.freebsd.org/base/head@${SVN_REVISION} freebsd

cd ${SRCDIR}/lib/libnetbsd
make -j ${JFLAG} all

#!/bin/sh

if [ $# -lt 2 ]; then
	echo "Usage: $0 <function name> <path to libm>"
	exit 1
fi

_BINPATH=`realpath $0`
BINDIR=`dirname ${_BINPATH}`

ITERATION=3
MEDIAN=$(((${ITERATION}+1)/2))

R=""
for i in `jot ${ITERATION}`; do
	T=`sudo LD_PRELOAD=$2 dtrace -s ${BINDIR}/msun-bench.d -c "${BINDIR}/msun-bench $1 ${BINDIR}/data" $1`
	R="${R}${T}\n"
done

printf "${R}" | sort -n | head -n ${MEDIAN} | tail -n 1

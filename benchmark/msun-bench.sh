#!/bin/sh

if [ $# -lt 1 ]; then
	echo "Usage: $0 <function name>"
	exit 1
fi

ITERATION=5
MEDIAN=$(((${ITERATION}+1)/2))

R=""
for i in `jot ${ITERATION}`; do
	T=`sudo dtrace -s msun-bench.d -c "./msun-bench $1" $1`
	R="${R}${T}\n"
done

printf "${R}" | sort -n | head -n ${MEDIAN} | tail -n 1

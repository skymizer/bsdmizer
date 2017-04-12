#!/bin/sh

ITERATION=5
MEDIAN=$(((${ITERATION}+1)/2))

R=""
for i in `jot 5`; do
	T=`sudo dtrace -s msun-bench.d -c "./msun-bench $1" $1`
	R="${R}${T}\n"
done

printf "${R}" | sort -n | head -n ${MEDIAN} | tail -n 1

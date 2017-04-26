#!/bin/sh

cd ~/workspace-bzip2

WORKDIR=`realpath .`

ITERATION=3
MEDIAN=$(((${ITERATION}+1)/2))

R=""
for i in `jot ${ITERATION}`; do
	T=`sudo LD_PRELOAD=${WORKDIR}/libbz2.so.4 dtrace -s bzip2-bench.d -c "./bzip2 -k -9 ./data"`
	diff data.bz2.orig data.bz2
	if [ $? -ne 0 ]; then
		exit 1
	fi
	rm -f data.bz2
	R="${R}${T}\n"
done

printf "${R}" | sort -n | head -n ${MEDIAN} | tail -n 1

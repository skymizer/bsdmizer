#!/bin/sh

sudo dtrace -s msun-bench.d -c "./msun-bench $1" $1

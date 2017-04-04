all:
	clang -o msun-bench -lm msun-bench.c

bench:
	sudo dtrace -s msun-bench.d -c ./msun-bench

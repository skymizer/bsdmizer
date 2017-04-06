all:
	clang -o msun-bench -lm msun-bench.c

bench:
	@sudo dtrace -s msun-bench.d -c ./msun-bench

bench100:
	@for i in `jot 100`; do \
		sudo dtrace -s msun-bench.d -c ./msun-bench; \
	done

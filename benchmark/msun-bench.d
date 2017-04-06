#!/usr/sbin/dtrace -s

#pragma D option quiet

pid$target:msun-bench:test_pow:entry
{
	self->vts = vtimestamp;
}

pid$target:msun-bench:test_pow:return /self->vts/
{
	printf("%lu", vtimestamp - self->vts);
	self->vts = 0;
}

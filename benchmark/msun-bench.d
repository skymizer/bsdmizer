#!/usr/sbin/dtrace -s

#pragma D option quiet

pid$target:msun-bench:test_$$1:entry
{
	self->vts = vtimestamp;
}

pid$target:msun-bench:test_$$1:return /self->vts/
{
	printf("%lu", vtimestamp - self->vts);
	self->vts = 0;
}

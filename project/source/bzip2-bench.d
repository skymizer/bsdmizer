#!/usr/sbin/dtrace -s

#pragma D option quiet

pid$target:bzip2:main:entry
{
	self->vts = vtimestamp;
}

pid$target:bzip2:main:return /self->vts/
{
	printf("%lu", vtimestamp - self->vts);
	self->vts = 0;
}

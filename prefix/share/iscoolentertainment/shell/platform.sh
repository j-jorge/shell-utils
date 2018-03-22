#!/bin/sh

[ -z "$ISCOOL_PLATFORM_INCLUDED" ] || return 0
ISCOOL_PLATFORM_INCLUDED=1

is_osx()
{
    uname -s | grep -q Darwin
}

cpu_count()
{
    ( is_osx && echo $(( $(sysctl -n hw.ncpu) - 1 )) )\
        || nproc
}

host_architecture()
{
    ( is_osx && (sysctl hw.machine | cut -d " " -f 2) ) \
          || (uname -p | sed 's/^i[3-6]/x/')
}

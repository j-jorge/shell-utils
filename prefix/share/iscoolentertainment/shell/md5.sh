#!/bin/bash

[ -z "$ISCOOL_MD5_INCLUDED" ] || return 0
ISCOOL_MD5_INCLUDED=1

. "$(dirname "${BASH_SOURCE[0]}")/platform.sh"

if is_osx
then
    md5_sum()
    {
        md5 "$@" | awk '{ print $NF }'
    }
else
    md5_sum()
    {
        md5sum "$@" | awk '{ print $1 }'
    }
fi

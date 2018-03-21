#!/bin/bash

[ -z "$ISCOOL_TEMPORARIES_INCLUDED" ] || return 0
ISCOOL_TEMPORARIES_INCLUDED=1

export IC_TEMP_FILES=$(mktemp /tmp/tmp.XXXXXXXXXX)

trap 'cat $IC_TEMP_FILES | xargs rm -f -r $IC_TEMP_FILES' EXIT

make_temporary_file()
{
    local RESULT

    RESULT=$(mktemp /tmp/tmp.XXXXXXXXXX)
    echo "$RESULT" >> "$IC_TEMP_FILES"
    
    echo "$RESULT"
}

make_temporary_directory()
{
    local RESULT

    RESULT=$(mktemp -d /tmp/tmp.XXXXXXXXXX)
    echo "$RESULT" >> "$IC_TEMP_FILES"
    
    echo "$RESULT"
}

#!/bin/bash

[ -z "$ISCOOL_TEMPORARIES_INCLUDED" ] || return 0
ISCOOL_TEMPORARIES_INCLUDED=1

export IC_TEMP_FILES=$(mktemp /tmp/tmp.XXXXXXXXXX)

trap 'cat $IC_TEMP_FILES | xargs rm -f -r $IC_TEMP_FILES' EXIT

make_temporary_file()
{
    local PREFIX="$1"
    local RESULT

    [ -n "$PREFIX" ] || PREFIX=/tmp/tmp.XXXXXXXXXX
    
    RESULT=$(mktemp "$PREFIX")
    echo "$RESULT" >> "$IC_TEMP_FILES"
    
    echo "$RESULT"
}

make_temporary_directory()
{
    local PREFIX="$1"
    local RESULT

    [ -n "$PREFIX" ] || PREFIX=/tmp/tmp.XXXXXXXXXX
    
    RESULT=$(mktemp -d "$PREFIX")
    echo "$RESULT" >> "$IC_TEMP_FILES"
    
    echo "$RESULT"
}

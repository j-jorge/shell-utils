#!/bin/bash

INCLUDE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$INCLUDE_ROOT/share/iscoolentertainment/shell/testing.sh"
. "$INCLUDE_ROOT/share/iscoolentertainment/shell/options.sh"

ARRAY=()
add_array_value()
{
    ARRAY+=("$@")
}

LONG_VALUE=
set_long_value()
{
    LONG_VALUE=$1
}

LONG_FLAG=
set_long_flag()
{
    LONG_FLAG=1
}

SHORT_VALUE=
set_short_value()
{
    SHORT_VALUE=$1
}

SHORT_FLAG=
set_short_flag()
{
    SHORT_FLAG=10
}

register_option '--array=<value…>' add_array_value "Add a value to the array"
register_option '--long=<value>' set_long_value "Set the long value" 11
register_option '--long-flag' set_long_flag "Set the long flag" no-long-flag
register_option '-s<value>' set_short_value "Set the short value" 222
register_option '-f' set_short_flag "Set the short flag" no-short-flag

extract_parameters

[ "${#ARRAY[@]}" = 0 ] || test_failed $LINENO

ARRAY=()
extract_parameters --array 11

[ "${#ARRAY[@]}" = 1 ] || test_failed $LINENO
[ "${ARRAY[0]}" = 11 ] || test_failed $LINENO

[ -z "$LONG_VALUE" ] || test_failed $LINENO
[ -z "$LONG_FLAG" ] || test_failed $LINENO
[ -z "$SHORT_VALUE" ] || test_failed $LINENO
[ -z "$SHORT_FLAG" ] || test_failed $LINENO

ARRAY=()
extract_parameters --array=22

[ "${#ARRAY[@]}" = 1 ] || test_failed $LINENO
[ "${ARRAY[0]}" = 22 ] || test_failed $LINENO

[ -z "$LONG_VALUE" ] || test_failed $LINENO
[ -z "$LONG_FLAG" ] || test_failed $LINENO
[ -z "$SHORT_VALUE" ] || test_failed $LINENO
[ -z "$SHORT_FLAG" ] || test_failed $LINENO

ARRAY=()
extract_parameters --array 33 44

[ "${#ARRAY[@]}" = 2 ] || test_failed $LINENO
[ "${ARRAY[0]}" = 33 ] || test_failed $LINENO
[ "${ARRAY[1]}" = 44 ] || test_failed $LINENO

[ -z "$LONG_VALUE" ] || test_failed $LINENO
[ -z "$LONG_FLAG" ] || test_failed $LINENO
[ -z "$SHORT_VALUE" ] || test_failed $LINENO
[ -z "$SHORT_FLAG" ] || test_failed $LINENO

ARRAY=()
extract_parameters --array 44 --array 55 66

[ "${#ARRAY[@]}" = 3 ] || test_failed $LINENO
[ "${ARRAY[0]}" = 44 ] || test_failed $LINENO
[ "${ARRAY[1]}" = 55 ] || test_failed $LINENO
[ "${ARRAY[2]}" = 66 ] || test_failed $LINENO

[ -z "$LONG_VALUE" ] || test_failed $LINENO
[ -z "$LONG_FLAG" ] || test_failed $LINENO
[ -z "$SHORT_VALUE" ] || test_failed $LINENO
[ -z "$SHORT_FLAG" ] || test_failed $LINENO

ARRAY=()
extract_parameters ignore_0 --long=22 1 --array 555 666 --long-flag ignore_1 \
                   --array 777 -s222 ignore_2 --array 888 -f ignore_3 \
                   --array 999 000
                   
[ "${#ARRAY[@]}" = 6 ] || test_failed $LINENO
[ "${ARRAY[0]}" = 555 ] || test_failed $LINENO
[ "${ARRAY[1]}" = 666 ] || test_failed $LINENO
[ "${ARRAY[2]}" = 777 ] || test_failed $LINENO
[ "${ARRAY[3]}" = 888 ] || test_failed $LINENO
[ "${ARRAY[4]}" = 999 ] || test_failed $LINENO
[ "${ARRAY[5]}" = 000 ] || test_failed $LINENO

[ "$LONG_VALUE" = 22 ] || test_failed $LINENO
[ "$LONG_FLAG" = 1 ] || test_failed $LINENO
[ "$SHORT_VALUE" = 222 ] || test_failed $LINENO
[ "$SHORT_FLAG" = 10 ] || test_failed $LINENO

test_end

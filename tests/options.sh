#!/bin/bash

INCLUDE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$INCLUDE_ROOT/share/iscoolentertainment/shell/testing.sh"
. "$INCLUDE_ROOT/share/iscoolentertainment/shell/options.sh"

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

register_option '--long=<value>' set_long_value "Set the long value" 11
register_option '--long-flag' set_long_flag "Set the long flag" no-long-flag
register_option '-s<value>' set_short_value "Set the short value" 222
register_option '-f' set_short_flag "Set the short flag" no-short-flag

extract_parameters

[ -z "$LONG_VALUE" ] || test_failed $LINENO
[ -z "$LONG_FLAG" ] || test_failed $LINENO
[ -z "$SHORT_VALUE" ] || test_failed $LINENO
[ -z "$SHORT_FLAG" ] || test_failed $LINENO

extract_parameters --long=22 --long-flag -s222 -f

[ "$LONG_VALUE" = 22 ] || test_failed $LINENO
[ "$LONG_FLAG" = 1 ] || test_failed $LINENO
[ "$SHORT_VALUE" = 222 ] || test_failed $LINENO
[ "$SHORT_FLAG" = 10 ] || test_failed $LINENO

extract_parameters --long 44 -s 444

[ "$LONG_VALUE" = 44 ] || test_failed $LINENO
[ "$SHORT_VALUE" = 444 ] || test_failed $LINENO

test_end

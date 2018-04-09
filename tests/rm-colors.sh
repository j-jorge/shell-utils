#!/bin/bash

PREFIX_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$PREFIX_ROOT/share/iscoolentertainment/shell/colors.sh"
. "$PREFIX_ROOT/share/iscoolentertainment/shell/testing.sh"

RM_COLORS="$PREFIX_ROOT/bin/rm-colors"

[ "$(echo -e "ab${yellow}cd" | "$RM_COLORS")" = "abcd" ] \
    || test_failed $LINENO

test_end

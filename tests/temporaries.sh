#!/bin/bash

INCLUDE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$INCLUDE_ROOT/share/iscoolentertainment/shell/testing.sh"
. "$INCLUDE_ROOT/share/iscoolentertainment/shell/temporaries.sh"

TEMP_1=$(make_temporary_file)
TEMP_2=$(make_temporary_file)
TEMP_DIR=$(make_temporary_directory)

[ -f "$TEMP_1" ] || test_failed $LINENO
[ -f "$TEMP_2" ] || test_failed $LINENO
[ -d "$TEMP_DIR" ] || test_failed $LINENO

test_end

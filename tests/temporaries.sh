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

custom_tmpdir="$TEMP_DIR"
export TMPDIR="$custom_tmpdir"

custom_1=$(make_temporary_file)
custom_dir=$(make_temporary_directory)

[ "$(dirname "$custom_1")" -ef "$custom_tmpdir" ] || test_failed $LINENO
[ "$(dirname "$custom_dir")" -ef "$custom_tmpdir" ] || test_failed $LINENO

test_end

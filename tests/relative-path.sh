#!/bin/bash

PREFIX_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$PREFIX_ROOT/share/iscoolentertainment/shell/colors.sh"
. "$PREFIX_ROOT/share/iscoolentertainment/shell/testing.sh"

RELATIVE_PATH="$PREFIX_ROOT/bin/relative-path"

[ "$("$RELATIVE_PATH" a/b/c a/b/d)" = "../d" ] || test_failed $LINENO
[ "$("$RELATIVE_PATH" a/b/c a/b)" = ".." ] || test_failed $LINENO
[ "$("$RELATIVE_PATH" a/b/c a/d)" = "../../d" ] || test_failed $LINENO
[ "$("$RELATIVE_PATH" /a/b/c /a/d)" = "../../d" ] || test_failed $LINENO
[ "$("$RELATIVE_PATH" /a/b/c/ /a/d)" = "../../d" ] || test_failed $LINENO
[ "$("$RELATIVE_PATH" /a/b/c /a/d/)" = "../../d" ] || test_failed $LINENO
[ "$("$RELATIVE_PATH" /a/b/c/ /a/d/)" = "../../d" ] || test_failed $LINENO

test_end

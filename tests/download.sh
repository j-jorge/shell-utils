#!/bin/bash

INCLUDE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$INCLUDE_ROOT/share/iscoolentertainment/shell/testing.sh"
. "$INCLUDE_ROOT/share/iscoolentertainment/shell/temporaries.sh"

TMP_DIR=$(make_temporary_directory)
REFERENCE="$TMP_DIR/reference.html"
TARGET="$TMP_DIR/target.html"
URL="http://example.com/"

curl --silent "$URL" --output "$REFERENCE"
MIME_TYPE=$(file --mime "$REFERENCE" | cut -d' ' -f2 | tr -d ';')

CACHE="$TMP_DIR/cache/"
mkdir "$CACHE"
ISCOOL_DOWNLOAD_CACHE="$CACHE" \
                     "$INCLUDE_ROOT/bin/download" \
                         --url="$URL" \
                         --mime-type="$MIME_TYPE" \
                         --target-file="$TARGET" \
                         --skip-size-test

[ -f "$REFERENCE" ] || test_failed $LINENO
[ -L "$TARGET" ] || test_failed $LINENO
cmp --quiet "$TARGET" "$REFERENCE" || test_failed $LINENO

test_end

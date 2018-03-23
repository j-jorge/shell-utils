#!/bin/bash

INCLUDE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$INCLUDE_ROOT/share/iscoolentertainment/shell/testing.sh"
. "$INCLUDE_ROOT/share/iscoolentertainment/shell/temporaries.sh"

TMP_DIR=$(make_temporary_directory)

echo "echo 1" > "$TMP_DIR/1.sh"
chmod a+x "$TMP_DIR/1.sh"

echo "echo 2" > "$TMP_DIR/2.sh"

echo "echo 3" > "$TMP_DIR/3.sh"
chmod a+x "$TMP_DIR/3.sh"

"$INCLUDE_ROOT/bin/run-all-scripts" \
    "$TMP_DIR/3.sh" \
    "$TMP_DIR/2.sh" \
    "$TMP_DIR/1.sh" \
    | grep -v -F "$TMP_DIR" \
    > "$TMP_DIR/output.txt"

cat > "$TMP_DIR/expected.txt" <<EOF
3
1
EOF

cmp --quiet "$TMP_DIR/output.txt" "$TMP_DIR/expected.txt" || test_failed $LINENO

test_end

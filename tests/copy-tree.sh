#!/bin/bash

INCLUDE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$INCLUDE_ROOT/share/iscoolentertainment/shell/testing.sh"
. "$INCLUDE_ROOT/share/iscoolentertainment/shell/temporaries.sh"

COPY_TREE="$(dirname "${BASH_SOURCE[0]}")/../prefix/bin/copy-tree"

test_tree()
{
    local SOURCE=
    local DESTINATION=

    SOURCE=$(make_temporary_directory)
    DESTINATION=$(make_temporary_directory)

    echo 1 > "$SOURCE/linked"

    mkdir "$SOURCE/d/"
    echo 11 > "$SOURCE/.hidden"
    echo 22 > "$SOURCE/d/.hidden"

    mkdir -p "$SOURCE/e/f"
    echo 111 > "$SOURCE/e/f/1"
    echo 222 > "$SOURCE/e/f/2"

    ln -s ../../linked "$SOURCE/e/f/link"

    "$COPY_TREE" --from "$SOURCE" --to "$DESTINATION"

    diff -r "$SOURCE" "$DESTINATION" || test_failed $LINENO
    [ -f "$DESTINATION/e/f/link" ] || test_failed $LINENO
}


test_update()
{
    local SOURCE=
    local DESTINATION=

    SOURCE=$(make_temporary_directory)
    DESTINATION=$(make_temporary_directory)

    mkdir "$SOURCE/d/"
    echo 11 > "$SOURCE/1"
    echo 22 > "$SOURCE/d/2"

    mkdir "$DESTINATION/d"
    echo 33 > "$DESTINATION/d/2"
    
    "$COPY_TREE" --from "$SOURCE" --to "$DESTINATION"

    [ 33 -eq "$(cat "$DESTINATION/d/2")" ] || test_failed $LINENO
}

test_tree
test_update

test_end

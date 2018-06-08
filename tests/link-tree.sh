#!/bin/bash

INCLUDE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../prefix

. "$INCLUDE_ROOT/share/iscoolentertainment/shell/testing.sh"
. "$INCLUDE_ROOT/share/iscoolentertainment/shell/temporaries.sh"

LINK_TREE="$(dirname "${BASH_SOURCE[0]}")/../prefix/bin/link-tree"

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

    "$LINK_TREE" --from "$SOURCE" --to "$DESTINATION"

    diff -r "$SOURCE" "$DESTINATION" || test_failed $LINENO

    [ -L "$DESTINATION/.hidden" ] || test_failed $LINENO
    [ -L "$DESTINATION/linked" ] || test_failed $LINENO
    [ -L "$DESTINATION/d" ] || test_failed $LINENO
    [ -L "$DESTINATION/e" ] || test_failed $LINENO
}

keep_existing_directories()
{
    local SOURCE=
    local DESTINATION=

    SOURCE=$(make_temporary_directory)
    DESTINATION=$(make_temporary_directory)

    echo 1 > "$SOURCE/1"

    mkdir "$SOURCE/d/"
    echo 11 > "$SOURCE/.hidden"
    echo 22 > "$SOURCE/d/.hidden"

    mkdir -p "$SOURCE/e/f"
    echo 111 > "$SOURCE/e/f/1"
    echo 222 > "$SOURCE/e/f/2"

    mkdir "$DESTINATION/e"
    
    "$LINK_TREE" --from "$SOURCE" --to "$DESTINATION"

    diff -r "$SOURCE" "$DESTINATION" || test_failed $LINENO

    [ -L "$DESTINATION/.hidden" ] || test_failed $LINENO
    [ -L "$DESTINATION/d" ] || test_failed $LINENO
    [ -d "$DESTINATION/e" ] || test_failed $LINENO
    [ -L "$DESTINATION/e/f" ] || test_failed $LINENO
}

non_matching_destination_types()
{
    local SOURCE=
    local DESTINATION=

    SOURCE=$(make_temporary_directory)
    DESTINATION=$(make_temporary_directory)

    echo 1 > "$SOURCE/1"

    mkdir "$SOURCE/d/"
    echo 11 > "$SOURCE/.hidden"
    echo 22 > "$SOURCE/d/.hidden"

    mkdir -p "$SOURCE/e/f"
    echo 111 > "$SOURCE/e/f/1"
    echo 222 > "$SOURCE/e/f/2"

    mkdir "$DESTINATION/1"
    true > "$DESTINATION/e"
    
    "$LINK_TREE" --from "$SOURCE" --to "$DESTINATION"

    diff -r "$SOURCE" "$DESTINATION" || test_failed $LINENO

    [ -L "$DESTINATION/.hidden" ] || test_failed $LINENO
    [ -L "$DESTINATION/linked" ] || test_failed $LINENO
    [ -L "$DESTINATION/d" ] || test_failed $LINENO
    [ -d "$DESTINATION/e" ] || test_failed $LINENO
    [ -L "$DESTINATION/e/f" ] || test_failed $LINENO
}

test_tree
keep_existing_directories

test_end

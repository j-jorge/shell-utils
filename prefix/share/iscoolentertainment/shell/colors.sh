#!/bin/sh

[ -z "${ISCOOL_COLORS_INCLUDED:-}" ] || return 0
ISCOOL_COLORS_INCLUDED=1

if [[ -t 1 ]]
then
    blue="\033[0;34m"
    blue_bold="\033[1;34m"

    green="\033[0;32m"
    green_bold="\033[1;32m"

    red="\033[0;31m"
    red_bold="\033[1;31m"

    yellow="\033[0;33m"
    yellow_bold="\033[1;33m"

    term_color="\033[0;0m"
else
    blue=""
    blue_bold=""

    green=""
    green_bold=""

    red=""
    red_bold=""

    yellow=""
    yellow_bold=""

    term_color=""
fi

#!/bin/sh

[ -z "$ISCOOL_COLORS_INCLUDED" ] || return 0
ISCOOL_COLORS_INCLUDED=1

green="\e[0;32m"
green_bold="\e[1;32m"

red="\e[0;31m"
red_bold="\e[1;31m"

yellow="\e[0;33m"
yellow_bold="\e[1;33m"

term_color="\e[0;0m"

#!/bin/bash

[ -z "${ISCOOL_TESTING_INCLUDED:-}" ] || return 0
ISCOOL_TESTING_INCLUDED=1

. "$(dirname "${BASH_SOURCE[0]}")"/colors.sh

test_failure_flag=

test_failed()
{
    printf "${red}Test failed:${term_color} line %s.\n" $1
    test_failure_flag=1
}

test_end()
{
    printf -- "--\n"

    if [ -z "$test_failure_flag" ]
    then
        printf "${green}All tests passed successfully.${term_color}\n"
        exit 0
    else
        printf "${red}Some tests failed.${term_color}\n"
        exit 1
    fi
}

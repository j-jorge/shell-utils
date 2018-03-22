#!/bin/bash

[ -z "$ISCOOL_MIME_TYPES_INCLUDED" ] || return 0
ISCOOL_MIME_TYPES_INCLUDED=1

. "$(dirname "${BASH_SOURCE[0]}")/platform.sh"

mime_type_name()
{
    case "$1" in
        bin)
            is_osx && echo "application/x-mach-binary" \
                    || echo "application/x-executable"
            ;;
        gzip)
            is_osx && echo "application/x-gzip" || echo "application/gzip"
            ;;
        *)
            printf "Unsupported type for mime types: %s.\n" "$1" >&2
            ;;
    esac
}


#!/bin/sh
# mk-sbom.sh - script to create info for an SBOM
# Copyright (C) 2024 g10 Code GmbH
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# SPDX-License-Identifier: FSFULLRWD

set -e

PGM=build.sh

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS] package_files
Output a line for each packae with information usefuul for a SBOM.

Options:
        --verbose       Show how the commit-id was retrieved
        --help          This output.

Example:
    ./$PGM foo-2.3.tar.bz2 bar-1.2.3.tar.xz

        Output two lines with the checksum, name and version, and the
        commit-id (if available).
EOF
    exit $1
}


# Parse the command line options.
verbose=
while [ $# -gt 0 ]; do
    case "$1" in
	--*=*)
	    optarg=`echo "$1" | sed 's/[-_a-zA-Z0-9]*=//'`
	    ;;
	*)
	    optarg=""
	    ;;
    esac

    case "$1" in
        --verbose|-v) verbose=yes ;;
        --help|-h) usage 0 ;;
        --) shift; break 2 ;;
        --*) usage 1 1>&2; exit 1;;
        *) break 2 ;;
    esac
    shift
done



for file in "$@"; do
    sha1=$(sha1sum < "$file"|cut -f1 -d' ')
    name="${file##*/}"
    commitid=
    uncompress=
    case "$name" in
	*.tar.gz|*.tgz)         uncompress=zcat ;;
        *.tar.bz2|*.tbz2|*.tbz) uncompress=bzcat ;;
	*.tar.xz)               uncompress=xzcat ;;
	*.tar)                  uncompress=cat ;;
    esac
    if [ -n "$uncompress" ]; then
        source="tar comment"
        commitid=$($uncompress "$file" 2>/dev/null \
                      | git get-tar-commit-id 2>/dev/null || true)
        if [ -z "$commitid" ]; then
            source="version file"
            save_IFS="$IFS"
            IFS=
            verfile=$($uncompress "$file" 2>/dev/null \
                      | tar -xOf - --wildcards "*/VERSION" 2>/dev/null || true)
            IFS="$save_IFS"
            commitid=$(echo "$verfile" | sed -n 2p)
        fi
        if [ -n "$commitid" -a $(echo -n "$commitid" | wc -c) -ne 40 ]; then
            echo >&2 "$PGM: bad commit-id in '$file' ($source)"
            commitid=
        fi
    else
        source="n/a"
    fi
    if [ -z "$verbose" ]; then
       :
    elif [ -n "$commitid" ]; then
        echo >&2 "$PGM: $file - commit-id from $source"
    else
        echo >&2 "$PGM: $file"
    fi
    echo "$sha1 $name $commitid"
done

#!/bin/bash
# Copyright (C) 2016 Intevation GmbH
# Copyright (C) 2021 g10 Code GmbH
#
# Software engineering by Ingo Klöcker <dev@ingo-kloecker.de>
#
# This file is part of GPG4Win.
#
# GPG4Win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# GPG4Win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-2.0+

# Use this script for updating packages for which no dedicated script exists.

PGM=gen-package.sh

set -e

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS] VERSION PACKAGE
Options:
        [--help]       Show usage information
EOF
    exit $1
}

while [ $# -gt 0 ]; do
    case $1 in
	--help|-h)
	    usage 0
	    ;;
	--*)
	    usage 1 1>&2
	    ;;
	*)
	    break
	    ;;
    esac
    shift
done

if [ $# -ne 2 ]; then
    usage 1 1>&2
fi

version=$1
package=$2

curdate=$(date +%Y-%m-%d)

sig=no
keyring=no-keyring-set

case ${package} in
    gettext | libiconv)
        server=https://ftp.gnu.org/pub/gnu
        filepathonserver=${package}/${package}-${version}.tar.gz
        sig=yes
        keyring=$(dirname $0)/gnu-keyring.gpg
        ;;
    xcb-util-cursor)
        server=https://xcb.freedesktop.org/dist
        filepathonserver=${package}-${version}.tar.xz
        sig=yes
        keyring=$(dirname $0)/keyring-xcb-util-cursor-alan-coopersmith.gpg
        ;;
    *)
        echo "$PGM: error: Unsupported package '${package}'"
        exit 1
        ;;
esac

tmpdir=$(mktemp -d -t gen-package.XXXXXXXXXX)

tarfileurl=${server}/${filepathonserver}
tarfile=$(basename ${filepathonserver})
echo "Downloading ${tarfileurl}..." >&2
if ! curl -L --silent --show-error --fail "${tarfileurl}" > "$tmpdir/${tarfile}"; then
    echo "Downloading ${tarfileurl} failed" >&2
    exit 1
fi

if [ "${sig}" == "yes" ]; then
    sigfileurl=${tarfileurl}.sig
    sigfile=$(basename ${sigfileurl})
    echo "Downloading signature ${sigfileurl}..." >&2
    if ! curl -L --silent --show-error --fail "${sigfileurl}" > "$tmpdir/${sigfile}"; then
        echo "Downloading ${sigfileurl} failed" >&2
        exit 1
    fi
    echo "Verifying signature..." >&2
    if ! gpgv --keyring "$keyring" "$tmpdir/${sigfile}" "$tmpdir/${tarfile}" >&2; then
        echo "Signature for $tmpdir/${tarfile} is not valid!" >&2
        exit 1
    fi
fi

sha2=$(sha256sum $tmpdir/${tarfile} | cut -d ' ' -f 1)

cat > ${tmpdir}/snippet <<EOF
# ${package}
# last changed: ${curdate}
# by: $(echo ${EMAIL-$USER}|sed 's/@.*//')
# verified: PGP signed by ${keyring##*/} (created by gen-package.sh)
file ${filepathonserver}
chk  $sha2

EOF

perl -i -p0e "s@# ${package}\n# last changed:.*?\n# by:.*?\n# verified:.*?\nfile.*?\nchk.*?\n@'`cat ${tmpdir}/snippet`
'@se" packages.list

cat ${tmpdir}/snippet

rm -r $tmpdir

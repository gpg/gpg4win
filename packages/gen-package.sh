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
Usage: $PGM [OPTIONS] PACKAGE VERSION [SHA256]
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

if [ $# -lt 2 -o $# -gt 3 ]; then
    usage 1 1>&2
fi

package=$1
version=$2
checksum=$3

curdate=$(date +%Y-%m-%d)

user=$(echo ${EMAIL-$USER}|sed 's/@.*//')
sig=no
keyring=no-keyring-set
verification=

case ${package} in
    gettext | libiconv)
        server=https://ftp.gnu.org/pub/gnu
        filepathonserver=${package}/${package}-${version}.tar.gz
        sig=yes
        keyring=$(dirname $0)/gnu-keyring.gpg
        ;;
    libical)
        server=https://github.com
        filepathonserver=libical/libical/releases/download/v${version}/libical-${version}.tar.gz
        ;;
    wayland-protocols)
        server=https://gitlab.freedesktop.org
        filepathonserver=wayland/${package}/-/releases/${version}/downloads/${package}-${version}.tar.xz
        sig=yes
        # Keys of Daniel Stone and Simon Ser (owners of wayland-protocols) downloaded from gitlab.freedesktop.org;
        # imported in temporary keyring and then exported with --export-options export-minimal to remove packages
        # that confuse gpgv
        keyring=$(dirname $0)/keyring-wayland-protocols.gpg
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

if [ "${sig}" == "no" -a -z "${checksum}" ]; then
    echo "$PGM: error: The package '${package}' is not signed. You have to provide the SHA-256 checksum." >&2
    usage 1 1>&2
fi

tmpdir=$(mktemp -d -t gen-package.XXXXXXXXXX)

tarfileurl=${server}/${filepathonserver}
tarfile=$(basename ${filepathonserver})
echo "Downloading ${tarfileurl}..." >&2
if ! curl -L --silent --show-error --fail "${tarfileurl}" > "$tmpdir/${tarfile}"; then
    echo "Downloading ${tarfileurl} failed" >&2
    exit 1
fi

if [ -n ${checksum} ]; then
    sha256filepath=${tmpdir}/${tarfile}.sha256
    echo "Verifying checksum..." >&2
    echo "${checksum}  ${tarfile}" > ${sha256filepath}
    curdir=$(pwd)
    cd ${tmpdir}
    if ! sha256sum --check ${sha256filepath} >&2; then
        echo "Checksum for ${tmpdir}/${tarfile} is not valid!" >&2
        exit 1
    fi
    cd ${curdir}
    verification="verification of checksum provided by ${user}"
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
    if [ -n ${checksum} ]; then
        echo "Calculating checksum..." >&2
        checksum=$(sha256sum $tmpdir/${tarfile} | cut -d ' ' -f 1)
    fi
    verification="PGP signed by ${keyring##*/} (created by gen-package.sh)"
fi

cat > ${tmpdir}/snippet <<EOF
# ${package}
# last changed: ${curdate}
# by ${user}
# verified: ${verification}
file ${filepathonserver}
chk  ${checksum}

EOF

perl -i -p0e "s@# ${package}\n# last changed:.*?\n# by.*?\n# verified:.*?\nfile.*?\nchk.*?\n@'`cat ${tmpdir}/snippet`
'@se" packages.list

cat ${tmpdir}/snippet

rm -r $tmpdir

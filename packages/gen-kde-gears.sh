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

# Grab the version information for packages released with a KDE Gears release
# and generate a text block that can be copy and pasted into packages.current.

set -e

if [ -z "$1" ]; then
    echo "Usage $0 <Version> > snippet"
    exit 1
fi

GEARS="libkleo
    kleopatra"

fullversion=$1
case ${fullversion} in
    *.*.*)
        majorversion=${fullversion%.*}
        ;;
    *.*)
        majorversion=${fullversion}
        fullversion=${majorversion}.0
        echo "Using full version ${fullversion}"
        ;;
    *)
        echo "Invalid version ${fullversion}"
        exit 1
        ;;
esac

curdate=$(date +%Y-%m-%d)

KEYRING=$(dirname $0)/kde-release-keys.gpg

server=https://download.kde.org/stable/release-service
echo "server ${server}"

tmpdir=$(mktemp -d -t gen-kde-gears.XXXXXXXXXX)

for package in $GEARS; do
    # Download packages over https now and verify that the signature matches
    tarfile="${package}-${fullversion}.tar.xz"
    tarfileurl="${server}/${fullversion}/src/${tarfile}"
    if ! curl -L --silent --show-error --fail "${tarfileurl}" > "$tmpdir/${tarfile}"; then
        echo "Downloading ${tarfileurl} failed"
        exit 1
    fi
    sigfile="${tarfile}.sig"
    sigfileurl="${tarfileurl}.sig"
    if ! curl -L --silent --show-error --fail "${sigfileurl}" > "$tmpdir/${sigfile}"; then
        echo "Downloading ${sigfileurl} failed"
        exit 1
    fi
    # Check the signature
    if ! gpgv --keyring "$KEYRING" "$tmpdir/${sigfile}" "$tmpdir/${tarfile}"; then
        echo "Signature for $tmpdir/${tarfile} is not valid!"
        exit 1
    fi

    sha2=$(sha256sum $tmpdir/${tarfile} | cut -d ' ' -f 1)

    echo "# $package"
    echo "# last changed: $curdate"
    echo "# by: ah"
    echo "# verified: PGP Signed by ./kde-release-keys.gpg (created by gen-kde-gears.sh)"
    echo "file ${fullversion}/src/${tarfile}"
    echo "chk $sha2"
    echo ""
done

rm -r $tmpdir

#!/bin/bash
# Copyright (C) 2016 Intevation GmbH
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
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA

# Grab the version information for KDE Frameworks and generate a text block
# that can be copy and pasted into packages.current.
#
# Ideally KDE will PGP Sign their releases soon.

set -e

if [ -z "$1" ]; then
    echo "Usage $0 <Version> > snippet"
    exit 1
fi

FRAMEWORKS="extra-cmake-modules
    kconfig
    ki18n
    kwidgetsaddons
    kcompletion
    kwindowsystem
    kcoreaddons
    kcodecs
    kconfigwidgets
    kdbugaddons
    kxmlgui
    kguiaddons
    kitemviews
    kitemmodels
    kiconthemes
    breeze-icons
    karchive
    kcrash"

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

KEYRING=$(dirname $0)/kde-release-key.gpg

server=https://download.kde.org/stable/frameworks
echo "server ${server}"

tmpdir=$(mktemp -d -t gen-frameworks.XXXXXXXXXX)

for fw in $FRAMEWORKS; do
    # Download packages over https now and verify that the signature matches
    tarfile="$fw-${fullversion}.tar.xz"
    tarfileurl="${server}/$majorversion/${tarfile}"
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

    echo "# $fw"
    echo "# last changed: $curdate"
    echo "# by: ah"
    echo "# verified: PGP Signed by ./kde-release-key.gpg (created by gen-frameworks.sh)"
    echo "file $majorversion/${tarfile}"
    echo "chk $sha2"
    echo ""
done

rm -r $tmpdir

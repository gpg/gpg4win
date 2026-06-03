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

# Grab the version information for KDE Frameworks and generate a text block
# that can be copy and pasted into packages.current.

set -e

if [ -z "$1" ]; then
    echo "Usage $0 <Version> [PACKAGE] ..."
    exit 1
fi

fullversion=$1
shift
packages=$@

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

case ${majorversion} in
    5.*)
        defaultpackages="qtbase
                         qttools
                         qtwinextras
                         qtx11extras
                         qtwayland
                         qtsvg
                         qttranslations"
        tarfileinfix="everywhere-opensource-src"
        ;;
    6.*)
        defaultpackages="qtbase
                         qttools
                         qtsvg
                         qttranslations
                         qthttpserver
                         qtwayland
                         qtwebsockets"
        tarfileinfix="everywhere-src"
        ;;
    *)
        echo "Unknown Qt version: ${majorversion}"
        exit 1
        ;;
esac
if [ -z "$packages" ]; then
    packages=${defaultpackages}
fi

curdate=$(date +%Y-%m-%d)

KEYRING=$(dirname $0)/kde-release-keys.gpg

server=https://download.qt.io/archive/qt
echo "server ${server}"

tmpdir=$(mktemp -d -t gen-qt.XXXXXXXXXX)

for module in $packages; do
    # Download packages over https now and verify that the signature matches
    tarfile="${module}-${tarfileinfix}-${fullversion}.tar.xz"
    tarfileurl="${server}/${majorversion}/${fullversion}/submodules/${tarfile}"
    resultingtarfile="${module}-${fullversion}.tar.xz"
    echo "Downloading ${tarfileurl} ..."
    if ! curl -L --silent --show-error --fail "${tarfileurl}" > "$tmpdir/${resultingtarfile}"; then
        echo "Downloading ${tarfileurl} failed"
        exit 1
    fi
    tarfilesha="${tarfileurl}.sha256"
    echo "Downloading ${tarfilesha} ..."
    if ! curl -L --silent --show-error --fail "${tarfilesha}" | sed "s/${tarfile}/${resultingtarfile}/" > "$tmpdir/${resultingtarfile}.sha256"; then
        echo "Downloading ${tarfilesha} failed"
        exit 1
    fi

    (cd ${tmpdir} && sha256sum -c "${resultingtarfile}.sha256" || exit 1; )

    sha2=$(sha256sum $tmpdir/${resultingtarfile} | cut -d ' ' -f 1)

    cat > ${tmpdir}/snippet <<EOF
# ${module}
# last changed: ${curdate}
# by: $USER
# verified: mirror sha256sum (created by gen-qt.sh)"
name ${resultingtarfile}
file ${majorversion}/${fullversion}/submodules/${tarfile}
chk ${sha2}

EOF

perl -i -p0e "s@# ${module}\n# last changed:.*?\n# by:.*?\n# verified:.*?\nname.*?\nfile.*?\nchk.*?\n@'`cat ${tmpdir}/snippet`
'@se" packages.list
done

rm -r $tmpdir

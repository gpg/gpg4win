#!/bin/bash
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

# Packages the current HEAD of a git repository as tarball and generates
# a text block that can be copy and pasted into packages.current.

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 PACKAGE --auto"
    echo "where PACKAGE is either the name of a supported library or application, e.g. 'kleopatra',"
    echo "or the path of a local Git repository, e.g. '~/src/kleopatra',"
    echo "or the URL of a remote Git repository, e.g. 'https://invent.kde.org/pim/kleopatra.git'."
    echo ""
    echo "add the --auto parameter to automatically update packages.common and upload the tarball."
    exit 1
fi

package=$1
is_gpg="no"
is_w32="no"
do_auto="no"
branch="master"

case ${package} in
    */*)
        repo=${package%/}
        package=$(basename ${repo})
        package=${package%.git}
        ;;
    gnupg | gpgme | libassuan | libgcrypt | libgpg-error | \
        libksba | npth | pinentry | scute | ntbtls)
        repo=git://git.gnupg.org/${package}.git
        is_gpg="yes"
        ;;
    gpgol | gpgex)
        repo=git://git.gnupg.org/${package}.git
        is_gpg="yes"
        is_w32="yes"
        ;;
    gpg4win-tools)
        repo=git://git.gnupg.org/${package}.git
        ;;
    kleopatra | libkleo)
        # assume that package is provided by KDE
        repo=https://invent.kde.org/pim/${package}.git
        branch=gpg4win/23.07
        ;;
    k* | libk*)
        # assume that package is provided by KDE
        repo=https://invent.kde.org/pim/${package}.git
        ;;
    okular)
        repo=https://invent.kde.org/graphics/${package}.git
        branch="work/sune/WORK"
        ;;
    poppler)
        repo=https://anongit.freedesktop.org/git/poppler/poppler.git
        #repo=https://gitlab.freedesktop.org/svuorela/${package}.git
        #branch="WORK"
        ;;
    *)
        echo "Error: Unsupported package '${package}'"
        exit 1
        ;;
esac

if [ "$2" == "--auto" ]; then
    do_auto="yes";
fi

tmpdir=$(mktemp -d -t gen-tarball.XXXXXXXXXX)
curdate=$(date +%Y-%m-%d)
timestamp=$(date +%Y%m%d%H%M)
snapshotdir=${package}-${timestamp}
tarball=${snapshotdir}.tar.xz

git clone ${repo} ${tmpdir}/${snapshotdir}

if [ "${is_gpg}" == "yes" ]; then
    olddir=$(pwd)
    cd ${tmpdir}/${snapshotdir}
    ./autogen.sh --force >&2
    if [ "${is_w32}" == "yes" ]; then
        ./autogen.sh --build-w32 >&2
#        ./autogen.sh --build-w32 --with-libassuan-prefix=/home/aheinecke/w64root/ >&2
    else
        ./configure >&2
    fi
    make dist-xz >&2
    tarball=$(ls -t *.tar.xz | head -1)
    cp ${tmpdir}/${snapshotdir}/${tarball} ${olddir}
    cd ${olddir}
else
    echo "Archiving $branch.."
    (cd ${tmpdir}/${snapshotdir} && \
    git archive --format tar.xz --prefix=${snapshotdir}/ "origin/$branch") > ${tarball} || \
      (echo "Failed to archive tarball. Is tar.xz configured?: git config --global tar.tar.xz.command \"xz -c\"" && exit 1)
fi
checksum=$(sha256sum ${tarball} | cut -d ' ' -f 1)


cat > ${tmpdir}/snippet <<EOF
# ${package}
# last changed: ${curdate}
# by: $USER
# verified: Tarball created by $USER.
file ${package}/${tarball}
chk ${checksum}
EOF

if [ "${do_auto}" == "yes" ]; then
    perl -i -p0e "s@# ${package}\n# last changed:.*?\n# by:.*?\n# verified:.*?\nfile.*?\nchk.*?\n@'`cat ${tmpdir}/snippet`
'@se" packages.common

    echo "uploading" >&2
    rsync -vP ${tarball} trithemius.gnupg.org:/home/ftp/gcrypt/snapshots/${package}/
else
    echo "------------------------------ >8 ------------------------------"
    cat "${tmpdir}/snippet"
    echo "------------------------------ >8 ------------------------------"
    echo "To upload:" >&2
    echo "rsync -vP ${tarball} trithemius.gnupg.org:/home/ftp/gcrypt/snapshots/${package}/" >&2
fi;
rm -fr ${tmpdir}

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

# Packages the current HEAD of a git repository as tarball and updates
# the packages.common accordingly if the entry matches the exact pattern.
# For KDE this script also tries to integrate the translations even for
# custom / stable branches which do not fit the upstream translation
# workflow.

PGM=gen-tarball.sh

set -e

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS]  PACKAGE
Generate a tarball from a repository.

Options:
        --auto                 Upload to ftp server
        --user=name            Use NAME as FTP server user

PACKAGE is either the name of a supported library or application,
e.g. 'kleopatra', or the path of a local Git repository,
e.g. '~/src/kleopatra', or the URL of a remote Git repository,
e.g. 'https://invent.kde.org/pim/kleopatra.git'.  Branches for
packages are defined within this script.

EOF
    exit $1
}

autoupload=no
ftpuser_at=""
is_gpg="no"
is_w32="no"
do_auto="no"
branch="master"
while [ $# -gt 0 ]; do
    case "$1" in
	--*=*)
	    optarg=`echo "$1" | sed 's/[-_a-zA-Z0-9]*=//'`
	    ;;
	*)
	    optarg=""
	    ;;
    esac

    case $1 in
	--auto)
	    autoupload=yes
	    ;;
        --user|--user=*)
            ftpuser_at="${optarg}@"
            ;;
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

if [  $# -ne 1 ]; then
    usage 1 1>&2
fi
package="$1"
shift


case ${package} in
    */*)
        repo=${package%/}
        package=$(basename ${repo})
        package=${package%.git}
        if [ "${package}" == "gpgmeqt" ]; then
            package=qgpgme
        fi
        ;;
    gnupg | gpgme | libassuan | libgcrypt | libgpg-error | \
        libksba | npth | pinentry | scute | ntbtls | gpgmepp | \
        gpgol | gpgex | gpg4win-tools | gpgpass)
        repo=git://git.gnupg.org/${package}.git
        ;;
    gpgmeqt | qgpgme)
        # the repo is named gpgmeqt, but the tarball/library is named qgpgme
        package=qgpgme
        repo=git://git.gnupg.org/gpgmeqt.git
        ;;
    mimetreeparser | kleopatra | libkleo)
        repo=https://invent.kde.org/pim/${package}.git
        ;;
    okular)
        repo=https://invent.kde.org/graphics/${package}.git
        ;;
    poppler)
        #repo=https://anongit.freedesktop.org/git/poppler/poppler.git
        repo=https://gitlab.freedesktop.org/svuorela/${package}.git
        ;;
    *)
        echo "$PGM: error: Unsupported package '${package}'"
        exit 1
        ;;
esac
case ${package} in
    gnupg | gpgme | libassuan | libgcrypt | libgpg-error | \
        libksba | npth | pinentry | scute | ntbtls)
        is_gpg="yes"
        ;;
    gpgmepp | qgpgme)
        is_g10_cmake="yes"
        ;;
    gpgol | gpgex)
        is_gpg="yes"
        is_w32="yes"
        ;;
    gpg4win-tools | gpgpass)
        ;;
    mimetreeparser)
        branch="gpg4win/24.05"
        ;;
    kleopatra)
        branch="gpg4win/24.05"
        ;;
    libkleo)
        branch="gpg4win/24.05"
        ;;
    okular)
        branch="work/sune/WORK"
        ;;
    poppler)
        branch="WORK"
        ;;
    *)
        echo "$PGM: error: Unsupported package '${package}'"
        exit 1
        ;;
esac


tmpdir=$(mktemp -d -t gen-tarball.XXXXXXXXXX)
curdate=$(date +%Y-%m-%d)
timestamp=$(date +%Y%m%d%H%M)
snapshotdir=${package}-${timestamp}
tarball=${snapshotdir}.tar.xz

if [ "${is_gpg}" == "yes" ]; then
    git clone ${repo} ${tmpdir}/${snapshotdir}
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
elif [ "${is_g10_cmake}" == "yes" ]; then
    git clone ${repo} ${tmpdir}/${snapshotdir}
    olddir=$(pwd)
    cd ${tmpdir}/${snapshotdir}
    mkdir build
    cd build
    cmake .. >&2
    make dist >&2
    tarball=$(ls -t *.tar.xz | head -1)
    cp ${tarball} ${olddir}
    cd ${olddir}
else
    git clone --depth=1 --branch $branch ${repo} ${tmpdir}/${snapshotdir}
    olddir=$(pwd)
    echo "$PGM: Archiving branch $branch."
    cd ${tmpdir}/${snapshotdir}
    git archive --format tar.xz --prefix=${snapshotdir}/ "${branch}" > ${tarball}
    cp ${tmpdir}/${snapshotdir}/${tarball} ${olddir}
    cd ${olddir}
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

if [ "${autoupload}" = "yes" ]; then
    perl -i -p0e "s@# ${package}\n# last changed:.*?\n# by:.*?\n# verified:.*?\nfile.*?\nchk.*?\n@'`cat ${tmpdir}/snippet`
'@se" packages.common

    echo "$PGM: uploading to ${ftpuser_at}trithemius.gnupg.org" >&2
    rsync -vP ${tarball} ${ftpuser_at}trithemius.gnupg.org:/home/ftp/gcrypt/snapshots/${package}/
else
    echo "------------------------------ >8 ------------------------------"
    cat "${tmpdir}/snippet"
    echo "------------------------------ >8 ------------------------------"
    echo "$PGM: info: To upload:" >&2
    echo "rsync -vP ${tarball} trithemius.gnupg.org:/home/ftp/gcrypt/snapshots/${package}/" >&2
fi;
rm -fr ${tmpdir}

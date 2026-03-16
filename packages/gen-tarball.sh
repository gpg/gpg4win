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
# SPDX-License-Identifier: GPL-2.0-or-later

# Packages the current HEAD of a git repository as tarball and updates
# the packages.list accordingly if the entry matches the exact pattern.
# For KDE this script also tries to integrate the translations even for
# custom / stable branches which do not fit the upstream translation
# workflow.

PGM=gen-tarball.sh

set -e

FRONTEND_PKGS="
libkleo
kleopatra
gpgol
gpgoljs
gpgpass
gpg4win-tools"

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS]  PACKAGE ...
Generate a tarball from a repository.

Options:
        -a|--auto              Upload to ftp server
        -u|--update            Remove the old package locally
        --user=name            Use NAME as FTP server user
        -f                     Update frontend packages en block.

Frontend packages are:
$FRONTEND_PKGS

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
do_auto="no"
update="no"
branch="master"
add_version_file="no"
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
    --auto|-a)
        autoupload="yes"
        ;;
    --user|--user=*)
        ftpuser_at="${optarg}@"
        ;;
    --update|-u)
        update="yes"
        ;;
    -f)
        update="full"
        ;;
    --help|-h)
        usage 0
        ;;
    --*)
        usage 1 1>&2
        ;;
    -*)
        # Handle combined short options
        for (( i=1; i<${#1}; i++ )); do
            char="${1:i:1}"
            case "$char" in
                a)
                    autoupload="yes"
                    ;;
                u)
                    update="yes"
                    ;;
                f)
                    update="full"
                    ;;
                h)
                    usage 0
                    ;;
                *)
                    usage 1 1>&2
                    ;;
            esac
        done
        ;;
    *)
        break
        ;;
    esac
    shift
done

if [ $# -eq 0 ] && [ "$update" != "full" ]; then
    usage 1 1>&2
fi

PACKAGES="$@"

if [ "$update" == "full" ]; then
    PACKAGES="$PACKAGES $FRONTEND_PKGS"
fi

for package in $PACKAGES; do

# Reset variables
branch="master"
is_gpg="no"
is_w32="no"
custom_l10n="no"

case ${package} in
    */*)
        repo=${package%/}
        package=$(basename ${repo})
        package=${package%.git}
        if [ "${package}" == "gpgmeqt" ]; then
            package=qgpgme
        elif [ "${package}" == "gpgol.js" ]; then
            package=gpgoljs
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
    gpgol.js|gpgoljs)
        repo=git://git.gnupg.org/gpgol.js.git
        package=gpgoljs
        ;;
    mimetreeparser | kleopatra | libkleo)
        repo=https://invent.kde.org/pim/${package}.git
        ;;
    okular)
        repo=https://invent.kde.org/graphics/${package}.git
        ;;
    poppler)
        repo=https://anongit.freedesktop.org/git/poppler/poppler.git
        #repo=https://gitlab.freedesktop.org/svuorela/${package}.git
        ;;
    breeze)
        url=https://download.kde.org/stable/plasma/6.5.4/breeze-6.5.4.tar.xz
        ;;
    kio)
        repo=https://invent.kde.org/frameworks/${package}.git
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
    gpgol.js|gpgoljs)
        ;;
    mimetreeparser)
#        branch="gpg4win/24.05"
        ;;
    kleopatra)
#        branch="gpg4win/24.05"
        add_version_file="yes"
        ;;
    libkleo)
#        branch="gpg4win/24.05"
        ;;
    okular)
  #      branch="work/sune/WORK"
        ;;
    poppler)
        #branch="WORK"
        ;;
    breeze)
#         branch=v6.5.4
        ;;
    kio)
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

olddir=$(pwd)
if [ "${is_gpg}" == "yes" ]; then
    git clone ${repo} ${tmpdir}/${snapshotdir}
    cd ${tmpdir}/${snapshotdir}
    ./autogen.sh --force >&2
    if [ "${is_w32}" == "yes" ]; then
        ./autogen.sh --build-w32 >&2
    else
        ./configure >&2
    fi
    make dist-xz >&2
    tarball=$(ls -t *.tar.xz | head -1)
    if [ "$update" != "no" ]; then
        find "${olddir}" -name ${package}\* -print0 | xargs -0 rm -f
    fi
    cp ${tmpdir}/${snapshotdir}/${tarball} ${olddir}
elif [ "${is_g10_cmake}" == "yes" ]; then
    git clone ${repo} ${tmpdir}/${snapshotdir}
    cd ${tmpdir}/${snapshotdir}
    mkdir build
    cd build
    cmake -DCONFIGURE_FOR_DISTRIBUTION=ON .. >&2
    make dist >&2
    tarball=$(ls -t *.tar.xz | head -1)
    cp ${tarball} ${olddir}
elif [ "${package}" == "breeze" ]; then
    # repackage the release package of breeze without the huge wallpapers and cursors
    cd ${tmpdir}
    git clone https://invent.kde.org/sysadmin/release-keyring.git
    mkdir gnupghome-release-keyring
    GNUPGHOME=$(pwd)/gnupghome-release-keyring gpg --import release-keyring/keys/*.asc
    GNUPGHOME=$(pwd)/gnupghome-release-keyring gpg --export >kde-release-keyring.kbx
    wget ${url} ${url}.sig
    tarball=$(basename ${url})
    gpgv --keyring $(pwd)/kde-release-keyring.kbx ${tarball}.sig ${tarball}
    tar xf ${tarball}
    archivename=${tarball%.tar.xz}
    rm -rf ${archivename}/cursors ${archivename}/wallpapers
    modifiedarchivename=${archivename}-g10
    mv ${archivename} ${modifiedarchivename}
    tarball=${modifiedarchivename}.tar.xz
    tar cfJ ${tarball} ${modifiedarchivename}
    cp ${tarball} ${olddir}
else
    git clone --depth=1 --branch $branch ${repo} ${tmpdir}/${snapshotdir}
    echo "$PGM: Archiving branch $branch."
    cd ${tmpdir}/${snapshotdir}
    extrafiles=""
    if [ "${add_version_file}" == "yes" ]; then
        # write empty line as first line in VERSION file because we don't have a useful version number
        echo >VERSION
        git rev-parse --verify HEAD >>VERSION
        extrafiles="--add-file=VERSION"
    fi
    git archive --format tar.xz --prefix=${snapshotdir}/ ${extrafiles} HEAD > ${tarball}
    if [ "$update" != "no" ]; then
        find "${olddir}" -name ${package}\* -print0 | xargs -0 rm -f
    fi
    cp ${tmpdir}/${snapshotdir}/${tarball} ${olddir}
fi
cd ${olddir}
checksum=$(sha256sum ${tarball} | cut -d ' ' -f 1)


cat > ${tmpdir}/snippet <<EOF
# ${package}
# last changed: ${curdate}
# by: $(echo ${EMAIL-$USER}|sed 's/@.*//')
# verified: Tarball created by $USER.
file ${package}/${tarball}
chk ${checksum}
EOF

perl -i -p0e "s@# ${package}\n# last changed:.*?\n# by:.*?\n# verified:.*?\nfile.*?\nchk.*?\n@'`cat ${tmpdir}/snippet`
'@se" packages.list

echo "------------------------------ >8 ------------------------------"
cat "${tmpdir}/snippet"
echo "------------------------------ >8 ------------------------------"
if [ "${autoupload}" = "yes" ]; then
    echo "$PGM: uploading to ${ftpuser_at}gnupg.net" >&2
    rsync -vP ${tarball} ${ftpuser_at}gnupg.net:/var/www/gnupg.net/snapshots/${package}/
else
    echo "$PGM: info: To upload:" >&2
    echo "rsync -vP ${tarball} gnupg.net:/var/www/gnupg.net/snapshots/${package}/" >&2
fi;
rm -fr ${tmpdir}
done

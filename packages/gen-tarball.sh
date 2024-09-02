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

PGM=gen-tarball.sh

set -e

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS]  PACKAGE ...
Generate a tarball from a repository.

Options:
        --auto                 Upload to ftp server
        -u|--update            Remove the old package locally
        --user=name            Use NAME as FTP server user
        --ignore-msgcat-error  Ignore errors from msgcat invocation

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
ignore_msgcat_errors="no"
update="no"
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
	--auto|-a)
	    autoupload=yes
	    ;;
        --user|--user=*)
            ftpuser_at="${optarg}@"
            ;;
        --ignore-msgcat-error)
            ignore_msgcat_errors=yes
            ;;
    --update|-u)
        update="yes"
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

if [  $# -eq 0 ]; then
    usage 1 1>&2
fi

for package in "$@"; do
shift

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
    gpg4win-tools )
        repo=git://git.gnupg.org/${package}.git
        ;;
    gpgpass )
        repo=git://git.gnupg.org/${package}.git
        ;;
    gpgol.js|gpgoljs)
        repo=git://git.gnupg.org/gpgol.js.git
        package=gpgoljs
        ;;
    mimetreeparser)
        repo=https://invent.kde.org/pim/${package}.git
        #branch="gpg4win/24.05"
        #custom_l10n="l10n-support/de/summit/messages/mimetreeparser/mimetreeparser6.po"
        ;;
    kleopatra)
        repo=https://invent.kde.org/pim/${package}.git
#        branch="gpg4win/24.05"
#        custom_l10n="l10n-support/de/summit/messages/kleopatra/kleopatra.po"
        ;;
    libkleo)
        repo=https://invent.kde.org/pim/${package}.git
#        branch="gpg4win/24.05"
#        custom_l10n="l10n-support/de/summit/messages/libkleo/libkleopatra6.po"
        ;;
    okular)
        repo=https://invent.kde.org/graphics/${package}.git
  #      branch="work/sune/WORK"
        ;;
    poppler)
        repo=https://anongit.freedesktop.org/git/poppler/poppler.git
        #repo=https://gitlab.freedesktop.org/svuorela/${package}.git
        #branch="WORK"
        ;;
    breeze)
        repo=https://invent.kde.org/plasma/${package}.git
        branch=v6.1.3
        ;;
    kio)
        repo=https://invent.kde.org/frameworks/${package}.git
        ;;
    ktextaddons)
        repo=https://invent.kde.org/libraries/${package}.git
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

git clone ${repo} ${tmpdir}/${snapshotdir}

if [ "${is_gpg}" == "yes" ]; then
    olddir=$(pwd)
    cd ${tmpdir}/${snapshotdir}
    ./autogen.sh --force >&2
    if [ "${is_w32}" == "yes" ]; then
        ./autogen.sh --build-w32 >&2
    else
        ./configure >&2
    fi
    make dist-xz >&2
    tarball=$(ls -t *.tar.xz | head -1)
    if [ "$update" == "yes" ]; then
        find "${olddir}" -name ${package}\* -print0 | xargs -0 rm -f
    fi
    cp ${tmpdir}/${snapshotdir}/${tarball} ${olddir}
    cd ${olddir}
else
    olddir=$(pwd)
    echo "$PGM: Archiving branch $branch."
    cd ${tmpdir}/${snapshotdir}
    git checkout $branch
    if [ "$custom_l10n" != "no" ]; then
        echo "$PGM: Downloading german translations from ${custom_l10n}"
        poname=${package}
        if [ "${package}" == "libkleo" ]; then
            poname="libkleopatra"
        fi
        svn export --force svn://anonsvn.kde.org/home/kde/trunk/${custom_l10n} \
            po/de/${poname}_summit.po
        if ! msgcat --use-first po/de/${poname}_summit.po \
             po/de/${poname}.po > po/de/${poname}_new.po ; then
          if [ "$ignore_msgcat_errors" = yes ]; then
              echo "$PGM: error from msgcat ignored on demand" >&2
          else
              exit 2
          fi
        fi
        mv po/de/${poname}_new.po po/de/${poname}.po
        git add po/de/${poname}.po
        git commit -m "Add latest German translation"
    fi
    if [ "${package}" == "breeze" ]; then
        git rm -r wallpapers cursors
        sed -i '/add_subdirectory(wallpapers)/d' CMakeLists.txt
        sed -i '/add_subdirectory(cursors)/d' CMakeLists.txt
        git commit -a -m "Escort the elephants out of the room"
    fi
    git archive --format tar.xz --prefix=${snapshotdir}/ HEAD > ${tarball}
    if [ "$update" == "yes" ]; then
        find "${olddir}" -name ${package}\* -print0 | xargs -0 rm -f
    fi
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

perl -i -p0e "s@# ${package}\n# last changed:.*?\n# by:.*?\n# verified:.*?\nfile.*?\nchk.*?\n@'`cat ${tmpdir}/snippet`
'@se" packages.common

echo "------------------------------ >8 ------------------------------"
cat "${tmpdir}/snippet"
echo "------------------------------ >8 ------------------------------"
if [ "${autoupload}" = "yes" ]; then
    echo "$PGM: uploading to ${ftpuser_at}trithemius.gnupg.org" >&2
    rsync -vP ${tarball} ${ftpuser_at}trithemius.gnupg.org:/home/ftp/gcrypt/snapshots/${package}/
else
    echo "$PGM: info: To upload:" >&2
    echo "rsync -vP ${tarball} trithemius.gnupg.org:/home/ftp/gcrypt/snapshots/${package}/" >&2
fi;
rm -fr ${tmpdir}
done

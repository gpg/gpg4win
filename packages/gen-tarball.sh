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
    echo "Usage: $0 PACKAGE > snippet"
    echo "where PACKAGE is either the name of a supported library or application, e.g. 'kleopatra',"
    echo "or the path of a local Git repository, e.g. '~/src/kleopatra',"
    echo "or the URL of a remote Git repository, e.g. 'https://invent.kde.org/pim/kleopatra.git'."
    exit 1
fi

package=$1
is_gpg="no"

case ${package} in
    */*)
        repo=${package%/}
        package=$(basename ${repo})
        package=${package%.git}
        ;;
    gnupg | gpgme | libassuan | libgcrypt | libgpg-error | libksba | npth | pinentry | gpg4win-tools | scute)
        repo=git://git.gnupg.org/${package}.git
        is_gpg="yes"
        ;;
    k* | libk*)
        # assume that package is provided by KDE
        repo=https://invent.kde.org/pim/${package}.git
        ;;
    *)
        echo "Error: Unsupported package '${package}'"
        exit 1
        ;;
esac

case ${package} in
    kleopatra)
        # pofiles="kleopatra.po kwatchgnupg.po"
        ;;
    libkleo)
        #pofiles="libkleopatra.po"
        ;;
    *)
        echo "Warning: No known translations for package '${package}'"
        ;;
esac

tmpdir=$(mktemp -d -t gen-tarball.XXXXXXXXXX)
curdate=$(date +%Y-%m-%d)
timestamp=$(date +%Y%m%d%H%M)
snapshotdir=${package}-${timestamp}
tarball=${snapshotdir}.tar.xz

git clone ${repo} ${tmpdir}/${snapshotdir}

# fetch the translations
if test -n "${pofiles}"; then
    echo "Fetching languages ..."
    languagesurl="https://websvn.kde.org/*checkout*/trunk/l10n-kf5/subdirs"
    # we have to pretend to be a browser to be able to retrieve the file
    languages=$(curl --silent --show-error --fail -H "User-Agent: Mozilla/5.0" "${languagesurl}" || true)
    if test -z "${languages}"; then
        echo "Warning: Downloading the list of languages from ${languagesurl} failed."
    fi
    echo "Fetching translations ..."
    for lang in ${languages}; do
        mkdir -p ${tmpdir}/${snapshotdir}/po/${lang}
        for pofile in ${pofiles}; do
            svn export --force \
                "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/${lang}/messages/${package}/${pofile}" \
                "${tmpdir}/${snapshotdir}/po/${lang}/${pofile}" \
            || echo "Info: $pofile not found in $lang"
        done
        # remove empty language folders
        rmdir --ignore-fail-on-non-empty ${tmpdir}/${snapshotdir}/po/${lang}
    done
fi

if [ -e ${tmpdir}/${snapshotdir}/po ]; then
    (cd ${tmpdir}/${snapshotdir} && git add po && git commit -m "Add po files")
fi

if [ "${is_gpg}" == "yes" ]; then
    olddir=$(pwd)
    cd ${tmpdir}/${snapshotdir}
    ./autogen.sh --force >&2
    ./configure >&2
    make -j`nproc` distcheck >&2
    make dist-xz >&2
    tarball=$(ls -t *.tar.xz | head -1)
    cp ${tmpdir}/${snapshotdir}/${tarball} ${olddir}
else
    (cd ${tmpdir}/${snapshotdir} && \
    git archive --format tar.xz --prefix=${snapshotdir} master) > ${tarball} || \
      (echo "Failed to archive tarball. Is tar.xz configured?: git config --global tar.tar.xz.command \"xz -c\"" && exit 1)
fi
checksum=$(sha256sum ${tarball} | cut -d ' ' -f 1)

echo "------------------------------ >8 ------------------------------"
echo "# ${package}"
echo "# last changed: ${curdate}"
echo "# by: $USER"
echo "# verified: Tarball created by $USER."
echo "file ${package}/${tarball}"
echo "chk ${checksum}"
echo "------------------------------ >8 ------------------------------"

echo "To upload:" >&2
echo "rsync -vP ${tarball} trithemius.gnupg.org:/home/ftp/gcrypt/snapshots/${package}/" >&2
rm -fr ${tmpdir}

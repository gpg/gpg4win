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
# the packages.common accordingly if the entry matches the exact pattern.
# For KDE this script also tries to integrate the translations even for
# custom / stable branches which do not fit the upstream translation
# workflow.

PGM=gen-tarball.sh

# Taken from the generated list which checked for languages
# in which more then 500 strings for Kleopatra were translated
translation_langs="bg bs ca cs da de el eo es et eu fi fr gl hu ia it ja km ko lv mk mr ms nb nds nl nn pl pt pt_BR ru sk sl sv tr uk zh_CN zh_TW"

set -e

FRONTEND_PKGS="
gpgme
libkleo
kleopatra
gpgol
gpgoljs
gpgpass
gpg4win-tools
mimetreeparser"

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
custom_l10n="no"
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
#        branch="gpg4win/24.05"
#        custom_l10n="mimetreeparser/mimetreeparser6.po"
        ;;
    kleopatra)
        repo=https://invent.kde.org/pim/${package}.git
#        branch="gpg4win/24.05"
#        custom_l10n="kleopatra/kleopatra.po"
        # When we are really far from upstream we might have strings
        # in our custom branch which are neither in summit nor in the
        # original branch. So they have to be manually extracted using
        # git://invent.kde.org/sysadmin/l10n-scripty/extract_messages.sh
        # and then merged and manually translated. "local_l10n"
        # allows us to cat these additional strings to the translations,
        # too.
        # Requires custom_l10n to be also set.
#        local_l10n="kleopatra-24.05-de-full-translation.po"
        ;;
    libkleo)
        repo=https://invent.kde.org/pim/${package}.git
#        branch="gpg4win/24.05"
#        custom_l10n="libkleo/libkleopatra6.po"
#        local_l10n="libkleopatra-24.05-de-full-translation.po"
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
    if [ "$update" != "no" ]; then
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
        for lang in $translation_langs; do
            if [ "$lang" = "de" ]; then
                # Sorry but the development team is german centric
                echo "##############################DE#######################################"
            fi
            echo "$PGM: Downloading $lang translations from svn."
            poname=${package}
            if [ "${package}" == "libkleo" ]; then
                poname="libkleopatra"
            fi
            # First integrate any additions from custom l10n
            if ! svn export --force svn://anonsvn.kde.org/home/kde/trunk/l10n-support/$lang/summit/messages/${custom_l10n} po/$lang/${poname}_main.po >/dev/null 2>&1; then
                if ! svn export --force svn://anonsvn.kde.org/home/kde/trunk/l10n-kf6/$lang/messages/${custom_l10n} po/$lang/${poname}_main.po >/dev/null 2>&1; then
                    echo "No translations for $package found in language $lang"
                    continue
                else
                    echo "Using l10n-kf6 for $lang"
                fi
            else
                echo "Using summit for $lang"
            fi
            if [ ! -e po/$lang/${poname}_main.po ]; then
                echo "failed to download the custom l10n file $custom_l10n for language $lang"
                continue
            fi

            echo "Adding translations to $lang with:"
            msgfmt --statistics po/$lang/${poname}_main.po
            if ! msgcat --use-first po/$lang/${poname}_main.po po/$lang/${poname}.po > po/$lang/${poname}_new.po ; then
                  echo "WARN: error from msgcat ignored" >&2
            fi
            # For german we go the extra mile to be 100% and add even
            # more local strings if this is required
            if [ "$lang" = "de" -a "$local_l10n" != "" ]; then
                echo "Adding local l10n file $local_l10n which contains:"
                msgfmt --statistics "$olddir/$local_l10n"
                if ! msgcat --use-first po/$lang/${poname}_new.po "$olddir/$local_l10n" > po/$lang/${poname}.po ; then
                  echo "WARN: error from msgcat ignored" >&2
                fi
            else
                mv po/$lang/${poname}_new.po po/$lang/${poname}.po
            fi
            echo "Final translation statistics for $lang: "
            msgfmt --statistics po/$lang/${poname}.po
            git add po/$lang/${poname}.po
            if [ "$lang" = "de" ]; then
                echo "#####################################################################"
            fi
        done
        git commit -m "Add latest translations"
    fi
    if [ "${package}" == "breeze" ]; then
        git rm -r wallpapers cursors
        sed -i '/add_subdirectory(wallpapers)/d' CMakeLists.txt
        sed -i '/add_subdirectory(cursors)/d' CMakeLists.txt
        git commit -a -m "Escort the elephants out of the room"
    fi
    git archive --format tar.xz --prefix=${snapshotdir}/ HEAD > ${tarball}
    if [ "$update" != "no" ]; then
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

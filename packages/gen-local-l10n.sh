#!/bin/bash
# Copyright (C) 2025 g10 Code GmbH
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

PGM=gen-local-l10n.sh

translation_langs="de fr ja"

set -e

usage()
{
    cat <<EOF
Usage: $PGM PACKAGE
Update the local translations file for a KDE project.

PACKAGE is either the name of a supported library or application,
e.g. 'kleopatra'.  Branches for packages are defined within this script.

EOF
    exit $1
}

branch="master"
custom_l10n="no"
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

if [  $# -ne 1 ]; then
    usage 1 1>&2
fi
package="$1"
shift

case ${package} in
    mimetreeparser)
        repo=https://invent.kde.org/pim/${package}.git
        branch="gpg4win/24.05"
        custom_l10n="mimetreeparser/mimetreeparser6.po"
        local_l10n='mimetreeparser-24.05-${lang}-full-translation.po'
        ;;
    kleopatra)
        repo=https://invent.kde.org/pim/${package}.git
        branch="gpg4win/24.05"
        custom_l10n="kleopatra/kleopatra.po"
        local_l10n='kleopatra-24.05-${lang}-full-translation.po'
        ;;
    libkleo)
        repo=https://invent.kde.org/pim/${package}.git
        branch="gpg4win/24.05"
        custom_l10n="libkleo/libkleopatra6.po"
        local_l10n='libkleopatra-24.05-${lang}-full-translation.po'
        ;;
    okular)
        repo=https://invent.kde.org/graphics/${package}.git
        branch="work/sune/WORK"
        ;;
    poppler)
        #repo=https://anongit.freedesktop.org/git/poppler/poppler.git
        repo=https://gitlab.freedesktop.org/svuorela/${package}.git
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

if [ "$custom_l10n" != "no" -a "$local_l10n" != "" ]; then
    echo "Updating local translations for branch $branch"
    git clone --depth=1 --branch $branch ${repo} ${tmpdir}/${snapshotdir}
    olddir=$(pwd)
    cd ${tmpdir}/${snapshotdir}
    echo "Extracting messages"
    # this script can be found in https://invent.kde.org/sysadmin/l10n-scripty ;
    # you will also need some of the scripts in https://invent.kde.org/sdk/kde-dev-scripts
    extract-messages.sh

    for lang in $translation_langs; do
        echo "#######################################################################"
        eval local_l10n_file="${local_l10n}"
        if [ -f "$olddir/$local_l10n_file" ]; then
            echo "Updating local l10n file for language $lang"
            echo "Statistics for local l10n file $local_l10n_file before the update:"
            msgfmt --statistics "$olddir/$local_l10n_file"
        else
            echo "Creating local l10n file for language $lang"
        fi

        echo "Downloading $lang translations from svn."
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
        # get rid of obsolete messages because msgcat --use-first would drop non-obsolete messages from
        # the package's po file that match obsolete messages from the *_main.po file
        if msgattrib --no-obsolete po/$lang/${poname}_main.po > po/$lang/${poname}_main_noobsolete.po ; then
            mv po/$lang/${poname}_main_noobsolete.po po/$lang/${poname}_main.po
        else
            echo "WARN: error from msgattrib ignored" >&2
        fi

        echo "Adding translations to $lang with:"
        msgfmt --statistics po/$lang/${poname}_main.po
        if ! msgcat --use-first po/$lang/${poname}_main.po po/$lang/${poname}.po > po/$lang/${poname}_new.po ; then
                echo "WARN: error from msgcat ignored" >&2
        fi
        # add the local strings
        if [ -f "$olddir/$local_l10n_file" ]; then
            # get rid of obsolete messages because msgcat --use-first would drop non-obsolete messages from
            # the local_l10n file that match obsolete messages from the *_new.po file
            if msgattrib --no-obsolete po/$lang/${poname}_new.po > po/$lang/${poname}_new_noobsolete.po ; then
                mv po/$lang/${poname}_new_noobsolete.po po/$lang/${poname}_new.po
            else
                echo "WARN: error from msgattrib ignored" >&2
            fi
            echo "Adding local l10n file $local_l10n_file which contains:"
            msgfmt --statistics "$olddir/$local_l10n_file"
            if ! msgcat --use-first po/$lang/${poname}_new.po "$olddir/$local_l10n_file" > po/$lang/${poname}.po ; then
                echo "WARN: error from msgcat ignored" >&2
            fi
        else
            mv po/$lang/${poname}_new.po po/$lang/${poname}.po
        fi

        echo "Merging updated translations with extracted messages"
        msgmerge --previous -o po/$lang/${poname}.po po/$lang/${poname}.po po/${poname}.pot
        # get rid of obsolete messages because msgcat --use-first would drop non-obsolete messages from
        # the second file that match obsolete messages from the first file
        if msgattrib --no-obsolete po/$lang/${poname}.po > po/$lang/${poname}_noobsolete.po ; then
            mv po/$lang/${poname}_noobsolete.po po/$lang/${poname}.po
        else
            echo "WARN: error from msgattrib ignored" >&2
        fi
        cp po/$lang/${poname}.po "$olddir/$local_l10n_file"

        echo "Statistics for local l10n file $local_l10n_file after the update:"
        msgfmt --statistics "$olddir/$local_l10n_file"
    done
    cd ${olddir}
    rm -fr ${tmpdir}
else
    echo "Error: No local l10n file defined for ${package}"
fi

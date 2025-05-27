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

# Extracts translated messages of a KDE project and merges the latest
# translations from KDE.

PGM=update-po-files.sh

# Taken from the generated list which checked for languages
# in which more then 500 strings for Kleopatra were translated
translation_langs="bg bs ca cs da de el eo es et eu fi fr gl hu ia it ja km ko lv mk mr ms nb nds nl nn pl pt pt_BR ru sk sl sv tr uk zh_CN zh_TW"

set -e

usage()
{
    cat <<EOF
Usage: $PGM PATH
Update the translation files of a KDE project.

PATH is the path of a local Git repository. The basename must
match the name of the KDE project.

EOF
    exit $1
}

branch="gpg4win/24.05"
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
repo_path="$1"
repo_path=${repo_path%/}
shift

if [ ! -e ${repo_path}/.git ]; then
    echo "Error: '${repo_path}' is not a local git repository." >&2
    usage 1 1>&2
fi

package=$(basename ${repo_path})

case ${package} in
    mimetreeparser)
        custom_l10n="mimetreeparser/mimetreeparser6.po"
        ;;
    kleopatra)
        custom_l10n="kleopatra/kleopatra.po"
        ;;
    libkleo)
        custom_l10n="libkleo/libkleopatra6.po"
        ;;
    *)
        echo "$PGM: error: Unsupported package '${package}'"
        exit 1
        ;;
esac

olddir=$(pwd)
echo "$PGM: Updating translation files."
cd ${repo_path}

echo "Extracting messages..."
# this script can be found in https://invent.kde.org/sysadmin/l10n-scripty ;
# you will also need some of the scripts in https://invent.kde.org/sdk/kde-dev-scripts
extract-messages.sh

statsfile=$(mktemp)

for lang in $translation_langs; do
    poname=${package}
    if [ "${poname}" == "libkleo" ]; then
        poname="libkleopatra"
    fi
    if [ "$lang" = "de" ]; then
        # the development team is German
        echo "##############################DE#######################################"
    fi
    echo "Updating ${poname}.po for language $lang"
    if [ ! -e po/$lang/${poname}.po ]; then
        echo "WARN: po/$lang/${poname}.po does not exist. Skipping."
        continue
    fi
    if [ "$lang" = "de" -o "$lang" = "fr" -o "$lang" = "ja" ]; then
        echo "Statistics for po/$lang/${poname}.po before the update:" | tee -a ${statsfile}
        msgfmt --statistics po/$lang/${poname}.po 2>&1 | tee -a ${statsfile}
    else
        echo "Statistics for po/$lang/${poname}.po before the update:"
        msgfmt --statistics po/$lang/${poname}.po
    fi

    echo "$PGM: Downloading $lang translations from svn."
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
    rm po/$lang/${poname}_main.po
    mv po/$lang/${poname}_new.po po/$lang/${poname}.po

    echo "Merging updated translations with extracted messages"
    msgmerge --previous -o po/$lang/${poname}.po po/$lang/${poname}.po po/${poname}.pot
    # get rid of obsolete messages
    if msgattrib --no-obsolete po/$lang/${poname}.po > po/$lang/${poname}_noobsolete.po ; then
        mv po/$lang/${poname}_noobsolete.po po/$lang/${poname}.po
    else
        echo "WARN: error from msgattrib ignored" >&2
    fi

    if [ "$lang" = "de" -o "$lang" = "fr" -o "$lang" = "ja" ]; then
        echo "Statistics for po/$lang/${poname}.po after the update:" | tee -a ${statsfile}
        msgfmt --statistics po/$lang/${poname}.po 2>&1 | tee -a ${statsfile}
        echo "---" >>${statsfile}
    else
        echo "Statistics for po/$lang/${poname}.po after the update:"
        msgfmt --statistics po/$lang/${poname}.po
    fi

    git add po/$lang/${poname}.po
    if [ "$lang" = "de" ]; then
        echo "#####################################################################"
    fi
done

rm po/${poname}.pot
rm -f messages.mo

echo "#####################################################################"
cat ${statsfile}
rm ${statsfile}
cd ${olddir}

# findicons.sh - Find icons for Gpg4win.
# Copyright (C) 2023 g10 Code GmbH
#
# This file is part of Gpg4win.
#
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA


# This is pretty much a brute force approach to find the icons which
# might be called from our UI apps. So anything that does QIcon::fromTheme
# is included and for Pagedialogs also the addPage.

# First we grab all the breeze icons
ICONS=$(find /usr/share/icons/breeze -name \*.svg | \
        sed 's@/usr/share/icons/breeze/.*/@@' | sed 's@.svg@@' | \
        sort -u)

# And then look through the packages which might use them
PACKAGES="kleopatra
    okular
    poppler
    mimetreeparser
    libkleo
    gpg4win-tools
    kwidgetsaddons
    kcompletion
    kwindowsystem
    kcoreaddons
    kcodecs
    kconfigwidgets
    kxmlgui
    kguiaddons
    kitemviews
    kitemmodels
    kiconthemes
    karchive
    kio
    kbookmarks
    kservice
    solid
    kjobwidgets
    kparts
    ktextwidgets
    sonnet
    kcalendarcore
    kmime"



for pkg in $PACKAGES; do
    sdirs=$(ls playground/build | grep $pkg | grep -v build)
    for dir in $sdirs; do
        sdir=playground/build/$dir
        if ! grep -r -m 1 -q QIcon $sdir; then
            echo "skipping $dir no QIcon"
            continue
        fi
        echo "########## searching in $dir #########";
        for icon in $ICONS; do
            if grep -m 1 -q -r QIcon::fromTheme.\*\(\"$icon $sdir ||
               grep -m 1 -q -r addPage.\*\(\"$icon $sdir; then
                if grep -q $icon included-icons.txt; then
                    # Shows some progress :)
                    echo "$icon already included"
                else
                    echo "Found new icon $icon"
                    echo $icon >> included-icons.txt
                fi
            fi
        done
    done
done

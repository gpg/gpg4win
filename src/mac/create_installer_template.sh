#!/bin/sh
# create_installer_template.sh - create a simple styled installer .dmg template
#
# Copyright (C) 2026 g10 Code GmbH
#
# Software engineering by Thomas Friedrichsmeier <thomas.friedrichsmeier@gnupg.com>
# Many concepts taken from the much more elabort "create-dmg" script (MIT license).
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
# along with this program; if not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-2.0+
set -e

scriptdir=$(dirname "$0")
volumename="$1"

imagefile="${scriptdir}/${volumename}.template.dmg"
preimage="${imagefile}.pre.dmg"
tmpsrc="$TMPDIR/templatesrc"
mountpoint="/Volumes/${volumename}"

rm -rf "${tmpsrc}"
mkdir -p "${tmpsrc}"
#mkdir -p "${mountpoint}"
mkdir -p "${tmpsrc}/${volumename}.app"
mkdir -p "${tmpsrc}/.background"
cp ${scriptdir}/arrow.png "${tmpsrc}/.background/arrow.png"
ln -s /Applications/ "${tmpsrc}/Applications"

rm -f "${preimage}" "${imagefile}"
hdiutil create -fs HFSX -layout SPUD -size 1000000k "${preimage}" -srcfolder "${tmpsrc}" -format UDRW -volname "${volumename}"
hdiutil attach "${preimage}" -mountpoint "${mountpoint}"

/usr/bin/osascript -e "
on run (volumeName)
    tell application \"Finder\"
        tell disk (volumeName as string)
            open

            set opts to the icon view options of container window
            tell opts
                set icon size to 90
                set text size to 16
                set arrangement to not arranged
            end tell
            set background picture of opts to file \".background:arrow.png\"

            set wWidth to 450
            set wHeight to 100
            tell container window
                    set current view to icon view
                    set toolbar visible to false
                    set statusbar visible to false
                    set the bounds to {200, 200, 200+wWidth, 200+wHeight}
                    set statusbar visible to false
            end tell

            close
            open

            set position of item \"Applications\" to {280, 70}
            set position of item \"${volumename}.app\" to {80, 70}
            set position of item \".background:arrow.png\" to {600, 600}

            update without registering applications
            delay 1
        end tell
    end tell
end run" "${volumename}"

while [ ! -f "${mountpoint}/.DS_Store" ] ; do
    echo "Waiting for ${mountpoint}/.DS_Store"
    sleep 1
done

hdiutil detach "${mountpoint}"
rm -r "${tmpsrc}"
hdiutil convert -format UDZO -imagekey zlib-level=9 -o "${imagefile}" "${preimage}"
rm "${preimage}"
echo "Installer template generated at ${imagefile}. Note that you may apply additional manual styling."

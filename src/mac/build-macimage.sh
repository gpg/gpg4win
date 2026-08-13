#!/bin/sh
# Build a MacOS Image of GnuPG (VS-)Desktop
# Copyright (C) 2021, 2024, 2026 g10 Code GmbH
#
# Software engineering by: Ingo Klöcker <dev@ingo-kloecker.de>
#                          Andre Heinecke <aheinecke@gnupg.org>
# This file is part of GnuPG.
#
# GnuPG is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# GnuPG is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-3.0+

set -e

BUILDROOT=/build
SRCDIR=/src
INSTDIR=${BUILDROOT}/install
TARGETIMAGENAME=Kleopatra

# Check for the buildtype and existence of required files
# early
BUILDTYPE=$(cat ${SRCDIR}/packages/BUILDTYPE || echo default)
if [ $BUILDTYPE != default ] && [ ! -f ${VSD_DIR}/custom.mk ]; then
    echo "ERROR: Non default build without custom file."
    echo "Check that ${VSD_DIR}/custom.mk exists or "
    echo "change the BUILDTYPE in ${SRCDIR}/packages/BUILDTYPE"
    exit 2
fi

# The actual build
cd ${BUILDROOT}
PATH=/opt/homebrew/opt/bison/bin:$PATH
PATH=/opt/homebrew/opt/cmake/bin:$PATH
PATH=/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
${SRCDIR}/configure --enable-macimage --with-playground=${BUILDROOT}
cd ${BUILDROOT}
make TOPSRCDIR=${SRCDIR} PLAYGROUND=${BUILDROOT} TARGETIMAGENAME=${TARGETIMAGENAME}

# TODO: write and sign version file (see appimage scripts)
python3 ${SRCDIR}/src/mac/bundle.py "${INSTDIR}" ${IMAGENAME} "${BUILDROOT}/${TARGETIMAGENAME}.dmg"

echo ready
exit 0

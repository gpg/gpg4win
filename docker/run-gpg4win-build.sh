#! /bin/bash
# Build Windows installers of GnuPG (VS-)Desktop using a Debian-based container
# Copyright (C) 2022 g10 Code GmbH
#
# Software engineering by Ingo Klöcker <dev@ingo-kloecker.de>
#
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

set -ex

if [ "$1" = "--devel" ]; then
    devmode=
else
    devmode="/build/gpg4win/src/build-gpg4win.sh"
fi

sourcedir=$(cd $(dirname $0)/..; pwd)

if [ -z "$devmode" ]; then
    buildroot="${GPG4WIN_BUILDROOT:-/tmp/gpg4win-bullseye.$(id -un).d}"
    [ -d "$buildroot" ] || mkdir "$buildroot"
else
    buildroot=$(mktemp -d --tmpdir gpg4win-bullseye.XXXXXXXXXX)
fi
echo Using ${buildroot}

# make a local clone of gpg4win to keep the working copy clean
cd ${buildroot}
if test ! -d ${buildroot}/gpg4win; then
    git clone ${sourcedir}
fi

docker run -it --rm --user "$(id -u):$(id -g)" \
    --volume ${buildroot}:/build \
    g10-build-gpg4win:bullseye $devmode

echo "You can find the installers in ${buildroot}/gpg4win/src/installers (if the build succeeded)."

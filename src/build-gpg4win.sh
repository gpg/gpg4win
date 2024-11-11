#!/bin/sh
# Build Windows installers of GnuPG (VS-)Desktop
# Copyright (C) 2024 g10 Code GmbH
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
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

PGM=build-gpg4win.sh

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS]
Helper to build Gpg4win in a docker containter.
Called by build.sh

Options:
        --dirty         Include uncommited changes
        --build-w32     Build 32 bit Windows version
        --build-w64     Build 64 bit Windows version
EOF
    exit $1
}




dirty="no"
buildw64="--build-w32"
skipshift=
while [ $# -gt 0 ]; do
    case "$1" in
        --dirty) dirty="yes";;
        --build-w32) buildw64="--build-w64";;
        --build-w64) buildw64="--build-w32";;
        --*) usage 1 1>&2; exit 1;;
        *) skipshift=1; break ;;
    esac
    [ -z "$skipshift" ] && shift
done

gpg4win_root=$(cd $(dirname $0)/..; pwd)

if [ $dirty = no ]; then
  cd ${gpg4win_root}/packages
  ./download.sh
fi

cd ${gpg4win_root}
./autogen.sh
if [ $# -gt 0 ]; then
    ./autogen.sh "$@"
else
    ./autogen.sh $buildw32
fi
make

#!/bin/sh
# Build an AppImage of Kleopatra
# Copyright (C) 2021 g10 Code GmbH
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

set -e

source /opt/rh/devtoolset-7/enable

cd /src/packages
./download.sh

cd /src
./configure --enable-appimage --enable-maintainer-mode --disable-manuals

cd /src
make

echo 'rootdir = $APPDIR/usr' >/build/AppDir/usr/bin/gpgconf.ctl

export PATH=/opt/linuxdeploy/usr/bin:$PATH
export LD_LIBRARY_PATH=/build/AppDir/usr/lib

# tell the linuxdeploy qt-plugin where to find qmake
export QMAKE=/build/AppDir/usr/bin/qmake

# create plugin directories expected by linuxdeploy qt-plugin
# workaround for
# [qt/stdout] Deploy[qt/stderr] terminate called after throwing an instance of 'boost::filesystem::filesystem_error'
# [qt/stderr]   what():  boost::filesystem::directory_iterator::construct: No such file or directory: "/build/AppDir/usr/plugins/printsupport"
# ERROR: Failed to run plugin: qt (exit code: 6)
mkdir -p /build/AppDir/usr/plugins/{printsupport,sqldrivers}

cd /build
# remove existing wrapped AppRun, that may be left over from a previous run of
# linuxdeploy, to ensure that our custom AppRun is deployed
rm -f /build/AppDir/AppRun.wrapped
linuxdeploy --appdir /build/AppDir \
            --desktop-file /build/AppDir/usr/share/applications/org.kde.kleopatra.desktop \
            --icon-file /build/AppDir/usr/share/icons/hicolor/256x256/apps/kleopatra.png \
            --custom-apprun /src/src/appimage/AppRun \
            --plugin qt \
            --output appimage \
    2>&1 | tee /build/logs/linuxdeploy-kleopatra.log

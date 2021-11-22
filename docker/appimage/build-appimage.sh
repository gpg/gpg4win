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

if [ -f /src/src/gnupg-vsd/custom.mk ]; then
    GNUPG_BUILD_VSD=yes
else
    GNUPG_BUILD_VSD=no
fi
export GNUPG_BUILD_VSD

echo 'rootdir = $APPDIR/usr' >/build/AppDir/usr/bin/gpgconf.ctl
if [ $GNUPG_BUILD_VSD = yes ]; then
    echo 'sysconfdir = /etc/gnupg-vsd' >>/build/AppDir/usr/bin/gpgconf.ctl
else
    echo 'sysconfdir = /etc/gnupg' >>/build/AppDir/usr/bin/gpgconf.ctl
fi

# Copy the start-shell helper for use AppRun
cp /src/src/appimage/start-shell /build/AppDir/
chmod +x /build/AppDir/start-shell

# Copy standard global configuration
if [ $GNUPG_BUILD_VSD = yes ]; then
    mkdir -p /build/AppDir/usr/share/gnupg/conf/gnupg-vsd
    rsync -av --delete --omit-dir-times \
          /src/src/gnupg-vsd/Standard/etc/gnupg/ \
          /build/AppDir/usr/share/gnupg/conf/gnupg-vsd/
fi

export PATH=/opt/linuxdeploy/usr/bin:$PATH
export LD_LIBRARY_PATH=/build/install/lib

# tell the linuxdeploy qt-plugin where to find qmake
export QMAKE=/build/install/bin/qmake

# create plugin directories expected by linuxdeploy qt-plugin
# workaround for
# [qt/stdout] Deploy[qt/stderr] terminate called after throwing an instance of 'boost::filesystem::filesystem_error'
# [qt/stderr]   what():  boost::filesystem::directory_iterator::construct: No such file or directory: "/build/AppDir/usr/plugins/sqldrivers"
# ERROR: Failed to run plugin: qt (exit code: 6)
mkdir -p /build/install/plugins/sqldrivers

# copy KDE plugins
for d in iconengines kf5 pim; do
    mkdir -p /build/AppDir/usr/plugins/${d}/
    rsync -av --delete --omit-dir-times /build/install/lib64/plugins/${d}/ /build/AppDir/usr/plugins/${d}/
done

cd /build
# Remove existing AppRun and wrapped AppRun, that may be left over
# from a previous run of linuxdeploy, to ensure that our custom AppRun
# is deployed
rm -f /build/AppDir/AppRun /build/AppDir/AppRun.wrapped 2>/dev/null
# Remove existing translations that may be left over from a previous
# run of linuxdeploy
rm -rf /build/AppDir/usr/translations
# Remove the version files to make sure that only one will be created.
rm -f /build/AppDir/GnuPG-VS-Desktop-VERSION 2>/dev/null
rm -f /build/AppDir/GnuPG-Desktop-VERSION    2>/dev/null

# Extract gnupg version or (for VSD builds) gpg4win version for use
# as filename of the AppImage
if [ $GNUPG_BUILD_VSD = yes ]; then
    myversion=$(grep PACKAGE_VERSION /src/config.h|sed -n 's/.*"\(.*\)"$/\1/p')
    OUTPUT=gnupg-vs-desktop-${myversion}-x86_64.AppImage
    echo $myversion >/build/AppDir/GnuPG-VS-Desktop-VERSION
else
    myversion=$(ls gnupg/gnupg-2.*tar /src/packages \
                    | sed -n 's,.*/gnupg-\(2.*\).tar.*,\1,p')
    OUTPUT=gnupg-desktop-${myversion}-x86_64.AppImage
    echo $myversion >/build/AppDir/GnuPG-Desktop-VERSION
fi
export OUTPUT

linuxdeploy --appdir /build/AppDir \
            --desktop-file /build/AppDir/usr/share/applications/org.kde.kleopatra.desktop \
            --icon-file /build/AppDir/usr/share/icons/hicolor/256x256/apps/kleopatra.png \
            --custom-apprun /src/src/appimage/AppRun \
            --plugin qt \
            --output appimage \
    2>&1 | tee /build/logs/linuxdeploy-gnupg-desktop.log

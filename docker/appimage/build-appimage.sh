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
export LD_LIBRARY_PATH=/build/install/lib

# tell the linuxdeploy qt-plugin where to find qmake
export QMAKE=/build/install/bin/qmake

# create plugin directories expected by linuxdeploy qt-plugin
# workaround for
# [qt/stdout] Deploy[qt/stderr] terminate called after throwing an instance of 'boost::filesystem::filesystem_error'
# [qt/stderr]   what():  boost::filesystem::directory_iterator::construct: No such file or directory: "/build/AppDir/usr/plugins/printsupport"
# ERROR: Failed to run plugin: qt (exit code: 6)
mkdir -p /build/install/plugins/{printsupport,sqldrivers}

# copy KDE plugins
for d in iconengines kf5 pim; do
    mkdir -p /build/AppDir/usr/plugins/${d}/
    rsync -av --delete --omit-dir-times /build/install/lib64/plugins/${d}/ /build/AppDir/usr/plugins/${d}/
done

cd /build
# remove existing AppRun and wrapped AppRun, that may be left over from a previous run of
# linuxdeploy, to ensure that our custom AppRun is deployed
rm -f /build/AppDir/AppRun /build/AppDir/AppRun.wrapped
# copy the translations of qtscript, qtmultimedia and qtxmlpatterns; we do not use those
# Qt modules, but Kleopatra (via ki18n) loads the qt_ meta catalog which depends on
# the catalogs of qtbase and the above three modules for most languages; loading the
# Qt translations fails if any of those catalogs are missing; linuxdeploy automatically
# includes the catalogs of the modules we use, but as we do not use the other three
# we have to copy them ourselves
# as a side effect linuxdeploy will create bogus symlinks from
# /build/AppDir/usr/share/locale/*/LC_MESSAGES/kfoo5_qt.qm to
# /build/AppDir/usr/translations/kfoo5_qt.qm
# (note the missing language id in the symlinks) which obviously makes no sense;
# luckily, this does not seem to cause problems
rsync -av /build/install/translations/qtscript_* /build/AppDir/usr/translations/
rsync -av /build/install/translations/qtmultimedia_* /build/AppDir/usr/translations/
rsync -av /build/install/translations/qtxmlpatterns_*.qm /build/AppDir/usr/translations/
linuxdeploy --appdir /build/AppDir \
            --desktop-file /build/AppDir/usr/share/applications/org.kde.kleopatra.desktop \
            --icon-file /build/AppDir/usr/share/icons/hicolor/256x256/apps/kleopatra.png \
            --custom-apprun /src/src/appimage/AppRun \
            --plugin qt \
            --output appimage \
    2>&1 | tee /build/logs/linuxdeploy-kleopatra.log

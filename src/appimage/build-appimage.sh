#!/bin/sh
# Build an AppImage of GnuPG (VS-)Desktop
# Copyright (C) 2021, 2024 g10 Code GmbH
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
APPDIR=${BUILDROOT}/AppDir
INSTDIR=${BUILDROOT}/install
VSD_DIR=${SRCDIR}/src/gnupg-vsd

# Check for the buildtype and existence of required files
# early
BUILDTYPE=$(cat ${SRCDIR}/packages/BUILDTYPE || echo default)
if [ $BUILDTYPE != default ] && [ ! -f ${VSD_DIR}/custom.mk ]; then
    echo "ERROR: Non default build without custom file."
    echo "Check that ${VSD_DIR}/custom.mk exists or "
    echo "change the BUILDTYPE in ${SRCDIR}/packages/BUILDTYPE"
    exit 2
fi
if [ $BUILDTYPE = vsd ] && \
    [ ! -f ${VSD_DIR}/Standard/VERSION ]; then
    echo "No VERSION file in Standard dir."
    exit 2
fi
if [ $BUILDTYPE = gpd ] && \
    [ ! -f ${VSD_DIR}/Desktop/VERSION ]; then
    echo "No VERSION file in Desktop dir."
    exit 2
fi

# The actual build
cd ${BUILDROOT}
${SRCDIR}/configure --enable-appimage --with-playground=${BUILDROOT}
make TOPSRCDIR=${SRCDIR} PLAYGROUND=${BUILDROOT}

echo 'rootdir = $APPDIR/usr' >${APPDIR}/usr/bin/gpgconf.ctl
if [ $BUILDTYPE = vsd ]; then
    echo 'sysconfdir = /etc/gnupg-vsd' >>${APPDIR}/usr/bin/gpgconf.ctl
else
    echo 'sysconfdir = /etc/gnupg' >>${APPDIR}/usr/bin/gpgconf.ctl
fi

# Copy the start-shell helper for use AppRun
cp ${SRCDIR}/src/appimage/start-shell ${APPDIR}/
chmod +x ${APPDIR}/start-shell

# Copy standard global configuration
if [ $BUILDTYPE = vsd ]; then
    mkdir -p ${APPDIR}/usr/share/gnupg/conf/gnupg-vsd
    rsync -aLv --delete --omit-dir-times \
          ${VSD_DIR}/Standard/etc/gnupg/ \
          ${APPDIR}/usr/share/gnupg/conf/gnupg-vsd/
fi

export PATH=/opt/linuxdeploy/usr/bin:$PATH
export LD_LIBRARY_PATH=${INSTDIR}/lib:${INSTDIR}/lib64

# tell the linuxdeploy qt-plugin where to find qmake
export QMAKE=${INSTDIR}/bin/qmake

# create plugin directories expected by linuxdeploy qt-plugin
# workaround for
# [qt/stdout] Deploy[qt/stderr] terminate called after throwing an instance of 'boost::filesystem::filesystem_error'
# [qt/stderr]   what():  boost::filesystem::directory_iterator::construct: No such file or directory: "/build/AppDir/usr/plugins/sqldrivers"
# ERROR: Failed to run plugin: qt (exit code: 6)
mkdir -p ${INSTDIR}/plugins/sqldrivers

# copy KDE plugins to ${APPDIR}/usr/lib/plugins/
# copying the plugins to a subfolder of ${APPDIR}/usr/lib (instead of to
# ${APPDIR}/usr/plugins/ as linuxdeploy does for the Qt plugins) ensures that
# linuxdeploy copies the dependencies of the plugins to APPDIR so that
# we don't have to take care of this ourselves
mkdir -p ${APPDIR}/usr/lib/plugins
for d in kf6 kiconthemes6 styles; do
    rsync -av --delete --omit-dir-times ${INSTDIR}/lib64/plugins/${d}/ ${APPDIR}/usr/lib/plugins/${d}/
done
rsync -av --delete --omit-dir-times ${INSTDIR}/lib64/plugins/okular_generators/okularGenerator_poppler.so ${APPDIR}/usr/lib/plugins/okular_generators/

cd /build
# Remove existing AppRun and wrapped AppRun, that may be left over
# from a previous run of linuxdeploy, to ensure that our custom AppRun
# is deployed
rm -f ${APPDIR}/AppRun ${APPDIR}/AppRun.wrapped 2>/dev/null
# Remove existing translations that may be left over from a previous
# run of linuxdeploy
rm -rf ${APPDIR}/usr/translations
# Remove the version files to make sure that only one will be created.
rm -f ${APPDIR}/GnuPG-VS-Desktop-VERSION 2>/dev/null
rm -f ${APPDIR}/GnuPG-Desktop-VERSION    2>/dev/null
rm -f ${APPDIR}/Gpg4win-VERSION        2>/dev/null

myversion=$(grep PACKAGE_VERSION ${BUILDROOT}/config.h|sed -n 's/.*"\(.*\)"$/\1/p')
if [ $BUILDTYPE = vsd ]; then
    OUTPUT=gnupg-vs-desktop-${myversion}-x86_64.AppImage
    echo "Packaging GnuPG VS-Desktop Appimage: $myversion"
    echo $myversion >${APPDIR}/GnuPG-VS-Desktop-VERSION
    cp ${VSD_DIR}/Standard/VERSION* ${APPDIR}/usr/
    echo "Packaging help files"
    mkdir -p ${APPDIR}/usr/share/doc/gnupg-vsd
    cp ${VSD_DIR}/help/*.pdf ${APPDIR}/usr/share/doc/gnupg-vsd
    if [ -f ${VSD_DIR}/Standard/kleopatrarc ]; then
        echo "Packaging kleopatrarc"
        mkdir -p ${APPDIR}/usr/etc/xdg
        cp ${VSD_DIR}/Standard/kleopatrarc ${APPDIR}/usr/etc/xdg
    fi
elif [ $BUILDTYPE = gpd ]; then
    OUTPUT=gnupg-desktop-${myversion}-x86_64.AppImage
    echo "Packaging GnuPG Desktop Appimage: $myversion"
    echo $myversion >${APPDIR}/GnuPG-Desktop-VERSION
    cp ${VSD_DIR}/Desktop/VERSION* ${APPDIR}/usr/
    echo "Packaging help files"
    mkdir -p ${APPDIR}/usr/share/doc/gnupg-vsd
    cp ${VSD_DIR}/help/*.pdf ${APPDIR}/usr/share/doc/gnupg-vsd
    if [ -f ${VSD_DIR}/Desktop/kleopatrarc ]; then
        echo "Packaging kleopatrarc"
        mkdir -p ${APPDIR}/usr/etc/xdg
        cp ${VSD_DIR}/Desktop/kleopatrarc ${APPDIR}/usr/etc/xdg
    fi
else
    OUTPUT=gpg4win-${myversion}-x86_64.AppImage
    echo "Packaging Gpg4win Appimage: $myversion"
    echo $myversion >${APPDIR}/Gpg4win-VERSION
fi
export OUTPUT

# Hack around that linuxdeploy does not know libexec
for f in dirmngr_ldap gpg-check-pattern \
         gpg-preset-passphrase gpg-protect-tool \
         gpg-wks-client scdaemon \
         keyboxd gpg-pair-tool; do
# Ignore errors because some files might not exist depending
# on GnuPG Version
    /opt/linuxdeploy/usr/bin/patchelf --debug \
              --set-rpath '$ORIGIN/../lib' ${APPDIR}/usr/libexec/$f || true
done

# linuxdeploy also doesn't know about non-Qt plugins
for f in $(find ${APPDIR}/usr/lib/plugins/ -mindepth 2 -maxdepth 2 -type f); do
    /opt/linuxdeploy/usr/bin/patchelf --debug --set-rpath '$ORIGIN/../..' $f
done
for f in $(find ${APPDIR}/usr/lib/plugins/ -mindepth 3 -maxdepth 3 -type f); do
    /opt/linuxdeploy/usr/bin/patchelf --debug --set-rpath '$ORIGIN/../../..' $f
done
for f in $(find ${APPDIR}/usr/lib/plugins/ -mindepth 4 -maxdepth 4 -type f); do
    /opt/linuxdeploy/usr/bin/patchelf --debug --set-rpath '$ORIGIN/../../../..' $f
done

# Fix up everything and build the file system
linuxdeploy --appdir ${APPDIR} \
            --desktop-file ${APPDIR}/usr/share/applications/org.kde.kleopatra.desktop \
            --icon-file ${APPDIR}/usr/share/icons/hicolor/256x256/apps/kleopatra.png \
            --custom-apprun ${SRCDIR}/src/appimage/AppRun \
            --plugin qt \
            --output appimage \
    2>&1 | tee /build/logs/linuxdeploy-gnupg-desktop.log

echo ready
exit 0

#!/bin/bash
# Copyright (C) 2024-2026 g10 Code GmbH
#
# Software engineering by Andre Heinecke <aheinecke@gnupg.org>
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
# SPDX-License-Identifier: GPL-2.0-or-later

set -e

PGM=build.sh

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS]
Build Gpg4win in a docker containter.

Options:
        --appimage      Build the AppImage instead of the NSIS installer.
        --w32           Use 32 bit Windows as primary host arch
        --clean         Remove a pre-existing build directory
        --dist          Create a distributable tarball
        --release       Create a tarball and then build this tarball
        --shell         Start a shell instead of starting the build script
        --builddir=DIR  Directory where the build should take place
                        (default is ~/b/SRCDIRNAME-playground for gpg4win,
                         ~/b/SRCDIRNAME-appimage for the AppImage, and
                         ~/b/SRCDIRNAME-mill for release builds)
        --logfile=FILE  Change default build log file to FILE
                        Unavailabe for --release builds
        --force         Force configure run
        --no-sign       Do not authenticode sign packages
        --update-image  Update the docker image before build
        --msi           Building MSI packages
                        Also assumes --w32 if BUILDTYPE is vsd3
        --user=name     Use NAME as FTP server user
        --download      Download packages first
        --runcmd CMD    Run a command via a pair of FIFOs
        --git-pkgs      Use latest git versions for the frontend
                        packages:
                        libkleo kleopatra gpgol gpgol.js
                        gpgpass gpg4win-tools mimetreeparser
        --signkey       OpenPGP key ID for signing an AppImage
                        Overwrites VERSION_SIGNKEY of ~/.gnupg-autogen.rc
                        Only used if BUILDTYPE is vsd, vsd3 or gpd
        --verbose       Get more verbose output


qThis script is used to build either the Appimage or the Windows
installer.  The build is done in a suffixed build directory (see above
for the defaults).  Use the option --builddir to use a non-default build
directory.  Take care not to use the source directory for building.

Examples:
    ./$PGM
        Build in the default build directory ~/b/SRCDIRNAME-playground

    ./$PGM --builddir=/foo/bar/my-playground
        Build in the given directory.
EOF
    exit $1
}

# Other constants
WINE=wine
WINHOST=win10
WINLIGHT=c:/wix/light.exe
# WINEPREFIX - determined at runtime or passed by caller
# WIXPREFIX  - determined at runtime or passed by caller


# Store the original script and the command line
# for diagnostic reasons
myself="$0"
commandline="$0 $@"

# Preset variables.
indocker="no"
appimage="no"
appimage_docker_build="no"
shell="no"
clean="no"
dist="no"
release="no"
branch="master"
srcdir=$(cd $(dirname $0); pwd)
is_tmpbuild="no"
update_image="no"
w64="yes"
download="no"
runcmd="no"
fromgit="no"
withmsi="no"
force="no"
nosign="no"
ftpuser=
verbose=
logfile=
custom_logfile="no"
quiet=
docker_cmd_extras=
version_signkey=
have_signkey="no"
# Get UID for use by docker.
userid=$(id -u)
groupid=$(id -g)

# Track whether we reset the tty to cooked mode.  docker sets it to raw mode
# and we set it back via our runner process so that we are sure docker is
# already running.
recooked=

# Parse the command line options.
skipshift=
while [ $# -gt 0 ]; do
    case "$1" in
        --*=*) optarg=`echo "$1" | sed 's/[-_a-zA-Z0-9]*=//'`;;
        *) optarg="";;
    esac

    case "$1" in
        --appimage)              appimage="yes"       ;;
        --shell)                 shell="yes"          ;;
        --clean|-c)              clean="yes"          ;;
        --dist)                  dist="yes"           ;;
        --release)               release="yes"        ;;
        --update-image|--update-img|-u)
                                 update_image="yes"   ;;
        --w32)                   w64="no"             ;;
        --force)                 force="yes"          ;;
        --no-sign)               nosign="yes"         ;;
        --download)              download="yes"       ;;
        --runcmd)                runcmd="yes"         ;;
        --git|-g|--git-pkgs)     fromgit="yes"        ;;
        --builddir|--builddir=*) builddir="${optarg}" ;;
        --logfile|--logfile=*)   logfile="${optarg}"
                                 custom_logfile="yes" ;;
        --user|--user=*)         ftpuser="${optarg}"  ;;
        --msi|--with-msi)        withmsi="yes"        ;;
        --signkey|--signkey=*)   version_signkey="${optarg}"
                                 have_signkey="yes"   ;;
        --verbose|-v)            verbose="yes"        ;;
        --*)                     usage 1 1>&2; exit 1 ;;
        *)                       skipshift=1; break   ;;
    esac
    [ -z "$skipshift" ] && shift
done

if [ "$appimage" = yes -a "$release" = yes ] ; then
    echo "--release can't be used together with --appimage"
    exit 1
fi
if [ "$custom_logfile" = yes -a "$release" = yes ] ; then
    echo "--release can't be used together with --logfile"
    exit 1
fi

[ -z "$verbose" ] && quiet="--quiet"

if [ -z "$builddir" ]; then
    if [ "$release" = "yes" ]; then
        builddir="${HOME}/b/$(basename "$srcdir")-mill"
    elif [ "$appimage" = "yes" ]; then
        builddir="${HOME}/b/$(basename "$srcdir")-appimage"
    else
        builddir="${HOME}/b/$(basename "$srcdir")-playground"
    fi
fi

# Check whether we are running in the docker container.
if [ -d /src/src -a -d /src/patches -a -d /build ]; then
    indocker="yes"
    srcdir="/src"
    builddir="/build"
    instdir="${builddir}/install"
    vsddir="${srcdir}/src/gnupg-vsd"
    if [ "$appimage" = "yes" ] ; then
        appimage_docker_build="yes"
        appdir="${builddir}/AppDir"
    fi
    echo >&2 "$PGM: running in docker"
fi

echo >&2 "$PGM: source directory: $srcdir"
echo >&2 "$PGM: build  directory: $builddir"

# Remove leading an trailing whitespace
trim() {
    local var="$*"

    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"

    printf '%s' "$var"
}


# Make sure we have a BUILDTYPE file
buildtype_prefix=""
[ "$indocker" = yes ] && buildtype_prefix="/src/"
if [ -e "${buildtype_prefix}packages/BUILDTYPE" ]; then
    buildtype="$(trim "$(cat "${buildtype_prefix}packages/BUILDTYPE" 2>/dev/null)")"
else
    echo >&2 "PGM: ${buildtype_prefix}packages/BUILDTYPE not found - see README"
    exit 1
fi


# Run a command using the FIFOs.  This needs to be called via a FIFO
# from the docker.  Note that we don't explicit serialize access to the
# FIFO, hopefully no parallel make rules are run.
if [ "$runcmd" = yes ]; then
    if [ "$indocker" != yes ]; then
        echo >&2 "$PGM: Option --runcmd must be called from docker"
        echo >&2 "$PGM: Available commands are:"
        echo >&2 "$PGM:   ping      - Wait for a pong"
        echo >&2 "$PGM:   gpg       - Run a gpg command"
        echo >&2 "$PGM:   msibase   - Prepare MSI linking"
        echo >&2 "$PGM:   litcandle - Run candle.exe"
        exit 2
    fi
    # Running in docker
    if [ -z "$1" ]; then
        echo >&2 "usage: /src/build.sh --runcmd COMMAND ARGS"
        exit 2
    fi
    [ -f /build/S.build.sh-rc ] && rm /build/S.build.sh-rc
    echo "$@" >/build/S.build.sh-in
    cat /build/S.build.sh-out
    while [ ! -f /build/S.build.sh-rc ]; do sleep 0.05; done
    rc=$(sed -ne 's/EXITSTATUS=\([0-9]*\).*$/\1/p' \
             </build/S.build.sh-rc 2>/dev/null || true)
    [ -z "$rc" ] && rc=0
    exit $rc
fi


# The following condition does the whole AppImage building stuff
# It must not be placed earlier in the script so that neccessary
# checks and actions have already taken place!
if  [ "$appimage_docker_build" = "yes" ] ; then
    echo "run appimage build" | tee -a ${logfile} >&2

    write_version_file () (
        # TODO: add uidcomment and read content from config files
        echo "Writing VERSION file" | tee -a ${logfile} >&2
        local VERSION_FILE="$1"
        local FLAVOUR="$2"
        local LANG="$3"
        local VSD_VERSION="$4"
        local BUILD_CID_INSTALLER="$(cd "${srcdir}" && git rev-parse --verify HEAD)"
        local BUILD_CID_CONFIG="$(cd "${srcdir}/src/gnupg-vsd" && git rev-parse --verify HEAD)"
        local YEAR="$(date +%Y)"

        if [ "${FLAVOUR}" = "vsd" ] ; then
            local KLEO_VERSION="VS-Desktop-${VSD_VERSION}"
            local KLEO_BUG_ADDRESS="https://gnupg.com/vsd/report.html"
            local KLEO_HOMEPAGE="https://www.gnupg.com/vsd/release-notes.html"
            if [ "${LANG}" = "de" ] ; then
                local KLEO_SHORT_DESC="<h1>GnuPG VS-Desktop<sup>®</sup></h1><br/><b>AppImage</b><br/><br/>Die GnuPG.com Unterstützung ist verfügbar unter:<br/><br/>+49-2104-4938-797<br/><a href=\"mailto:support@gnupg.com\">support@gnupg.com</a><br/>Stichwort: VSD AppImage<br/><br/>"
                local KLEO_OTHER_TEXT="<b>GnuPG VS-Desktop</b><sup>®</sup> ist Copyright (c) 2005-${YEAR} g10 Code GmbH<br/>Eine vollständige Liste der Lizenzen findet sich in der beiliegenden pkg-licenses.txt Datei."
            else
                local KLEO_SHORT_DESC="<h1>GnuPG VS-Desktop<sup>®</sup></h1><br/><b>AppImage</b><br/><br/>The GnuPG.com vendor support is available at:<br/><br/>+49-2104-4938-797<br/><a href=\"mailto:support@gnupg.com\">support@gnupg.com</a><br/>Keyword: VSD AppImage English<br/><br/>"
                local KLEO_OTHER_TEXT="<b>GnuPG VS-Desktop</b><sup>®</sup> is Copyright (c) 2005-${YEAR} g10 Code GmbH<br/>For a full list of licenses see the installed pkg-licenses.txt file."
            fi
        elif [ "${FLAVOUR}" = "gpd" ] ; then
            local KLEO_VERSION="Desktop-${VSD_VERSION}"
            local KLEO_BUG_ADDRESS="https://gnupg.com/gpd/report.html"
            local KLEO_HOMEPAGE="https://www.gnupg.com/gpd/release-notes.html"
            if [ "${LANG}" = "de" ] ; then
                local KLEO_SHORT_DESC="<h1>GnuPG Desktop<sup>®</sup></h1><br/><b>AppImage</b><br/><br/>Die GnuPG.com Unterstützung ist verfügbar unter:<br/><br/>+49-2104-4938-797<br/><a href=\"mailto:support@gnupg.com\">support@gnupg.com</a><br/>Stichwort: GPD AppImage<br/><br/>"
                local KLEO_OTHER_TEXT="<b>GnuPG Desktop</b><sup>®</sup> ist Copyright (c) 2005-${YEAR} g10 Code GmbH<br/>Eine vollständige Liste der Lizenzen findet sich in der beiliegenden pkg-licenses.txt Datei."
            else
                local KLEO_SHORT_DESC="<h1>GnuPG Desktop<sup>®</sup></h1><br/><b>AppImage</b><br/><br/>The GnuPG.com vendor support is available at:<br/><br/>+49-2104-4938-797<br/><a href=\"mailto:support@gnupg.com\">support@gnupg.com</a><br/>Keyword: GPD AppImage English<br/><br/>"
                KLEO_OTHER_TEXT="<b>GnuPG Desktop</b><sup>®</sup> is Copyright (c) 2005-${YEAR} g10 Code GmbH<br/>For a full list of licenses see the installed pkg-licenses.txt file."
            fi
        fi

        local OKULAR_VERSION="${KLEO_VERSION}"
        local OKULAR_SHORT_DESC="${KLEO_SHORT_DESC}"
        local OKULAR_OTHER_TEXT="${KLEO_OTHER_TEXT}"
        local OKULAR_BUG_ADDRESS="${KLEO_BUG_ADDRESS}"
        local OKULAR_HOMEPAGE="${KLEO_HOMEPAGE}"

        cat <<- EOF > ${VERSION_FILE}
		[Kleopatra]
		version=${KLEO_VERSION}
		shortDescription=${KLEO_SHORT_DESC}
		otherText=${KLEO_OTHER_TEXT}
		bugAddress=${KLEO_BUG_ADDRESS}
		homepage=${KLEO_HOMEPAGE}
		copyrightStatement=<pre></pre>
		statusline=${VSD_VERSION}

		[Okular]
		version=${OKULAR_VERSION}
		shortDescription=${OKULAR_SHORT_DESC}
		otherText=${OKULAR_OTHER_TEXT}
		bugAddress=${OKULAR_BUG_ADDRESS}
		homepage=${OKULAR_HOMEPAGE}
		displayName=Okular - GnuPG Edition

		[Build]
		cidInstaller=${BUILD_CID_INSTALLER}
		cidConfig=${BUILD_CID_CONFIG}" > ${VERSION_FILE}
		EOF
    )

    sign_version_file () (
        local VERSION_FILE="$1"
        local SIGNKEY="$2"

        [ -n "$verbose" ] && echo "$PGM (AppImage): signkey      : ${SIGNKEY}" | tee -a ${logfile} >&2

        /src/build.sh --runcmd gpg --yes -o "${VERSION_FILE}.sig" -bau "${SIGNKEY}" "${VERSION_FILE}"
        chmod 0644 "${VERSION_FILE}.sig"
    )

    # Check for the buildtype and existence of required files
    # early
    if [ "${buildtype}" = "vsd" -o "${buildtype}" = "vsd3" -o "${buildtype}" = "gpd" ] && [ ! -f ${vsddir}/custom.mk ]; then
        (   echo "ERROR: Non default build without custom file."
            echo "Check that ${vsddir}/custom.mk exists or "
            echo "change the BUILDTYPE in ${srcdir}/packages/BUILDTYPE" ) | tee -a ${logfile} >&2
        exit 2
    fi

    if [ -n "$verbose" ] ; then
        (   echo "$PGM (AppImage): printenv     : $(printenv)"
            echo "$PGM (AppImage): version      : $(cat /proc/version)"
            echo "$PGM (AppImage): buildtype    : ${buildtype}"
            echo "$PGM (AppImage): vsddir       : ${vsddir}"
            echo "$PGM (AppImage): builddir     : ${builddir}"
            echo "$PGM (AppImage): srcdir       : ${srcdir}"
            echo "$PGM (AppImage): appdir       : ${appdir}"
            echo "$PGM (AppImage): instdir      : ${instdir}"
            echo "$PGM (AppImage): signkey      : ${version_signkey}" ) | tee -a ${logfile} >&2
        # echo "$PGM (AppImage): : ${}"
    fi

    # The actual build
    cd ${builddir}
    if [ -f /opt/rh/gcc-toolset-14/enable ] ;then
        [ -n "$verbose" ] && echo "$PGM (AppImage): found        : /opt/rh/gcc-toolset-14/enable" | tee -a ${logfile} >&2
    else
        echo "$PGM (AppImage): no found     : /opt/rh/gcc-toolset-14/enable" | tee -a ${logfile} >&2
        exit 1
    fi
    source /opt/rh/gcc-toolset-14/enable
    echo "${srcdir}/configure --enable-appimage --with-playground=${builddir}" | tee -a ${logfile} >&2
    ${srcdir}/configure --enable-appimage --with-playground=${builddir}
    # Nuke the AppDir to make sure we get everything nice and clean
    cd ${builddir}/src/appimage
    make TOPSRCDIR=${srcdir} PLAYGROUND=${builddir} clean-appdir
    cd ${builddir}
    make TOPSRCDIR=${srcdir} PLAYGROUND=${builddir}

    echo 'rootdir = $appdir/usr' >${appdir}/usr/bin/gpgconf.ctl
    if [ ${buildtype} = vsd -o ${buildtype} = vsd3 ]; then
        echo 'sysconfdir = /etc/gnupg-vsd' >>${appdir}/usr/bin/gpgconf.ctl
    else
        echo 'sysconfdir = /etc/gnupg' >>${appdir}/usr/bin/gpgconf.ctl
    fi

    # Copy the start-shell helper for use AppRun
    cp ${srcdir}/src/appimage/start-shell ${appdir}/
    chmod +x ${appdir}/start-shell

    # Copy standard global configuration
    if [ ${buildtype} = vsd -o ${buildtype} = vsd3 ]; then
        mkdir -p ${appdir}/usr/share/gnupg/conf/gnupg-vsd
        rsync -aLv --delete --omit-dir-times \
            --perms --chmod=D0755,F0644 \
            ${vsddir}/Standard/etc/gnupg/ \
            ${appdir}/usr/share/gnupg/conf/gnupg-vsd/
    fi

    export PATH=/opt/linuxdeploy/usr/bin:$PATH
    export LD_LIBRARY_PATH=${instdir}/lib

    # tell the linuxdeploy qt-plugin where to find qmake
    export QMAKE=${instdir}/bin/qmake

    # create plugin directories expected by linuxdeploy qt-plugin
    # workaround for
    # [qt/stdout] Deploy[qt/stderr] terminate called after throwing an instance of 'boost::filesystem::filesystem_error'
    # [qt/stderr]   what():  boost::filesystem::directory_iterator::construct: No such file or directory: "/build/AppDir/usr/plugins/sqldrivers"
    # ERROR: Failed to run plugin: qt (exit code: 6)
    mkdir -p ${instdir}/plugins/sqldrivers

    # copy KDE plugins to ${appdir}/usr/lib/plugins/
    # copying the plugins to a subfolder of ${appdir}/usr/lib (instead of to
    # ${appdir}/usr/plugins/ as linuxdeploy does for the Qt plugins) ensures that
    # linuxdeploy copies the dependencies of the plugins to ${appdir} so that
    # we don't have to take care of this ourselves
    mkdir -p ${appdir}/usr/lib/plugins
    if [ ${buildtype} = vsd ]; then
        for d in kf6 kiconthemes6 styles; do
            rsync -av --delete --omit-dir-times ${instdir}/lib/plugins/${d}/ ${appdir}/usr/lib/plugins/${d}/
        done
        rsync -av --delete --omit-dir-times ${instdir}/lib/plugins/okular_generators/okularGenerator_poppler.so ${appdir}/usr/lib/plugins/okular_generators/
    elif [ ${buildtype} = vsd3 ]; then
        for d in iconengines kauth kf5 okular plasma; do
            rsync -av --delete --omit-dir-times ${instdir}/lib/plugins/${d}/ ${appdir}/usr/lib/plugins/${d}/
        done
        rsync -av --delete --omit-dir-times ${instdir}/lib/plugins/okularpart.so ${appdir}/usr/lib/plugins/

        mkdir -p ${appdir}/usr/lib
        # copy dependencies of the plugins
        # okularGenerator_*.so
        for f in libfreetype* libpoppler* libtiff.so* libOkular5Core.so* ; do
            rsync -av --delete --omit-dir-times ${instdir}/lib/${f} ${appdir}/usr/lib/
        done
    fi

    cd ${builddir}
    myversion=$(grep PACKAGE_VERSION ${builddir}/config.h|sed -n 's/.*"\(.*\)"$/\1/p')
    if [ ${buildtype} = vsd -o ${buildtype} = vsd3 ]; then
        appimage_name=gnupg-vs-desktop-${myversion}-x86_64.AppImage
        echo "Packaging GnuPG VS-Desktop Appimage: ${myversion}" | tee -a ${logfile} >&2
        echo $myversion >${appdir}/GnuPG-VS-Desktop-VERSION
        write_version_file "${appdir}/usr/VERSION" "vsd" "en" "${myversion}" && sign_version_file "${appdir}/usr/VERSION" "${version_signkey}"
        echo "Packaging help files" | tee -a ${logfile} >&2
        mkdir -p ${appdir}/usr/share/doc/gnupg-vsd
        cp ${vsddir}/help/*.pdf ${appdir}/usr/share/doc/gnupg-vsd
        if [ -f ${vsddir}/Standard/kleopatrarc ]; then
            echo "Packaging kleopatrarc" | tee -a ${logfile} >&2
            mkdir -p ${appdir}/usr/etc/xdg
            cp ${vsddir}/Standard/kleopatrarc ${appdir}/usr/etc/xdg
        fi
        kleopatra_icon=${srcdir}/src/icons/kleopatra-vsd.svg
    elif [ ${buildtype} = gpd ]; then
        appimage_name=gnupg-desktop-${myversion}-x86_64.AppImage
        echo "Packaging GnuPG Desktop Appimage: $myversion" | tee -a ${logfile} >&2
        echo $myversion >${appdir}/GnuPG-Desktop-VERSION
        write_version_file "${appdir}/usr/VERSION" "gpd" "en" "${myversion}" && sign_version_file "${appdir}/usr/VERSION" "${version_signkey}"
        echo "Packaging help files" | tee -a ${logfile} >&2
        mkdir -p ${appdir}/usr/share/doc/gnupg-vsd
        cp ${vsddir}/help/*.pdf ${appdir}/usr/share/doc/gnupg-vsd
        if [ -f ${vsddir}/Desktop/kleopatrarc ]; then
            echo "Packaging kleopatrarc" | tee -a ${logfile} >&2
            mkdir -p ${appdir}/usr/etc/xdg
            cp ${vsddir}/Desktop/kleopatrarc ${appdir}/usr/etc/xdg
        fi
        kleopatra_icon=${srcdir}/src/icons/gpd/sc-apps-kleopatra.svg
    else
        appimage_name=gpg4win-${myversion}-x86_64.AppImage
        echo "Packaging Gpg4win Appimage: $myversion" | tee -a ${logfile} >&2
        echo $myversion >${appdir}/Gpg4win-VERSION
        kleopatra_icon=${srcdir}/src/icons/gpd/sc-apps-kleopatra.svg
    fi

    if [ -n "${kleopatra_icon}" ]; then
        # Replace Breeze icons for kleopatra with our icon
        find ${appdir}/usr/share/icons/breeze -name 'kleopatra*.svg' -delete
        find ${appdir}/usr/share/icons/breeze-dark -name 'kleopatra*.svg' -delete
        cp -av ${kleopatra_icon} ${appdir}/usr/share/icons/breeze/apps/22/kleopatra-symbolic.svg
        cp -av ${kleopatra_icon} ${appdir}/usr/share/icons/breeze/apps/48/kleopatra.svg
        cp -av ${kleopatra_icon} ${appdir}/usr/share/icons/breeze-dark/apps/22/kleopatra-symbolic.svg
        cp -av ${kleopatra_icon} ${appdir}/usr/share/icons/breeze-dark/apps/48/kleopatra.svg
    else
        # Restore the Breeze icons that may have been replaced in a previous build
        for f in breeze/apps/22/kleopatra-symbolic.svg breeze/apps/48/kleopatra.svg \
                breeze-dark/apps/22/kleopatra-symbolic.svg breeze-dark/apps/48/kleopatra.svg; do
            # copy files only if they are not hard-linked; otherwise, cp complains that the files are the same file
            test ${instdir}/share/icons/$f -ef ${appdir}/usr/share/icons/$f \
                || cp -av ${instdir}/share/icons/$f ${appdir}/usr/share/icons/$f
        done
    fi

    # Hack around that linuxdeploy does not know libexec
    for f in dirmngr_ldap gpg-check-pattern \
            gpg-preset-passphrase gpg-protect-tool \
            gpg-wks-client scdaemon \
            keyboxd gpg-pair-tool; do
    # Ignore errors because some files might not exist depending
    # on GnuPG Version
        /opt/linuxdeploy/usr/bin/patchelf --debug \
                --set-rpath '$ORIGIN/../lib' ${appdir}/usr/libexec/$f || true
    done

    # linuxdeploy also doesn't know about non-Qt plugins
    for f in $(find ${appdir}/usr/lib/plugins/ -mindepth 1 -maxdepth 1 -type f); do
        # this is only needed for the Qt 5 version of okularpart.so because it's installed in /usr/lib/plugins
        /opt/linuxdeploy/usr/bin/patchelf --debug --set-rpath '$ORIGIN/..' $f
    done
    for f in $(find ${appdir}/usr/lib/plugins/ -mindepth 2 -maxdepth 2 -type f); do
        /opt/linuxdeploy/usr/bin/patchelf --debug --set-rpath '$ORIGIN/../..' $f
    done
    for f in $(find ${appdir}/usr/lib/plugins/ -mindepth 3 -maxdepth 3 -type f); do
        /opt/linuxdeploy/usr/bin/patchelf --debug --set-rpath '$ORIGIN/../../..' $f
    done
    for f in $(find ${appdir}/usr/lib/plugins/ -mindepth 4 -maxdepth 4 -type f); do
        /opt/linuxdeploy/usr/bin/patchelf --debug --set-rpath '$ORIGIN/../../../..' $f
    done

    # Fix up everything and build the file system
    linuxdeploy --appdir ${appdir} \
                --desktop-file ${appdir}/usr/share/applications/org.kde.kleopatra.desktop \
                --icon-file ${appdir}/usr/share/icons/hicolor/256x256/apps/kleopatra.png \
                --custom-apprun ${srcdir}/src/appimage/AppRun \
                --plugin qt \
        2>&1 | tee ${builddir}/logs/linuxdeploy-gnupg-desktop.log

    # Replace qt.conf generated by linuxdeploy-plugin-qt with our own qt.conf
    if [ ${buildtype} = vsd3 ]; then
        cp ${srcdir}/src/appimage/qt5/qt.conf ${appdir}/usr/bin
    else
        cp ${srcdir}/src/appimage/qt6/qt.conf ${appdir}/usr/bin
    fi

    # Finally, create the AppImage
    /opt/linuxdeploy/plugins/linuxdeploy-plugin-appimage/usr/bin/appimagetool ${appdir} ${appimage_name}

    echo ready
    exit 0
fi

# Helper to get the value of a variable from the ~/.gnupg-autogen.rc file
# Argument is the name of the variable.
getvar_from_autogenrc() {
    if [ -f "$HOME/.gnupg-autogen.rc" ]; then
        grep '^[[:blank:]]*'$1'[[:blank:]]*=' "$HOME/.gnupg-autogen.rc" \
            | cut -d= -f2 | xargs
    elif [ -f "$TOPSRCDIR/.gnupg-autogen.rc" ]; then
        grep '^[[:blank:]]*'$1'[[:blank:]]*=' "$TOPSRCDIR/.gnupg-autogen.rc" \
            | cut -d= -f2 | xargs
    else
        echo "$PGM: warning: .gnupg-autogen.rc not found in " \
             "HOME or $TOPSRCDIR" >&2
    fi
}


# First build  a tarball and then build from that tarball
build_from_tarball() {
    local milldir
    local tarballname
    local extraopt
    local gnupgvsdconfrepo

    if [ "$indocker" = yes ]; then
        echo >&2 "$PGM: error: option --release may not be used from docker"
        exit 2
    fi

    # Get the URL of the gnupg-vsd repo which carries customized
    # configurations for GnuPG [VS-]Desktop
    gnupgvsdconfrepo="$(getvar_from_autogenrc GNUPG_VSD_CONF_REPO)"
    if [ -z "$gnupgvsdconfrepo" ] && [ $need_gnupg_vsd = yes ]; then
        echo "$PGM: error: GNUPG_VSD_CONF_REPO value missing in " \
             ".gnupg-autogen.rc" >&2
        exit 2
    fi

    [ -d "${builddir}" ] || mkdir -p "${builddir}"
    milldir=$(cd "${builddir}"; pwd)

    # Use a common log file in the top directory.
    logfile="${milldir}/build-log.txt"

    ( echo "$PGM: *"
      echo "$PGM: * Building release in $milldir"
      echo "$PGM: *" ) | tee -a ${logfile} >&2

    rm -rf "$milldir/tarball" || true
    rm -rf "$milldir/source" || true
    rm -rf "$milldir/binary" || true
    mkdir "$milldir/tarball"
    mkdir "$milldir/source"
    mkdir "$milldir/binary"

    extraopt="--logfile=$logfile"
    [ -n "$verbose" ] && extraopt="$extraopt --verbose"
    [ "$download" = yes ] && extraopt="$extraopt --download"
    $myself --builddir="$milldir/tarball" --dist $extraopt
    if [ $? != 0 ]; then
        ( echo "$PGM: *"
          echo "$PGM: * ERROR: creating tarball failed"
          echo "$PGM: *" ) | tee -a ${logfile} >&2
        exit 2
    fi

    tarballname=$(ls "$milldir/tarball/artifacts/"gpg4win*xz)

    cd "$milldir/source"
    tar --strip-components=1 -xJf "$tarballname"
    if [ $? != 0 ]; then
        ( echo "$PGM: *"
          echo "$PGM: * ERROR: failed to extract tarball"
          echo "$PGM: *" ) | tee -a ${logfile} >&2
        exit 2
    fi

    if [ $withmsi = yes ] && [ $need_gnupg_vsd = yes ]; then
        cd src
        git clone "$gnupgvsdconfrepo"
        ( cd gnupg-vsd
          echo "$PGM: *"
          echo "$PGM: * gnupg-vsd cloned"
          echo "$PGM: *   branch .. : $(git branch --show-current)"
          echo "$PGM: *   commitid .: $(git rev-parse HEAD)"
          echo "$PGM: *" ) | tee -a ${logfile} >&2
        cd "$milldir/source"
    fi

    extraopt="--logfile=$logfile"
    [ -n "$verbose" ] && extraopt="$extraopt --verbose"
    [ $withmsi = yes ] && extraopt="$extraopt --msi"
    [ $nosign = yes ] && extraopt="$extraopt --no-sign"
    $myself --builddir="$milldir/binary" $extraopt
    if [ $? != 0 ]; then
        ( echo "$PGM: *"
          echo "$PGM: * ERROR: building release failed"
          echo "$PGM: *" ) | tee -a ${logfile} >&2
        exit 2
    fi

    ( cd "$milldir/binary/artifacts"
      ln -s "$tarballname" . )

    ( echo "$PGM: *"
      echo "$PGM: * READY"
      echo "$PGM: *"  ) | tee -a ${logfile} >&2
    exit 0
}



# The main GUI packages.  Check the gen-tarball script to see which
# branches are used.
FRONTEND_PKGS="
libkleo
kleopatra
gpgol
gpgoljs
gpgpass
gpg4win-tools
mimetreeparser"


# Function to download the packages.  Optionally generate new tarballs
# for the main GUI components.
download_packages() {
    if [ "$indocker" = yes ]; then
        echo >&2 "$PGM: error: downloading files from docker is not possible"
        exit 2
    fi

    cd packages

    if [ "$fromgit" = yes ]; then
        # FIXME: We should check at least the commits from the gpg4win
        # repo before doing this.  But well, this very scripts is a
        # catch22 so that we need to have an external installed test
        # script before running this script from an updated repo.  Or
        # well, we could use us to check our next version.
        echo >&2 "$PGM: Creating new tarballs and updating packages file ... "
        myargs=
        [ -n "$ftpuser" ]  && myargs="$myargs --user=$ftpuser"
        ./gen-tarball.sh $myargs -u $FRONTEND_PKGS
        echo >&2 "$PGM: Generating tarballs done"
    fi

    echo "$PGM: Downloading packages"
    ./download.sh $quiet --update
    echo >&2 "$PGM: downloading done"

    cd ..
}


# Check whether the --release target needs to clone the gnupg-vsd repo.
case "${buildtype}" in
    vsd3)       need_gnupg_vsd=yes
                w64=no              ;;
    vsd|gpd)    need_gnupg_vsd=yes  ;;
    gpg4win|default)
                need_gnupg_vsd=no   ;;
    *)          echo "Not a valid BUILDTYPE: ${buildtype}" >&2
                echo "Put vsd3, vsd, gpd, gpg4win or default into packages/BUILDTYPE" >&2
                exit 1
                                    ;;
esac


# Check whether we are in the docker image and run appropriate commands.
# Note that this script is used to start the docker container and also
# within the docker container to run the desired commands.
if [ "$indocker" = yes ]; then
    # NB: In docker the builddir is always /build and the source /src
    cd /build
    if [ ! -f config.status ]; then
        force=yes
    elif [ /src/configure -nt config.status ]; then
        force=yes
    fi
    if [ $force = no ]; then
         echo >&2 "$PGM: Not running configure (--force not used)"
    elif [ "$w64" = "yes" ]; then
        /src/autogen.sh --build-w64
    else
        /src/autogen.sh --build-w32
    fi
    export CMAKE_COLOR_DIAGNOSTICS=OFF
    if [ $dist = yes ]; then
        make dist XZ_OPT=-2 TOPSRCDIR=/src PLAYGROUND=/build
    else
        make TOPSRCDIR=/src PLAYGROUND=/build VERBOSE=1
        if [ $? = 0 ] && [ $withmsi = yes ]; then
            make TOPSRCDIR=/src PLAYGROUND=/build msi-signed
        fi
    fi
    exit $?
fi # (end of script use inside the docker container) #


# Setup for using the Wix tools under Wine if requested.
if [ $withmsi = yes ]; then
    if [ -z "$(which $WINE)" ]; then
       echo >&2 "$PGM: error: For MSI packaging Wine needs to be installed"
       exit 1
    fi
    [ -z "$WINEPREFIX" ] && WINEPREFIX="$HOME/.wine"
    if [ ! -e "$WINEPREFIX/dosdevices" ]; then
        echo >&2 "PGM: error: No value for WINEPREFIX found"
        exit 1
    fi
    if [ -z "$WIXPREFIX" ]; then
        tmp="$(readlink -f ~/w32root/wixtools)"
    if [ -d "$tmp" ]; then
        WIXPREFIX="$tmp"
        echo >&2 "$PGM: Using $WIXPREFIX as WIXPREFIX"
    else
        echo >&2 "$PGM: error: You must set WIXPREFIX" \
                 " to an installation of wixtools"
        exit 1
    fi
    fi
    WINEINST="$WINEPREFIX/dosdevices/k:"
    WINESRC="$WINEPREFIX/dosdevices/i:"
    WINEINSTEX="$WINEPREFIX/dosdevices/j:"
    WINEBLD="$WINEPREFIX/dosdevices/l:"
    die=no
    for f in "$WINEINST" "$WINESRC" "$WINEINSTEX" "$WINEBLD" ; do
    if [ -e "$f" -a ! -h "$f" ]; then
        echo >&2 "$PGM: error: '$f' already exists. Please remove."
        die=yes
    fi
    done
    # Also check that there is no cruft in the gnupg-vsd subdir.
    # For now we check only the standard configuration directories.
    f="${srcdir}/src/gnupg-vsd/custom.mk"
    if [ "$release" = "yes" ]; then
        echo >&2 "$PGM: note: gnupg-vsd will be cloned later"
    elif [ ! -f "$f" ]; then
        echo >&2 "$PGM: error: '$f' does not exist."
        die=yes
    else
        for x in Enterprise Standard Entry Testorg Desktop ; do
            f="${srcdir}/src/gnupg-vsd/$x"
            for y in VERSION VERSION.sig $x.wxs ; do
                if [ -f "$f/$y" ]; then
                    echo >&2 "$PGM: error: file '$f/$y' should not exist."
                    die=yes
                fi
            done
        done
    fi
    [ $die = yes ] && exit 1
fi

# Determine the needed docker image
if [ "$appimage" = "yes" ]; then
    [ -n "$verbose" ] && docker_cmd_extras="${docker_cmd_extras} --verbose"
    if [ "${buildtype}" = "vsd" ] || [ "${buildtype}" = "vsd3" ] || [ "${buildtype}" = "gpd" ] ; then
        if [ "$have_signkey" = "no" ] && [ -f "$HOME/.gnupg-autogen.rc" ] ; then
            version_signkey="$(grep '^[[:blank:]]*VERSION_SIGNKEY[[:blank:]]*=' "$HOME/.gnupg-autogen.rc"|cut -d= -f2|xargs)"
        fi
        if  [ -z "${version_signkey}" ] ; then
            echo "No signing key defined, which is mandatory for buildtypes vsd, vsd3 and gpd!"
            exit 1
        fi
        cmd="/src/build.sh --appimage --signkey=${version_signkey} ${docker_cmd_extras}"
    else
        cmd="/src/build.sh --appimage ${docker_cmd_extras}"
    fi
    docker_image=g10-build-appimage:almalinux810
    dockerfile=${srcdir}/docker/appimage
else
    # We will run our self again in the docker image.
    if [ "$w64" = "yes" ]; then
        cmd="/src/build.sh ${docker_cmd_extras}"
    else
        cmd="/src/build.sh --w32 ${docker_cmd_extras}"
    fi
    [ $dist = yes ] && cmd="$cmd --dist"
    [ $force = yes ] && cmd="$cmd --force"
    [ $withmsi = yes -a $shell = no ] && cmd="$cmd --msi"
    docker_image=g10-build-gpg4win:trixie
    dockerfile=${srcdir}/docker/gpg4win-trixie
fi

# Update the docker image if requested or if it does not exist.
drep=$(echo $docker_image | cut -d : -f 1)
dtag=$(echo $docker_image | cut -d : -f 2)
if [ -z "$(docker images | grep $drep | grep $dtag)" \
     -o "$update_image" = "yes" ]; then
    echo >&2 "$PGM: Local image $docker_image not found"
    echo >&2 "$PGM: Building docker image"
    docker build --pull -t $docker_image $dockerfile 2>&1
fi

# If --shell was used override the command for docker.
# if not used try to download first.
if [ "$shell" = "yes" ]; then
    cmd="bash"
elif [ "$release" = yes ]; then
    build_from_tarball
elif [ "$download" = yes ]; then
    download_packages
else
    echo >&2 "$PGM: package download skipped"
fi

start_time=$(date +"%s")
[ -z "$logfile" ] && logfile="${builddir}/build-log.txt"

# Kill the given process and all its descendants
killtree() {
    local parent=$1 child
    for child in $(ps -o ppid= -o pid= | awk "\$1==$parent {print \$2}"); do
        killtree $child
    done
    kill $parent
}


# Remove FIFO files.
remove_fifos() {
  [ -e "${builddir}/S.build.sh-in" ] && rm "${builddir}/S.build.sh-in"
  [ -e "${builddir}/S.build.sh-out" ] && rm "${builddir}/S.build.sh-out"
  return 0
}


# Create FIFO files.
create_fifos() {
  remove_fifos
  mkfifo -m 600 "${builddir}/S.build.sh-in"
  mkfifo -m 600 "${builddir}/S.build.sh-out"
  return 0
}


# Make sure we have an absolute build directory and the fifos
# so that docker does not create it with root as owner.
[ -d "${builddir}" ] || mkdir -p "${builddir}"
builddir=$(cd "${builddir}"; pwd)
[ -d "${builddir}/po" ] || mkdir -p "${builddir}/po"
create_fifos

# Function to stop our command runner
runnerpid=
stop_runner() {
    printf >&2 -- "$PGM: stop-runner called\n"
    if [ -n "$runnerpid" ]; then
        echo >&2 "$PGM: stopping runner ..."
        killtree $runnerpid
        runnerpid=
        remove_fifos
    fi
    return 0
}

# Transform a directory from docker to host directory
transform_dir() {
    echo "$1"|sed -e "s,^/build/,$builddir/," -e "s,/src/,$srcdir/,"
}

# Transform all directories in the provided string
# Fixme: This sed expression is not robust enough.
transform_multi_dir() {
    echo "$1"|sed -e "s, /build/, $builddir/,g" -e "s, /src/, $srcdir,g"
}

# Run a gpg command
runner_cmd_gpg() {
    local cmd="$1"

    cmd=$(transform_multi_dir "$cmd")
    printf >&2 -- "$PGM(runner): invoking gpg\n"
    set +e
    $cmd </dev/null
    rc=$?
    set -e
    printf >&2 -- "$PGM(runner): gpg returned $rc\n"
    return 0
}

# Run the gpg-authcode-sign command
runner_cmd_gpg_authcode_sign() {
    local cmd="$1"

    [ $nosign = yes ] && cmd="--dry-run $cmd"

    printf >&2 -- "$PGM(runner): gpg-authcode-sign.sh --stamp $cmd\n"
    set +e
    [ -n "$verbose" ] && set -x
    ( cd "$builddir"/install && gpg-authcode-sign.sh --stamp $cmd </dev/null )
    rc=$?
    [ -n "$verbose" ] && set +x
    set -e
    printf >&2 -- "$PGM(runner): gpg-authcode-sign.sh returned $rc\n"
    return 0
}


# Copy some files to the Windows host to prepare the MSI linking
# Args are: See below
runner_cmd_msibase() {
    local version="$1" gnupgmsi="$2"

    set +e
    [ -n "$verbose" ] && set -x
    ssh "$WINHOST" "mkdir AppData\\Local\\Temp\\gpg4win-$version" || true
    scp "$srcdir"/packages/gnupg-msi-${gnupgmsi}-bin.wixlib \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version";
    scp "$srcdir"/src/icons/shield.ico \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"
    scp "$srcdir"/doc/logo/gpg4win-msi-header_install-493x58.bmp \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"/header.bmp
    scp "$srcdir"/doc/logo/gpg4win-msi-wizard_install-493x312.bmp \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"/dialog.bmp
    scp "$srcdir"/doc/logo/gpg4win-msi-wizard_install-493x312.bmp \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"/dialog.bmp
    scp "$srcdir"/doc/logo/gpg4win-msi-wizard_install-info-32x32.bmp \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"/info.bmp
    scp "$srcdir"/doc/logo/gpg4win-msi-wizard_install-exclamation-32x32.bmp \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"/exclamation.bmp
    scp "$srcdir"/po/gpg4win-en.wxl \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"
    scp "$srcdir"/po/gpg4win-de.wxl \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"
    scp WixUI_Gpg4win.wxs \
        "$WINHOST":AppData/Local/Temp/gpg4win-"$version"
    rc=0
    [ -n "$verbose" ] && set +x
    set -e
    return 0
}


# Copy files to the Windows host
runner_cmd_cptowinhost() {
    local version="$1"
    local target="$WINHOST":AppData/Local/Temp/gpg4win-"$version"
    local files

    shift

    files=
    for f in "$@"; do
        files="$files $(transform_dir "$f")"
    done
    set +e
    echo >&2 "$PGM: running scp $files  $target"
    scp $files  "$target"
    rc=$?
    set -e

    return 0
}

# Copy file from the Windows host
runner_cmd_cpfromwinhost() {
    local version="$1" prefix="$2" name="$3" vsdvers="$4"
    local mydir="$WINHOST":AppData/Local/Temp/gpg4win-"$version"

    set +e
    scp "$mydir/$prefix-$version-$name.msi" \
        "$builddir/src/installers/$prefix-$vsdvers-$name.msi"
    rc=$?
    set -e

    return 0
}

# Run light.exe on Windows host
runner_cmd_lightwinhost() {
    local version="$1" prefix="$2" name="$3" intlopt="$4" msivers="$5"

    [ -n "$verbose" ] && set -x
    set +e
    ssh "$WINHOST" "cd AppData/Local/Temp/gpg4win-$version \
        && $WINLIGHT \
        -cc . -reusecab -spdb \
        -ext WixUIExtension   \
        -ext WixUtilExtension \
        -out $prefix-$version-$name.msi \
        $(echo "$intlopt" | sed 's,%20, ,g') \
        -dcl:high -pedantic \
        $prefix-$version.wixlib gnupg-msi-$msivers-bin.wixlib $name-$version.wixlib" \
      | grep -v "ICE80" | grep -v "ICE57"
    rc="${PIPESTATUS[0]}"
    set -e
    [ -n "$verbose" ] && set +x
    # FIXME:
    echo >&2 "$PGM(runner): cmd lightwinhost exited with $rc - forcing 0"
    rc=0

    return 0
}



# Run the Wix tools under Wine.
runner_cmd_litcandle() {
    local mode="$1" version="$2" prefix="$3" idir="$4" exidir="$5"
    local dwixobj fwxs

    if [ $withmsi = no ]; then
        echo >&2 "$PGM(runner): litcandle requires --with-msi option"
        rc=2
        return 0
    fi

    idir=$(transform_dir "$idir")
    exidir=$(transform_dir "$exidir")

    fwixlib="$prefix"-"$version".wixlib
    fwixobj="$prefix"-"$version".wixobj
    if [ "$mode" = ui ]; then
        fwxs="l:\\src\\gnupg-vsd\\$prefix\\$prefix".wxs
        fextraobj="k:\\gpg4win-ui.wixobj"
    else
        fwxs="l:\\src\\$prefix"-"$version".wxs
        fextraobj=
    fi

    # Create symlinks into the Wine dosdevices directory
    if [ -n "$verbose" ]; then
        (   echo "$PGM(runner): idir    : $WINEINST"
            echo "$PGM(runner): exidir  : $WINEINSTEX"
            echo "$PGM(runner): srcdir  : $WINESRC"
            echo "$PGM(runner): builddir: $WINEBLD" ) | tee -a ${logfile} >&2
    fi
    ln -sf "$idir"   "$WINEINST"
    ln -sf "$exidir" "$WINEINSTEX"
    ln -sf "$srcdir" "$WINESRC"
    ln -sf "$builddir" "$WINEBLD"
    # Run the tools
    rc=0
    [ -n "$verbose" ] && set -x
    set +e
    if [ $rc -eq 0 ]; then
        $WINE "$WIXPREFIX/candle.exe" \
            -dInstDir=k: \
            -dInstDirEx=j: \
            -dSrcDir=i:\\ \
            -dBldDir=l:\\ \
            -dVersion="$version" \
            -dWin64="yes" \
            -out k:\\"$fwixobj" \
            -pedantic -wx "$fwxs" \
            -arch x64
        rc=$?
    fi
    if [ $rc -eq 0 -a -n "$fextraobj" ]; then
        $WINE "$WIXPREFIX/candle.exe" \
            -dInstDir=k: \
            -dInstDirEx=j: \
            -dSrcDir=i:\\ \
            -dBldDir=l:\\ \
            -dVersion="$version" \
            -dWin64="yes" \
            -out "$fextraobj" \
            -arch x64 \
            -pedantic -wx i:\\src\\WixUI_Gpg4win.wxs
        rc=$?
    fi
    if [ $rc -eq 0 ]; then
        $WINE "$WIXPREFIX/lit.exe" \
            -out k:\\"$fwixlib" \
            -bf \
            -wx \
            -pedantic \
            k:\\"$fwixobj" "$fextraobj"
        rc=$?
    fi
    set -e
    [ -n "$verbose" ] && set +x
    # Remove the symlinks
    rm "$WINEINST" "$WINESRC" "$WINEINSTEX" "$WINEBLD" || true
    return 0
}


# Run a command received from the fifo.  Args are command and the line
# with args for the command.
runner_exec_cmd() {
    local cmd="$1" line="$2" rc
    printf >&2 -- "$PGM: cmd='%s' line='%s'\n" "$cmd" "$line"
    # The called functions need to set RC to the desired exit status
    rc=42
    case "$cmd" in
        ping) echo pong; rc=0 ;;
        gpg)  runner_cmd_gpg "gpg $line" ;;
        gpg-authcode-sign) runner_cmd_gpg_authcode_sign "$line" ;;
        msibase) runner_cmd_msibase $line ;;
        cptowinhost)   runner_cmd_cptowinhost $line ;;
        cpfromwinhost) runner_cmd_cpfromwinhost $line ;;
        lightwinhost)  runner_cmd_lightwinhost $line ;;
        litcandle) runner_cmd_litcandle $line ;;
        *)    echo "$PGM(runner): $cmd: no such command"; rc=4 ;;
    esac
    echo "$PGM: runner cmd '$cmd' returned $rc" | tee -a ${logfile} >&2
    # Make sure that we have a final LF in the output and then write
    # the error line
    echo
    echo "EXITSTATUS=$rc" > "${builddir}/S.build.sh-rc"
    return 0
}


# Start our FIFO command runner.
runner_loop() {
   echo "$PGM: command runner started pid=$$" | tee -a ${logfile} >&2
   while : ; do
       if read -r cmd line < "${builddir}/S.build.sh-in" ; then
            if [ -z "$recooked" ]; then
                stty cooked </dev/tty
                recooked=yes
            fi
            echo "$PGM(runner): executing cmd" | tee -a ${logfile} >&2
            runner_exec_cmd "$cmd" "$line" >"${builddir}/S.build.sh-out" &
            echo "$PGM(runner): waiting for cmd" | tee -a ${logfile} >&2
            wait
            echo "$PGM(runner): cmd finished" | tee -a ${logfile} >&2
       fi
   done
   echo "$PGM: command runner stopped" | tee -a ${logfile} >&2
   exit 0
}

# Start our FIFO command runner
trap stop_runner EXIT SIGTERM SIGINT SIGHUP
runner_loop &
runnerpid=$!
echo >&2 "$PGM: command runner pid is $runnerpid"


# Run docker
docker_cmdline="run -it --rm --user $userid:$groupid"
docker_cmdline="$docker_cmdline -v "${srcdir}":/src:ro"
docker_cmdline="$docker_cmdline -v "${builddir}":/build:rw"
# only add ~/.gnupg-autogen.rc if it actually exists
[ -f "$HOME/.gnupg-autogen.rc" ] && \
    docker_cmdline="$docker_cmdline -v "$HOME/.gnupg-autogen.rc":/.gnupg-autogen.rc:ro"
docker_cmdline="$docker_cmdline $docker_image $cmd"
echo "$PGM: running: docker $docker_cmdline" | tee -a ${logfile} >&2
docker $docker_cmdline 2>&1 | tee -a ${logfile}
err="${PIPESTATUS[0]}"
echo "$PGM: docker finished. rc=$err" | tee -a ${logfile} >&2

end_time=$(date +"%s")
duration=$((end_time - start_time))
hours=$((duration / 3600))
minutes=$((duration % 3600 / 60))
seconds=$((duration % 60))
buildtime=$(printf "%02d:%02d:%02d\n" "$hours" "$minutes" "$seconds")

if [ "$err" = "1" -a "$appimage" = "yes" ]; then
    echo "$PGM: Return code 1 on AppImage build.  Treating as success." | tee -a ${logfile} >&2
    err=0
fi

if [ "$err" = "0" ]; then
    mkdir -p "${builddir}/artifacts"
    if [ "$dist" = "yes" ]; then
        results=$(find "${builddir}" -maxdepth 1 -name \*.tar.xz \
                -a -type f -printf '%p ')
    elif [ "$appimage" = "yes" ]; then
        results=$(find "${builddir}" -maxdepth 1 -iname \*.appimage \
                -a -type f -printf '%p ')
    elif [ $withmsi = yes ]; then
        results=$(find "${builddir}/src/signed_installers" -type f -printf '%p ')
    else
        results=$(find "${builddir}/src/installers" -type f -printf '%p ')
    fi
    echo >&2 ""
    echo >&2 "$PGM: ############### Success 🥳 ####################"
    for result in $results; do
        ln -sf -t "${builddir}/artifacts/" "$result"
        echo >&2 "$PGM: Created: ${builddir}/artifacts/$(basename $result)"
    done
else
    echo >&2 "$PGM: ############### Failure 😪 ####################"
fi

echo >&2 "$PGM: Logfile: ${logfile}"
echo >&2 "$PGM: Build command: ${commandline}"
echo >&2 "$PGM: Build time: $buildtime"
echo >&2 "$PGM: ##############################################"

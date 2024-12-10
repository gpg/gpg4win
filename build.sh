#!/bin/bash
# Copyright (C) 2024 g10 Code GmbH
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
        --v3            Use packages.3 instead of the default
        --w32           Use 32 bit Windows as primary host arch
        --clean         Remove a pre-existing build directory
        --shell         Start a shell instead of starting the build script
        --builddir=DIR  Directory where the build should take place
                        (default is ../b/foo-playground)
        --force         Force configure run
        --update-image  Update the docker image before build
        --user=name     Use NAME as FTP server user
        --download      Download packages first
        --git-pkgs      Use latest git versions for the frontend
                        packages:
                        gpgme libkleo kleopatra gpgol gpgol.js
                        gpgpass gpg4win-tools mimetreeparser


This script is used to build either the Appimage or the Windows
installer.  The build is done in a build directory with the suffix
"-playground".  Use the option --builddir to use a non-default build
directory.  Take care not to use the source directory for building.

Examples:
    ./$PGM
        Build in the default build directory ~/b/SRCDIRNAME-playground

    ./$PGM --builddir=/foo/bar/my-playground
        Build in the given directory.
EOF
    exit $1
}


# Store the original command line
# for diagnostic reasons
commandline="$0 $@"

# Preset variables.
indocker="no"
gpg22="no"
shell="no"
clean="no"
branch="master"
srcdir=$(cd $(dirname $0); pwd)
is_tmpbuild="no"
update_image="no"
w64="yes"
download="no"
fromgit="no"
builddir="${HOME}/b/$(basename "$srcdir")-playground"
force=no
ftpuser=
verbose=
quiet=
# Get UID for use by docker.
userid=$(id -u)
groupid=$(id -g)


# Parse the command line options.
skipshift=
while [ $# -gt 0 ]; do
    case "$1" in
	--*=*)
	    optarg=`echo "$1" | sed 's/[-_a-zA-Z0-9]*=//'`
	    ;;
	*)
	    optarg=""
	    ;;
    esac

    case "$1" in
        --appimage) appimage="yes";;
        --v3) gpg22="yes";;
        --shell) shell="yes";;
        --clean|-c) clean="yes";;
        --update-image|--update-img|-u) update_image="yes";;
        --w32) w64="no";;
        --w64) w64="yes";;
        --force) force="yes";;
        --download) download="yes";;
        --git|-g|--git-pkgs)     fromgit="yes";;
        --builddir|--builddir=*) builddir="${optarg}" ;;
        --user|--user=*)         ftpuser="${optarg}"  ;;
        --verbose|-v)            verbose=yes          ;;
        --*) usage 1 1>&2; exit 1;;
        *) skipshift=1; break ;;
    esac
    [ -z "$skipshift" ] && shift
done

[ -z "$verbose" ] && quiet="--quiet"

# Check whether we are running in the docker container.
if [ -d /src/src -a -d /src/patches -a -d /build ]; then
    indocker="yes"
    srcdir=/src
    builddir=/build
    echo >&2 "$PGM: running in docker"
fi

echo >&2 "$PGM: source directory: $srcdir"
echo >&2 "$PGM: build  directory: $builddir"


# The main GUI packages.  check the gen-tarball script to see which
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
        echo >&2 "$PGM: Creating new tarballs and updating packages file ... "
        myargs=
        [ -n "$ftpuser" ]  && myargs="$myargs --user=$ftpuser"
        ./gen-tarball.sh $myargs -u $FRONTEND_PKGS
        echo >&2 "$PGM: Generating tarballs done"
    fi

    echo "$PGM: Downloading packages"
    myargs=
    [ "$gpg22" = yes ] && myargs="$myargs --v3"
    ./download.sh $quiet $myargs
    echo >&2 "$PGM: downloading done"

    cd ..
}


# Check whether we are in the docker image run appropriate commands.
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
    make TOPSRCDIR=/src PLAYGROUND=/build
    exit $?
fi # (end of script use inside the docker container) #


# Determine the needed docker image
if [ "$appimage" = "yes" ]; then
    cmd=/build/src/appimage/build-appimage.sh
    docker_image=g10-build-appimage:sles15
    dockerfile=${srcdir}/docker/appimage
else
    # We will run our self again in the docker image.
    if [ "$w64" = "yes" ]; then
        cmd="/src/build.sh --w64"
    else
        cmd="/src/build.sh --w32"
    fi
    [ $force = yes ] && cmd="$cmd --force"
    docker_image=g10-build-gpg4win:bookworm
    dockerfile=${srcdir}/docker/gpg4win-bookworm
fi

# Update the docker image if requested or if it does not exist.
drep=$(echo $docker_image | cut -d : -f 1)
dtag=$(echo $docker_image | cut -d : -f 2)
if [ -z "$(docker images | grep $drep | grep $dtag)" \
     -o "$update_image" = "yes" ]; then
    echo >&2 "$PGM: Local image $docker_image not found"
    echo >&2 "$PGM: Building docker image"
    docker build -t $docker_image $dockerfile 2>&1
fi


# If --shell was used override the command for docker.
# if not used try to download first.
if [ "$shell" = "yes" ]; then
    cmd="bash"
elif [ "$download" = yes ]; then
    download_packages
else
    echo >&2 "$PGM: package download skipped"
fi

start_time=$(date +"%s")
log_file="${builddir}/build-log.txt"


# Run docker but create the build directory first so that docker does
# not create it with root as owner.
[ -d "${builddir}" ] || mkdir -p "${builddir}"
[ -d "${builddir}/po" ] || mkdir -p "${builddir}/po"
docker_cmdline="run -it --rm --user $userid:$groupid"
docker_cmdline="$docker_cmdline --volume "${srcdir}":/src:ro"
docker_cmdline="$docker_cmdline --volume "${builddir}":/build:rw"
docker_cmdline="$docker_cmdline $docker_image $cmd"
echo >&2 "$PGM: running: docker $docker_cmdline"
docker $docker_cmdline 2>&1 | tee -a ${log_file}
err="${PIPESTATUS[0]}"
echo >&2 "$PGM: docker finished. rc=$err"

end_time=$(date +"%s")
duration=$((end_time - start_time))
hours=$((duration / 3600))
minutes=$((duration % 3600 / 60))
seconds=$((duration % 60))
buildtime=$(printf "%02d:%02d:%02d\n" "$hours" "$minutes" "$seconds")

if [ "$err" = "1" -a "$appimage" = "yes" ]; then
    echo >&2 "$PGM: Return code 1 on AppImage build.  Treating as success."
    err=0
fi

if [ "$err" = "0" ]; then
    mkdir -p "${builddir}/artifacts"
    if [ "$appimage" = "yes" ]; then
        results=$(find "${builddir}" -maxdepth 1 -iname \*.appimage \
                  -a -type f -printf '%p ')
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

echo >&2 "$PGM: Logfile: ${log_file}"
echo >&2 "$PGM: Build command: ${commandline}"
echo >&2 "$PGM: Build time: $buildtime"
echo >&2 "$PGM: ##############################################"

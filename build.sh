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
        --dist          Create a distributable tarball
        --release       Create a tarball and then build this tarball
        --shell         Start a shell instead of starting the build script
        --builddir=DIR  Directory where the build should take place
                        (default is ~/b/SRCDIRNAME-playground for gpg4win
                         and ~/b/SRCDIRNAME-appimage for the AppImage)
        --logfile=file  Change default build log file to FILE
        --force         Force configure run
        --no-sign       Do not authenticode sign packages
        --update-image  Update the docker image before build
        --msi           Building MSI packages
        --user=name     Use NAME as FTP server user
        --download      Download packages first
        --runcmd CMD    Run a command via a pair of FIFOs
        --git-pkgs      Use latest git versions for the frontend
                        packages:
                        libkleo kleopatra gpgol gpgol.js
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
gpg22="no"
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
force=no
nosign=no
ftpuser=
verbose=
logfile=
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
        --dist) dist="yes";;
        --release) release="yes";;
        --update-image|--update-img|-u) update_image="yes";;
        --w32) w64="no";;
        --w64) w64="yes";;
        --force) force="yes";;
        --no-sign) nosign="yes" ;;
        --download) download="yes";;
        --runcmd)   runcmd="yes";;
        --git|-g|--git-pkgs)     fromgit="yes";;
        --builddir|--builddir=*) builddir="${optarg}" ;;
        --logfile|--logfile=*)   logfile="${optarg}"  ;;
        --user|--user=*)         ftpuser="${optarg}"  ;;
        --msi|--with-msi)        withmsi=yes          ;;
        --verbose|-v)            verbose=yes          ;;
        --*) usage 1 1>&2; exit 1;;
        *) skipshift=1; break ;;
    esac
    [ -z "$skipshift" ] && shift
done

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
    srcdir=/src
    builddir=/build
    echo >&2 "$PGM: running in docker"
fi

echo >&2 "$PGM: source directory: $srcdir"
echo >&2 "$PGM: build  directory: $builddir"


# First build  a tarball and then build from that tarball
build_from_tarball() {
    local milldir
    local tarballname
    local extraopt

    if [ "$indocker" = yes ]; then
        echo >&2 "$PGM: error: option --release may not be used from docker"
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
        make TOPSRCDIR=/src PLAYGROUND=/build
        if [ $? = 0 -a $withmsi = yes ]; then
            make TOPSRCDIR=/src PLAYGROUND=/build msi
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
    [ $die = yes ] && exit 1
fi

# Determine the needed docker image
if [ "$appimage" = "yes" ]; then
    cmd=/src/src/appimage/build-appimage.sh
    docker_image=g10-build-appimage:sles15
    dockerfile=${srcdir}/docker/appimage
else
    # We will run our self again in the docker image.
    if [ "$w64" = "yes" ]; then
        cmd="/src/build.sh --w64"
    else
        cmd="/src/build.sh --w32"
    fi
    [ $dist = yes ] && cmd="$cmd --dist"
    [ $force = yes ] && cmd="$cmd --force"
    [ $withmsi = yes -a $shell = no ] && cmd="$cmd --msi"
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

# Make sure we have a BUILDTYPE file
if [ ! -e packages/BUILDTYPE ]; then
    echo >&2 "PGM: packages/BUILDTYPE not found - see README"
    exit 1
fi

# If --shell was used override the command for docker.
# if not used try to download first.
if [ "$shell" = "yes" ]; then
    cmd="bash"
elif [ "$download" = yes ]; then
    download_packages
elif [ "$release" = yes ]; then
    build_from_tarball
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
    for f in $@; do
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

# Copy files to the Windows host
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
        echo >&2 "$PGM(runner): idir    : $WINEINST"
        echo >&2 "$PGM(runner): exidir  : $WINEINSTEX"
        echo >&2 "$PGM(runner): srcdir  : $WINESRC"
        echo >&2 "$PGM(runner): builddir: $WINEBLD"
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
    echo >&2 "$PGM: runner cmd '$cmd' returned $rc"
    # Make sure that we have a final LF in the output and then write
    # the error line
    echo
    echo "EXITSTATUS=$rc" > "${builddir}/S.build.sh-rc"
    return 0
}


# Start our FIFO command runner.
runner_loop() {
   echo >&2 "$PGM: command runner started pid=$$"
   while : ; do
       if read -r cmd line < "${builddir}/S.build.sh-in" ; then
           echo >&2 "$PGM(runner): executing cmd"
           runner_exec_cmd "$cmd" "$line" >"${builddir}/S.build.sh-out" &
           echo >&2 "$PGM(runner): waiting for cmd"
           wait
           echo >&2 "$PGM(runner): cmd finished"
       fi
   done
   echo >&2 "$PGM: command runner stopped"
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
docker_cmdline="$docker_cmdline -v "$HOME/.gnupg-autogen.rc":/.gnupg-autogen.rc:ro"
docker_cmdline="$docker_cmdline $docker_image $cmd"
echo >&2 "$PGM: running: docker $docker_cmdline"
docker $docker_cmdline 2>&1 | tee -a ${logfile}
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
    if [ "$dist" = "yes" ]; then
        results=$(find "${builddir}" -maxdepth 1 -name \*.tar.xz \
                  -a -type f -printf '%p ')
    elif [ "$appimage" = "yes" ]; then
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

echo >&2 "$PGM: Logfile: ${logfile}"
echo >&2 "$PGM: Build command: ${commandline}"
echo >&2 "$PGM: Build time: $buildtime"
echo >&2 "$PGM: ##############################################"

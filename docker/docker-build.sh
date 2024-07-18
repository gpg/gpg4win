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
#
# SPDX-License-Identifier: GPL-2.0+

# Packages the current HEAD of a git repository as tarball and generates
# a text block that can be copy and pasted into packages.current.


set -e

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS]
Build Gpg4win in a docker containter.

Options:
        --appimage      Build the AppImage
        --gpg-2.2       Use GnuPG 2.2 instead of the default
        --dirty         Include uncommited changes
        --shell         Start a shell instead of starting a buildscript
        --root-shell    Start a root shell
        --clean-pkgs    Do not use already downloaded packages
        --inplace       Build in the current directoy
        --buildroot     Directory where the build should take place
        --update-image  Update the docker image before build

This builds either the Appimage the Windows installer.
By default the build is done in \$TMPDIR (${TMPDIR}) with
a subdirectory prefixed with gpg4win.
Use the option --inplace or --buildroot to change that behavior.

Note that the option --dirty uses rsync to copy the local
checkout without the delete option.

Examples:
    ./$0
        Clone the current gpg4win directory to a temporary
        directory and build an installer there.

    ./$0 --dirty --buildroot /home/$USER/build/
        Make a copy with rsync of the current gpg4win checkout
        and build in that directory. E.g. for development.

    ./$0 --inplace
        Build in the current checkout directory. For
        example to rebuild a source tarball.
EOF
    exit $1
}

gpg22="no"
dirty="no"
shell="no"
root_shell="no"
clean_pkgs="no"
inplace="no"
branch="master"
srcdir=$(cd $(dirname $0)/..; pwd)
is_tmpbuild="no"
update_image="no"

while [ $# -gt 0 ]; do
    case $1 in
        --appimage) appimage="yes";;
        --gpg-2.2) gpg22="yes";;
        --dirty) dirty="yes";;
        --shell) shell="yes";;
        --root-shell) root_shell="yes";;
        --clean-pkgs) clean_pkgs="yes";;
        --inplace) inplace="yes";;
        --update-image) update_image="yes";;
        --buildroot) buildroot="$2"; shift; ;;
        *) usage 1 1>&2; exit 1;;
    esac
    shift
done

# Set default build directory if not specified
if [ -z "$buildroot" ]; then
    buildroot=$(mktemp -d --tmpdir gpg4win.XXXXXXXXXX)
    is_tmpbuild="yes"
fi

if [ "$appimage" == "yes" ]; then
    cmd=/build/src/appimage/build-appimage.sh
    docker_image=g10-build-appimage:sles15
    dockerfile=${srcdir}/docker/appimage
else
    cmd=/build/src/build-gpg4win.sh
    docker_image=g10-build-gpg4win:bookworm
    dockerfile=${srcdir}/docker/gpg4win-bookworm
fi

drep=$(echo $docker_image | cut -d : -f 1)
dtag=$(echo $docker_image | cut -d : -f 2)
if [ -z "$(docker images | grep $drep | grep $dtag)" -o "$update_image" == "yes" ]; then
    echo "Local image $docker_image not found"
    echo "Building docker image"
    docker build -t $docker_image $dockerfile 2>&1
fi

# make a local clone or export of gpg4win to keep the working copy clean

if [ "$inplace" == "yes" ]; then
    echo "Building in $srcdir"
    gpg4win_dir="$srcdir"
else
    echo "Building in $buildroot"
    mkdir -p "$buildroot"
    gpg4win_dir="${buildroot}/gpg4win"
    if test ! -d "${gpg4win_dir}"; then
        if [ "$dirty" == "yes" ]; then
            mkdir -p "${gpg4win_dir}"
            rsync -av --exclude ".git" --exclude "playground" \
                --exclude '*.tar.*' --exclude '*.zip' \
                --exclude '*.exe' --exclude '*.wixlib' \
                --exclude 'stamps'  --exclude 'installers' \
                "${srcdir}/" "${gpg4win_dir}/"
        else
            git clone "${srcdir}" "${gpg4win_dir}"
        fi
    else
        rsync -av --exclude ".git" --exclude "playground" \
            --exclude '*.tar.*' --exclude '*.zip' \
            --exclude '*.exe' --exclude '*.wixlib' \
            --exclude 'stamps'  --exclude 'installers' \
            "${srcdir}/" "${gpg4win_dir}/"
        echo "Continuing with existing directory"
    fi
fi

if [ "$clean_pkgs" == "no" -a "$inplace" == "no" ]; then
    echo "Copying packages from ${srcdir}/packages .."
    files=$(find ${srcdir}/packages -name \*.tar\* -o -name \*.zip -o -name \*.exe -o -name \*.wixlib)
    cp $files ${gpg4win_dir}/packages
fi

# Always call ./packages/download.sh to avoid accidentally
# using old tarballs. Local tarball switches can be done
# if the file and checksum is updated in the packages
# file.
cd ${gpg4win_dir}/packages

echo "Downloading packages"
if [ "$gpg22" == "yes" ]; then
    ./download.sh --v3
else
    ./download.sh
fi

userid=$(id -u)
grouid=$(id -g)

if [ "$root_shell" == "yes" ]; then
    userid="0"
    groupid="0"
    cmd="bash"
fi

if [ "$shell" == "yes" ]; then
    cmd="bash"
fi

start_time=$(date +"%s")

if [ "$appimage" == "yes" ]; then
    log_file="${buildroot}/appimage-buildlog.txt"
else
    log_file="${buildroot}/gpg4win-buildlog.txt"
fi

docker run -it --rm --user "$userid:$groupid" \
    --volume ${gpg4win_dir}:/build \
    $docker_image $cmd 2>&1 | tee ${buildroot}/build-log.txt

end_time=$(date +"%s")

duration=$((end_time - start_time))
hours=$((duration / 3600))
minutes=$((duration % 3600 / 60))
seconds=$((duration % 60))

if [ ! $err ]; then
    echo ""
    echo "#################### Finished ####################"
    echo "   Results (if successfull) can be found under:"
    echo "   ${gpg4win_dir}/src/installers"
    echo "   Log can be found at:"
    echo "   ${log_file}"
    echo -n "    Build took: $buildtime"
    printf "%02d:%02d:%02d\n" "$hours" "$minutes" "$seconds"
fi

if [ "$is_tmpbuild" == "yes" ]; then
    rm -I -rf "${buildroot}";
fi

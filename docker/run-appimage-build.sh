#! /bin/bash

set -e

if [ "$1" = "--devel" ]; then
    devmode=
else
    devmode="/build-appimage.sh"
fi

sourcedir=$(cd $(dirname $0)/..; pwd)

if [ -z "$devmode" ]; then
    buildroot="/tmp/appimage-gnupg.$(id -un).d"
    [ -d "$buildroot" ] || mkdir "$buildroot"
else
    buildroot=$(mktemp -d --tmpdir appimage-gnupg.XXXXXXXXXX)
fi
echo Using ${buildroot}


docker run -it --rm --user "$(id -u):$(id -g)" \
    --volume ${sourcedir}:/src \
    --volume ${buildroot}:/build \
    g10-build-appimage-kleopatra:centos7 $devmode

echo "You can find the AppImage in ${buildroot} (if the build succeeded)."

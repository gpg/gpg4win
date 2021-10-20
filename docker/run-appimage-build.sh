#! /bin/bash

set -e

sourcedir=$(cd $(dirname $0)/..; pwd)

buildroot=$(mktemp -d --tmpdir appimage-kleopatra.XXXXXXXXXX)
echo Using ${buildroot}

docker run -it --rm --user "$(id -u):$(id -g)" \
    --volume ${sourcedir}:/src \
    --volume ${buildroot}:/build \
    g10-build-appimage-kleopatra:centos7 \
    /build-appimage.sh

echo "You can find the AppImage in ${buildroot} (if the build succeeded)."

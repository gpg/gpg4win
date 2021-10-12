# Dockerfile - docker/appimage
# Copyright (C) 2021 g10 Code GmbH
#
# Software engineering by Ingo Klöcker <dev@ingo-kloecker.de>
#
# This file is part of GnuPG.
#
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-2.0+

FROM centos:7

# Import the CentOS 7 package signing key after verifying its fingerprint.
# Then add the software collections repository from the CentOS SCLo SIG and
# import its package signing key after verifying the fingerprint.
# Ditto for the EPEL 7 package signing key.
RUN test $(gpg --with-colons --with-fingerprint < /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 | grep ^pub: | wc -l) = 1 \
    && gpg --with-colons --with-fingerprint < /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 | grep -q ^fpr:::::::::6341AB2753D78A78A7C27BB124C6A8A7F4A80EB5 \
    && rpmkeys --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
    && yum -y update \
    && yum -y install \
        centos-release-scl \
    && test $(gpg --with-colons --with-fingerprint < /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo | grep ^pub: | wc -l) = 1 \
    && gpg --with-colons --with-fingerprint < /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo | grep -q ^fpr:::::::::C4DBD535B1FBBA14F8BA64A84EB84E71F2EE9D55 \
    && rpmkeys --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo \
    && yum -y update \
    && yum -y install \
        epel-release \
    && test $(gpg --with-colons --with-fingerprint < /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 | grep ^pub: | wc -l) = 1 \
    && gpg --with-colons --with-fingerprint < /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 | grep -q ^fpr:::::::::91E97D7C4A5E96F17F3E888F6A2FAEA2352C64E5 \
    && rpmkeys --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 \
    && yum -y update \
    && rm -rf /root/.gnupg

RUN yum -y install \
        at-spi2-core-devel \
        automake \
        boost169-devel \
        bzip2 \
        bzip2-devel \
        cmake3 \
        cups-devel \
        dbus-devel \
        devtoolset-7-binutils \
        devtoolset-7-gcc \
        devtoolset-7-gcc-c++ \
        devtoolset-7-make \
        double-conversion-devel \
        egl-wayland-devel \
        file \
        fontconfig-devel \
        freetype-devel \
        gettext \
        git \
        gnutls-devel \
        gperf \
        gtk-update-icon-cache \
        harfbuzz-devel \
        libXrender-devel \
        libicu-devel \
        libinput-devel \
        libjpeg-devel \
        libpng-devel \
        libusbx-devel \
        libxkbcommon-x11-devel \
        libzstd-devel \
        mesa-libEGL-devel \
        mesa-libGL-devel \
        mtdev-devel \
        openldap-devel \
        openssl11-devel \
        patch \
        pcre2-devel \
        python36-lxml \
        readline-devel \
        stow \
        systemd-devel \
        wayland-devel \
        wget \
        which \
        xcb-util-image-devel \
        xcb-util-keysyms-devel \
        xcb-util-renderutil-devel \
        xcb-util-wm-devel \
        xz-devel \
        zlib-devel

# download the necessary linuxdeploy AppImages and extract them because we have no fuse in the container
RUN mkdir -p /tmp/download \
    && cd /tmp/download \
    && wget --no-verbose https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage \
    && wget --no-verbose https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage \
    && chmod +x linuxdeploy-* \
    && cd /tmp \
    && download/linuxdeploy-plugin-qt-x86_64.AppImage --appimage-extract \
    && download/linuxdeploy-x86_64.AppImage --appimage-extract \
    && rm -rf /tmp/download \
    && mkdir -p /opt \
    && mv /tmp/squashfs-root /opt/linuxdeploy

COPY build-appimage.sh /

RUN chmod +x build-appimage.sh

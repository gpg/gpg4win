# Dockerfile - docker/appimage
# Copyright (C) 2024 g10 Code GmbH
#
# Software engineering by Ingo Klöcker <dev@ingo-kloecker.de>
#                         Andre Heinecke <aheinecke@gnupg.org>
#
# This file is part of Gpg4win.
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

FROM registry.suse.com/suse/sle15:latest
RUN zypper --non-interactive update && \
    zypper --non-interactive install \
    # Build basics
    which file git-core cmake gcc13 gcc13-c++ glibc-devel-static cmake3 pkg-config \
    flex bison gperf awk patch wget automake \
    # Python
    python311 python311-lxml \
    # Libraries
    alsa-devel \
    boost-devel \
    openssl-devel \
    libicu-devel \
    libmount-devel \
    libudev-devel \
    libX11-devel \
    libX11-xcb1 \
    libxcb-devel \
    libXcomposite-devel \
    libXcursor-devel \
    libXi-devel \
    libxkbcommon-devel \
    libxkbcommon-x11-devel \
    libXrandr-devel \
    libXtst-devel \
    Mesa-libEGL-devel \
    Mesa-libGL-devel \
    readline-devel \
    vulkan-devel \
    vulkan-headers \
    wayland-devel \
    xcb-util-image-devel \
    xcb-util-keysyms-devel \
    xcb-util-renderutil-devel \
    xcb-util-wm-devel \
    xz-devel \
    zlib-devel

# cleanup to ensure we don't leave behind anything that doesn't need to be in the image
RUN zypper --non-interactive clean -a && \
    # make sure the appropriate gcc/python versions are the defaults
    alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 1 && \
    alternatives --install /usr/bin/cc cc /usr/bin/gcc-13 1 && \
    alternatives --install /usr/bin/cpp cpp /usr/bin/g++-13 1 && \
    alternatives --install /usr/bin/g++ gcc++ /usr/bin/g++-13 1 && \
    alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-13 1 && \
    alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3-3.11 1

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

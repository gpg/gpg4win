# Dockerfile - docker/gpg4win-bullseye
# Copyright (C) 2022 g10 Code GmbH
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

FROM debian:bullseye

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        autoconf \
        automake \
        bison \
        build-essential \
        cmake \
        docbook-utils \
        flex \
        gettext \
        ghostscript \
        git \
        gperf \
        gpgrt-tools \
        icoutils \
        imagemagick \
        libboost-dev \
        libgdk-pixbuf2.0-dev \
        libgettextpo-dev \
        libglib2.0-dev \
        libgtk2.0-bin \
        libkf5config-dev \
        libkf5config-dev-bin \
        libkf5coreaddons-dev \
        libxml2-utils \
        mingw-w64 \
        mingw-w64-i686-dev \
        mingw-w64-x86-64-dev \
        nsis \
        stow \
        texinfo \
        unzip \
        wget

RUN update-alternatives --install /usr/bin/i686-w64-mingw32-gcc i686-w64-mingw32-gcc /usr/bin/i686-w64-mingw32-gcc-posix 100
RUN update-alternatives --install /usr/bin/i686-w64-mingw32-g++ i686-w64-mingw32-g++ /usr/bin/i686-w64-mingw32-g++-posix 100
RUN sed -i /pattern=\"EPS\"/d /etc/ImageMagick-6/policy.xml

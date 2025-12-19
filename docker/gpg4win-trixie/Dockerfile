# Dockerfile - docker/gpg4win-bookworm
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
# SPDX-License-Identifier: GPL-2.0-or-later

FROM debian:trixie

RUN set -x \
    && apt-get update && apt-get --no-install-recommends --no-install-suggests -y install eatmydata

RUN set -x \
    && apt-get update \
    && eatmydata apt-get install --no-install-recommends --no-install-suggests -y \
        autoconf \
        automake \
        bison \
        build-essential \
        cmake \
        devscripts \
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
        libgettextpo-dev \
        libxml2-utils \
        mingw-w64 \
        mingw-w64-i686-dev \
        mingw-w64-x86-64-dev \
        nsis \
        stow \
        texinfo \
        unzip \
        pkg-config \
        python3-lxml \
        gtk-update-icon-cache \
        uuid-runtime \
        wget

RUN echo "deb-src http://deb.debian.org/debian stable main" >> /etc/apt/sources.list && apt update
ADD --checksum=sha256:d7d9ca50a42ae93f90382d80f199bb2995e08420154999bf72d5103624cd76b0 https://github.com/mingw-w64/mingw-w64/commit/8e06daa36dfcea4bb491acf4b350658f40738f02.patch /tmp/winpthread-run-reverse-order.patch
RUN set -x && mkdir /tmp/mingw && cd /tmp/mingw && apt source mingw-w64 && cd mingw-w64-12.0.0 \
      && cp /tmp/winpthread-run-reverse-order.patch debian/patches && pwd \
      && echo winpthread-run-reverse-order.patch >> debian/patches/series  \
      && eatmydata apt-get -y --no-install-recommends --no-install-suggests -o APT::Get::Build-Dep-Automatic=true build-dep ./ \
      && dch --nmu "Add patch to fix destruction order of thread local" \
      && dpkg-buildpackage -j 10 && dpkg -i ../mingw-w64-i686-dev_12.0.0-5.1_all.deb ../mingw-w64-x86-64-dev_12.0.0-5.1_all.deb ../mingw-w64-common_12.0.0-5.1_all.deb ../mingw-w64_12.0.0-5.1_all.deb \
      && apt -y autoremove && rm -rf /tmp/mingw


RUN update-alternatives --install /usr/bin/i686-w64-mingw32-gcc i686-w64-mingw32-gcc /usr/bin/i686-w64-mingw32-gcc-posix 100
RUN update-alternatives --install /usr/bin/i686-w64-mingw32-g++ i686-w64-mingw32-g++ /usr/bin/i686-w64-mingw32-g++-posix 100
RUN update-alternatives --install /usr/bin/x86_64-w64-mingw32-gcc x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix 100
RUN update-alternatives --install /usr/bin/x86_64-w64-mingw32-g++ x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix 100

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

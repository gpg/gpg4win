# Makefile.am - Installer for GnuPG 4 Windows Makefile.
# Copyright (C) 2005, 2008, 2012 g10 Code GmbH
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
# along with this program; if not, see <http://www.gnu.org/licenses/>.

ACLOCAL_AMFLAGS = -I m4
AUTOMAKE_OPTIONS = dist-xz no-dist-gzip
DISTCHECK_CONFIGURE_FLAGS = --host=i686-w64-mingw32

if BUILD_GPG4WIN
po = po
else
po =
endif
if BUILD_GPG4WIN
doc = doc
else
doc =
endif

SUBDIRS = ${po} packages ${doc} src

# find patches -type f | sort | sed 's/$/ \\/' | sed 's/^/             /'
# find -L patches-appimage -type f | sort | sed 's/$/ \\/' | sed 's/^/             /'

EXTRA_DIST = autogen.rc autogen.sh README.GIT ONEWS \
             doc/license-page doc/GPLv3 \
             build-aux/git-log-footer build-aux/git-log-fix \
             build-aux/authenticode-sign.sh \
             docker/appimage/Dockerfile \
             docker/appimage/Dockerfile-CentOS7 \
             docker/docker-build.sh \
             docker/gpg4win-bookworm/Dockerfile \
             patches/breeze-icons/0001-Draft-Handle-cross-compiling-for-tools.patch \
             patches/breeze-icons/add-the-nose.patch \
             patches/breeze/0001-Do-not-alias-QtOpenGL-and-QtNetwork.patch \
             patches/extra-cmake-modules/0001-Do-not-abort-without-QML-tools.patch \
             patches/extra-cmake-modules/0001-Use-BIN_INSTALL_DIR-data-for-DATAROOTDIR-on-Windows.patch \
             patches/jpeg/fix-redefine.patch \
             patches/kcalendarcore/0001-Add-option-to-build-without-QML.patch \
             patches/kcontacts/0001-Make-the-depedency-to-QML-optional.patch \
             patches/kcoreaddons/0001-Fix-MINGW-build.patch \
             patches/ki18n/0001-Undef-snprintf-for-windows.patch \
             patches/kio/0001-Remove-kencodingfiledialog-to-avoid-Qt5Compat.patch \
             patches/kio2/0001-WIP-Add-option-to-force-disable-DBus-and-KCrash.patch \
             patches/kjobwidgets/0001-Remove-knotification.patch \
             patches/knotifications/0001-Fix-build-wihout-QDbus.patch \
             patches/kparts_/0001-Change-check-from-Android-to-DBus-check.patch \
             patches/ktextaddons/0001-Remove-unused-QDbus-includes.patch \
             patches/libical/workaround-weird-mingw-10.0.0-issue.patch \
             patches/libkdepim/0001-Disable-dbus-on-windows-and-macOS.patch \
             patches/libkdepim/0002-Fix-compilation-with-mingw.patch \
             patches/libkdepim/0003-Remove-test-dependency-unless-we-compile-the-tests.patch \
             patches/okular/0001-Add-GnuPG-specific-manifest-to-okular.patch \
             patches/okular/lower-cmake-requirement.patch \
             patches/pcre2/cross-build-cmake.patch \
             patches/prison/0001-Only-include-ECMQmlModule-if-building-WITH_QUICK.patch \
             patches/qtbase/0001-Gpg4win-qstandardpaths-patch.patch \
             patches/qtbase/add-kleopatras-mime-types.patch \
             patches/qtbase/qt_use_share_instead_of_data.patch \
             patches-appimage/extra-cmake-modules/0001-Do-not-abort-without-QML-tools.patch \
             patches-appimage/kcrash/0001-DRAFT-Do-not-use-OpenGL-if-it-is-not-available.patch \
             patches-appimage/kio/0001-Remove-kencodingfiledialog-to-avoid-Qt5Compat.patch \
             patches-appimage/kjobwidgets/0001-Remove-knotification.patch \
             patches-appimage/okular/0001-Make-KF6Pty-dependency-optional.patch \
             patches-appimage/okular/lower-cmake-requirement.patch \
             patches-appimage/qtbase/add-kleopatras-mime-types.patch

dist-hook: gen-ChangeLog

gen_start_date = 2012-03-26T00:00:00
.PHONY: gen-ChangeLog
gen-ChangeLog:
	set -e;                         				\
	if test -d $(top_srcdir)/.git; then				\
	  (cd $(top_srcdir) &&                      			\
	    $(GITLOG_TO_CHANGELOG) --append-dot --tear-off		\
	    --amend=build-aux/git-log-fix                		\
	    --since=$(gen_start_date) ) > $(distdir)/cl-t;		\
          cat $(top_srcdir)/build-aux/git-log-footer >> $(distdir)/cl-t;\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

download: packages/packages.common packages/packages.4 packages/packages.3
	(cd packages; ./download.sh)

vsd-versions: src/stamps/stamp-versions-all-signed

msi:
	$(MAKE) $(AM_MAKEFLAGS) -C src msi

msi-signed:
	$(MAKE) $(AM_MAKEFLAGS) -C src msi-signed

msi-upload:
	$(MAKE) $(AM_MAKEFLAGS) -C src msi-upload

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
# find patches-appimage -type f | sort | sed 's/$/ \\/' | sed 's/^/             /'

EXTRA_DIST = autogen.rc autogen.sh README.GIT ONEWS \
             doc/license-page doc/GPLv3 \
             build-aux/git-log-footer build-aux/git-log-fix \
             docker/appimage/Dockerfile \
             docker/build-appimage-docker-image.sh \
             docker/build-gpg4win-docker-image.sh \
             docker/gpg4win-bullseye/Dockerfile \
             docker/run-appimage-build.sh \
             docker/run-gpg4win-build.sh \
             patches/boost/boost-1-fixes.patch \
             patches/breeze-icons/0001-WIP-Qt6-replacement-for-binary-icons.patch \
             patches/breeze-icons/add-the-nose.patch \
             patches/breeze-icons/azz-Make-all-breeze-icons-available-in-breeze-dark.patch \
             patches/extra-cmake-modules/0001-Do-not-abort-without-QML.patch \
             patches/extra-cmake-modules/0001-Use-BIN_INSTALL_DIR-data-for-DATAROOTDIR-on-Windows.patch \
             patches/jpeg/fix-redefine.patch \
             patches/kconfigwidgets/0001-Don-t-use-DBus-on-Windows-macOS.patch \
             patches/ki18n/0001-Undef-snprintf-for-windows.patch \
             patches/kio/0001-WIP-Add-option-to-force-disable-DBus-and-KCrash.patch \
             patches/kleopatra/0001-No-more-WindowsWindowFunction.patch \
             patches/knotifications/0001-Fix-build-wihout-QDbus.patch \
             patches/kparts/0001-Change-check-from-Android-to-DBus-check.patch \
             patches/kxmlgui_bkp/0001-make-qdbus-optional.patch \
             patches/kxmlgui_bkp/0004-Cruedly-disable-KSendbugmail.patch \
             patches/libical/workaround-weird-mingw-10.0.0-issue.patch \
             patches/okular/0001-Add-GnuPG-specific-manifest-to-okular.patch \
             patches/okular/0001-Do-not-fail-if-WITH_K7ZIP-is-not-defined.patch \
             patches/okular/lower-cmake-requirement.patch \
             patches/pcre2/cross-build-cmake.patch \
             patches/prison/0001-Only-include-ECMQmlModule-if-building-WITH_QUICK.patch \
             patches-appimage/libkleo/gpg4win-check.patch \
             patches-appimage/okular/lower-cmake-requirement.patch \
             patches-appimage/qtbase/add-kleopatras-mime-types.patch

copy-news:
	cp NEWS doc/website/NEWS.last


copy-release: gpg4win-$(VERSION).tar.bz2 installers/gpg4win-$(VERSION).exe \
	      installers/gpg4win-light-$(VERSION).exe \
	      installers/gpg4win-vanilla-$(VERSION).exe
	@echo Copying $(VERSION) to $(RELEASEHOST) >&2
	@set -e;\
	if ssh "$$(echo $(RELEASEHOST)|cut -d: -f -1)" \
        test -f "$$(echo $(RELEASEHOST)/gpg4win-$(VERSION).exe|cut -d: -f2-)";\
	then echo "This release has already been copied to the server" >&2 ;\
	else scp gpg4win-$(VERSION).tar.bz2 \
	         installers/gpg4win-$(VERSION).exe \
	         installers/gpg4win-light-$(VERSION).exe \
	         installers/gpg4win-vanilla-$(VERSION).exe \
	         installers/gpg4win-src-$(VERSION).exe  $(RELEASEHOST)/ ;\
	     for f in en de ; do \
	       scp src/README.$$f.txt \
	             $(RELEASEHOST)/README-$(VERSION).$$f.txt; \
	     done;\
	fi

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

msi:
	$(MAKE) $(AM_MAKEFLAGS) -C src msi

msi-signed:
	$(MAKE) $(AM_MAKEFLAGS) -C src msi-signed

msi-upload:
	$(MAKE) $(AM_MAKEFLAGS) -C src msi-upload

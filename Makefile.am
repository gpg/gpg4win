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
AUTOMAKE_OPTIONS = dist-bzip2 no-dist-gzip
DISTCHECK_CONFIGURE_FLAGS = --host=i686-w64-mingw32

SUBDIRS = po packages doc src

# find patches -type f | sort | sed 's/$/ \\/' | sed 's/^/             /'

EXTRA_DIST = autogen.sh README.GIT ONEWS \
        doc/license-page doc/GPLv3 \
        build-aux/git-log-footer build-aux/git-log-fix \
        patches/glib-2.41.5/01-socket.patch \
        patches/qtbase/fix-freetype-link.patch \
        patches/qtbase/fix-oci-detect.patch \
        patches/qtbase/fix-syssemaphore.patch \
        patches/qtbase/fix-zlib-link.patch \
        patches/qtbase/relative-paths.patch \
        patches/qtbase/fix-fontconfig.patch \
        patches/qtbase/config-standardpaths.patch \
        patches/w32pth-2.0.5/workaround-broken-libtool.patch \
        patches/qttools/disable-most-tools.patch \
        patches/ki18n/no-tests.patch \
        patches/gpgme-1.9.0/0001-core-Don-t-split-gpgconf-strings-on-comma.patch \
        patches/kxmlgui/0002-Make-QDBus-dependency-optional.patch \
        patches/kxmlgui/0003-Make-KTextWidgets-optional.patch \
        patches/kxmlgui/0004-Cruedly-disable-KSendbugmail.patch \
        patches/kconfigwidgets/0001-Make-QDbus-optional.patch \
        patches/kconfigwidgets/0002-Crudely-remove-KF5Auth-depedency.patch \
        patches/kiconthemes/0001-Make-DBus-optional.patch \
        patches/qtsvg/qtsvg-link-zlib.patch \
        patches/extra-cmake-modules/0001-Add-convert-utility-support-for-Windows-icons.patch \
        patches/kleopatra/0005-Hack-generated-conf-files-for-Crosscompiling.patch \
        patches/kleopatra/lower-kf5-required.patch \
        patches/kleopatra/relax-gpgme-checks.patch \
        patches/kleopatra/fix-qt5.6-build.patch \
        patches/libgpg-error-1.21/0001-Add-FD_ISSET-replacement-for-Windows.patch \
        patches/gpgex-1.0.4/0001-Prefer-kleowrapped-gpgwrapped-binaries.patch \
        patches/libkleo/lower-kf5-required.patch \
        patches/gpgex-1.0.4/0002-Fix-loop-logic-error-in-new-server-name-detection.patch \
        patches/extra-cmake-modules/0001-Use-BIN_INSTALL_DIR-data-for-DATAROOTDIR-on-Windows.patch \
        patches/gpa-0.9.10/0001-w32-Make-location-of-locale-dir-more-flexible.patch

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

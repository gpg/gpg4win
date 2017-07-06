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
        patches/dirmngr-1.1.1/dirmngr-pth.patch \
        patches/dirmngr-1.1.1/dirmngr-load-crl-from-fs.patch \
        patches/glib-2.41.5/01-socket.patch \
        patches/gnupg2/0001-Enable-wildcard-expansion-with-mingw-w64.patch \
        patches/gnupg2/0002-Let-wchar_to_native-convert-to-console-codepage.patch \
        patches/gnupg2/0005-Fix-gpgtar-8-bit-encoding-handling-on-Win32.patch \
        patches/gnupg2/0006-gpgsm-Add-command-option-offline.patch \
        patches/gnupg2/01-version.patch \
        patches/gnupg2/01-version.patch.in \
        patches/gnutls-2.12.24/01-openssl-wincrypt.patch \
        patches/gnutls-2.12.24/02-cve-2013-2116.patch \
        patches/gnutls-2.12.24/03-cve-2014-1959.patch \
        patches/gnutls-2.12.24/04-cve-2014-0092.patch \
        patches/gnutls-2.12.24/05-cve-2014-3466.patch \
        patches/gnutls-2.12.24/06-cve-2015-0282.patch \
        patches/gnutls-2.12.24/07-cve-2015-0294.patch \
        patches/gnutls-2.12.24/fix-gcrypt-private-api-usage.patch \
        patches/gnutls-2.12.24/gnulib-mingw-w64-fix.patch \
        patches/gnutls-2.12.24/25_updatedgdocfrommaster.patch \
        patches/libtasn1-2.14/gnulib-mingw-w64-fix.patch \
        patches/w32pth-2.0.5/workaround-broken-libtool.patch \
        patches/scute-1.4.0/workaround-broken-libtool.patch \
        patches/libassuan-2.4.0/0001-Fix-windows-build-with-mingw-w64-2.0.x.patch \
        patches/gpgex-1.0.4/0001-Prefer-kleowrapped-gpgwrapped-binaries.patch \
        patches/gpgex-1.0.4/0002-Fix-loop-logic-error-in-new-server-name-detection.patch \
        patches/gpgol-1.4.0/0001-Fix-UI-Server-startup.patch \
        patches/gpgol-1.4.0/0002-Ignore-sent-S-MIME-Mails-if-S-MIME-is-disabled.patch \
        patches/gpgol-1.4.0/0003-Fix-loop-logic-error-in-new-server-name-detection.patch \
        patches/libgpg-error-1.23/0001-Define-EWOULDBLOCK-in-case-it-is-not-defined.patch \
        patches/gpa-0.9.10/0001-Fix-crash-on-filename-conversion-error.patch

copy-news:
	cp NEWS doc/website/NEWS.last


copy-release: gpg4win-$(VERSION).tar.bz2 src/gpg4win-$(VERSION).exe \
	      src/gpg4win-light-$(VERSION).exe \
	      src/gpg4win-vanilla-$(VERSION).exe
	@echo Copying $(VERSION) to $(RELEASEHOST) >&2
	@set -e;\
	if ssh "$$(echo $(RELEASEHOST)|cut -d: -f -1)" \
        test -f "$$(echo $(RELEASEHOST)/gpg4win-$(VERSION).exe|cut -d: -f2-)";\
	then echo "This release has already been copied to the server" >&2 ;\
	else scp gpg4win-$(VERSION).tar.bz2 \
	         src/gpg4win-$(VERSION).exe \
	         src/gpg4win-light-$(VERSION).exe \
	         src/gpg4win-vanilla-$(VERSION).exe \
	         src/gpg4win-src-$(VERSION).exe  $(RELEASEHOST)/ ;\
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

# Makefile.am - Installer for GnuPG 4 Windows Makefile.
# Copyright (C) 2005, 2008 g10 Code GmbH
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
DISTCHECK_CONFIGURE_FLAGS = --host=i586-mingw32msvc --disable-pkg-man_advanced_en 

SUBDIRS = po packages include doc src

EXTRA_DIST = autogen.sh README.SVN ONEWS \
        patches/pthreads-w32-2-8-0-release/01-make.patch \
        patches/glib-2.12.12/01-giowin32.patch \
        patches/glib-2.12.12/02-gspawn-w32.patch \
        patches/glib-2.12.12/03-gspawn-w32-fixup.patch \
        patches/glib-2.20.0/01-socket.patch \
        patches/glib-2.24.0/01-socket.patch \
	patches/gpgme/01-gpg2.patch \
        patches/gpgme/02-w32-io-threads.patch \
	patches/gpgme-1.1.7/01-registry.patch \
	patches/gpgme-1.1.7/02-extern-umlaute.patch \
	patches/gpgme-1.1.7/03-error-parsing.patch \
        patches/gpgme-1.2.0/01-w32-io-threads.patch \
	patches/gpgme-1.2.0/02-inv-signer.patch \
	patches/gpgme-1.2.0/03-w32-socket.patch \
        patches/gpgme-1.2.0/04-check-agent.patch \
        patches/gpgme-1.2.0/05-is-socket.patch \
	patches/gpgex-0.9.5/01-default-no-suffix.patch \
	patches/gnupg2/01-version.patch.in \
	patches/gnupg2-2.0.9/01-close-all-handle.patch \
	patches/gnupg2-2.0.9/02-de.po-fix.patch \
	patches/gnupg2-2.0.9/03-i18n+etc.patch \
	patches/gnupg2-2.0.9/04-ks-w32init.patch \
	patches/gnupg2-2.0.9/05-w32-http.patch \
	patches/gnupg2-2.0.12/01-scd-pw2.patch \
	patches/gnupg2-2.0.12/02-pth-estream.patch \
	patches/gnupg2-2.0.12/03-opgp-writekey.patch \
	patches/gnupg2-2.0.12/04-hash-prefs.patch \
	patches/gnupg2-2.0.12/05-dns-sd.patch \
        patches/gnupg2-2.0.12/06-opgp-sign3072.patch \
        patches/gnupg2-2.0.12/07-gpg-no-detached.patch \
        patches/gnupg2-2.0.12/08-sm-learn-card.patch \
	patches/gnupg2-2.0.12/09-sm-keylist.patch \
	patches/gnupg2-2.0.12/10-inv-sgnr.patch \
	patches/gnupg2-2.0.12/11-photoid-sk.patch \
	patches/gnupg2-2.0.14/01-encode-s2k.patch \
	patches/gnupg2-2.0.14/02-scd-no-service.patch \
	patches/gnupg2-2.0.16/01-estream.patch \
	patches/gnupg2-2.0.16/02-gpgtar.patch \
	patches/dirmngr-1.0.3/01-ldaphttp.patch \
	patches/gpgol-0.9.91/01-gpgme.patch \
        patches/gpa-0.9.0/01-title-prop.patch \
	patches/libetpan-0.57/01-gnutls_compat.patch \
        patches/scute-1.2.0/01-bugfixes.patch \
        patches/scute-1.3.0/01-wsastartup.patch

copy-news:
	cp NEWS doc/website/NEWS.last


copy-release: gpg4win-$(VERSION).tar.bz2 src/gpg4win-$(VERSION).exe
	@echo Copying $(VERSION) to $(RELEASEHOST) >&2
	@set -e;\
	if ssh "$$(echo $(RELEASEHOST)|cut -d: -f -1)" \
        test -f "$$(echo $(RELEASEHOST)/gpg4win-$(VERSION).exe|cut -d: -f2-)";\
	then echo "This release has already been copied to the server" >&2 ;\
	else scp gpg4win-$(VERSION).tar.bz2 \
	         src/gpg4win-$(VERSION).exe \
	         src/gpg4win-light-$(VERSION).exe \
	         src/gpg4win-src-$(VERSION).exe  $(RELEASEHOST)/ ;\
	     for f in en de ; do \
	       scp src/README.$$f.txt \
	             $(RELEASEHOST)/README-$(VERSION).$$f.txt; \
	     done;\
	fi


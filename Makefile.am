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

EXTRA_DIST = autogen.sh README.SVN \
        patches/pthreads-w32-2-7-0-release/01-make.patch \
        patches/glib-2.9.2-wk1/01-giowin32.patch \
        patches/glib-2.9.2-wk1/02-gspawn-w32.patch \
        patches/glib-2.9.2-wk1/03-gspawn-w32-fixup.patch \
        patches/glib-2.9.2-wk1/04-gspawn-w32-buffering.patch \
        patches/glib-2.12.12/01-giowin32.patch \
        patches/glib-2.12.12/02-gspawn-w32.patch \
        patches/glib-2.12.12/03-gspawn-w32-fixup.patch \
	patches/claws-mail-3.1.0cvs70/01-w32-logo.patch \
	patches/claws-mail-3.1.0cvs70/02-w32-icon.patch \
	patches/claws-mail-3.1.0cvs70/03-smime-plugin.patch \
	patches/claws-mail-3.1.0cvs70/99-auto.patch \
	patches/claws-mail-3.4.0/01-w32-logo.patch \
	patches/claws-mail-3.4.0/02-w32-icon.patch \
	patches/claws-mail-3.4.0/03-smime-plugin.patch \
	patches/claws-mail-3.4.0/04-gnutls.patch \
	patches/claws-mail-3.4.0/99-auto.patch \
	patches/claws-mail-3.5.0cvs114/01-gtk-input-add.patch \
	patches/claws-mail-3.5.0cvs114/02-pgpcore.patch \
	patches/claws-mail-3.5.0cvs114/03-smime.patch \
	patches/claws-mail-3.5.0cvs114/99-auto.patch \
	patches/gpgme/01-gpg2.patch \
	patches/gpgme/02-kleo-bugs-workaround.patch \
	patches/libetpan-0.54/01-config.patch \
	patches/libetpan-0.54/02-index.patch \
	patches/winpt/01-gpg-path.patch \
	patches/gnupg2/01-version.patch.in \
	patches/gnupg2/02-p12-hack.patch \
        patches/gnupg2/03-argv-quote-fix.patch \
	patches/gnupg2-2.0.9/01-close-all-handle.patch \
	patches/gnupg2-2.0.9/02-de.po-fix.patch \
	patches/gnupg2-2.0.9/03-i18n+etc.patch \
	patches/gnupg2-2.0.9/04-ks-w32init.patch \
	patches/gnupg2-2.0.9/05-w32-http.patch \
	patches/gpgol-0.9.91/01-gpgme.patch \
        patches/scute-1.2.0/01-bugfixes.patch

copy-news:
	cp NEWS doc/website/NEWS.last


# Makefile.am - Installer for GnuPG 4 Windows Makefile.
# Copyright (C) 2005 g10 Code GmbH
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
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA

ACLOCAL_AMFLAGS = -I m4
AUTOMAKE_OPTIONS = dist-bzip2
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
	patches/sylpheed-claws-2.3.1/01-locale-dir.patch \
	patches/sylpheed-claws-2.3.1/02-fix-plugin-dir.patch \
	patches/sylpheed-claws-2.3.1/03-std-plugins.patch \
	patches/sylpheed-claws-2.3.1/04-pgpcore-def.patch \
        patches/sylpheed-claws-2.3.1/05-pgpinline-def.patch \
        patches/sylpheed-claws-2.3.1/06-pgpmime-def.patch \
        patches/sylpheed-claws-2.3.1/07-mbox.patch \
	patches/sylpheed-claws-2.3.1/08-w32-logo.patch \
	patches/sylpheed-claws-2.3.1/09-w32-icon.patch \
	patches/sylpheed-claws-2.3.1/99-auto.patch \
	patches/sylpheed-claws-2.4.0/01-w32-logo.patch \
	patches/sylpheed-claws-2.4.0/02-w32-icon.patch \
        patches/sylpheed-claws-2.4.0/03-plugins-symbols.patch \
        patches/sylpheed-claws-2.4.0/04-font-prefs.patch \
        patches/sylpheed-claws-2.4.0/05-textviewer.patch \
	patches/sylpheed-claws-2.4.0/99-auto.patch \
	patches/claws-mail-2.9.2/01-w32-logo.patch \
	patches/claws-mail-2.9.2/02-w32-icon.patch \
	patches/claws-mail-2.9.2/03-w32-port.patch \
	patches/claws-mail-2.9.2/04-smime-plugin.patch \
	patches/claws-mail-2.9.2/99-auto.patch

copy-news:
	cp NEWS doc/website/NEWS.last


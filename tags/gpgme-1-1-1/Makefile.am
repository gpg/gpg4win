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
DISTCHECK_CONFIGURE_FLAGS = --host=i586-mingw32msvc

SUBDIRS = packages include doc src

EXTRA_DIST = autogen.sh README.SVN \
	patches/gnupg-1.4.2/01-po-subdirs.patch \
	patches/gpgme-1.1.0/01-gpgme-def.patch \
	patches/gpgme-1.1.0/02-libtool-dll.patch \
        patches/pthreads-w32-2-7-0-release/01-make.patch \
        patches/glib-2.9.2-wk1/01-giowin32.patch \
        patches/glib-2.9.2-wk1/02-gspawn-w32.patch \
	patches/sylpheed-claws-1.9.100cvs124/01-fix-plugin-dir.patch \
	patches/sylpheed-claws-1.9.100cvs124/02-std-plugins.patch \
        patches/gpa-0.7.2/01-bin-open.patch
# configure.ac for GPG4Win
# Copyright (C) 2005 g10 Code GmbH
# 
# This file is part of GPG4Win
# 
# GPG4Win is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# GPG4Win is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 
# (Process this file with autoconf to produce a configure script.)

AC_PREREQ(2.59)

AC_INIT([gpg4win],[0.0.0-cvs],[gpg4win-devel@wald.intevation.org])

PACKAGE=$PACKAGE_NAME
VERSION=$PACKAGE_VERSION

AC_CONFIG_SRCDIR(include/config.sh.in)
AC_CONFIG_MACRO_DIR(m4)

AM_INIT_AUTOMAKE($PACKAGE, $VERSION)
AM_MAINTAINER_MODE
AC_CANONICAL_HOST

AC_SUBST(PACKAGE)
AC_SUBST(VERSION)


# Required tools.

AC_CHECK_PROGS(MAKE, make)
AC_CHECK_PROGS(UNZIP, unzip)
AC_CHECK_PROGS(TAR, tar)
AC_CHECK_PROGS(MKDIR, mkdir)
AC_CHECK_PROGS(CP, cp)
AC_CHECK_PROGS(RM, rm)
AC_CHECK_PROGS(STOW, stow)
AC_PROG_INSTALL


# Optional tools.

AC_CHECK_PROGS(WGET, wget)


# Packages.

GPG4WIN_BPKG_GNU([libiconv])
GPG4WIN_BPKG_GNU([gettext], [libiconv])

GPG4WIN_BPKG_GNUWIN32([zlib])
GPG4WIN_BPKG_GNUWIN32([libpng], [pkgconfig])

GPG4WIN_BPKG_GTK([pkgconfig])
GPG4WIN_BPKG_GTK_DEV([glib], [pkgconfig])
#GPG4WIN_BPKG_GTK_DEV([gtk+], [atk pango glib libiconv gettext pkgconfig])
GPG4WIN_BPKG_GTK_DEV([gtk+], [atk pango glib pkgconfig])
GPG4WIN_BPKG_GTK_DEV([atk], [glib pkgconfig])
GPG4WIN_BPKG_GTK_DEV([pango], [glib pkgconfig])

GPG4WIN_SPKG([libgpg-error])
GPG4WIN_SPKG([gpgme], [libgpg-error])
GPG4WIN_SPKG([gnupg])
GPG4WIN_SPKG([gpgol], [gpgme])
GPG4WIN_SPKG([gpa], [zlib gtk+ libpng glib gpgme])

GPG4WIN_FINALIZE


# Finalize.

AC_CONFIG_FILES(Makefile packages/Makefile include/Makefile src/Makefile)
AC_CONFIG_FILES(include/config.sh src/gpg4win.mk)
AC_OUTPUT

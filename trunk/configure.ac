# configure.ac for GPG4Win
# Copyright (C) 2005, 2006 g10 Code GmbH
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
min_automake_version="1.9.3"

# Remember to change the version number immediately *after* a release.
# Set my_issvn to "yes" for non-released code.  Remember to run an
# "svn up" and "autogen.sh" right before creating a distribution.
# Right after a release the make target "copy-news" is to be called!
m4_define([my_version], [1.0.5])
m4_define([my_issvn], [yes])

m4_define([svn_revision], m4_esyscmd([echo -n $((svn info 2>/dev/null \
          ||echo 'Revision: 0')|sed -n '/^Revision:/ s/[^0-9]//gp'|head -1)]))
AC_INIT([gpg4win], my_version[]m4_if(my_issvn,[yes],[-svn[]svn_revision]),
        [gpg4win-devel@wald.intevation.org])

# Remember to update these version numbers also in the NEWS file.
MANUALVERSION_EINSTEIGER="2.0.2"
MANUALDATE_EINSTEIGER="30. Mai 2006"
MANUALVERSION_DURCHBLICKER="2.0.2"
MANUALDATE_DURCHBLICKER="30. Mai 2006"


MANUALINPROGRESS_DE=m4_if(my_issvn,[yes],["~und evtl. seitdem weiter bearbeitet"])
SVN_REVISION=svn_revision
PACKAGE=$PACKAGE_NAME
VERSION=$PACKAGE_VERSION


AC_CONFIG_SRCDIR(include/config.nsi.in)
AC_CONFIG_MACRO_DIR(m4)

AM_INIT_AUTOMAKE
AM_MAINTAINER_MODE
AC_CANONICAL_HOST

AC_SUBST(PACKAGE)
AC_SUBST(VERSION)
AC_SUBST(MANUALVERSION_EINSTEIGER)
AC_SUBST(MANUALDATE_EINSTEIGER)
AC_SUBST(MANUALVERSION_DURCHBLICKER)
AC_SUBST(MANUALDATE_DURCHBLICKER)
AC_SUBST(MANUALINPROGRESS_DE)


# Generate extended version information.  Note, that for NSIS use we
# must not translate the dots to commas in the BUILD_FILEVERSION.
BUILD_TIMESTAMP=`date --iso-8601=minutes`
BUILD_ISODATE=`date --iso-8601`
changequote(,)dnl
BUILD_FILEVERSION=`echo "$VERSION" | sed 's/\([0-9.]*\).*/\1./'`
changequote([,])dnl
BUILD_FILEVERSION="${BUILD_FILEVERSION}${SVN_REVISION}"
AC_SUBST(BUILD_TIMESTAMP)
AC_SUBST(BUILD_ISODATE)
AC_SUBST(BUILD_FILEVERSION)


# For development of this package it is useful to build without
# creatign the source installer (takes a long time).  This option may
# be used to suppress creation of the source installer.
AC_ARG_ENABLE(source-installer,
    AC_HELP_STRING([--disable-source-installer],
                   [Do not create the Source installer]),
                    build_source_installer=$enableval,
                    build_source_installer=yes)
AC_MSG_RESULT($source_installer)
AM_CONDITIONAL(BUILD_SOURCE_INSTALLER, test "$build_source_installer" = yes)


# You can build a light version of the installer in addition to the
# regular version.  This one does not contain the manuals.
AC_ARG_ENABLE(light-installer,
    AC_HELP_STRING([--disable-light-installer],
                   [Do not create the light version of the installer]),
                    build_light_installer=$enableval,
                    build_light_installer=yes)
AC_MSG_RESULT($light_installer)
AM_CONDITIONAL(BUILD_LIGHT_INSTALLER, test "$build_light_installer" = yes)


# Required tools.
AC_PROG_CC
AC_PROG_CPP
AC_CHECK_TOOLS(DLLTOOL, dlltool)
AC_CHECK_PROGS(MAKE, make)
AC_CHECK_PROGS(UNZIP, unzip)
AC_CHECK_PROGS(TAR, tar)
AC_CHECK_PROGS(MKDIR, mkdir)
AC_CHECK_PROGS(CP, cp)
AC_CHECK_PROGS(RM, rm)
AC_CHECK_PROGS(STOW, stow)
AC_CHECK_PROGS(MAKENSIS, makensis)
AC_CHECK_PROGS(ZCAT, zcat)
AC_CHECK_PROGS(TEXI2DVI, texi2dvi)
AC_CHECK_PROGS(DVIPDF, dvipdf)
AC_CHECK_PROGS(CONVERT, convert)
AC_CHECK_PROGS(SHA1SUM, sha1sum)
AC_PROG_INSTALL

missing_tools=
for i in DLLTOOL MAKE UNZIP TAR MKDIR CP RM STOW MAKENSIS ZCAT TEXI2DVI \
         DVIPDF CONVERT SHA1SUM ; do
   eval tmp='$'$i
   if test -z "$tmp"; then 
      missing_tools="$missing_tools `echo $i | tr 'A-Z' 'a-z'`"
   fi
done


# Optional tools.

AC_CHECK_PROGS(WGET, wget)


# Packages.

GPG4WIN_BPKG_GNU([libiconv])
GPG4WIN_BPKG_GNU([gettext], [libiconv])

GPG4WIN_BPKG_GNUWIN32([zlib])
GPG4WIN_BPKG_GNUWIN32_LIB([crypt])
GPG4WIN_BPKG_GNUWIN32_LIB([regex])
GPG4WIN_BPKG_GNUWIN32([libpng], [pkgconfig])

GPG4WIN_BPKG_GTK([pkgconfig])
# We build our own version of glib, because we need to patch giowin32.c.
# GPG4WIN_BPKG_GTK_DEV([glib], [pkgconfig])
GPG4WIN_SPKG([glib], [libiconv gettext pkgconfig])
GPG4WIN_BPKG_GTK_DEV([gtk+], [atk pango glib libiconv gettext pkgconfig])
GPG4WIN_BPKG_GTK_DEV([atk], [glib pkgconfig])
GPG4WIN_BPKG_GTK_DEV([pango], [glib pkgconfig])
GPG4WIN_BPKG_BINSRC([GPGee], [gnupg])

GPG4WIN_SPKG([libgpg-error], [libiconv gettext])
GPG4WIN_SPKG([gpgme], [libgpg-error gnupg glib])
GPG4WIN_SPKG([gnupg])
GPG4WIN_SPKG([pthreads-w32])
GPG4WIN_SPKG([gpgol], [gpgme])
GPG4WIN_SPKG([gpa], [libiconv gettext zlib gtk+ libpng glib gpgme])
GPG4WIN_SPKG([winpt], [gpgme gnupg])
GPG4WIN_SPKG([sylpheed-claws], [libiconv gettext zlib gtk+ libpng glib dnl
                                gpgme pthreads-w32 crypt regex])
# The Eudora license (the one for thye EMS API) is still not acceptable.
#GPG4WIN_SPKG([eudoragpg])
GPG4WIN_IPKG([man_novice_de])
GPG4WIN_IPKG([man_advanced_de])

GPG4WIN_FINALIZE

# Throw an error if required tools are missing
if test -n "$missing_tools"; then
    for i in $missing_tools; do 
      AC_MSG_NOTICE([$i is missing])
    done
    AC_MSG_ERROR([[
***
*** Required tools not found. Please consult the above messages
*** and install them before running configure again.
***]])
fi


# Finalize.

AC_CONFIG_FILES(Makefile packages/Makefile include/Makefile src/Makefile)
AC_CONFIG_FILES(include/config.nsi src/gpg4win.mk)
AC_CONFIG_FILES(doc/Makefile)
AC_CONFIG_FILES(doc/logo/Makefile)
AC_CONFIG_FILES(doc/manual-de/Makefile doc/manual-de/version.tex)
AC_CONFIG_FILES(doc/website/Makefile)
AC_OUTPUT

# configure.ac for GPG4Win
# Copyright (C) 2005, 2006, 2007, 2008 g10 Code GmbH
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
# along with this program; if not, see <http://www.gnu.org/licenses/>.
 
# (Process this file with autoconf to produce a configure script.)

AC_PREREQ(2.59)
min_automake_version="1.9.3"

# Remember to change the version number immediately *after* a release.
# Set my_issvn to "yes" for non-released code.  Remember to run an
# "svn up" and "autogen.sh" right before creating a distribution.
# Right after a release the make target "copy-news" is to be called!
m4_define([my_version], [2.0.1rc1])
m4_define([my_issvn], [no])

m4_define([svn_revision], m4_esyscmd([echo -n $( (svn info 2>/dev/null \
          ||echo 'Revision: 0')|sed -n '/^Revision:/ s/[^0-9]//gp'|head -1)]))
AC_INIT([gpg4win], 
        [my_version[]m4_if(my_issvn,[yes],[-svn[]svn_revision])],
        [gpg4win-devel@wald.intevation.org])

# Remember to update these version numbers also in the NEWS file.
MANUALVERSION_EINSTEIGER="2.0.2"
MANUALDATE_EINSTEIGER="30. Mai 2006"
MANUALVERSION_DURCHBLICKER="2.0.2"
MANUALDATE_DURCHBLICKER="30. Mai 2006"
MANUALVERSION_NOVICES="1.0.0"
MANUALDATE_NOVICES="Nov. 30, 2006"
MANUALVERSION_ADVANCED="0.0.0"
MANUALDATE_ADVANCED="Nov. 30, 2006"
COMPENDIUM_VERSION_DE="3.0.0-beta4-1286"
COMPENDIUM_DATE_DE="14. September 2009"


MANUALINPROGRESS_DE=m4_if(my_issvn,[yes],["~und evtl. seitdem weiter bearbeitet"])
MANUALINPROGRESS_EN=m4_if(my_issvn,[yes],["~and may have been further edited"])
SVN_REVISION=svn_revision
PACKAGE=$PACKAGE_NAME
VERSION=$PACKAGE_VERSION


AC_CONFIG_SRCDIR(include/config.nsi.in)
AC_CONFIG_MACRO_DIR(m4)

AM_INIT_AUTOMAKE
AM_MAINTAINER_MODE
AC_CANONICAL_HOST
AM_CONFIG_HEADER(config.h)

# Language support
AM_PO_SUBDIRS


AC_SUBST(PACKAGE)
AC_SUBST(VERSION)
AC_SUBST(MANUALVERSION_EINSTEIGER)
AC_SUBST(MANUALDATE_EINSTEIGER)
AC_SUBST(MANUALVERSION_DURCHBLICKER)
AC_SUBST(MANUALDATE_DURCHBLICKER)
AC_SUBST(MANUALINPROGRESS_DE)
AC_SUBST(MANUALVERSION_NOVICES)
AC_SUBST(MANUALDATE_NOVICES)
AC_SUBST(MANUALVERSION_ADVANCED)
AC_SUBST(MANUALDATE_ADVANCED)
AC_SUBST(MANUALINPROGRESS_EN)
AC_SUBST(COMPENDIUM_VERSION_DE)
AC_SUBST(COMPENDIUM_DATE_DE)


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


# To test tye manuals using an actual web server, the preview target
# may be used in doc/manuals.  The default is my (wk) test environment
# but may be overriden using another preview variable.  PREVIEWHOST is
# expected to be the target for an rsync command.
if test -z "$PREVIEWHOST" ; then
   PREVIEWHOST="vigenere:/var/www/all/preview.gpg4win.org/htdocs/"
fi
AC_SUBST(PREVIEWHOST)


# For development of this package it is useful to build without
# creating the source installer (takes a long time).  This option may
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

AC_ARG_ENABLE(fast-makensis,
    AC_HELP_STRING([--enable-fast-makensis],
                   [Use a less efficient compressor to speed up building]),
                    use_fast_makensis=$enableval,
                    use_fast_makensis=no)
AC_MSG_RESULT($light_installer)
if test "$use_fast_makensis" = yes; then
  EXTRA_MAKENSIS_FLAGS="${EXTRA_MAKENSIS_FLAGS} -DDISABLE_LZMA=1"
fi
AC_SUBST(EXTRA_MAKENSIS_FLAGS)


# Required tools.
AC_PROG_CC
AC_PROG_CPP
AC_PROG_RANLIB
AC_CHECK_TOOL(AR, ar, :)
AC_CHECK_TOOLS(STRIP, strip)
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
AC_CHECK_PROGS(MSGFMT, msgfmt)
AC_PROG_INSTALL

missing_tools=
for i in DLLTOOL MAKE UNZIP TAR MKDIR CP RM STOW MAKENSIS ZCAT TEXI2DVI \
         DVIPDF CONVERT SHA1SUM MSGFMT ; do
   eval tmp='$'$i
   if test -z "$tmp"; then 
      missing_tools="$missing_tools `echo $i | tr 'A-Z' 'a-z'`"
   fi
done



# Optional tools.

AC_CHECK_PROGS(WGET, wget)


# Packages.
gpg4win_dup_sources=""

GPG4WIN_BPKG_GNU([libiconv])
GPG4WIN_BPKG_GNU([gettext], [libiconv])

GPG4WIN_BPKG_GNUWIN32([zlib])
GPG4WIN_BPKG_GNUWIN32_LIB([crypt])
GPG4WIN_BPKG_GNUWIN32([regex])
GPG4WIN_BPKG_GNUWIN32([jpeg])
GPG4WIN_BPKG_GNUWIN32([bsfilter])

GPG4WIN_BPKG_GTK([pkgconfig])
# We build our own version of glib, because we need to apply a few patches.
# GPG4WIN_BPKG_GTK_DEV([glib], [pkgconfig])
GPG4WIN_SPKG([glib], [libiconv gettext pkgconfig])
GPG4WIN_BPKG_GTK_DEV([atk], [glib pkgconfig])
GPG4WIN_BPKG_GTK_DEV([pango], [glib pkgconfig])
GPG4WIN_BPKG_GTK_DEV([cairo], [glib pkgconfig])
GPG4WIN_BPKG_GTK_DEV([gtk+], [libiconv gettext pkgconfig atk pango glib cairo])
GPG4WIN_BPKG_GTK_DEV([libpng], [pkgconfig])

GPG4WIN_SPKG([bzip2])
GPG4WIN_SPKG([adns])
GPG4WIN_SPKG([libgpg-error], [libiconv gettext])
GPG4WIN_SPKG([libgcrypt], [libgpg-error])
GPG4WIN_SPKG([libksba], [libgpg-error])
GPG4WIN_SPKG([w32pth])
GPG4WIN_SPKG([libassuan], [libgpg-error w32pth])
GPG4WIN_SPKG([dirmngr], [libgpg-error libgcrypt libassuan libksba w32pth])
GPG4WIN_SPKG([pinentry], [libiconv gtk+])
GPG4WIN_SPKG([gpgme], [libgpg-error gnupg2 glib])
GPG4WIN_SPKG([curl], [zlib gnutls])
GPG4WIN_SPKG([gnupg2], [libiconv libgcrypt libksba libassuan libgpg-error dnl
                        w32pth zlib bzip2 adns pinentry])
GPG4WIN_SPKG([pthreads-w32])
GPG4WIN_SPKG([gpgol], [gpgme libassuan])
GPG4WIN_SPKG([gpgex], [libassuan])
GPG4WIN_SPKG([scute], [libgpg-error libassuan])
GPG4WIN_SPKG([paperkey])
GPG4WIN_SPKG([gpa], [libiconv gettext zlib gtk+ libpng glib gpgme])
GPG4WIN_SPKG([winpt], [gpgme gnupg2])
GPG4WIN_SPKG([libgsasl])
GPG4WIN_SPKG([libtasn1])
GPG4WIN_SPKG([gnutls], [libgsasl libtasn1 libgcrypt])
GPG4WIN_SPKG([libetpan], [pthreads-w32 gnutls])
GPG4WIN_SPKG([libxml2], [zlib])
GPG4WIN_SPKG([claws-mail], [libiconv gettext zlib gtk+ libpng jpeg glib dnl
                            gpgme pthreads-w32 crypt regex libetpan gnutls])
GPG4WIN_SPKG([notification_plugin], [claws-mail])
GPG4WIN_SPKG([gtkhtml2_viewer], [curl claws-mail libxml2])
GPG4WIN_SPKG([vcalendar], [curl claws-mail])
GPG4WIN_SPKG([rssyl], [curl claws-mail])
GPG4WIN_SPKG([tnef_parse], [claws-mail])
GPG4WIN_SPKG([attachwarner], [claws-mail])
GPG4WIN_SPKG([bsfilter_plugin], [claws-mail])
GPG4WIN_IPKG([compendium_de])
GPG4WIN_IPKG([man_novice_en])
#GPG4WIN_IPKG([man_advanced_en])

# Qt related stuff.
GPG4WIN_BPKG_GNUWIN32([kdesupport])
GPG4WIN_BPKG_BINSRC([oxygen-icons])
GPG4WIN_BPKG_GNUWIN32([qt], [kdesupport])
GPG4WIN_BPKG_GNUWIN32([kdelibs], [qt oxygen-icons])
GPG4WIN_BPKG_BINSRC([kleopatra], [gpgme gnupg2 kdelibs])
#GPG4WIN_BPKG_GNUWIN32([kleopatra], [gpgme gnupg2 kdelibs])

GPG4WIN_FINALIZE

# Qt is compiled with -mthreads, and thus requires the mingwm10.dll.
mingwm_dll=no
AC_ARG_WITH([mingwm-dll],
	    AC_HELP_STRING([--with-mingwm-dll=FILE], [use the mingwm DLL]),
	    [mingwm_dll=$withval])
if test "$mingwm_dll" = "no"; then
  file="/usr/share/doc/mingw32-runtime/mingwm10.dll.gz"
  if test -r "$file"; then
    mingwm_dll="$file"
  fi
fi
if test "$mingwm_dll" = "no"; then
  missing_tools="mingwm10.dll $missing_tools"
fi
# To make things simple, we just install a copy of the file in the
# source directory.  No need to make this ugly hack any uglier by
# messing around with the build system.
case "$mingwm_dll" in
    *.gz)
      $ZCAT $mingwm_dll > src/mingwm10.dll
      ;;
    *)
      cp $mingwm_dll src/mingwm10.dll
      ;;
esac


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

# Throw an error if any duplicate source packages have been found
if test -n "$gpg4win_dup_sources"; then
    tmp=
    for i in $gpg4win_dup_sources; do 
      tmp="$tmp
$i"
    done
    AC_MSG_ERROR([Packages with more that one source version:$tmp])
fi


# Finalize.

AC_CONFIG_COMMANDS([gpg4win-conf],[[
chmod +x patches/gnupg2/01-version.patch
]])

AC_CONFIG_FILES(Makefile)
AC_CONFIG_FILES(packages/Makefile include/Makefile src/Makefile po/Makefile.in)
AC_CONFIG_FILES(include/config.nsi src/gpg4win.mk)
AC_CONFIG_FILES(doc/Makefile)
AC_CONFIG_FILES(doc/logo/Makefile)
AC_CONFIG_FILES(doc/manual/Makefile doc/manual/version.tex)
AC_CONFIG_FILES(doc/website/Makefile)
AC_CONFIG_FILES(patches/gnupg2/01-version.patch)
AC_OUTPUT

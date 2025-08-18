# configure.ac for GPG4Win
# Copyright (C) 2005, 2006, 2007, 2008, 2010, 2023 g10 Code GmbH
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

# To build a release you need to create a tag with the version number
# (git tag -s gpg4win-2.x.y) and run "./autogen.sh --force".  Please
# bump the version number immediately after the release and do another
# commit and push so that the git magic is able to work.
# BUILDTYPE can be used to build the VSD or GPD versions.  Note that
# IS_VSD_BUILD is set along with IS_GPD_BUILD.
m4_define([mym4_package],[gpg4win])
m4_define([mym4_isvsd],[no])
m4_define([mym4_isgpd],[no])
m4_define([mym4_isv3build], m4_if(m4_esyscmd([ls packages/gnupg-2.*.tar.* | \
                                             head -1 | cut -d. -f2 | \
                                             tr -d '\n']),
                                             [2],  [yes], [no]))
m4_define([mym4_buildtype],
           m4_chomp_all(m4_esyscmd([(cat packages/BUILDTYPE 2>/dev/null\
                                                      || echo default)])))
m4_if(mym4_buildtype,[vsd],[m4_define([mym4_isvsd],[yes])
                            m4_define([mym4_isv3build],[yes]]))

# For VSD with GnuPG 2.6 we will use version 4.x
# For GPD and Gpg4win with GnuPG 2.6 we use version 5.x
m4_if(mym4_buildtype,vsd,
      [m4_define([mym4_major],[4])
       m4_define([mym4_minor],[0])
       m4_define([mym4_micro],[0])],
      [m4_define([mym4_major],[5])
       m4_define([mym4_minor],[0])
       m4_define([mym4_micro],[0])])


# We need to set isgpd only after having set the version number.
m4_if(mym4_buildtype,[gpd],[m4_define([mym4_isvsd],[yes])
                            m4_define([mym4_isgpd],[yes])])


# Below is m4 magic to extract and compute the git revision number,
# the decimalized short revision number, a beta version string and a
# flag indicating a development version (mym4_isbeta).  Note that the
# m4 processing is done by autoconf and not during the configure run.
m4_define([mym4_tsdir], m4_chomp_all(m4_esyscmd([./autogen.sh --print-tsdir])))
m4_define([mym4_verslist], m4_split(m4_esyscmd([./autogen.sh --find-version] \
                          mym4_package mym4_major mym4_minor mym4_micro),[:]))
m4_define([mym4_isbeta],       m4_argn(2, mym4_verslist))
m4_define([mym4_ingit],        m4_argn(3, mym4_verslist))
m4_define([mym4_version],      m4_argn(4, mym4_verslist))
m4_define([mym4_betastr],      m4_argn(6, mym4_verslist))
m4_define([mym4_revision],     m4_argn(7, mym4_verslist))
m4_define([mym4_revision_dec], m4_argn(8, mym4_verslist))
m4_define([mym4_commitid],     m4_argn(9, mym4_verslist))

m4_esyscmd([echo ]mym4_version[>VERSION])
m4_esyscmd([echo ]mym4_commitid[>>VERSION])

AC_INIT([mym4_package],[mym4_version],[https://bugs.gnupg.org])


PACKAGE=$PACKAGE_NAME
VERSION=$PACKAGE_VERSION
BUILD_COMMITID="mym4_commitid"
GIT_REVISION=mym4_revision
GIT_REVISION_DEC=mym4_revision_dec
GIT_BETASTRING=mym4_betastr
IS_BETA_BUILD=mym4_isbeta
IS_VSD_BUILD=mym4_isvsd
IS_GPD_BUILD=mym4_isgpd

# Variables for the version info
PRODUCT_NAME=m4_if(mym4_isvsd, [yes], ["GnuPG VS-Desktop"],
                   m4_if(mym4_isgpd, [yes], ["GnuPG Desktop"], ["Gpg4win"]))
COMPANY_NAME=m4_if(mym4_buildtype, [default],
                ["Gpg4win Community"], ["g10 Code GmbH"])

# Early sanity checks and dirs
AC_CONFIG_SRCDIR(src/nsis/config.nsi.in)
AC_CONFIG_MACRO_DIR(m4)

AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([tar-ustar])
AM_MAINTAINER_MODE
AC_CANONICAL_HOST
AC_CONFIG_HEADERS([config.h])


AC_SUBST(PRODUCT_NAME)
AC_SUBST(COMPANY_NAME)
AC_SUBST(PACKAGE)
AC_SUBST(VERSION)
AC_SUBST(GIT_BETASTRING)
AC_SUBST(IS_BETA_BUILD)
AC_SUBST(IS_VSD_BUILD)
AC_SUBST(IS_GPD_BUILD)
AC_SUBST(BUILD_COMMITID)

# Generate extended version information.  Note, that for NSIS use we
# must not translate the dots to commas in the BUILD_FILEVERSION.
BUILD_TIMESTAMP=`date --iso-8601=minutes`
BUILD_ISODATE=`date --iso-8601`
BUILD_DATETIME=`date +%Y%m%d%H%M`
changequote(,)dnl
BUILD_FILEVERSION=`echo "$VERSION" | sed 's/\([0-9.]*\).*/\1./'`
changequote([,])dnl
BUILD_FILEVERSION="${BUILD_FILEVERSION}${GIT_REVISION_DEC}"
BUILD_FILEVERSION_TR=`echo "${BUILD_FILEVERSION}" | tr . ,`
changequote(,)dnl
BUILD_BETANUM=`let a=$(($(echo "${GIT_BETASTRING}"|sed 's/[^0-9]*//')+0));echo $a`
changequote([,])dnl
AC_SUBST(BUILD_BETANUM)
AC_SUBST(BUILD_TIMESTAMP)
AC_SUBST(BUILD_ISODATE)
AC_SUBST(BUILD_FILEVERSION)
AC_SUBST(BUILD_FILEVERSION_TR)


# The final release is copied to an archive server.  The default
# location may be changed by setting the RELEASEHOST envvar.
if test -z "$RELEASEHOST" ; then
   RELEASEHOST="vigenere:tarballs/gpg4win"
   if test "${IS_BETA_BUILD}" = yes ; then
      RELEASEHOST="${RELEASEHOST}/Beta"
   fi
fi
AC_SUBST(RELEASEHOST)

# Substitutions to set generated files in a Emacs buffer to read-only.
AC_SUBST(emacs_local_vars_begin, ['Local Variables:'])
AC_SUBST(emacs_local_vars_read_only, ['buffer-read-only: t'])
AC_SUBST(emacs_local_vars_end, ['End:'])

GPG4WIN_BUILD_RELEASE(gpg4win, no)
GPG4WIN_BUILD_RELEASE(appimage, no)

# Additionaly enable building gpgex for another host
AC_ARG_WITH([additional-gpgex-host],
    AS_HELP_STRING([--with-additional-gpgex-host=HOST],
                   [Additionaly build gpgex for this host]),
                   [if test "$withval" = yes; then
                      AC_MSG_FAILURE(
                          [--with-additional-gpgex-host was given,
                           but no host specified])
                    else
                      gpgex_host=$withval
                    fi
                   ],
                    gpgex_host=no)

if test "$gpgex_host" != no; then
    GPGEX_ADD_HOST="$gpgex_host"
fi
AC_SUBST(GPGEX_ADD_HOST)

AC_ARG_ENABLE(fast-makensis,
    AS_HELP_STRING([--enable-fast-makensis],
                   [Use a less efficient compressor to speed up building]),
                    use_fast_makensis=$enableval,
                    use_fast_makensis=no)
if test "$use_fast_makensis" = yes; then
  EXTRA_MAKENSIS_FLAGS="${EXTRA_MAKENSIS_FLAGS} -DDISABLE_LZMA=1"
fi
AC_SUBST(EXTRA_MAKENSIS_FLAGS)

# Use ninja instead of make for cmake projects
AC_ARG_ENABLE(ninja,
    AS_HELP_STRING([--enable-ninja],
                   [Use ninja instead of make]),
                    use_ninja=$enableval,
                    use_ninja=no)

#
# Set variables for use by automake makefiles.
#
if test -f /src/packages/BUILDTYPE ; then
   dockerbuild=yes
else
   dockerbuild=no
fi
AM_CONDITIONAL(DOCKERBUILD,    test "$dockerbuild" = "yes")
AM_CONDITIONAL(BUILD_GPG4WIN,  test "$build_gpg4win" = "yes")
AM_CONDITIONAL(BUILD_APPIMAGE, test "$build_appimage" = "yes")
AM_CONDITIONAL(BUILD_W64_COND, test "$BUILD_W64" = "yes")


# Required tools.
AC_PROG_CC
AC_PROG_CPP
AC_PROG_RANLIB
AC_PROG_AWK
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
AC_CHECK_PROGS(MSGFMT, msgmerge)
AC_CHECK_PROGS(GITLOG_TO_CHANGELOG, gitlog-to-changelog,
               [build-aux/gitlog-to-changelog])
AC_CHECK_PROGS(BUILD_CC, gcc cc)
AC_CHECK_PROGS(CMAKE, cmake3 cmake)
AC_CHECK_PROGS(RSYNC, rsync)
if test "${use_ninja}" = "yes"; then
    AC_CHECK_PROGS(NINJA, ninja)
    MAKETOOL=${NINJA}
    CMAKE_GENERATOR_FLAGS="-G Ninja -DCMAKE_GENERATOR=Ninja"
    AC_MSG_NOTICE([Using ${NINJA} in cmake projects])
else
    MAKETOOL=${MAKE}
fi
AC_SUBST(CMAKE_GENERATOR_FLAGS)
AC_SUBST(MAKETOOL)

AC_PROG_INSTALL

if test -n "$GPGEX_ADD_HOST"; then
    AC_CHECK_TOOLS(STRIP_EX, ${GPGEX_ADD_HOST}-strip)
fi

if test -z "$GPG4WIN_PARALLEL"; then
    JOBS=$(nproc 2>/dev/null || echo 1)
    GPG4WIN_PARALLEL=-j$JOBS
    AC_MSG_NOTICE([Using autodetected $JOBS make jobs. You can override this by setting GPG4WIN_PARALLEL.])
fi
AC_SUBST(GPG4WIN_PARALLEL)

required_tools="MAKE TAR MKDIR CP RM ZCAT SHA1SUM MSGFMT BUILD_CC CMAKE"
if test "$build_gpg4win" = yes ; then
    required_tools="$required_tools DLLTOOL UNZIP STOW MAKENSIS TEXI2DVI DVIPDF CONVERT"
fi
if test "$build_appimage" = yes ; then
    required_tools="$required_tools RSYNC"
fi

missing_tools=
for i in $required_tools; do
   eval tmp='$'$i
   if test -z "$tmp"; then
      missing_tools="$missing_tools `echo $i | tr 'A-Z' 'a-z'`"
   fi
done

if test "$build_gpg4win" = yes ; then

    case "${host}" in
    x86_64*-mingw32*)
        BUILD_W64=yes
        # Since we use 32 makensis we need to compile our plugin
        # for NSIS also for 32bit so we hardcode this here.
        # Otherwise for 64 bit builds --with-additional-gpgex-host
        # is then 32 bit to take care of that.
        AC_CHECK_PROGS(W32CC32, i686-w64-mingw32-gcc)
        GPG4WIN_RUNTIME_LIBRARY(libgcc_s_seh-1)
        ;;
    *)
        W32CC32=${CC}
        BUILD_W64=no
        ;;
    esac
    AC_SUBST(BUILD_W64)

    GPG4WIN_RUNTIME_LIBRARY(libstdc++-6, REQUIRED)
    GPG4WIN_RUNTIME_LIBRARY(libwinpthread-1, REQUIRED)

    GPG4WIN_RUNTIME_LIBRARY_EX(libwinpthread-1)

    # One of these is required
    GPG4WIN_RUNTIME_LIBRARY(libgcc_s_dw2-1)
    GPG4WIN_RUNTIME_LIBRARY(libgcc_s_sjlj-1)

    if test "${gpg4win_rtlib_libgcc_s_dw2_1}" = no \
         -a "${gpg4win_rtlib_libgcc_s_sjlj_1}" = no \
         -a "${gpg4win_rtlib_libgcc_s_seh_1}" = no ; then
        AC_MSG_ERROR(No exception library found. Please check what your system
                     uses and see above message about either dw2- sjlj- or seh-
                     dlls.)
    fi
fi

AC_CHECK_PROGS(WGET, wget)


#
# Set source and build directory.
#
# They are always set to the directories seen outside of the
# container.
#
TOPSRCDIR="mym4_tsdir"
AC_ARG_WITH([playground],
       AS_HELP_STRING([--with-playground=DIR],
                      [Use DIR as the build directory]),
       [PLAYGROUND="$withval"], [PLAYGROUND=""])

if test -n "$PLAYGROUND" ; then
    if test ! -d "$PLAYGROUND"; then
        AC_MSG_ERROR([[
***
*** Given playground directory does not exist.
*** Please create it first or use the default.
***]])
    fi
    PLAYGROUND="$(cd "$PLAYGROUND" && pwd)"
else
    PLAYGROUND="${HOME}/b/$(basename "$TOPSRCDIR")-playground"
fi
PLAYGROUND=$(echo "$PLAYGROUND" | sed s,^//,/,)
AC_SUBST(TOPSRCDIR)
AC_SUBST(PLAYGROUND)


#
# Prepare variables for po/Makefile.am
# Note that we do not use the ususal GNU gettext make system.
#
# LINGUAS  := The list of all translated languages taken from po/LINGUAS
# POTFILES := The list of NSI files with translatable strings taken from
#             po/POTFILES
# POFILES  := The actual available translations (w/o directory)
# NSIFILES := The to-be generated translation files in the NSI format.
#             (w/o directory)
#
if test $dockerbuild = yes ; then
  posrcdir=/src/po
else
  posrcdir="$TOPSRCDIR/po"
fi
LINGUAS=$(sed -e "/^#/d" -e "s/#.*//" "$posrcdir/LINGUAS" | xargs -- )
POTFILES=$(for f in $(sed -e "/^#/d" -e "s/#.*//" "$posrcdir/POTFILES");\
           do echo "$posrcdir/$f"; done | xargs -- )
AC_SUBST(LINGUAS)
AC_SUBST(POTFILES)
POFILES=
NSIFILES=
for lang in $LINGUAS; do
   if test -f "$posrcdir/$lang.po" ; then
       POFILES="$POFILES $lang.po"
       NSIFILES="$NSIFILES $lang.nsi"
   fi
done
AC_SUBST(POFILES)
AC_SUBST(NSIFILES)


#
# Packages for Gpg4Win.
#
if test "$build_gpg4win" = yes ; then
    gpg4win_dup_sources=""

    GPG4WIN_SPKG([zlib])

    GPG4WIN_BPKG_GTK([pkgconfig])

    GPG4WIN_SPKG([bzip2])
    GPG4WIN_SPKG([libgpg-error], [libiconv gettext])
    GPG4WIN_SPKG([libassuan], [libgpg-error])
    GPG4WIN_SPKG([scute], [libgpg-error libassuan])
    GPG4WIN_SPKG([pinentry], [qtbase libassuan libiconv])
    GPG4WIN_SPKG([gpgme], [libgpg-error libassuan])
    GPG4WIN_KDEPKG([gpgmepp], [gpgme])
    GPG4WIN_KDEPKG([qgpgme], [gpgmepp qtbase])
    GPG4WIN_SPKG([gpgol], [gpgmepp libassuan])
    GPG4WIN_SPKG([gpgex], [libassuan])
    GPG4WIN_SPKG([paperkey])
    GPG4WIN_SPKG([libiconv])
    GPG4WIN_SPKG([gettext], [libiconv])
    GPG4WIN_SPKG([libpng], [zlib])
    GPG4WIN_SPKG([jpeg])
    GPG4WIN_KDEPKG([libqrencode], [libpng libiconv])

    # Packages needed for gpgex
    GPG4WIN_SPKGEX([libgpg-error])
    GPG4WIN_SPKGEX([libassuan], [libgpg-error])
    GPG4WIN_SPKGEX([gpgex], [libassuan])
    GPG4WIN_SPKGEX([gpgme], [libgpg-error libassuan])
    GPG4WIN_CMKPKGEX([gpgmepp], [gpgme])
    GPG4WIN_SPKGEX([gpgol], [gpgmepp])

    # The GnuPG Package.
    GPG4WIN_BPKG_BINSRC([gnupg-w32])
    GPG4WIN_BPKG_MSISRC([gnupg-msi])

    # Tools required for cross compiling
    GPG4WIN_NATIVEPKG([qtbase])
    GPG4WIN_NATIVEPKG([extra-cmake-modules])
    GPG4WIN_NATIVEPKG([breeze-icons], [qtbase extra-cmake-modules])
    GPG4WIN_NATIVEPKG([qttools], [qtbase])
    GPG4WIN_NATIVEPKG([kconfig], [qtbase qttools extra-cmake-modules])

    # Qt related stuff.
    GPG4WIN_KDEPKG([zstd])
    GPG4WIN_KDEPKG([qtbase], [jpeg zlib zstd libpng freetype pcre2])
    GPG4WIN_KDEPKG([qttools], [qtbase])
    GPG4WIN_KDEPKG([qttranslations], [qtsvg qttools native-qttools])
    GPG4WIN_KDEPKG([qtsvg], [qtbase])
    GPG4WIN_KDEPKG([qthttpserver], [qtbase])
    GPG4WIN_KDEPKG([qtwebsockets], [qtbase])
    GPG4WIN_KDEPKG([tiff])
    GPG4WIN_KDEPKG([pcre2])
    GPG4WIN_KDEPKG([breeze], [qtbase kcoreaddons kconfig kconfigwidgets kguiaddons kiconthemes kwindowsystem native-kconfig])
#   GPG4WIN_KDEPKG([snoretoast])
    GPG4WIN_KDEPKG([openjpeg], [tiff jpeg])
    GPG4WIN_KDEPKG([breeze-icons], [extra-cmake-modules qtbase])
    GPG4WIN_KDEPKG([kleopatra], [kstatusnotifieritem mimetreeparser kio gnupg-w32 breeze-icons kxmlgui libkleo kitemmodels qttranslations ktextwidgets native-kconfig])
    GPG4WIN_KDEPKG([extra-cmake-modules])
    GPG4WIN_KDEPKG([kconfig], [qtbase native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([ki18n], [qtbase gettext native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([kwidgetsaddons], [kconfig native-qttools qtbase])
    GPG4WIN_KDEPKG([kcompletion], [kwidgetsaddons])
    GPG4WIN_KDEPKG([kwindowsystem], [qtbase native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([kcoreaddons], [qtbase native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([kcodecs], [qtbase native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([kguiaddons], [qtbase native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([kmime], [kcodecs ki18n])
    GPG4WIN_KDEPKG([kmbox], [kmime])
    GPG4WIN_KDEPKG([kconfigwidgets], [kwidgetsaddons kguiaddons ki18n kcodecs kconfig kcolorscheme])
    GPG4WIN_KDEPKG([kitemviews], [qtbase native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([kitemmodels], [qtbase native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([karchive], [qtbase native-qttools extra-cmake-modules])
    GPG4WIN_KDEPKG([kcrash], [kwindowsystem kcoreaddons])
    GPG4WIN_KDEPKG([solid], [native-qttools qtbase extra-cmake-modules])
    GPG4WIN_KDEPKG([kjobwidgets], [kwidgetsaddons kcoreaddons qtbase extra-cmake-modules])
    GPG4WIN_KDEPKG([kservice], [kconfig kcoreaddons ki18n])
    GPG4WIN_KDEPKG([kbookmarks], [kconfig kxmlgui kcoreaddons kconfigwidgets kwidgetsaddons kcodecs])
    GPG4WIN_KDEPKG([kio], [kcrash kjobwidgets solid kservice kbookmarks kwidgetsaddons kxmlgui kwindowsystem karchive kconfig kcoreaddons ki18n])
    GPG4WIN_KDEPKG([kiconthemes], [qtsvg kconfigwidgets karchive])
    GPG4WIN_KDEPKG([kxmlgui], [kiconthemes kconfigwidgets kitemviews ktextwidgets breeze])
    GPG4WIN_KDEPKG([libkleo], [kmime kconfigwidgets kwindowsystem kcompletion qgpgme])
    GPG4WIN_KDEPKG([gpg4win-tools], [libkleo qgpgme])
    GPG4WIN_KDEPKG([threadweaver], [qtbase extra-cmake-modules])
    GPG4WIN_KDEPKG([kcolorscheme], [kconfig kguiaddons ki18n])
    GPG4WIN_KDEPKG([freetype], [zlib bzip2])
    GPG4WIN_KDEPKG([sonnet], [qtbase native-qttools])
    GPG4WIN_KDEPKG([ktextwidgets], [sonnet kcompletion kconfig kconfigwidgets ki18n kwidgetsaddons])
    GPG4WIN_KDEPKG([poppler], [libpng openjpeg tiff gpgmepp kio qtbase freetype])
    GPG4WIN_KDEPKG([kparts], [kio kservice kxmlgui kconfigwidgets kwidgetsaddons ktextwidgets])
    GPG4WIN_KDEPKG([okular], [kparts gpgmepp kio poppler threadweaver qtsvg native-kconfig])
    GPG4WIN_KDEPKG([libical])
    GPG4WIN_KDEPKG([kcalendarcore], [qtbase libical extra-cmake-modules])
    GPG4WIN_KDEPKG([mimetreeparser], [libkleo kwidgetsaddons ki18n kmbox kmime kcodecs kcalendarcore])
    GPG4WIN_KDEPKG([prison], [qtbase extra-cmake-modules libqrencode])
    GPG4WIN_KDEPKG([kstatusnotifieritem], [kwindowsystem qtbase extra-cmake-modules])
    GPG4WIN_KDEPKG([gpgpass], [kio prison kconfigwidgets kiconthemes ki18n qgpgme native-kconfig])
    GPG4WIN_KDEPKG([kcontacts], [kcoreaddons qtbase ki18n kconfig kcodecs])
    GPG4WIN_KDEPKG([gpgoljs],[qtwebsockets kcontacts qthttpserver mimetreeparser libkleo sonnet kcompletion ki18n kwidgetsaddons kio])

    GPG4WIN_FINALIZE
fi

# Packages for the AppImage
if test "$build_appimage" = yes ; then
    appimage_dup_sources=""

    APPIMAGE_SPKG([freetype])
    APPIMAGE_SPKG([sqlite])
    APPIMAGE_SPKG([jpeg])
    APPIMAGE_KDEPKG([libqrencode])
    APPIMAGE_SPKG([xcb-util-cursor])

    APPIMAGE_SPKG([libgpg-error])
    APPIMAGE_SPKG([libassuan], [libgpg-error])
    APPIMAGE_SPKG([npth])
    APPIMAGE_SPKG([libgcrypt], [libgpg-error])
    APPIMAGE_SPKG([libksba], [libgpg-error])
    APPIMAGE_SPKG([ntbtls], [libgcrypt libksba])
    APPIMAGE_SPKG([gnupg], [libgpg-error libassuan npth libgcrypt libksba sqlite ntbtls])
    APPIMAGE_SPKG([pinentry], [qtbase])

    APPIMAGE_SPKG([gpgme], [libgpg-error libassuan])
    APPIMAGE_KDEPKG([gpgmepp], [gpgme])
    APPIMAGE_KDEPKG([qgpgme], [gpgmepp qtbase])
    APPIMAGE_SPKG([paperkey])

    # Qt related stuff.
    # (dependency on gnupg is only to make sure gnupg is build first so
    #  that we don't need to wait for the long running Qt builds)
    APPIMAGE_KDEPKG([zstd])
    APPIMAGE_KDEPKG([pcre2])
    APPIMAGE_KDEPKG([qtbase], [jpeg zstd freetype pcre2 gnupg xcb-util-cursor])
    APPIMAGE_KDEPKG([qttools], [qtbase])
    APPIMAGE_KDEPKG([qttranslations], [qtsvg qttools])
    APPIMAGE_KDEPKG([qtsvg], [qtbase])
    APPIMAGE_KDEPKG([qtwayland], [qtbase])
    APPIMAGE_KDEPKG([wayland-protocols], [qtwayland])
    APPIMAGE_KDEPKG([plasma-wayland-protocols], [wayland-protocols])
    APPIMAGE_KDEPKG([breeze], [qtbase kcoreaddons kconfig kconfigwidgets kguiaddons kiconthemes kwindowsystem])

    # KDE Frameworks Tier 1
    APPIMAGE_KDEPKG([extra-cmake-modules], [qttools])
    APPIMAGE_KDEPKG([breeze-icons], [extra-cmake-modules qtbase])
    APPIMAGE_KDEPKG([karchive], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kauth], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kcodecs], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kcolorscheme], [kconfig kguiaddons ki18n])
    APPIMAGE_KDEPKG([kconfig], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kcoreaddons], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kdbusaddons], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kguiaddons], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([ki18n], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kitemmodels], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kitemviews], [qtbase qttools extra-cmake-modules])
    APPIMAGE_KDEPKG([kwindowsystem], [qtbase qtwayland extra-cmake-modules wayland-protocols plasma-wayland-protocols])
    APPIMAGE_KDEPKG([solid], [qtbase extra-cmake-modules])
    APPIMAGE_KDEPKG([sonnet], [qtbase extra-cmake-modules])
    APPIMAGE_KDEPKG([threadweaver], [qtbase extra-cmake-modules])

    # KDE Frameworks Tier 2
    APPIMAGE_KDEPKG([kcompletion], [kwidgetsaddons])
    APPIMAGE_KDEPKG([kcrash], [kwindowsystem kcoreaddons])
    APPIMAGE_KDEPKG([kjobwidgets], [kwidgetsaddons kcoreaddons qtbase extra-cmake-modules])
    APPIMAGE_KDEPKG([kstatusnotifieritem], [kwindowsystem qtbase extra-cmake-modules])
    APPIMAGE_KDEPKG([kwidgetsaddons], [kconfig qttools qtbase])

    # KDE Frameworks Tier 3
    APPIMAGE_KDEPKG([kconfigwidgets], [kwidgetsaddons kguiaddons ki18n kcodecs kconfig])
    APPIMAGE_KDEPKG([kiconthemes], [qtsvg kconfigwidgets karchive])
    APPIMAGE_KDEPKG([ktextwidgets], [sonnet kcompletion kconfig kconfigwidgets ki18n kwidgetsaddons])
    APPIMAGE_KDEPKG([kxmlgui], [kiconthemes kconfigwidgets kitemviews ktextwidgets breeze])
    APPIMAGE_KDEPKG([kbookmarks], [kconfig kxmlgui kcoreaddons kconfigwidgets kwidgetsaddons kcodecs])
    APPIMAGE_KDEPKG([kservice], [kconfig kcoreaddons ki18n])
    APPIMAGE_KDEPKG([kio], [kcrash kjobwidgets solid kservice kbookmarks kwidgetsaddons kxmlgui kwindowsystem karchive kconfig kcoreaddons ki18n kauth])
    APPIMAGE_KDEPKG([kparts], [kio kservice kxmlgui kconfigwidgets kwidgetsaddons ktextwidgets])

    # KDE PIM
    APPIMAGE_KDEPKG([libical])
    APPIMAGE_KDEPKG([kcalendarcore], [qtbase libical extra-cmake-modules])
    APPIMAGE_KDEPKG([mimetreeparser], [libkleo kwidgetsaddons ki18n kmime kcodecs kcalendarcore kmbox])
    APPIMAGE_KDEPKG([kmime], [kcodecs ki18n])
    APPIMAGE_KDEPKG([kmbox], [kmime])
    APPIMAGE_KDEPKG([libkleo], [kmime kconfigwidgets kwindowsystem kcompletion qgpgme])

    APPIMAGE_KDEPKG([kleopatra], [mimetreeparser gnupg qgpgme breeze-icons kio kxmlgui libkleo kitemmodels qttranslations kdbusaddons kstatusnotifieritem])

    # Okular/Poppler
    APPIMAGE_KDEPKG([poppler], [gpgmepp kio qtbase freetype])
    APPIMAGE_KDEPKG([okular], [kparts gpgmepp kio poppler threadweaver qtsvg])

    # Gpgpass
    APPIMAGE_KDEPKG([prison], [qtbase extra-cmake-modules libqrencode])
    APPIMAGE_KDEPKG([gpgpass], [kio prison kconfigwidgets kiconthemes ki18n qgpgme])
    APPIMAGE_FINALIZE
fi

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

# Throw an error if any duplicate source packages have been found The
# packages_dirpfx is set depending on whether we are running under
# docker.  See also GPG4WIN_PACKAGES.
packages_dirpfx=
test -f /src/packages/BUILDTYPE && packages_dirpfx=/src/
packages_files=${packages_dirpfx}packages/packages.list
if test -n "$gpg4win_dup_sources"; then
    tmp=
    for i in $gpg4win_dup_sources; do
      tmp="$tmp
$i"
    done
    tmp2="
You might remove them with:"
    for i in $gpg4win_rm_candidates; do
        if ! grep -q $(basename $i) $packages_files; then
            tmp2="$tmp2
rm $i"
        fi
    done
    AC_MSG_ERROR([Packages with more that one source version:$tmp$tmp2])
fi

if test -n "$appimage_dup_sources"; then
    tmp=
    for i in $appimage_dup_sources; do
      tmp="$tmp
$i"
    done
    tmp2="
You might remove them with:"
    for i in $appimage_rm_candidates; do
        if ! grep -q $(basename $i) $packages_files; then
            tmp2="$tmp2
rm $i"
        fi
    done
    AC_MSG_ERROR([Packages with more that one source version:$tmp$tmp2])
fi

# Finalize.

AC_CONFIG_FILES(Makefile)
AC_CONFIG_FILES(packages/Makefile src/Makefile po/Makefile)
AC_CONFIG_FILES(src/nsis/config.nsi src/gpg4win.mk)
AC_CONFIG_FILES(doc/Makefile)
AC_CONFIG_FILES(doc/logo/Makefile)
AC_CONFIG_FILES(src/toolchain.cmake)
AC_CONFIG_FILES(src/toolchain-ex.cmake)
AC_CONFIG_FILES(src/toolchain-native.cmake)
AC_CONFIG_FILES(src/appimage/Makefile src/appimage/appimage.mk)
AC_CONFIG_FILES(src/appimage/rsync-filters/Makefile)
AC_CONFIG_FILES(src/nsis/Makefile)
AC_CONFIG_FILES(src/versioninfo.rc.in)
AC_CONFIG_FILES(src/gpg4win.w32-manifest.in)

AC_CONFIG_FILES(src/gccwrap.sh)
AC_CONFIG_COMMANDS([chmod],[chmod +x src/gccwrap.sh])

AC_OUTPUT

# Throw a warning if optional tools are missing
if test -n "$missing_opt_tools"; then
    AC_MSG_WARN([[
***
*** Some tools not found.  They may or may not be needed depending on
*** the packages you want to include.  For example GLIB and GTK+
*** require certain tools; you may need to install a recent version of
*** GLIB and GTK+ on the build machine to allow for cross-compiling.
***]])
    for i in $missing_opt_tools; do
      AC_MSG_NOTICE([$i is missing])
    done
fi

echo -n "
        $PACKAGE_NAME-$PACKAGE_VERSION prepared for make

        Revision .....: ${GIT_REVISION}  (${GIT_REVISION_DEC})
        Main platform : $host
        Extra platform: ${GPGEX_ADD_HOST}
        Distribution .: ${PRODUCT_NAME} (mym4_buildtype)
        Source dir ...: ${TOPSRCDIR}
        Build dir ....: ${PLAYGROUND}
"
if test -n "$JOBS"; then
    echo "        make jobs ....: ${JOBS}"
else
    echo ""
fi

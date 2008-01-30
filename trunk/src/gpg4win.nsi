# gpg4win.nsi - Installer for GnuPG 4 Windows.        -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007, 2008 g10 Code GmbH
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

!cd "${BUILD_DIR}"
!addincludedir "${TOP_SRCDIR}"
!addincludedir "${TOP_SRCDIR}/po"
!addincludedir "${SRCDIR}"
!addplugindir "${BUILD_DIR}"
!include "../include/config.nsi"

# For the "light" version of the package, we explicitely disable some
# of the packages right after including config.nsi.
!ifdef GPG4WIN_LIGHT
!undef HAVE_PKG_MAN_NOVICE_DE
!undef HAVE_PKG_MAN_NOVICE_EN
!undef HAVE_PKG_MAN_ADVANCED_DE
!ifdef HAVE_PKG_KLEOPATRA
!undef HAVE_PKG_KLEOPATRA
!endif
!ifdef HAVE_PKG_GPGEX
!undef HAVE_PKG_GPGEX
!endif
!ifdef HAVE_PKG_KDELIBS
!undef HAVE_PKG_KDELIBS
!endif
!ifdef HAVE_PKG_KDESUPPORT
!undef HAVE_PKG_KDESUPPORT
!endif
!ifdef HAVE_PKG_OXYGEN_ICONS
!undef HAVE_PKG_OXYGEN_ICONS
!endif
!ifdef HAVE_PKG_QT
!undef HAVE_PKG_QT
!endif
!ifdef HAVE_PKG_GNUPG2
!undef HAVE_PKG_GNUPG2
!endif
!ifdef HAVE_PKG_PINENTRY
!undef HAVE_PKG_PINENTRY
!endif
!ifdef HAVE_PKG_DIRMNGR
!undef HAVE_PKG_DIRMNGR
!endif
!ifdef HAVE_PKG_LIBGCRYPT
!undef HAVE_PKG_LIBGCRYPT
!endif
!ifdef HAVE_PKG_LIBKSBA
!undef HAVE_PKG_LIBKSBA
!endif
!ifdef HAVE_PKG_LIBASSUAN
!undef HAVE_PKG_LIBASSUAN
!endif
!ifdef HAVE_PKG_W32PTH
!undef HAVE_PKG_W32PTH
!endif
!endif


# The package name and version.  PRETTY_PACKAGE is a user visible name
# only while PACKAGE is useful for filenames etc.  PROD_VERSION is the
# product version and needs to be in the format "MAJ.MIN.MIC.BUILDNR".
# NOTE: Please keep the capitalization of PRETTY_PACKAGE_SHORT as it is
# used as registry key.
!define PACKAGE "${_PACKAGE}"
!define PRETTY_PACKAGE "GnuPG For Windows"
!define PRETTY_PACKAGE_SHORT "GPG4Win"
!define VERSION "${_VERSION}"
!define PROD_VERSION "${_BUILD_FILEVERSION}"
!define COMPANY "g10 Code GmbH"
!define COPYRIGHT "Copyright (C) 2007 g10 Code GmbH"
!define DESCRIPTION "Gpg4win: The GNU Privacy Guard and tools for Windows"

!define INSTALL_DIR "GnuPG"

!define WELCOME_TITLE_STR "$(T_WelcomeTitleGpg4win)"
!define ABOUT_STR "$(T_AboutGpg4win)"

# The copyright license of the package.  Define only one of these.
!define LICENSE_GPL
# !define LICENSE_LGPL


# Define this if we require an NSIS running on Windows.  This is
# necessary if you want to handle DLLs properly.
# !define REQUIRE_W32_NSIS


# Define if in debug mode.
!ifdef GPG4WIN_DEBUG
!define DEBUG
!endif


# The installation directory.
!define ipdir "playground/install/pkgs"
!define bpdir "playground/build"

# Select the best compression algorithm available.  The dictionary
# size is the default (8 MB). 
!ifndef SOURCES
SetCompressor lzma
# SetCompressorDictSize 8
!endif


# Now include the generic parts.
!define HAVE_STARTMENU
!include "installer.nsi"


# Now include the sections.
!define BINARIES
!include "inst-sections.nsi"


# The WelcomeTitle is displayed on the first page.
LangString T_WelcomeTitleGpg4win ${LANG_ENGLISH} \
  "Welcome to the installation of Gpg4win"

# The About string as displayed on the first page.
# TRANSLATORS: As an exception, this string contains \r\n characters.
LangString T_AboutGpg4win ${LANG_ENGLISH} \
 "GnuPG is GNU's tool for secure communication and data storage. \
  It can be used to encrypt data and to create digital signatures. \
  It includes an advanced key management facility and is compliant \
  with the proposed OpenPGP Internet standard as described in RFC2440. \
  ${DOSLF}${DOSLF}$_CLICK \
  ${DOSLF}${DOSLF}${DOSLF}${DOSLF}${DOSLF}This is Gpg4win version ${VERSION}${DOSLF} \
  file version ${PROD_VERSION}${DOSLF}${DOSLF} \
  release date ${_BUILD_ISODATE}"

# At long last, include all the translations.
!include "../po/catalogs.nsi"

# Now include the generic parts to end the installation.
!include "installer-finish.nsi"

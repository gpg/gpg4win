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
!ifdef HAVE_PKG_COMPENDIUM
!undef HAVE_PKG_COMPENDIUM
!endif
!ifdef HAVE_PKG_KLEOPATRA
!undef HAVE_PKG_KLEOPATRA
!endif
!ifdef HAVE_PKG_KDELIBS
!undef HAVE_PKG_KDELIBS
!endif
!ifdef HAVE_PKG_OXYGEN_ICONS
!undef HAVE_PKG_OXYGEN_ICONS
!endif
!ifdef HAVE_PKG_QT
!undef HAVE_PKG_QT
!endif
!endif


# The package name and version.  PRETTY_PACKAGE is a user visible name
# only while PACKAGE is useful for filenames etc.  PROD_VERSION is the
# product version and needs to be in the format "MAJ.MIN.MIC.BUILDNR".
# NOTE: Please keep the capitalization of PRETTY_PACKAGE_SHORT as it is
# used as registry key.
!define PACKAGE "${_PACKAGE}"
!define PRETTY_PACKAGE "Gpg4win"
!define PRETTY_PACKAGE_SHORT "GPG4Win"
!define VERSION "${_VERSION}"
!define PROD_VERSION "${_BUILD_FILEVERSION}"
!define COMPANY "g10 Code GmbH"
!define COPYRIGHT "Copyright (C) 2008 g10 Code GmbH"
!define DESCRIPTION "Gpg4win: The GNU Privacy Guard and Tools for Windows"

!define INSTALL_DIR "GnuPG"

!define WELCOME_TITLE_STR "$(T_WelcomeTitleGpg4win)"

!define ABOUT_STR "$(T_AboutGpg4win) \
	\r\n\r\n$_CLICK \r\n\r\n\r\n\r\n\r\n \
	$(T_AboutGpg4winVersion) \r\n \
        $(T_AboutGpg4winFileVersion) \r\n\r\n \
	$(T_AboutGpg4winReleaseDate)"

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
!ifndef DISABLE_LZMA
!ifndef SOURCES
SetCompressor lzma
# SetCompressorDictSize 8
!endif
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
LangString T_AboutGpg4win ${LANG_ENGLISH} \
 "Gpg4win is a installer package for Windows for EMail and \
  file encryption using the core componenent GnuPG for Windows. \
  Both relevant cryptography standards are supported, OpenPGP \
  and S/MIME. Gpg4win and the software included with Gpg4win \
  are Free Software."

LangString T_AboutGpg4winVersion ${LANG_ENGLISH} \
 "This is Gpg4win version ${VERSION}"

LangString T_AboutGpg4winFileVersion ${LANG_ENGLISH} \
 "file version ${PROD_VERSION}"

LangString T_AboutGpg4winReleaseDate ${LANG_ENGLISH} \
 "release date ${_BUILD_ISODATE}"

# At long last, include all the translations.
!include "../po/catalogs.nsi"

# Now include the generic parts to end the installation.
!include "installer-finish.nsi"

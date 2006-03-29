# gpg4win.nsi - Installer for GnuPG 4 Windows.        -*- coding: latin-1; -*-
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

!cd "${BUILD_DIR}"
!addincludedir "${TOP_SRCDIR}"
!addincludedir "${SRCDIR}"
!addplugindir "${BUILD_DIR}"
!include "../include/config.nsi"


# The package name and version.  PRETTY_PACKAGE is a user visible name
# only while PACKAGE is useful for filenames etc.  PROD_VERSION is the
# product version and needs to be in the format "MAJ.MIN.MIC.BUILDNR".
!define PACKAGE "${_PACKAGE}"
!define PRETTY_PACKAGE "GnuPG For Windows"
!define PRETTY_PACKAGE_SHORT "GPG4Win"
!define VERSION "${_VERSION}"
!define PROD_VERSION "${_BUILD_FILEVERSION}"
!define COMPANY "g10 Code GmbH"
!define COPYRIGHT "Copyright (C) 2005 g10 Code GmbH"
!define DESCRIPTION "GPG4Win: The GNU Privacy Guard and tools for Windows"

!define INSTALL_DIR "GnuPG"

!define WELCOME_TITLE_ENGLISH \
 "Welcome to the installation of Gpg4Win"

!define WELCOME_TITLE_GERMAN \
 "Willkommen bei der Installation von Gpg4Win"

!define ABOUT_ENGLISH \
 "GnuPG is GNU's tool for secure communication and data storage. \
  It can be used to encrypt data and to create digital signatures. \
  It includes an advanced key management facility and is compliant \
  with the proposed OpenPGP Internet standard as described in RFC2440. \
  \r\n\r\n$_CLICK \
  \r\n\r\n\r\n\r\n\r\nThis is GPG4WIN version ${VERSION}\r\n\
  file version ${PROD_VERSION}\r\n\
  release date ${_BUILD_ISODATE}"
!define ABOUT_GERMAN \
  "GnuPG is das Werkzeug aus dem GNU Projekt zur sicheren Kommunikation \
   sowie zum sicheren Speichern von Daten. \
   \r\n\r\n$_CLICK \
   \r\n\r\n\r\n\r\n\r\nDies ist GPG4WIN Version ${VERSION}\r\n\
   Dateiversion ${PROD_VERSION}\r\n\
   Releasedatum ${_BUILD_ISODATE}"



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


# Now include the generic parts to end the installation.
!include "installer-finish.nsi"

# gpg4win-src.nsi - Installer for GPG4Win sources.   -*- coding: latin-1; -*-
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


# We need StrRep.
!include "StrFunc.nsh"


!include "../include/config.nsi"

# The package name and version.  PRETTY_PACKAGE is a user visible name
# only while PACKAGE is useful for filenames etc.  PROD_VERSION is the
# product version and needs to be in the format "MAJ.MIN.MIC.BUILDNR".
!define PACKAGE "${_PACKAGE}-src"
!define PRETTY_PACKAGE "GnuPG For Windows Sources"
!define PRETTY_PACKAGE_SHORT "GPG4WinSrc"
!define VERSION "${_VERSION}"
# FIXME
!define PROD_VERSION "0.0.0.1"
!define COMPANY "g10 Code GmbH"
!define COPYRIGHT "Copyright (C) 2005 g10 Code GmbH"
!define DESCRIPTION "GPG4Win: The GNU Privacy Guard and tools for Windows (Source Files)"

!define INSTALL_DIR "GnuPG\Source"

!define ABOUT_ENGLISH \
 "GnuPG is GNU's tool for secure communication and data storage. \
  It can be used to encrypt data and to create digital signatures. \
  It includes an advanced key management facility and is compliant \
  with the proposed OpenPGP Internet standard as described in RFC2440. \
  \r\n\r\n$_CLICK \
  \r\n\r\n\r\n\r\n\r\nThis is GnuPG version ${VERSION}\r\n\
  file version ${PROD_VERSION}"
!define ABOUT_GERMAN \
  "GnuPG is das Werkzeug aus dem GNU Projekt zur sicheren Kommunikation \
   sowie zum sicheren Speichern von Daten. \
   \r\n\r\n$_CLICK \
   \r\n\r\n\r\n\r\n\r\nDies ist GnuPG Version ${VERSION}\r\n\
   Dateiversion ${PROD_VERSION}"


# The copyright license of the package.  Define only one of these.
!define LICENSE_GPL
# !define LICENSE_LGPL


# The installation directory.
!define ipdir "playground/install/pkgs"


# Now include the generic parts.
!include "installer.nsi"


# Now include all the sections.
!define SOURCES
!include "inst-sections.nsi"


# Now include the generic parts to end the installation.
!include "installer-finish.nsi"

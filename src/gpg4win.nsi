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
!include "config.nsi"

# For the "light" version of the package, we explicitely disable some
# of the packages right after including config.nsi.
!ifdef GPG4WIN_LIGHT
!ifdef HAVE_PKG_COMPENDIUM
!undef HAVE_PKG_COMPENDIUM
!endif
!ifdef HAVE_PKG_KLEOPATRA
!undef HAVE_PKG_KLEOPATRA
!endif
!ifdef HAVE_PKG_OXYGEN_ICONS
!undef HAVE_PKG_OXYGEN_ICONS
!endif
!ifdef HAVE_PKG_QTBASE
!undef HAVE_PKG_QTBASE
!endif
!endif

# For the "vanilla" version of the package, we explicitely disable most
# of the packages right after including config.nsi.
!ifdef GPG4WIN_VANILLA
!ifdef HAVE_PKG_GPGOL
!undef HAVE_PKG_GPGOL
!endif
!ifdef HAVE_PKG_GPGEX
!undef HAVE_PKG_GPGEX
!endif
!ifdef HAVE_PKG_GPA
!undef HAVE_PKG_GPA
!endif
!ifdef HAVE_PKG_LIBGSASL
!undef HAVE_PKG_LIBGSASL
!endif
;!ifdef HAVE_PKG_LIBTASN1
;!undef HAVE_PKG_LIBTASN1
;!endif
;!ifdef HAVE_PKG_GNUTLS
;!undef HAVE_PKG_GNUTLS
;!endif
!ifdef HAVE_PKG_LIBPNG
!undef HAVE_PKG_LIBPNG
!endif
!ifdef HAVE_PKG_PKGCONFIG
!undef HAVE_PKG_PKGCONFIG
!endif
!ifdef HAVE_PKG_GLIB
!undef HAVE_PKG_GLIB
!endif
!ifdef HAVE_PKG_ATK
!undef HAVE_PKG_ATK
!endif
!ifdef HAVE_PKG_EXPAT
!undef HAVE_PKG_EXPAT
!endif
!ifdef HAVE_PKG_FREETYPE
!undef HAVE_PKG_FREETYPE
!endif
!ifdef HAVE_PKG_FONTCONFIG
!undef HAVE_PKG_FONTCONFIG
!endif
!ifdef HAVE_PKG_CAIRO
!undef HAVE_PKG_CAIRO
!endif
!ifdef HAVE_PKG_PANGO
!undef HAVE_PKG_PANGO
!endif
!ifdef HAVE_PKG_GTK_
!undef HAVE_PKG_GTK_
!endif
!ifdef HAVE_PKG_DBUS
!undef HAVE_PKG_DBUS
!endif
!ifdef HAVE_PKG_QTBASE
!undef HAVE_PKG_QTBASE
!endif
!ifdef HAVE_PKG_OXYGEN_ICONS
!undef HAVE_PKG_OXYGEN_ICONS
!endif
!ifdef HAVE_PKG_KLEOPATRA
!undef HAVE_PKG_KLEOPATRA
!endif
!ifdef HAVE_PKG_COMPENDIUM
!undef HAVE_PKG_COMPENDIUM
!endif
!endif

# Define this early automatically it is only defined after
# MUI_LANGUAGE has been called.
!define LANG_ENGLISH 1033

# The package name and version.  PRETTY_PACKAGE is a user visible name
# only while PACKAGE is useful for filenames etc.  PROD_VERSION is the
# product version and needs to be in the format "MAJ.MIN.MIC.BUILDNR".
# NOTE: Please keep the capitalization of PRETTY_PACKAGE_SHORT as it is
# used as registry key.
!define PACKAGE "${_PACKAGE}"
!define PRETTY_PACKAGE "Gpg4win"
!define PRETTY_PACKAGE_SHORT "Gpg4win"
!define VERSION "${_VERSION}"
!define PROD_VERSION "${_BUILD_FILEVERSION}"
!define COMPANY "Intevation GmbH"
!define COPYRIGHT "Copyright (C) 2020 Intevation GmbH"
!define DESCRIPTION "Gpg4win: The GNU Privacy Guard and Tools for Windows"

!define INSTALL_DIR "Gpg4win"

!define WELCOME_TITLE_STR "$(T_WelcomeTitleGpg4win)"

!define ABOUT_STR "$(T_AboutGpg4win) \
	$\r$\n$\r$\n$\r$\n$_CLICK $\r$\n$\r$\n$\r$\n$\r$\n$\r$\n\
	$(T_AboutGpg4winVersion) $\r$\n$(T_AboutGpg4winReleaseDate)"

# The copyright license of the package.  Define only one of these.
!define LICENSE_GPL

# Select the best compression algorithm available.  The dictionary
# size is the default (8 MB).
!ifndef DISABLE_LZMA
!ifndef SOURCES
SetCompressor /SOLID lzma
# SetCompressorDictSize 8
!endif
!endif

# We support user mode installation but prefer system wide
!define MULTIUSER_EXECUTIONLEVEL Highest
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_COMMANDLINE
!define MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_KEY "Software\${PRETTY_PACKAGE_SHORT}"
!define MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_VALUENAME ""
!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_KEY "Software\${PRETTY_PACKAGE_SHORT}"
!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_VALUENAME "Install Directory"
!define MULTIUSER_INSTALLMODE_INSTDIR "${PRETTY_PACKAGE_SHORT}"
!include "MultiUser.nsh"
!ifdef DEBUG
!undef DEBUG
!endif

# The installation directory.
!define ipdir "playground/install/pkgs"
!define exipdir "playground/install-ex/pkgs"
!define bpdir "playground/build"

!ifndef GPG4WIN_VANILLA
# Claws is a bit special because we installed
# it for some time and now remove the old
# version we did install during installation
# to be part of an update.
!include "uninst-claws-mail.nsi"
!endif

# Variables
VAR is_minimal
VAR with_browser
VAR is_update

# Sections
!include "Sections.nsh"

# We use Memento to remember past installation choices.
!include Memento.nsh
!define MEMENTO_REGISTRY_ROOT SHCTX
!define MEMENTO_REGISTRY_KEY \
  Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRETTY_PACKAGE_SHORT}
# We need to know wether we are installing to 64 bit.
!include "x64.nsh"

# Now include the sections.
!define BINARIES
!include "inst-sections.nsi"

# Now include the generic parts.
!define HAVE_STARTMENU
!include "installer.nsi"

# The WelcomeTitle is displayed on the first page.
LangString T_WelcomeTitleGpg4win ${LANG_ENGLISH} \
  "Welcome to the installation of Gpg4win"

# The About string as displayed on the first page.
LangString T_AboutGpg4win ${LANG_ENGLISH} \
 "Gpg4win is an installer package for Windows for EMail and \
  file encryption using the core component GnuPG for Windows. \
  Both relevant cryptography standards are supported, OpenPGP \
  and S/MIME. Gpg4win and the software included with Gpg4win \
  is Free Software."

LangString T_AboutGpg4winVersion ${LANG_ENGLISH} \
 "This is Gpg4win version ${VERSION}"

LangString T_AboutGpg4winFileVersion ${LANG_ENGLISH} \
 "file version ${PROD_VERSION}"

LangString T_AboutGpg4winReleaseDate ${LANG_ENGLISH} \
 "Release date ${_BUILD_ISODATE}"

# At long last, include all the translations.
!include "../po/catalogs.nsi"

# Now include the generic parts to end the installation.
!include "installer-finish.nsi"

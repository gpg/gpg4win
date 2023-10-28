# inst-gpg4win.nsi - Hidden section for common files. -*- coding: latin-1; -*-
# Copyright (C) 2006 g10 Code GmbH
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


# This is the very first section installed.
Section "-gpg4win" SEC_gpg4win
!ifdef SOURCES
  SetOutPath "$INSTDIR"
  File "${BUILD_DIR}/../gpg4win-${VERSION}.tar.bz2"
!else
  Call KillOtherAppsOrWarn
  StrCpy $is_update "0"

# BEGIN MSI IGNORE
#  For MSI we ignore this.

# Start the slideshow.
  SetDetailsPrint none

  SetOutPath "$PLUGINSDIR\Slides"
  File "${BUILD_DIR}/slideshow/slide1-gpgol.png"
  File "${BUILD_DIR}/slideshow/slide2-gpgex.png"
  #File "${BUILD_DIR}/slideshow/slide3-kleopatra.png"
  File "${BUILD_DIR}/slideshow/slide4-summary.png"
  File "${BUILD_DIR}/slideshow/slides.dat"
  g4wihelp::slide_show /NOUNLOAD /CCOLOR=0x000000 "/auto=$PLUGINSDIR\Slides\slides.dat" /FIT=WIDTH
  SetDetailsPrint both
  SetOutPath "$INSTDIR"
# END MSI IGNORE

# Uninstall an old version if found.
  ClearErrors
  ReadRegStr $0 SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\GPG4Win" "DisplayVersion"
  IfErrors skip_uninst 0
  StrCmp $0 "" skip_uninst
  DetailPrint  "$(T_UninstallingOldVersion)$0"
  ReadRegStr $0 SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\GPG4Win" "UninstallString"
  IfErrors skip_uninst 0
  ReadRegStr $1 SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\GPG4Win" "InstallLocation"
  IfErrors skip_uninst 0

  ExecWait '$0 /S /UPDATE=1 _?=$1'
# Deleting here does not work?
  StrCpy $is_update "1"
  Delete /REBOOTOK "$1\gpg4win-uninstall.exe"
  RmDir "$1"
  SetOutPath "$INSTDIR\share\gpg4win"

skip_uninst:
# BEGIN MSI IGNORE
  SetOutPath "$INSTDIR\share\gpg4win"

  File "${BUILD_DIR}/HOWTO-SMIME.en.txt"
  File "${BUILD_DIR}/HOWTO-SMIME.de.txt"

  File "${BUILD_DIR}/versioninfo.txt"
# END MSI IGNORE

  # Write a version file.
  DetailPrint "Opening VERSION file for writing"
  FileOpen $0 "$INSTDIR\VERSION" w
  FileWrite $0 "${PRETTY_PACKAGE}-${VERSION}$\r$\n"
  FileClose $0
  DetailPrint "VERSION closed"

# BEGIN MSI IGNORE

  # Register the install directory for Gpg4win suite.
  WriteRegStr SHCTX "Software\Gpg4win" "Install Directory" $INSTDIR
  DetailPrint "Saved install directory in the registry"

# END MSI IGNORE

  # We used to determine the language using a Registry entry.
  # Although we don't want to delete the user's Lang Registry Setting
  # because he might have have selected a different language than his
  # default.  We delete the global Lang of the installation.
  DeleteRegValue SHCTX "Software\GNU\GnuPG" "Lang"
  DetailPrint "Deleted obsolete Lang entry"

  # This old key is required for GPGee.  Please do not use in new
  # applications.
  # Note: We don't use it anymore so that gpgme decides what gpg to use
  #       For the new gpg4win we actually use gpg2.exe.
  #       To cope with old installations we actually remove this value.
  #       However we can only remove the SHCTX version not those set by
  #       the user under HKCU.
  #WriteRegStr SHCTX "Software\GNU\GnuPG" "gpgProgram" "$INSTDIR\gpg.exe"
  DeleteRegValue SHCTX "Software\GNU\GnuPG" "gpgProgram"
  DetailPrint "Deleted obsolete gpgProgram value"

  # Install gpg4win included tools
  SetOutPath "$INSTDIR\bin"
  File "${BUILD_DIR}/sha1sum.exe"
  SetOutPath "$INSTDIR\bin"
  File "${BUILD_DIR}/sha256sum.exe"
  File "${BUILD_DIR}/md5sum.exe"

  # Install the mingw32 runtime libraries.  They are stored in the
  # build directory with a different suffix, so that makensis does not
  # list symbol names.
  File /oname=libstdc++-6.dll     "${BUILD_DIR}/libstdc++-6.dll-x"
  File /oname=libwinpthread-1.dll "${BUILD_DIR}/libwinpthread-1.dll-x"
  # only one of the following two files exists
  File /nonfatal /oname=libgcc_s_sjlj-1.dll "${BUILD_DIR}/libgcc_s_sjlj-1.dll-x"
  File /nonfatal /oname=libgcc_s_dw2-1.dll  "${BUILD_DIR}/libgcc_s_dw2-1.dll-x"

  SetOutPath "$INSTDIR\bin_64"
  File /nonfatal /oname=libwinpthread-1.dll "${BUILD_DIR}/libwinpthread-1.dll-x64"
!endif

SectionEnd

LangString DESC_Menu_gpg4win_readme ${LANG_ENGLISH} \
   "General information on Gpg4win"

LangString DESC_Menu_gpg4win_howtosmime ${LANG_ENGLISH} \
   "Instruction to configure S/MIME"

LangString DESC_Menu_gnupg_faq ${LANG_ENGLISH} \
   "Show the Frequently Asked Questions document for GnuPG"

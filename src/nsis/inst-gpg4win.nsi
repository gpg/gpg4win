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

var uninst64_checked
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
  File "${SRCDIR}/slideshow/slide1-gpgol.png"
  File "${SRCDIR}/slideshow/slide2-gpgex.png"
  #File "${SRCDIR}/slideshow/slide3-kleopatra.png"
  File "${SRCDIR}/slideshow/slide4-summary.png"
  File "${SRCDIR}/slideshow/slides.dat"
  g4wihelp::slide_show /NOUNLOAD /CCOLOR=0x000000 "/auto=$PLUGINSDIR\Slides\slides.dat" /FIT=WIDTH
  SetDetailsPrint both
  SetOutPath "$INSTDIR"
# END MSI IGNORE

# We do the uninstall check twice once in the 32 bit registry and once
# looking in the 64 bit registry, even if we are a 32 bit installer.
# because  we could be downgrading a 64 bit installation and would want
# to call the uninstaller in that case, too.
  StrCpy $uninst64_checked "0"

  SetRegView 32
uninstall_check:
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
  # If we arrive here and uninst64_checked is 1 this means
  # that we checked both for 32 bit in the first run and
  # then jumped into another uninstall_check with the
  # 64bit reg view.
  StrCmp $uninst64_checked "1" uninst_checks_done 0
  StrCpy $uninst64_checked "1"
  SetRegView 64
  goto uninstall_check

uninst_checks_done:
!ifdef IS_W64_INST
# While trying to find the old installation dir and configuration in
# both 32 and 64 views. For new Versions we only install in the
# 64 view
  SetRegView 64
!else
  # Legacy installation
  SetRegView 32
!endif

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
  File /nonfatal /oname=libgcc_s_seh-1.dll "${BUILD_DIR}/libgcc_s_seh-1.dll-x"

  SetOutPath "$INSTDIR\${EX_BINDIR}"
  File /nonfatal /oname=libwinpthread-1.dll "${BUILD_DIR}/libwinpthread-1.dll-ex"

  SetOutPath "$INSTDIR"
  File /oname=pkg-licenses.txt "${SRCDIR}/../doc/pkg-copyright.txt"
!endif

SectionEnd

LangString DESC_Menu_gpg4win_readme ${LANG_ENGLISH} \
   "General information on Gpg4win"

LangString DESC_Menu_gpg4win_howtosmime ${LANG_ENGLISH} \
   "Instruction to configure S/MIME"

LangString DESC_Menu_gnupg_faq ${LANG_ENGLISH} \
   "Show the Frequently Asked Questions document for GnuPG"

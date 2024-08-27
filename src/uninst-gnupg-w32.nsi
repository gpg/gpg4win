# inst-gnupg2.nsi - Uninstaller snippet for gnupg-w32. -*- coding: latin-1; -*-
# Copyright (C) 2015 Intevation GmbH
#
# This file is part of Gpg4win.
#
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/gnupg-w32-${gpg4win_pkg_gnupg_w32_version}


# Uninstaller section.
Section  "un.gnupg_w32"
!ifdef SOURCES
  Push "${gpg4win_pkg_gnupg_w32}"
  Call un.SourceDelete
!else
  ClearErrors
  ReadRegStr $0 SHCTX "Software\GnuPG" "Install Directory"
  IfErrors gnupg_w32_not_installed 0
  # It is possible that someone uninstalled gnupg without uninstalling
  # gpg4win
  StrCmp $0 "" gnupg_w32_not_installed
  DetailPrint  "$(T_Uninstalling_GnuPG) ${gpg4win_pkg_gnupg_w32_version}"
  Delete "$0\bin\gpg-enable-keyboxd.bat"
  Delete "$0\bin\gpg-disable-keybox.bat"
  RmDir "$0\bin"
  ExecWait '"$0\gnupg-uninstall.exe" /S _?=$0'
  Delete "$0\gnupg-uninstall.exe"
  RmDir "$0"
gnupg_w32_not_installed:
!endif
SectionEnd

LangString T_UnInstalling_GnuPG ${LANG_ENGLISH} \
   "Uninstalling GnuPG"

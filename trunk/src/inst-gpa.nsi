# inst-gpa.nsi - Installer snippet for gpa.        -*- coding: latin-1; -*-
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


!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/gpa-${gpg4win_pkg_gpa_version}


Section "GPA" SEC_gpa
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gpa}"
!else
  File ${prefix}/bin/gpa.exe

  SetOutPath "$INSTDIR\pub"
  File /oname=gpa.exe "${BUILD_DIR}/gpgwrap.exe"

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/gpa.mo

  SetOutPath "$INSTDIR\share\gpa"
  File ${prefix}/share/gpa/gpa_tips.en
  File ${prefix}/share/gpa/gpa_tips.de
  File ${prefix}/share/gpa/gpa_logo.ppm
  File ${prefix}/share/gpa/gpa.png

  # If requested, install the configuration files.
  ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" AppData
  StrCmp $0 "" no_config_gpa_files
  SetOutPath "$0\gnupg"

  g4wihelp::config_fetch "gpa.conf"
  StrCmp $R0 "" no_config_gpa_conf
    CopyFiles $R0 "$0\gnupg\gpa.conf"
  no_config_gpa_conf:

  no_config_gpa_files:

!endif
SectionEnd


LangString DESC_SEC_gpa ${LANG_ENGLISH} \
   "GNU Privacy Assistant"

LangString DESC_Menu_gpa ${LANG_ENGLISH} \
   "Run the GNU Privacy Assistant key management tool. \
    This is an alternative to the WinPT key management tool."

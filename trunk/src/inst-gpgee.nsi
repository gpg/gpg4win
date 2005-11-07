# inst-gpgee.nsi - Installer snippet for GPGee       -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/gpgee-${gpg4win_pkg_gpgee_version}


Section "GPGee" SEC_gpgee
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gpgee_src}"
!else
  File ${prefix}/GPGee.dll
  File ${prefix}/GPGee.DEU
  File ${prefix}/GPGee.hlp

  # Register the DLL.
  Exec 'regsvr32.exe /s "$INSTDIR\GPGee.dll"'

  SetOutPath "$INSTDIR\share\gpgee"
  File ${prefix}/gpl.txt

!endif
SectionEnd


LangString DESC_SEC_gpgee ${LANG_ENGLISH} \
   "GPG Explorer Extensions"
LangString DESC_SEC_gpgee ${LANG_GERMAN} \
   "GPG Explorer Erweiterungen (GPGee) ist eine Erweiterung für \
    den Explorer, die es ermöglicht, Dateien über das Kontextmenü zu \
    verschlüsseln."

LangString DESC_Menu_gpgee_hlp ${LANG_ENGLISH} \
   "Show the online manula of GPGee"
LangString DESC_Menu_gpgee_hlp ${LANG_German} \
   "Das englische Handbuch zu GPGee anzeigen"


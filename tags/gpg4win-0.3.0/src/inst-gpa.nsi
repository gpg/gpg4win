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

  SetOutPath "$INSTDIR\share\gpa"
  File ${prefix}/share/gpa/gpa_tips.en
  File ${prefix}/share/gpa/gpa_tips.de
  File ${prefix}/share/gpa/gpa_logo.ppm
  File ${prefix}/share/gpa/gpa.png
!endif
SectionEnd


LangString DESC_SEC_gpa ${LANG_ENGLISH} \
   "GNU Privacy Assistant"
LangString DESC_SEC_gpa ${LANG_GERMAN} \
   "GNU Privacy Assistent (GPA) ist ein Schlüsselverwaltungsprogramm \
    welches für mehrere Betriebsysteme verfügbar ist.  Es kann zusammen \
    oder anstatt von WinPT benutzt werden."


LangString DESC_Menu_gpa ${LANG_ENGLISH} \
   "Run the GNU Privacy Assistant key management tool. \
    This is an alternative to the WinPT key management tool."
LangString DESC_Menu_gpa ${LANG_GERMAN} \
   "Das Schlüsselverwaltungsprogramm GNU Privacy Assistent aufrufen. \
    Dies ist eine Alternative zu dem WinPT Programm."

# inst-winpt.nsi - Installer snippet for WinPT       -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/winpt-${gpg4win_pkg_winpt_version}


Section "winpt" SEC_winpt
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_winpt_src}"
!else
  File ${prefix}/WinPT.exe
  File ${prefix}/PTD.dll

  SetOutPath "$INSTDIR\share\winpt"
  File ${prefix}/keyserver.conf
  File ${prefix}/NEWS-0.10.txt
  File ${prefix}/README-0.10.txt
!endif
SectionEnd


LangString DESC_SEC_winpt ${LANG_ENGLISH} \
   "Windows Privacy Tray"
LangString DESC_SEC_winpt ${LANG_GERMAN} \
   "Windows Privacy Tray"

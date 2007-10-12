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


Section /o "GPGee" SEC_gpgee
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gpgee_src}"
!else
  # Try to unregister first
  UnRegDLL "$INSTDIR\GPGee.dll"
  Sleep 500

  ClearErrors
  SetOverwrite try
  File ${prefix}/GPGee/GPGee.dll
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=GPGee.dll.tmp ${prefix}/GPGee/GPGee.dll
      Rename /REBOOTOK GPGee.dll.tmp GPGee.dll

  ClearErrors
  SetOverwrite try
  File ${prefix}/GPGee/GPGee.DEU
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=GPGee.DEU.tmp ${prefix}/GPGee/GPGee.DEU
      Rename /REBOOTOK GPGee.DEU.tmp GPGee.DEU

  File ${prefix}/GPGee/GPGee.hlp

  # Register the DLL.
  RegDLL "$INSTDIR\GPGee.dll"
  ifErrors 0 +2
     MessageBox MB_OK "$(T_GPGee_RegFailed)"

  SetOutPath "$INSTDIR\share\gpgee"
  File ${prefix}/GPGee/gpl.txt

!endif
SectionEnd

LangString T_GPGee_RegFailed ${LANG_ENGLISH} \
   "Warning: Registration of the GPGee explorer extension failed."

LangString DESC_SEC_gpgee ${LANG_ENGLISH} \
   "GPG Explorer Extensions"

LangString DESC_Menu_gpgee_hlp ${LANG_ENGLISH} \
   "Show the online manual of GPGee"

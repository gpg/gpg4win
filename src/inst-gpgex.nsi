# inst-gpgex.nsi - Installer snippet for gpgex.      -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007 g10 Code GmbH
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
!define prefix ${ipdir}/gpgex-${gpg4win_pkg_gpgex_version}


Section "-removegpgee"
!ifndef SOURCES
# Uninstall a previous gpgee version, if it exists.
  ifFileExists "$INSTDIR\GPGee.dll" 0 gpgex_no_gpgee
    UnRegDLL "$INSTDIR\GPGee.dll"
    Delete /REBOOTOK "$INSTDIR\GPGee.dll"
    Delete /REBOOTOK "$INSTDIR\GPGee.DEU"
    Delete "$INSTDIR\GPGee.hlp"
    Delete "$INSTDIR\share\gpgee\gpl.txt"
    RMDir "$INSTDIR\share\gpgee"
    RMDir "$INSTDIR\share"
    RMDir "$INSTDIR"
  gpgex_no_gpgee:
!endif
SectionEnd


${MementoSection} "GpgEX" SEC_gpgex
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gpgex}"
!else

  ClearErrors
  SetOverwrite try
  File ${prefix}/bin/gpgex.dll
  SetOverwrite lastused
  ifErrors 0 do_reg
      File /oname=gpgex.dll.tmp ${prefix}/bin/gpgex.dll
      Rename /REBOOTOK gpgex.dll.tmp gpgex.dll

 do_reg:
  # Register the DLL.
  RegDLL "$INSTDIR\gpgex.dll"
  ifErrors 0 +2
     MessageBox MB_OK "$(T_GpgEX_RegFailed)"

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/gpgex.mo

  SetOutPath "$INSTDIR\share\doc\gpgex"
  File ${prefix}/share/doc/gpgex/gpgex-en.html
  File ${prefix}/share/doc/gpgex/gpgex-de.html

!endif
${MementoSectionEnd}


LangString T_GpgEX_RegFailed ${LANG_ENGLISH} \
   "Warning: Registration of the GpgEX plugin failed."

LangString DESC_SEC_gpgex ${LANG_ENGLISH} \
   "GnuPG Shell Extension"

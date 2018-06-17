# uninst-gpgol.nsi - Installer snippet for gpgol.    -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/gpgol-${gpg4win_pkg_gpgol_version}


; Uninstaller section.
Section "-un.gpgol"
!ifdef SOURCES
  Push "${gpg4win_pkg_gpgol}"
  Call un.SourceDelete
!else

  Delete "$INSTDIR\share\gpgol\*.cfg"
  Delete "$INSTDIR\share\gpgol\*.ico"
  RMDir "$INSTDIR\share\gpgol"

  Delete "$INSTDIR\share\doc\gpgol\gpgol.pdf"
  RMDir "$INSTDIR\share\doc\gpgol"
  RMDir "$INSTDIR\share\doc"

  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\gpgol.mo"
  RMDir "$INSTDIR\share\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\de"
  Delete "$INSTDIR\share\locale\sv\LC_MESSAGES\gpgol.mo"
  RMDir "$INSTDIR\share\locale\sv\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\sv"
  Delete "$INSTDIR\share\locale\pt\LC_MESSAGES\gpgol.mo"
  RMDir "$INSTDIR\share\locale\pt\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\pt"
  Delete "$INSTDIR\share\locale\uk\LC_MESSAGES\gpgol.mo"
  RMDir "$INSTDIR\share\locale\uk\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\uk"
  Delete "$INSTDIR\share\locale\nl\LC_MESSAGES\gpgol.mo"
  RMDir "$INSTDIR\share\locale\nl\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\nl"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\gpgol.mo"
  RMDir "$INSTDIR\share\locale\fr\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\fr"
  Delete "$INSTDIR\share\locale\zh_CN\LC_MESSAGES\gpgol.mo"
  RMDir "$INSTDIR\share\locale\zh_CN\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\zh_CN"
  Delete "$INSTDIR\share\locale\zh_TW\LC_MESSAGES\gpgol.mo"
  RMDir "$INSTDIR\share\locale\zh_TW\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\zh_TW"
  RMDir "$INSTDIR\share\locale"
  RMDir "$INSTDIR\share\"

  UnRegDLL "$INSTDIR\bin\gpgol.dll"

  Delete /REBOOTOK "$INSTDIR\bin\gpgol.dll"

${If} ${RunningX64}
  ExecWait '"$SYSDIR\regsvr32" /u /s "$INSTDIR\bin_64\gpgol.dll"'
  Delete /REBOOTOK "$INSTDIR\bin_64\gpgol.dll"
${EndIf}
  RMDir "$INSTDIR"
!endif
SectionEnd

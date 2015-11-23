# uninst-gpgex.nsi - Installer snippet for gpgex.    -*- coding: latin-1; -*-
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


; Uninstaller section.
Section "-un.gpgex"
!ifdef SOURCES
  Push "${gpg4win_pkg_gpgex}"
  Call un.SourceDelete
!else

  Delete "$INSTDIR\share\doc\gpgex\gpgex-en.html"
  Delete "$INSTDIR\share\doc\gpgex\gpgex-de.html"
  RMDir "$INSTDIR\share\doc\gpgex"
  RMDir "$INSTDIR\share\doc"

  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\de"
  Delete "$INSTDIR\share\locale\ar\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\ar\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ar"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\es\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\es"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\ru\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ru"
  Delete "$INSTDIR\share\locale\pt\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\pt\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\pt"
  Delete "$INSTDIR\share\locale\pl\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\pl\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\pl"
  Delete "$INSTDIR\share\locale\zh_CN\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\zh_CN\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\zh_CN"
  Delete "$INSTDIR\share\locale\zh_TW\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\zh_TW\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\zh_TW"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\gpgex.mo"
  RMDir "$INSTDIR\share\locale\fr\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\fr"
  RMDir "$INSTDIR\share\locale"
  RMDir "$INSTDIR\share"

  UnRegDLL "$INSTDIR\gpgex.dll"

  Delete /REBOOTOK "$INSTDIR\gpgex.dll"

${If} ${RunningX64}
  ExecWait '"$SYSDIR\regsvr32" /u /s "$INSTDIR\bin\gpgex.dll"'
  Delete /REBOOTOK "$INSTDIR\bin\gpgex.dll"
${EndIf}

!endif
SectionEnd

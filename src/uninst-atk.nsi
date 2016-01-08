# uninst-atk.nsi - Installer snippet for atk.      -*- coding: latin-1; -*-
# Copyright (C) 2005, 2008 g10 Code GmbH
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
!define prefix ${ipdir}/atk-${gpg4win_pkg_atk_version}


; Uninstaller section.
Section "-un.atk"
!ifdef SOURCES
  Push "${gpg4win_pkg_atk_src}"
  Call un.SourceDelete
!else
  # Old stuff.
  Delete "$INSTDIR\lib\locale\de\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\lib\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\de"
  Delete "$INSTDIR\lib\locale\ar\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\lib\locale\ar\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\ar"
  Delete "$INSTDIR\lib\locale\es\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\lib\locale\es\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\es"
  Delete "$INSTDIR\lib\locale\fr\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\lib\locale\fr\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\fr"
  Delete "$INSTDIR\lib\locale\ru\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\lib\locale\ru\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\ru"

  # Current stuff.
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\share\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\de"
  Delete "$INSTDIR\share\locale\ar\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\share\locale\ar\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ar"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\share\locale\es\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\es"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\share\locale\fr\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\fr"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\atk10.mo"
  RMDir "$INSTDIR\share\locale\ru\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ru"
  RMDir "$INSTDIR\share\locale"
  RMDir "$INSTDIR\share"

  Delete /REBOOTOK "$INSTDIR\bin\libatk-1.0-0.dll"

!endif

SectionEnd

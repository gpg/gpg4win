# uninst-libgpg-error.nsi - Installer f. libgpg-error. -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/libgpg-error-${gpg4win_pkg_libgpg_error_version}


; Uninstaller section.
Section "-un.libgpg-error"
!ifdef SOURCES
  Push "${gpg4win_pkg_libgpg_error}"
  Call un.SourceDelete
!else
  Delete /REBOOTOK "$INSTDIR\bin\libgpg-error-0.dll"

  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\libgpg-error.mo"
  Delete "$INSTDIR\share\locale\pl\LC_MESSAGES\libgpg-error.mo"
  Delete "$INSTDIR\share\locale\ro\LC_MESSAGES\libgpg-error.mo"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\libgpg-error.mo"

  Delete "$INSTDIR\bin\gpg-error.exe"
  Delete "$INSTDIR\lib\libgpg-error.imp"
  Delete "$INSTDIR\lib\libgpg-assuan.imp"
  Delete "$INSTDIR\include\gpg-error.h"
${If} ${RunningX64}
  Delete /REBOOTOK "$INSTDIR\bin_64\libgpg-error-0.dll"
${EndIf}

!endif
SectionEnd

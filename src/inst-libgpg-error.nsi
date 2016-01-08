# inst-libgpg-error.nsi - snippet for libgpg-error.   -*- coding: latin-1; -*-
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


!ifdef DEBUG
Section "libgpg-error" SEC_libgpg_error
!else
Section "-libgpg-error" SEC_libgpg_error
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_libgpg_error}"
!else
  SetOutPath "$INSTDIR\bin"

  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/libgpg-error-0.dll"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=libgpg-error-0.dll.tmp "${prefix}/bin/libgpg-error-0.dll"
      Rename /REBOOTOK libgpg-error-0.dll.tmp libgpg-error-0.dll


  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/libgpg-error.mo
  SetOutPath "$INSTDIR\share\locale\pl\LC_MESSAGES"
  File ${prefix}/share/locale/pl/LC_MESSAGES/libgpg-error.mo
  SetOutPath "$INSTDIR\share\locale\ro\LC_MESSAGES"
  File ${prefix}/share/locale/ro/LC_MESSAGES/libgpg-error.mo
  SetOutPath "$INSTDIR\share\locale\fr\LC_MESSAGES"
  File ${prefix}/share/locale/fr/LC_MESSAGES/libgpg-error.mo

  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/gpg-error.exe

  SetOutPath "$INSTDIR\lib"
  File /oname=libgpg-error.imp "${prefix}/lib/libgpg-error.dll.a"

  SetOutPath "$INSTDIR\include"
  File "${prefix}/include/gpg-error.h"

!endif
SectionEnd

# uninst-libassuan.nsi - Uninstaller f. libassuan.  -*- coding: latin-1; -*-
# Copyright (C) 2007 g10 Code GmbH
#
# This file is part of Gpg4win.
#
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.


!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/libassuan-${gpg4win_pkg_libassuan_version}


; Uninstaller section.
Section "-un.libassuan"
!ifdef SOURCES
  Push "${gpg4win_pkg_libassuan}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\libassuan-0.dll"
  Delete "$INSTDIR\lib\libassuan.imp"
  Delete "$INSTDIR\include\assuan.h"

!endif
SectionEnd


# uninst-libgcrypt.nsi - Uninstaller f. libgcrypt.  -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/libgcrypt-${gpg4win_pkg_libgcrypt_version}


; Uninstaller section.
Section "-un.libgcrypt"
!ifdef SOURCES
  Push "${gpg4win_pkg_libgcrypt}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\libgcrypt-11.dll"
  Delete "$INSTDIR\lib\libgcrypt.imp"
  Delete "$INSTDIR\include\gcrypt.h"
  Delete "$INSTDIR\include\gcrypt-module.h"

  RMDir "$INSTDIR"
!endif
SectionEnd

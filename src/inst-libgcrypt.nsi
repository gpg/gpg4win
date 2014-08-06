# inst-libgcrypt.nsi - snippet for libgcrypt.   -*- coding: latin-1; -*-
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


!ifdef DEBUG
Section "libgcrypt" SEC_libgcrypt
!else
Section "-libgcrypt" SEC_libgcrypt
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_libgcrypt}"
!else
  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/libgcrypt-20.dll"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=libgcrypt-20.dll.tmp "${prefix}/bin/libgcrypt-20.dll"
      Rename /REBOOTOK libgcrypt-20.dll.tmp libgcrypt-20.dll

  SetOutPath "$INSTDIR\lib"
  File /oname=libgcrypt.imp "${prefix}/lib/libgcrypt.dll.a"

  SetOutPath "$INSTDIR\include"
  File "${prefix}/include/gcrypt.h"


!endif
SectionEnd

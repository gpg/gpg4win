# inst-libiconv.nsi - Installer snippet for libiconv.  -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/libiconv-${gpg4win_pkg_libiconv_version}


!ifdef DEBUG
Section "libiconv" SEC_libiconv
!else
Section "-libiconv" SEC_libiconv
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_libiconv}"
!else
  SetOutPath "$INSTDIR\bin"

  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/libiconv-2.dll"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=libiconv-2.dll.tmp "${prefix}/bin/libiconv-2.dll"
      Rename /REBOOTOK libiconv-2.dll.tmp libiconv-2.dll

  # Also install it under the name GnuPG and maybe other software
  # inspects since ages.
  ClearErrors
  SetOverwrite try
  File /oname=iconv.dll "${prefix}/bin/libiconv-2.dll"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=iconv.dll.tmp "${prefix}/bin/libiconv-2.dll"
      Rename /REBOOTOK iconv.dll.tmp iconv.dll

  SetOutPath "$INSTDIR\lib"
  File ${prefix}/lib/charset.alias

!ifdef DEBUG
  # We install a couple of binaries that may be useful for testing.
  File ${prefix}/bin/charset.dll
  File ${prefix}/bin/iconv.exe
!endif
!endif
SectionEnd

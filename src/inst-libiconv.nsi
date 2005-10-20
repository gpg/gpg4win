# inst-libiconv.nsi - Installer snippet for libiconv.
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
  File "${gpg4win_pkg_libiconv_src}"
!else
  File ${prefix}/bin/iconv.dll
!ifdef DEBUG
  # We install a couple of binaries that may be useful for testing.
  File ${prefix}/bin/charset.dll
  File ${prefix}/bin/iconv.exe
!endif
!endif
SectionEnd

; Uninstaller section.
Section "-un.libiconv"
!ifdef SOURCES
  Push "${gpg4win_pkg_libiconv_src}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\iconv.dll"
!ifdef DEBUG
  Delete "$INSTDIR\charset.dll"
  Delete "$INSTDIR\iconv.exe"
!endif
  RMDir "$INSTDIR"
!endif
SectionEnd

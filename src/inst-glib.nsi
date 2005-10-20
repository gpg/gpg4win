# inst-glib.nsi - Installer snippet for glib.
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
!define prefix ${ipdir}/glib-${gpg4win_pkg_glib_version}

!ifdef DEBUG
Section "glib" SEC_glib
!else
Section "-glib" SEC_glib
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File ${gpg4win_pkg_glib_src}
!else
  File ${prefix}/bin/gspawn-win32-helper.exe
  File ${prefix}/bin/libglib-2.0-0.dll
  File ${prefix}/bin/libgmodule-2.0-0.dll
  File ${prefix}/bin/libgobject-2.0-0.dll
  File ${prefix}/bin/libgthread-2.0-0.dll
!endif
SectionEnd


; Uninstaller section.
Section "-un.glib"
!ifdef SOURCES
  Push "${gpg4win_pkg_glib_src}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\gspawn-win32-helper.exe"
  Delete "$INSTDIR\libglib-2.0-0.dll"
  Delete "$INSTDIR\libgmodule-2.0-0.dll"
  Delete "$INSTDIR\libgobject-2.0-0.dll"
  Delete "$INSTDIR\libgthread-2.0-0.dll"
  RMDir "$INSTDIR"
!endif
SectionEnd

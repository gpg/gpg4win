# uninst-glib.nsi - Installer snippet for glib.      -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/glib-${gpg4win_pkg_glib_version}


; Uninstaller section.
Section "-un.glib"
!ifdef SOURCES
  Push "${gpg4win_pkg_glib}"
  Call un.SourceDelete
!else

  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\glib20.mo"
  Delete "$INSTDIR\share\locale\ar\LC_MESSAGES\glib20.mo"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\glib20.mo"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\glib20.mo"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\glib20.mo"

  Delete "$INSTDIR\share\glib-2.0\schemas\gschema.dtd"
  RMDir "$INSTDIR\share\glib-2.0\schemas"
  RMDir "$INSTDIR\share\glib-2.0"

  Delete "$INSTDIR\bin\gspawn-win32-helper.exe"
  Delete "$INSTDIR\bin\gspawn-win32-helper-console.exe"
  Delete "$INSTDIR\bin\gdbus.exe"
  Delete "$INSTDIR\bin\gio-querymodules.exe"
  Delete "$INSTDIR\bin\glib-compile-resources.exe"
  Delete "$INSTDIR\bin\glib-compile-schemas.exe"
  Delete "$INSTDIR\bin\glib-genmarshal.exe"
  Delete "$INSTDIR\bin\gobject-query.exe"
  Delete "$INSTDIR\bin\gresource.exe"
  Delete "$INSTDIR\bin\gsettings.exe"
  Delete "$INSTDIR\bin\gspawn-win32-helper-console.exe"
  Delete "$INSTDIR\bin\gspawn-win32-helper.exe"

  Delete /REBOOTOK "$INSTDIR\bin\libglib-2.0-0.dll"
  Delete /REBOOTOK "$INSTDIR\bin\libgmodule-2.0-0.dll"
  Delete /REBOOTOK "$INSTDIR\bin\libgobject-2.0-0.dll"
  Delete /REBOOTOK "$INSTDIR\bin\libgthread-2.0-0.dll"
  Delete /REBOOTOK "$INSTDIR\bin\libgio-2.0-0.dll"

!endif
SectionEnd

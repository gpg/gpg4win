# inst-glib.nsi - Installer snippet for glib.        -*- coding: latin-1; -*-
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

!ifdef DEBUG
Section "glib" SEC_glib
!else
Section "-glib" SEC_glib
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File ${gpg4win_pkg_glib}
!else
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/gspawn-win32-helper.exe
  File ${prefix}/bin/gspawn-win32-helper-console.exe
  File ${prefix}/bin/libglib-2.0-0.dll
  File ${prefix}/bin/libgmodule-2.0-0.dll
  File ${prefix}/bin/libgobject-2.0-0.dll
  File ${prefix}/bin/libgthread-2.0-0.dll
  File ${prefix}/bin/libgio-2.0-0.dll

  File ${prefix}/bin/gdbus.exe
  File ${prefix}/bin/gio-querymodules.exe
  File ${prefix}/bin/glib-compile-resources.exe
  File ${prefix}/bin/glib-compile-schemas.exe
  File ${prefix}/bin/glib-genmarshal.exe
  File ${prefix}/bin/gobject-query.exe
  File ${prefix}/bin/gresource.exe
  File ${prefix}/bin/gsettings.exe
  File ${prefix}/bin/gspawn-win32-helper-console.exe
  File ${prefix}/bin/gspawn-win32-helper.exe

  SetOutPath "$INSTDIR\share\glib-2.0\schemas"
  File ${prefix}/share/glib-2.0/schemas/gschema.dtd

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/glib20.mo

  SetOutPath "$INSTDIR\share\locale\ar\LC_MESSAGES"
  File ${prefix}/share/locale/ar/LC_MESSAGES/glib20.mo

  SetOutPath "$INSTDIR\share\locale\es\LC_MESSAGES"
  File ${prefix}/share/locale/es/LC_MESSAGES/glib20.mo

  SetOutPath "$INSTDIR\share\locale\fr\LC_MESSAGES"
  File ${prefix}/share/locale/fr/LC_MESSAGES/glib20.mo

  SetOutPath "$INSTDIR\share\locale\ru\LC_MESSAGES"
  File ${prefix}/share/locale/ru/LC_MESSAGES/glib20.mo

!endif
SectionEnd

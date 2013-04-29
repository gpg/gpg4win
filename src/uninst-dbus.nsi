# uninst-dbus.nsi - Snippet for dbus.  -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007 g10 Code GmbH
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
!define prefix ${ipdir}/dbus-${gpg4win_pkg_dbus_version}


; Uninstaller section.
Section "-un.dbus"
!ifdef SOURCES
  Push "${gpg4win_pkg_dbus_src}"
  Call un.SourceDelete
!else
  # FIXME: See inst-dbus.nsi.
  Delete /REBOOTOK "$INSTDIR\bin\dbus-daemon.exe"
  RMDir "$INSTDIR\bin"

  Delete "$INSTDIR\dbus-env.bat"
  Delete "$INSTDIR\dbus-launch.exe"
  Delete "$INSTDIR\dbus-monitor.exe"
  Delete "$INSTDIR\dbus-send.exe"

  # FIXME: Force dbus installed in our prefix down.
  Delete /REBOOTOK "$INSTDIR\libdbus-1.dll"
  Delete /REBOOTOK "$INSTDIR\libexpat.dll"
  Delete "$INSTDIR\libexpatw.dll"

  Delete "$INSTDIR\etc\session.conf"
  Delete "$INSTDIR\etc\system.conf"
  RMDir "$INSTDIR\etc"

  RMDir "$INSTDIR"
!endif
SectionEnd

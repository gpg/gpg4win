# inst-dbus.nsi - Snippet for dbus.      -*- coding: latin-1; -*-
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

!ifdef DEBUG
Section "dbus" SEC_dbus
!else
Section "-dbus" SEC_dbus
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_dbus_src}"
!else
  # FIXME: Figure out how to relocate dbus-daemon (and kleopatra).
  SetOutPath "$INSTDIR\bin"
  ClearErrors
  SetOverwrite try
  File ${prefix}/bin/dbus-daemon.exe
  SetOverwrite lastused
  IfErrors 0 +3
      File /oname=dbus-daemon.exe.tmp ${prefix}/bin/dbus-daemon.exe
      Rename /REBOOTOK dbus-daemon.exe.tmp dbus-daemon.exe
  SetOutPath "$INSTDIR"

  File ${prefix}/bin/dbus-launch.exe
  File ${prefix}/bin/dbus-env.bat
  File ${prefix}/bin/dbus-monitor.exe
  File ${prefix}/bin/dbus-send.exe

  ClearErrors
  SetOverwrite try
  File ${prefix}/bin/libdbus-1.dll
  SetOverwrite lastused
  IfErrors 0 +3
      File /oname=libdbus-1.dll.tmp ${prefix}/bin/libdbus-1.dll
      Rename /REBOOTOK libdbus-1.dll.tmp libdbus-1.dll

  ClearErrors
  SetOverwrite try
  File ${prefix}/bin/libexpat.dll
  SetOverwrite lastused
  IfErrors 0 +3
      File /oname=libexpat.dll.tmp ${prefix}/bin/libexpat.dll
      Rename /REBOOTOK libexpat.dll.tmp libexpat.dll

  File ${prefix}/bin/libexpatw.dll

  SetOutPath "$INSTDIR\etc"
  File ${prefix}/etc/session.conf
  File ${prefix}/etc/system.conf

!endif
SectionEnd

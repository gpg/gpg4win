# inst-w32pth.nsi - snippet for w32pth.   -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/w32pth-${gpg4win_pkg_w32pth_version}


!ifdef DEBUG
Section "w32pth" SEC_w32pth
!else
Section "-w32pth" SEC_w32pth
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_w32pth}"
!else
  SetOutPath "$INSTDIR\bin"

  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/libw32pth-0.dll"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=libw32pth-0.dll.tmp "${prefix}/bin/libw32pth-0.dll"
      Rename /REBOOTOK libw32pth-0.dll.tmp libw32pth-0.dll

!endif
SectionEnd

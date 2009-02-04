# uninst-paperkey.nsi - Snippet for paperkey.        -*- coding: latin-1; -*-
# Copyright (C) 2009 g10 Code GmbH
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
# along with this program; if not, see <http://www.gnu.org/licenses/>.


!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/paperkey-${gpg4win_pkg_paperkey_version}

; Uninstaller section.
Section "-un.paperkey"
!ifdef SOURCES
  Push "${gpg4win_pkg_paperkey}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\paperkey.exe"
  Delete "$INSTDIR\share\gnupg\paperkey.man"
  RMDir "$INSTDIR\share\gnupg"
!endif
SectionEnd

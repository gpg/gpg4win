# uninst-compendium.nsi - Installer snippet.     -*- coding: latin-1; -*-
# Copyright (C) 2008 g10 Code GmbH
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

; Uninstaller section.
Section "-un.compendium"
!ifdef SOURCES
  #Push "${gpg4win_pkg_compendium}"
  #Call un.SourceDelete
!else

  Delete "$INSTDIR\share\gpg4win\compendium-html\images-hyperlatex\*"
  Delete "$INSTDIR\share\gpg4win\compendium-html\images-compendium\*"
  Delete "$INSTDIR\share\gpg4win\compendium-html\de\*"
  Delete "$INSTDIR\share\gpg4win\compendium-html\en\*"
  RMDir "$INSTDIR\share\gpg4win\compendium-html"
  Delete "$INSTDIR\share\gpg4win\gpg4win-compendium-*.pdf"
  RMDir "$INSTDIR\share\gpg4win"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"

!endif
SectionEnd

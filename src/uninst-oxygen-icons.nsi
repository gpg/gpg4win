# uninst-oxygen-icons.nsi - Snippet for oxygen-icons.  -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007, 2008 g10 Code GmbH
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
!define prefix ${ipdir}/oxygen-icons-${gpg4win_pkg_oxygen_icons_version}


; Uninstaller section.
Section "-un.oxygen-icons"
!ifdef SOURCES
  Push "${gpg4win_pkg_oxygen_icons_src}"
  Call un.SourceDelete
!else

  Delete "$INSTDIR\share\icons\oxygen\index.theme"
  Delete "$INSTDIR\share\icons\oxygen\8x8\emblems\*.png"

  Delete "$INSTDIR\share\icons\oxygen\16x16\status\*.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\places\*.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\mimetypes\*.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\emblems\*.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\devices\*.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\categories\*.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\apps\*.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\actions\*.png"

  Delete "$INSTDIR\share\icons\oxygen\22x22\status\*.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\places\*.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\mimetypes\*.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\emblems\*.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\devices\*.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\categories\*.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\apps\*.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\actions\*.png"

  Delete "$INSTDIR\share\icons\oxygen\64x64\status\*.png"
  Delete "$INSTDIR\share\icons\oxygen\64x64\places\*.png"
  Delete "$INSTDIR\share\icons\oxygen\64x64\mimetypes\*.png"
  Delete "$INSTDIR\share\icons\oxygen\64x64\emblems\*.png"
  Delete "$INSTDIR\share\icons\oxygen\64x64\devices\*.png"
  Delete "$INSTDIR\share\icons\oxygen\64x64\categories\*.png"
  Delete "$INSTDIR\share\icons\oxygen\64x64\apps\*.png"
  Delete "$INSTDIR\share\icons\oxygen\64x64\actions\*.png"

  RMDir "$INSTDIR\share\icons\oxygen\8x8\emblems"
  RMDir "$INSTDIR\share\icons\oxygen\8x8"

  RMDir "$INSTDIR\share\icons\oxygen\16x16\status"
  RMDir "$INSTDIR\share\icons\oxygen\16x16\places"
  RMDir "$INSTDIR\share\icons\oxygen\16x16\mimetypes"
  RMDir "$INSTDIR\share\icons\oxygen\16x16\emblems"
  RMDir "$INSTDIR\share\icons\oxygen\16x16\devices"
  RMDir "$INSTDIR\share\icons\oxygen\16x16\categories"
  RMDir "$INSTDIR\share\icons\oxygen\16x16\apps"
  RMDir "$INSTDIR\share\icons\oxygen\16x16\actions"
  RMDir "$INSTDIR\share\icons\oxygen\16x16"

  RMDir "$INSTDIR\share\icons\oxygen\22x22\status"
  RMDir "$INSTDIR\share\icons\oxygen\22x22\places"
  RMDir "$INSTDIR\share\icons\oxygen\22x22\mimetypes"
  RMDir "$INSTDIR\share\icons\oxygen\22x22\emblems"
  RMDir "$INSTDIR\share\icons\oxygen\22x22\devices"
  RMDir "$INSTDIR\share\icons\oxygen\22x22\categories"
  RMDir "$INSTDIR\share\icons\oxygen\22x22\apps"
  RMDir "$INSTDIR\share\icons\oxygen\22x22\actions"
  RMDir "$INSTDIR\share\icons\oxygen\22x22"

  RMDir "$INSTDIR\share\icons\oxygen\64x64\status"
  RMDir "$INSTDIR\share\icons\oxygen\64x64\places"
  RMDir "$INSTDIR\share\icons\oxygen\64x64\mimetypes"
  RMDir "$INSTDIR\share\icons\oxygen\64x64\emblems"
  RMDir "$INSTDIR\share\icons\oxygen\64x64\devices"
  RMDir "$INSTDIR\share\icons\oxygen\64x64\categories"
  RMDir "$INSTDIR\share\icons\oxygen\64x64\apps"
  RMDir "$INSTDIR\share\icons\oxygen\64x64\actions"
  RMDir "$INSTDIR\share\icons\oxygen\64x64"

  RMDir "$INSTDIR\share\icons\oxygen"
  RMDir "$INSTDIR\share\icons"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"

!endif
SectionEnd

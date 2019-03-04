# uninst-breeze-icons.nsi - Snippet for breeze-icons.  -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/breeze-icons-${gpg4win_pkg_breeze_icons_version}


; Uninstaller section.
Section "-un.breeze-icons"
!ifdef SOURCES
  Push "${gpg4win_pkg_breeze_icons}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\share\icontheme.rcc"
  Delete "$INSTDIR\share\icons\kf5_rcc_theme\index.theme"
  Delete "$INSTDIR\share\icons\kf5_rcc_theme\icon-theme.cache"
  Delete "$INSTDIR\share\icons\breeze\index.theme"
  Delete "$INSTDIR\share\icons\breeze\icon-theme.cache"
  Delete "$INSTDIR\share\icons\breeze\actions\24\tools-report-bug.svg"
  Delete "$INSTDIR\share\icons\breeze\actions\24\help-contextual.svg"
  Delete "$INSTDIR\share\icons\breeze\actions\24\document-encrypt.svg"
  Delete "$INSTDIR\share\icons\breeze\actions\22\tools-report-bug.svg"
  Delete "$INSTDIR\share\icons\breeze\actions\22\help-contextual.svg"
  Delete "$INSTDIR\share\icons\breeze\actions\22\document-encrypt.svg"
  Delete "$INSTDIR\share\icons\breeze\actions\16\tools-report-bug.svg"
  Delete "$INSTDIR\share\icons\breeze\actions\16\help-contextual.svg"
  Delete "$INSTDIR\share\icons\breeze\actions\16\document-encrypt.svg"

  RMDir "$INSTDIR\share\icons\breeze\actions\24"
  RMDir "$INSTDIR\share\icons\breeze\actions\22"
  RMDir "$INSTDIR\share\icons\breeze\actions\16"
  RMDir "$INSTDIR\share\icons\breeze\actions"
  RMDir "$INSTDIR\share\icons\breeze"
  RMDir "$INSTDIR\share\icons"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"
!endif
SectionEnd

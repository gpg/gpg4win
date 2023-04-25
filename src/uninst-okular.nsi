# Copyright (C) 2023 g10 Code GmbH
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
!define prefix ${ipdir}/okular-${gpg4win_pkg_okular_version}

; Uninstaller section.
Section "-un.okular"
  Delete "$INSTDIR\bin\okular.exe"
  Delete "$INSTDIR\bin\libOkular5Core.dll"
  Delete "$INSTDIR\bin\plugins\okularpart.dll"
  Delete "$INSTDIR\bin\plugins\okular\generators\okularGenerator_poppler.dll"
  RmDir "$INSTDIR\bin\plugins\okular\generators"
  RmDir "$INSTDIR\bin\plugins\okular"
  RmDir "$INSTDIR\bin\plugins"
  RmDir "$INSTDIR\bin"
  Delete "$INSTDIR\share\icons\hicolor\64x64\apps\okular.png"
  Delete "$INSTDIR\share\icons\hicolor\48x48\apps\okular.png"
  Delete "$INSTDIR\share\icons\hicolor\32x32\apps\okular.png"
  Delete "$INSTDIR\share\icons\hicolor\22x22\apps\okular.png"
  Delete "$INSTDIR\share\icons\hicolor\16x16\apps\okular.png"
  Delete "$INSTDIR\share\icons\hicolor\128x128\apps\okular.png"
  Delete "$INSTDIR\share\icons\hicolor\icon-theme.cache"
  Delete "$INSTDIR\share\icons\hicolor\index.theme"
  RMDir "$INSTDIR\share\icons\hicolor\64x64\apps"
  RMDir "$INSTDIR\share\icons\hicolor\64x64"
  RMDir "$INSTDIR\share\icons\hicolor\48x48\apps"
  RMDir "$INSTDIR\share\icons\hicolor\48x48"
  RMDir "$INSTDIR\share\icons\hicolor\32x32\apps"
  RMDir "$INSTDIR\share\icons\hicolor\32x32"
  RMDir "$INSTDIR\share\icons\hicolor\22x22\apps"
  RMDir "$INSTDIR\share\icons\hicolor\22x22"
  RMDir "$INSTDIR\share\icons\hicolor\16x16\apps"
  RMDir "$INSTDIR\share\icons\hicolor\16x16"
  RMDir "$INSTDIR\share\icons\hicolor\128x128\apps"
  RMDir "$INSTDIR\share\icons\hicolor\128x128"
  RMDir "$INSTDIR\share\icons\hicolor"
  RMDir "$INSTDIR\share\icons"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"


  DetailPrint "Unregistering file extensions"

  DeleteRegValue SHCTX "Software\RegisteredApplications" "Gpg4win.Okular"
  DeleteRegKey SHCTX "Software\Gpg4win\Okular"

  DeleteRegKey SHCTX "Software\Classes\gpg4win.AssocFile.Okular.PDF"

SectionEnd

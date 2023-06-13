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

  Delete "$INSTDIR\share\kxmlgui5\okular\part.rc"
  Delete "$INSTDIR\share\kxmlgui5\okular\part-viewermode.rc"
  Delete "$INSTDIR\share\kxmlgui5\okular\shell.rc"

  Delete "$INSTDIR\share\okular\drawingtools.xml"
  Delete "$INSTDIR\share\okular\toolsQuick.xml"
  Delete "$INSTDIR\share\okular\tools.xml"

  Delete "$INSTDIR\share\okular\pics\checkmark.png"
  Delete "$INSTDIR\share\okular\pics\circle.png"
  Delete "$INSTDIR\share\okular\pics\comment.png"
  Delete "$INSTDIR\share\okular\pics\cross.png"
  Delete "$INSTDIR\share\okular\pics\help.png"
  Delete "$INSTDIR\share\okular\pics\insert.png"
  Delete "$INSTDIR\share\okular\pics\key.png"
  Delete "$INSTDIR\share\okular\pics\newparagraph.png"
  Delete "$INSTDIR\share\okular\pics\note.png"
  Delete "$INSTDIR\share\okular\pics\paperclip.png"
  Delete "$INSTDIR\share\okular\pics\paragraph.png"
  Delete "$INSTDIR\share\okular\pics\pushpin.png"
  Delete "$INSTDIR\share\okular\pics\rightarrow.png"
  Delete "$INSTDIR\share\okular\pics\rightpointer.png"
  Delete "$INSTDIR\share\okular\pics\stamps.svg"
  Delete "$INSTDIR\share\okular\pics\star.png"
  Delete "$INSTDIR\share\okular\pics\tool-base-okular@2x.png"
  Delete "$INSTDIR\share\okular\pics\tool-base-okular.png"
  Delete "$INSTDIR\share\okular\pics\tool-highlighter-okular-colorizable@2x.png"
  Delete "$INSTDIR\share\okular\pics\tool-highlighter-okular-colorizable.png"
  Delete "$INSTDIR\share\okular\pics\tool-ink-okular-colorizable@2x.png"
  Delete "$INSTDIR\share\okular\pics\tool-ink-okular-colorizable.png"
  Delete "$INSTDIR\share\okular\pics\tool-note-inline-okular-colorizable@2x.png"
  Delete "$INSTDIR\share\okular\pics\tool-note-inline-okular-colorizable.png"
  Delete "$INSTDIR\share\okular\pics\tool-note-inline.png"
  Delete "$INSTDIR\share\okular\pics\tool-note-okular-colorizable@2x.png"
  Delete "$INSTDIR\share\okular\pics\tool-note-okular-colorizable.png"
  Delete "$INSTDIR\share\okular\pics\tool-note.png"
  Delete "$INSTDIR\share\okular\pics\tool-typewriter-okular-colorizable@2x.png"
  Delete "$INSTDIR\share\okular\pics\tool-typewriter-okular-colorizable.png"
  Delete "$INSTDIR\share\okular\pics\uparrow.png"
  Delete "$INSTDIR\share\okular\pics\upleftarrow.png"

  RmDir "$INSTDIR\share\okular\pics\"
  RmDir "$INSTDIR\share\okular"
  RmDir "$INSTDIR\share"

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

  DeleteRegValue SHCTX "Software\RegisteredApplications" "Okular - GnuPG Edition"
  DeleteRegKey SHCTX "Software\Gpg4win\okular"

  DeleteRegKey SHCTX "Software\Classes\gpgokular.AssocFile.PDF"
  DeleteRegValue SHCTX "Software\Classes\.pdf\OpenWithProgIDs" "gpgokular.AssocFile.PDF"
  DeleteRegValue SHCTX "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\OpenWithProgids" "gpgokular.AssocFile.PDF"

SectionEnd

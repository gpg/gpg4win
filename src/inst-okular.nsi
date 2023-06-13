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

# Okular - Opt in for now.
${MementoUnselectedSection} "Okular (experimental)" SEC_okular

  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/okular.exe
  File ${prefix}/bin/libOkular5Core.dll
  SetOutPath "$INSTDIR\bin\plugins\okular\generators"
#  File ${prefix}/plugins/okular/generators/okularGenerator_fb.dll
#  File ${prefix}/plugins/okular/generators/okularGenerator_comicbook.dll
#  File ${prefix}/plugins/okular/generators/okularGenerator_kimgio.dll
#  File ${prefix}/plugins/okular/generators/okularGenerator_dvi.dll
#  File ${prefix}/plugins/okular/generators/okularGenerator_txt.dll
#  File ${prefix}/plugins/okular/generators/okularGenerator_fax.dll
  File ${prefix}/lib/plugins/okular/generators/okularGenerator_poppler.dll
#  File ${prefix}/plugins/okular/generators/okularGenerator_xps.dll
  SetOutPath "$INSTDIR\bin\plugins"
  File ${prefix}/lib/plugins/okularpart.dll


  SetOutPath "$INSTDIR\share\icons\hicolor\128x128\apps"

  File ${prefix}/share/icons/hicolor/128x128/apps/okular.png

  SetOutPath "$INSTDIR\share\icons\hicolor\16x16\apps"

  File ${prefix}/share/icons/hicolor/16x16/apps/okular.png

  SetOutPath "$INSTDIR\share\icons\hicolor\22x22\apps"

  File ${prefix}/share/icons/hicolor/22x22/apps/okular.png

  SetOutPath "$INSTDIR\share\icons\hicolor\32x32\apps"

  File ${prefix}/share/icons/hicolor/32x32/apps/okular.png

  SetOutPath "$INSTDIR\share\icons\hicolor\48x48\apps"

  File ${prefix}/share/icons/hicolor/48x48/apps/okular.png

  SetOutPath "$INSTDIR\share\icons\hicolor\64x64\apps"

  File ${prefix}/share/icons/hicolor/64x64/apps/okular.png

  SetOutPath "$INSTDIR\share\kxmlgui5\okular"
  File ${prefix}/share/kxmlgui5/okular/part.rc
  File ${prefix}/share/kxmlgui5/okular/part-viewermode.rc
  File ${prefix}/share/kxmlgui5/okular/shell.rc

  SetOutPath "$INSTDIR\share\okular"
  File ${prefix}/share/okular/drawingtools.xml
  File ${prefix}/share/okular/toolsQuick.xml
  File ${prefix}/share/okular/tools.xml

  SetOutPath "$INSTDIR\share\okular\pics"
  File ${prefix}/share/okular/pics/checkmark.png
  File ${prefix}/share/okular/pics/circle.png
  File ${prefix}/share/okular/pics/comment.png
  File ${prefix}/share/okular/pics/cross.png
  File ${prefix}/share/okular/pics/help.png
  File ${prefix}/share/okular/pics/insert.png
  File ${prefix}/share/okular/pics/key.png
  File ${prefix}/share/okular/pics/newparagraph.png
  File ${prefix}/share/okular/pics/note.png
  File ${prefix}/share/okular/pics/paperclip.png
  File ${prefix}/share/okular/pics/paragraph.png
  File ${prefix}/share/okular/pics/pushpin.png
  File ${prefix}/share/okular/pics/rightarrow.png
  File ${prefix}/share/okular/pics/rightpointer.png
  File ${prefix}/share/okular/pics/stamps.svg
  File ${prefix}/share/okular/pics/star.png
  File ${prefix}/share/okular/pics/tool-base-okular@2x.png
  File ${prefix}/share/okular/pics/tool-base-okular.png
  File ${prefix}/share/okular/pics/tool-highlighter-okular-colorizable@2x.png
  File ${prefix}/share/okular/pics/tool-highlighter-okular-colorizable.png
  File ${prefix}/share/okular/pics/tool-ink-okular-colorizable@2x.png
  File ${prefix}/share/okular/pics/tool-ink-okular-colorizable.png
  File ${prefix}/share/okular/pics/tool-note-inline-okular-colorizable@2x.png
  File ${prefix}/share/okular/pics/tool-note-inline-okular-colorizable.png
  File ${prefix}/share/okular/pics/tool-note-inline.png
  File ${prefix}/share/okular/pics/tool-note-okular-colorizable@2x.png
  File ${prefix}/share/okular/pics/tool-note-okular-colorizable.png
  File ${prefix}/share/okular/pics/tool-note.png
  File ${prefix}/share/okular/pics/tool-typewriter-okular-colorizable@2x.png
  File ${prefix}/share/okular/pics/tool-typewriter-okular-colorizable.png
  File ${prefix}/share/okular/pics/uparrow.png
  File ${prefix}/share/okular/pics/upleftarrow.png

  # ProgID gpgokular.AssocFile.PDF
  # Capability_name 'okular'
  # assocname gpgokular
  # name: Okular - GnuPG Edition
  # capability_path Software\Gpg4win\okular\Capabilities

  # Register Capabilities
  WriteRegStr SHCTX "Software\RegisteredApplications" "Okular - GnuPG Edition" "Software\Gpg4win\okular\Capabilities"
  WriteRegStr SHCTX "Software\Gpg4win\okular" "" "Okular - GnuPG Edition"

  WriteRegStr SHCTX "Software\Gpg4win\okular\Capabilities" "ApplicationDescription" "Okular - GnuPG Edition"
  WriteRegStr SHCTX "Software\Gpg4win\okular\Capabilities" "ApplicationName" "Okular - GnuPG Edition"
  WriteRegStr SHCTX "Software\Gpg4win\okular\Capabilities" "ApplicationIcon" "$INSTDIR\bin\okular.exe,0"
  WriteRegStr SHCTX "Software\Gpg4win\okular\Capabilities\FileAssociations" ".pdf" "gpgokular.AssocFile.PDF"
  WriteRegStr SHCTX "Software\Gpg4win\okular\Capabilities\MimeAssociations" "application/pdf" "gpgokular.AssocFile.PDF"
  WriteRegStr SHCTX "Software\Gpg4win\okular\Capabilities\shell\open\command" "" "$\"$INSTDIR\bin\okular.exe$\" -- $\"%1$\""


  WriteRegStr SHCTX "Software\Classes\gpgokular.AssocFile.PDF" "" "PDF Dokument"
  WriteRegStr SHCTX "Software\Classes\gpgokular.AssocFile.PDF\shell\open\command" "" "$\"$INSTDIR\bin\okular.exe$\" -- $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpgokular.AssocFile.PDF" "FriendlyTypeName" "PDF Document"
  WriteRegStr SHCTX "Software\Classes\gpgokular.AssocFile.PDF" "PerceivedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpgokular.AssocFile.PDF\DefaultIcon" "" "$INSTDIR\bin\okular.exe,0"

  WriteRegBin SHCTX "Software\Classes\.pdf\OpenWithProgids" "gpgokular.AssocFile.PDF" 0
  WriteRegBin SHCTX "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\OpenWithProgids" "gpgokular.AssocFile.PDF" 0

${MementoSectionEnd}

LangString DESC_SEC_okular ${LANG_ENGLISH} \
   "A PDF viewer to sign and verify pdf documents with GnuPG."

LangString DESC_Menu_okular ${LANG_ENGLISH} \
   "Run the Okular PDF viewer to sign and verify documents with GnuPG."

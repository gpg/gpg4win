# Copyright (C) 2024 g10 Code GmbH
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
; Uninstaller section.
Section "-un.gpgoljs"
  Delete "$INSTDIR\bin\gpgol-client.exe"
  Delete "$INSTDIR\bin\gpgol-server.exe"
  Delete "$INSTDIR\bin\install.ps1"
  RmDir "$INSTDIR\bin"

  Delete "$INSTDIR\share\gpgol-web\dist\index.html"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\index-*.css"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\index-*.js"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\document-decrypt-32.png"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\document-decrypt-64.png"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\document-decrypt-80.png"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\icon-128.png"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\icon-16.png"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\icon-32.png"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\icon-64.png"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\icon-80.png"
  Delete "$INSTDIR\share\gpgol-web\dist\assets\logo.png"
  RmDir "$INSTDIR\share\gpgol-web\dist\assets"
  RmDir "$INSTDIR\share\gpgol-web\dist"
  RmDir "$INSTDIR\share\gpgol-web"

  Delete "$INSTDIR\share\kxmlgui5\gpgol-client\composerui.rc"
  RmDir "$INSTDIR\share\kxmlgui5\gpgol-client"
  RmDir "$INSTDIR\share\kxmlgui5"

  Delete "$INSTDIR\share\gpgol-client\manifest.xml"
  RmDir "$INSTDIR\share\gpgol-client"
  RmDir "$INSTDIR\share"
SectionEnd

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

  Delete "$INSTDIR\share\gpgol-web\index.html"
  Delete "$INSTDIR\share\gpgol-web\assets\index-*.css"
  Delete "$INSTDIR\share\gpgol-web\assets\index-*.js"
  Delete "$INSTDIR\share\gpgol-web\assets\document-decrypt-32.png"
  Delete "$INSTDIR\share\gpgol-web\assets\document-decrypt-64.png"
  Delete "$INSTDIR\share\gpgol-web\assets\document-decrypt-80.png"
  Delete "$INSTDIR\share\gpgol-web\assets\icon-128.png"
  Delete "$INSTDIR\share\gpgol-web\assets\icon-16.png"
  Delete "$INSTDIR\share\gpgol-web\assets\icon-32.png"
  Delete "$INSTDIR\share\gpgol-web\assets\icon-64.png"
  Delete "$INSTDIR\share\gpgol-web\assets\icon-80.png"
  Delete "$INSTDIR\share\gpgol-web\assets\logo.png"
  RmDir "$INSTDIR\share\gpgol-web\assets"
  RmDir "$INSTDIR\share\gpgol-web"

  Delete "$INSTDIR\share\icons\hicolor\scalable\apps\com.gnupg.gpgolweb.svg"
  RmDir "$INSTDIR\share\icons\hicolor\scalable\apps"
  RmDir "$INSTDIR\share\icons\hicolor\scalable"
  Delete "$INSTDIR\share\icons\hicolor\256x256\apps\com.gnupg.gpgolweb.png"
  RmDir "$INSTDIR\share\icons\hicolor\256x256\apps"
  RmDir "$INSTDIR\share\icons\hicolor\256x256"
  Delete "$INSTDIR\share\icons\hicolor\32x32\apps\com.gnupg.gpgolweb.png"
  RmDir "$INSTDIR\share\icons\hicolor\32x32\apps"
  RmDir "$INSTDIR\share\icons\hicolor\32x32"
  Delete "$INSTDIR\share\icons\hicolor\48x48\apps\com.gnupg.gpgolweb.png"
  RmDir "$INSTDIR\share\icons\hicolor\48x48\apps"
  RmDir "$INSTDIR\share\icons\hicolor\48x48"
  Delete "$INSTDIR\share\icons\hicolor\64x64\apps\com.gnupg.gpgolweb.png"
  RmDir "$INSTDIR\share\icons\hicolor\64x64\apps"
  RmDir "$INSTDIR\share\icons\hicolor\64x64"
  RmDir "$INSTDIR\share\icons\hicolor"
  RmDir "$INSTDIR\share\icons"

  Delete "$INSTDIR\share\kxmlgui5\gpgol-client\composerui.rc"
  RmDir "$INSTDIR\share\kxmlgui5\gpgol-client"
  RmDir "$INSTDIR\share\kxmlgui5"
  RmDir "$INSTDIR\share"
SectionEnd

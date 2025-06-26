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
!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/gpgoljs-${gpg4win_pkg_gpgoljs_version}

# gpgoljs - Opt in for now.
${MementoUnselectedSection} "Web based Oulook plugin" SEC_gpgoljs

  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/gpgol-client.exe
  File ${prefix}/bin/gpgol-server.exe
  File ${prefix}/bin/install.ps1

  SetOutPath "$INSTDIR\share\gpgol-web"
  File ${prefix}/share/gpgol-web/index.html

  SetOutPath "$INSTDIR\share\gpgol-web\assets"
  # Take care: we can't use wildcards for the filenames because the MSI
  # building process won't be able to cope wit it.
  File ${prefix}/share/gpgol-web/assets/index-C8C8AKuF.css
  File ${prefix}/share/gpgol-web/assets/index-Drll8Pr4.js
  File ${prefix}/share/gpgol-web/assets/document-decrypt-32.png
  File ${prefix}/share/gpgol-web/assets/document-decrypt-64.png
  File ${prefix}/share/gpgol-web/assets/document-decrypt-80.png
  File ${prefix}/share/gpgol-web/assets/icon-128.png
  File ${prefix}/share/gpgol-web/assets/icon-16.png
  File ${prefix}/share/gpgol-web/assets/icon-32.png
  File ${prefix}/share/gpgol-web/assets/icon-64.png
  File ${prefix}/share/gpgol-web/assets/icon-80.png
  File ${prefix}/share/gpgol-web/assets/logo.png

  SetOutPath "$INSTDIR\share\icons\hicolor\scalable\apps"
  File /nonfatal ${prefix}/share/icons/hicolor/scalable/apps/com.gnupg.gpgolweb.svg

  SetOutPath "$INSTDIR\share\icons\hicolor\256x256\apps"
  File /nonfatal ${prefix}/share/icons/hicolor/256x256/apps/com.gnupg.gpgolweb.png

  SetOutPath "$INSTDIR\share\icons\hicolor\32x32\apps"
  File /nonfatal ${prefix}/share/icons/hicolor/32x32/apps/com.gnupg.gpgolweb.png

  SetOutPath "$INSTDIR\share\icons\hicolor\48x48\apps"
  File /nonfatal ${prefix}/share/icons/hicolor/48x48/apps/com.gnupg.gpgolweb.png

  SetOutPath "$INSTDIR\share\icons\hicolor\64x64\apps"
  File /nonfatal ${prefix}/share/icons/hicolor/64x64/apps/com.gnupg.gpgolweb.png


  SetOutPath "$INSTDIR\share\kxmlgui5\gpgol-client"
  File ${prefix}/share/kxmlgui5/gpgol-client/composerui.rc

${MementoSectionEnd}

LangString DESC_SEC_gpgoljs ${LANG_ENGLISH} \
   "An addon for the new, web based, Oulook."

LangString DESC_Menu_gpgoljs ${LANG_ENGLISH} \
   "Run the GpgOL/Web client"

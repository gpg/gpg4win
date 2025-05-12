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

  SetOutPath "$INSTDIR\share\gpgol-web\dist"
  File ${prefix}/share/gpgol-web/dist/index.html

  SetOutPath "$INSTDIR\share\gpgol-web\dist\assets"
  File ${prefix}/share/gpgol-web/dist/assets/index-*.css
  File ${prefix}/share/gpgol-web/dist/assets/index-*.js
  File ${prefix}/share/gpgol-web/dist/assets/document-decrypt-32.png
  File ${prefix}/share/gpgol-web/dist/assets/document-decrypt-64.png
  File ${prefix}/share/gpgol-web/dist/assets/document-decrypt-80.png
  File ${prefix}/share/gpgol-web/dist/assets/icon-128.png
  File ${prefix}/share/gpgol-web/dist/assets/icon-16.png
  File ${prefix}/share/gpgol-web/dist/assets/icon-32.png
  File ${prefix}/share/gpgol-web/dist/assets/icon-64.png
  File ${prefix}/share/gpgol-web/dist/assets/icon-80.png
  File ${prefix}/share/gpgol-web/dist/assets/logo.png


  SetOutPath "$INSTDIR\share\kxmlgui5\gpgol-client"
  File ${prefix}/share/kxmlgui5/gpgol-client/composerui.rc

  SetOutPath "$INSTDIR\share\gpgol-client"
  File ${prefix}/share/gpgol/manifest.xml

${MementoSectionEnd}

LangString DESC_SEC_gpgoljs ${LANG_ENGLISH} \
   "An addon for the new, web based, Oulook."

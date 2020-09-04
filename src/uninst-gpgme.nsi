# uninst-gpgme.nsi - Installer snippet for gpgme.   -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/gpgme-${gpg4win_pkg_gpgme_version}


; Uninstaller section.
Section "-un.gpgme"
!ifdef SOURCES
  Push "${gpg4win_pkg_gpgme}"
  Call un.SourceDelete
!else
  Delete /REBOOTOK "$INSTDIR\bin\libgpgme-11.dll"
  Delete /REBOOTOK "$INSTDIR\bin\libgpgme-glib-11.dll"
  Delete /REBOOTOK "$INSTDIR\bin\libqgpgme-7.dll"
  Delete /REBOOTOK "$INSTDIR\bin\libgpgmepp-6.dll"
${If} ${RunningX64}
  Delete /REBOOTOK "$INSTDIR\bin_64\libgpgmepp-6.dll"
  Delete /REBOOTOK "$INSTDIR\bin_64\libgpgme11.dll"
  Delete /REBOOTOK "$INSTDIR\bin_64\gpgme-json.exe"
${EndIf}
  Delete "$INSTDIR\bin\gpgme-w32spawn.exe"
  Delete "$INSTDIR\bin\gpgme-json.exe"
  Delete "$INSTDIR\lib\libgpgme.imp"
  Delete "$INSTDIR\lib\libgpgme-glib.imp"
  Delete "$INSTDIR\include\gpgme.h"
  Delete "$INSTDIR\bin\gpgme-chrome.json"
  Delete "$INSTDIR\bin\gpgme-mozilla.json"

  DeleteRegKey SHCTX "Software\Google\Chrome\NativeMessagingHosts\gpgmejson"
  DeleteRegKey SHCTX "Software\Mozilla\NativeMessagingHosts\gpgmejson"

  SetRegView 64
  DeleteRegKey SHCTX "Software\Google\Chrome\NativeMessagingHosts\gpgmejson"
  DeleteRegKey SHCTX "Software\Mozilla\NativeMessagingHosts\gpgmejson"
  SetRegView 32

!endif
SectionEnd

# inst-gpgme-browser.nsi - Installer snippet for gpgme natiove msg.
# Copyright (C) 2018 Intevation GmbH
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

# We need StrRep
!include "StrFunc.nsh"
${StrRep}

# Browser integration. Opt in for now.
${MementoUnselectedSection} "Browser integration" SEC_gpgme_browser

!ifndef SOURCES

  SetOutPath "$INSTDIR\bin"

  # Replace the backslashes in the install path by double backslashes
  push $2
  ${StrRep} $2 "$INSTDIR" "\" "\\"

  push $1
  FileOpen $1 "$INSTDIR\bin\gpgme-chrome.json" "w"
  FileWrite $1 '{$\r$\n'
  FileWrite $1 '"name": "gpgmejson",$\r$\n'
  FileWrite $1 '"description": "Javascript-binding for gnupg",$\r$\n'
  FileWrite $1 '"path": "$2\\bin\\gpgme-json.exe",$\r$\n'
  FileWrite $1 '"type": "stdio",$\r$\n'
  FileWrite $1 '"allowed_origins": [$\r$\n'
  FileWrite $1 '	"chrome-extension://kajibbejlbohfaggdiogboambcijhkke/"$\r$\n'
  FileWrite $1 ']$\r$\n'
  FileWrite $1 '}$\r$\n'
  FileClose $1
  pop $1

  push $1
  FileOpen $1 "$INSTDIR\bin\gpgme-mozilla.json" "w"
  FileWrite $1 '{$\r$\n'
  FileWrite $1 '"name": "gpgmejson",$\r$\n'
  FileWrite $1 '"description": "Javascript-binding for gnupg",$\r$\n'
  FileWrite $1 '"path": "$2\\bin\\gpgme-json.exe",$\r$\n'
  FileWrite $1 '"type": "stdio",$\r$\n'
  FileWrite $1 '"allowed_extensions": [$\r$\n'
  FileWrite $1 '	"jid1-AQqSMBYb0a8ADg@jetpack"$\r$\n'
  FileWrite $1 '	]$\r$\n'
  FileWrite $1 '}$\r$\n'
  pop $1

  pop $2

  WriteRegStr SHCTX "Software\Google\Chrome\NativeMessagingHosts\gpgmejson" "" "$INSTDIR\bin\gpgme-chrome.json"
  WriteRegStr SHCTX "Software\Mozilla\NativeMessagingHosts\gpgmejson" "" "$INSTDIR\bin\gpgme-mozilla.json"
  SetRegView 64
  WriteRegStr SHCTX "Software\Google\Chrome\NativeMessagingHosts\gpgmejson" "" "$INSTDIR\bin\gpgme-chrome.json"
  WriteRegStr SHCTX "Software\Mozilla\NativeMessagingHosts\gpgmejson" "" "$INSTDIR\bin\gpgme-mozilla.json"
  SetRegView 32

!endif

${MementoSectionEnd}

LangString DESC_SEC_gpgme_browser ${LANG_ENGLISH} \
   "Register GnuPG as native messaging service e.g. for the Mailvelope extension."

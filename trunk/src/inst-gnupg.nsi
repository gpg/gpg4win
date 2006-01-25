# inst-gnupg.nsi - Installer snippet for gnupg.     -*- coding: latin-1; -*-
# Copyright (C) 2005 g10 Code GmbH
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
!define prefix ${ipdir}/gnupg-${gpg4win_pkg_gnupg_version}


Section "GnuPG" SEC_gnupg
  SectionIn RO

  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gnupg}"
!else
  File "${prefix}/bin/gpg.exe"
  File "${prefix}/bin/gpgsplit.exe"
  File "${prefix}/bin/gpgv.exe"

  # As a special exception, these programs are not kept in
  # libexec/gnupg, where they belong.  Please see the comment in
  # gnupg/g10/keyserver.c::keyserver_spawn() for an explanation.
  File "${prefix}/libexec/gnupg/gpgkeys_finger.exe"
  File "${prefix}/libexec/gnupg/gpgkeys_hkp.exe"
  File /nonfatal "${prefix}/libexec/gnupg/gpgkeys_http.exe"
  File /nonfatal "${prefix}/libexec/gnupg/gpgkeys_curl.exe"
  File "${prefix}/libexec/gnupg/gpgkeys_ldap.exe"

  SetOutPath "$INSTDIR\share\gnupg"
  File "${prefix}/share/gnupg/options.skel"
  File "${prefix}/share/gnupg/FAQ"
  File "${prefix}/share/gnupg/faq.html"

  WriteRegStr HKLM "Software\GNU\GnuPG" "Install Directory" $INSTDIR
!endif
SectionEnd


LangString DESC_SEC_gnupg ${LANG_ENGLISH} \
   "GNU Privacy Guard"
LangString DESC_SEC_gnupg ${LANG_GERMAN} \
   "Der GNU Privacy Guard (GnuPG) ist der Kernbestandteil \
    dieser Software.  GnuPG stellt die eigentliche \
    Verschlüsselung sowie die Verwaltung der Schlüssel bereit."

LangString DESC_Menu_gnupg_faq ${LANG_ENGLISH} \
   "Show the Frequently Asked Questions Document for GnuPG"
LangString DESC_Menu_gnupg_faq ${LANG_GERMAN} \
   "Das Dokument mit den häufig gestellten Fragen (FAQ) zu GnuPG anzeigen"


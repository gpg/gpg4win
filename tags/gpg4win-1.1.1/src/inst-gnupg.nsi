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
  File "${prefix}/libexec/gnupg/gpgkeys_curl.exe"
  File "${prefix}/libexec/gnupg/gpgkeys_ldap.exe"

  SetOutPath "$INSTDIR\pub"
  File /oname=gpg.exe      "${BUILD_DIR}/gpgwrap.exe"
  File /oname=gpgv.exe     "${BUILD_DIR}/gpgwrap.exe"
  File /oname=gpgsplit.exe "${BUILD_DIR}/gpgwrap.exe"

  SetOutPath "$INSTDIR\share\gnupg"
  File "${prefix}/share/gnupg/options.skel"
  File "${prefix}/share/gnupg/FAQ"
  File "${prefix}/share/gnupg/faq.html"
  File "${prefix}/share/man/man1/gpg.man"
  File "${prefix}/share/man/man1/gpgv.man"
  File "${prefix}/share/man/man7/gnupg.man"

  # Install the language files for gpg.  Note that the PO files are
  # required to be UTF-8 encoded and that the post-install macro in
  # Makefile.am needs to build them.
  SetOutPath "$INSTDIR\gnupg.nls"
  File "${prefix}/share/gnupg/de.mo"


  WriteRegStr HKLM "Software\GNU\GnuPG" "Install Directory" $INSTDIR

  # Add the public directory to the PATH
  Push "$INSTDIR\pub"
  Call AddToPath

!endif
SectionEnd


LangString DESC_SEC_gnupg ${LANG_ENGLISH} \
   "GNU Privacy Guard"


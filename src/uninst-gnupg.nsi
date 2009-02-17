# uninst-gnupg.nsi - Installer snippet for gnupg.   -*- coding: latin-1; -*-
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


; Uninstaller section.
Section "-un.gnupg"
!ifdef SOURCES
  Push "${gpg4win_pkg_gnupg}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\gpg.exe"
  Delete "$INSTDIR\gpgsplit.exe"
  Delete "$INSTDIR\gpgv.exe"

  Delete "$INSTDIR\pub\gpg.exe"
  Delete "$INSTDIR\pub\gpgsplit.exe"
  Delete "$INSTDIR\pub\gpgv.exe"
  RMDir "$INSTDIR\pub"

  Delete "$INSTDIR\gpgkeys_finger.exe"
  Delete "$INSTDIR\gpgkeys_hkp.exe"
  Delete "$INSTDIR\gpgkeys_curl.exe"
  Delete "$INSTDIR\gpgkeys_ldap.exe"
  # Old gpg versions come with a separate http keyserver helper.
  Delete "$INSTDIR\gpgkeys_http.exe"

  Delete "$INSTDIR\share\gnupg\options.skel"
  Delete "$INSTDIR\share\gnupg\FAQ"
  Delete "$INSTDIR\share\gnupg\faq.html"
  Delete "$INSTDIR\share\gnupg\gpg.man"
  Delete "$INSTDIR\share\gnupg\gpgv.man"
  Delete "$INSTDIR\share\gnupg\gnupg.man"
  RMDir "$INSTDIR\share\gnupg"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"

  Delete "$INSTDIR\gnupg.nls\de.mo"
  RMDir  "$INSTDIR\gnupg.nls"

!endif
SectionEnd

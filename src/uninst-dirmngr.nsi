 # uninst-dirmngr.nsi - Uninstaller snippet.        -*- coding: latin-1; -*-
# Copyright (C) 2007 g10 Code GmbH
# 
# This file is part of Gpg4win.
# 
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.


!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/dirmngr-${gpg4win_pkg_dirmngr_version}


# Uninstaller section.
Section "-un.dirmngr"
!ifdef SOURCES
  Push "${gpg4win_pkg_dirmngr}"
  Call un.SourceDelete
!else
  # Try to stop the daemon in case it is running.
  g4wihelp::service_stop "DirMngr"

  g4wihelp::service_delete "DirMngr"

  Delete "$INSTDIR\dirmngr.exe"
  Delete "$INSTDIR\dirmngr-client.exe"
  Delete "$INSTDIR\dirmngr_ldap.exe"
  RMDir "$INSTDIR\cache"

  # The next thing is only to cleanup cruft from versions < 1.9.3.
  # Newer versions install them into COMMON_APPDATA and they are not
  # removed on purpose.  Remove the extra-certs directory.  Obviously
  # this works only if the user has not populated it.
  RMDir "$INSTDIR\lib\dirmngr\extra-certs"
  RMDir "$INSTDIR\lib\dirmngr"

  # Remove etc files.  This is only useful for installer < 1.9.3.

  Delete "$INSTDIR\etc\dirmngr\dirmngr.conf"
  Delete "$INSTDIR\etc\dirmngr\bnetza-10r-ocsp.signer"

  Delete "$INSTDIR\etc\dirmngr\trusted-certs\README"
  Delete "$INSTDIR\etc\dirmngr\trusted-certs\bnetza-10r-ca.crt"

  RMDir "$INSTDIR\etc\dirmngr\trusted-certs"
  RMDir "$INSTDIR\etc\dirmngr"
  RMDir "$INSTDIR\etc"
  RMDir "$INSTDIR"
!endif
SectionEnd

# uninst-gnupg2.nsi - Uninstaller snippet for gnupg2. -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/gnupg2-${gpg4win_pkg_gnupg2_version}


# Uninstaller section.
Section "-un.gnupg2"
!ifdef SOURCES
  Push "${gpg4win_pkg_gnupg2}"
  Call un.SourceDelete
!else

  # Try to stop a running agent.  This is only for the admin but in
  # some cases that is actually useful.  We sleep for awhile to give
  # scdaemon a chance to commit suicide.
  ifFileExists "$INSTDIR\gpg-connect-agent.exe" 0 no_u_gpg_connect_agent
    ifFileExists "$INSTDIR\libgpg-error-0.dll" 0 no_u_gpg_connect_agent
      ifFileExists "$INSTDIR\libw32pth-0.dll" 0 no_u_gpg_connect_agent
        ExecWait '"$INSTDIR\gpg-connect-agent.exe" killagent /bye'
        Sleep 3000
  no_u_gpg_connect_agent:

  Delete "$INSTDIR\gpg2.exe"
  Delete "$INSTDIR\gpgsm.exe"
  Delete "$INSTDIR\gpg-agent.exe"
  Delete "$INSTDIR\scdaemon.exe"
  Delete "$INSTDIR\gpgconf.exe"
  Delete "$INSTDIR\gpg-connect-agent.exe"

  Delete "$INSTDIR\pub\gpg2.exe"
  Delete "$INSTDIR\pub\gpgsm.exe"
  Delete "$INSTDIR\pub\gpg-connect-agent.exe"
  RMDir "$INSTDIR\pub"

  Delete "$INSTDIR\gpg2keys_finger.exe"
  Delete "$INSTDIR\gpg2keys_hkp.exe"
  Delete "$INSTDIR\gpg2keys_curl.exe"
  Delete "$INSTDIR\gpg2keys_ldap.exe"
  Delete "$INSTDIR\gpg-protect-tool.exe"
  Delete "$INSTDIR\gpg-preset-passphrase.exe"

  Delete "$INSTDIR\share\gnupg\qualified.txt"
  Delete "$INSTDIR\share\gnupg\com-certs.pem"
  Delete "$INSTDIR\share\gnupg\gpg-conf.skel"
  RMDir "$INSTDIR\share\gnupg"

#  Delete "$INSTDIR\gnupg.nls\de.mo"
#  RMDir  "$INSTDIR\gnupg.nls"

!endif
SectionEnd

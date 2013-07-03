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
Section "-un.gnupg"
!ifdef SOURCES
  Push "${gpg4win_pkg_gnupg2}"
  Call un.SourceDelete
!else
  # Try to stop a running agent.  This is only for the admin but in
  # some cases that is actually useful.
  ifFileExists "$INSTDIR\gpg-connect-agent.exe" 0 no_u_gpg_connect_agent
    ifFileExists "$INSTDIR\libgpg-error-0.dll" 0 no_u_gpg_connect_agent
      ifFileExists "$INSTDIR\libw32pth-0.dll" 0 no_u_gpg_connect_agent
        ExecWait '"$INSTDIR\gpg-connect-agent.exe" killagent /bye'
  no_u_gpg_connect_agent:

  Delete "$INSTDIR\gpg2.exe"
  Delete "$INSTDIR\gpgv2.exe"
  Delete "$INSTDIR\gpgsm.exe"
  Delete /REBOOTOK "$INSTDIR\gpg-agent.exe"
  Delete /REBOOTOK "$INSTDIR\scdaemon.exe"
  Delete "$INSTDIR\gpgconf.exe"
  Delete "$INSTDIR\gpg-connect-agent.exe"
  Delete "$INSTDIR\gpgsplit.exe"
  Delete "$INSTDIR\gpgtar.exe"

  Delete "$INSTDIR\pub\gpg.exe"
  Delete "$INSTDIR\pub\gpg2.exe"
  Delete "$INSTDIR\pub\gpgv.exe"
  Delete "$INSTDIR\pub\gpgsm.exe"
  Delete "$INSTDIR\pub\gpg-connect-agent.exe"
  Delete "$INSTDIR\pub\gpgconf.exe"

  Delete "$INSTDIR\gpg2keys_finger.exe"
  Delete "$INSTDIR\gpg2keys_hkp.exe"
  Delete "$INSTDIR\gpg2keys_curl.exe"
  Delete "$INSTDIR\gpg2keys_ldap.exe"
  Delete "$INSTDIR\gpg2keys_kdns.exe"
  Delete "$INSTDIR\gpg-protect-tool.exe"
  Delete "$INSTDIR\gpg-preset-passphrase.exe"

  Delete "$INSTDIR\share\gnupg\qualified.txt"
  Delete "$INSTDIR\share\gnupg\com-certs.pem"
  Delete "$INSTDIR\share\gnupg\gpg-conf.skel"
  Delete "$INSTDIR\share\gnupg\help.*.txt"
  Delete "$INSTDIR\share\gnupg\*.man"
  RMDir "$INSTDIR\share\gnupg"


  Delete "$INSTDIR\share\locale\be\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\ca\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\cs\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\da\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\el\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\eo\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\et\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\fi\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\gl\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\hu\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\id\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\it\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\ja\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\nb\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\pl\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\pt_BR\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\pt\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\ro\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\sk\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\sv\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\tr\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\zh_CN\LC_MESSAGES\gnupg2.mo"
  Delete "$INSTDIR\share\locale\zh_TW\LC_MESSAGES\gnupg2.mo"


!endif
SectionEnd

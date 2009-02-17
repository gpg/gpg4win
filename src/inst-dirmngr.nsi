# inst-dirmngr.nsi - Installer snippet.            -*- coding: latin-1; -*-
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

!ifdef DEBUG
Section "dirmngr" SEC_dirmngr
!else
Section "-dirmngr" SEC_dirmngr
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_dirmngr}"
!else
  Var /GLOBAL DirMngrStatus
  g4wihelp::service_query "DirMngr"
  StrCpy $DirMngrStatus $R0

  File "${prefix}/bin/dirmngr.exe"
  File "${prefix}/bin/dirmngr-client.exe"
  File "${prefix}/libexec/dirmngr_ldap.exe"

  # Create a directory for extra certs for documentation reasons.
  SetShellVarContext all
  SetOutPath "$APPDATA\GNU\lib\dirmngr\extra-certs"

  ifFileExists "$APPDATA\GNU\etc\dirmngr\dirmngr.conf" dirmngr_no_conf 0
   SetOutPath "$APPDATA\GNU\etc\dirmngr"
   File "${SRCDIR}/dirmngr.conf"
   File "${prefix}/share/doc/dirmngr/examples/bnetza-10r-ocsp.signer"

   SetOutPath "$APPDATA\GNU\etc\dirmngr\trusted-certs"
   File "${prefix}/share/doc/dirmngr/examples/trusted-certs/README"
   File "${prefix}/share/doc/dirmngr/examples/trusted-certs/bnetza-10r-ca.crt"
  dirmngr_no_conf:
  SetShellVarContext current

  SetOutPath "$INSTDIR"

  StrCmp $DirMngrStatus "MISSING" 0 dirmngr_created
    # Create the service.
    g4wihelp::service_create "DirMngr" "DirMngr" \
                             '"$INSTDIR\dirmngr.exe" --service'
  dirmngr_created:

  # Start the service.
  # FIXME: This does not work.  Luckily, it is also not needed.
  # g4wihelp::service_start "DirMngr" "2" '"$INSTDIR\dirmngr.exe"' "--service"
  # This works.
  g4wihelp::service_start "DirMngr" 0

  # If requested, install the configuration files.
  ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" AppData
  StrCmp $0 "" no_config_dirmngr_files
  CreateDirectory "$0\gnupg"

  g4wihelp::config_fetch "dirmngr.conf"
  StrCmp $R0 "" no_config_dirmngr_conf
    CopyFiles $R0 "$0\gnupg\dirmngr.conf"
  no_config_dirmngr_conf:

  g4wihelp::config_fetch "dirmngr_ldapservers.conf"
  StrCmp $R0 "" no_config_dirmngr_ldapservers_conf
    CopyFiles $R0 "$0\gnupg\dirmngr_ldapservers.conf"
  no_config_dirmngr_ldapservers_conf:

  no_config_dirmngr_files:

  # Try to delete certain trusted certificates installed by default
  # with gpg4win 1.1.3.  They are not useful at this location anymore.
  # We only delete the certificates we know about and not just all of
  # them.
  Delete "$INSTDIR\etc\dirmngr"
  Delete "$INSTDIR\etc\dirmngr\bnetza-10r-ocsp.signer"
  Delete "$INSTDIR\etc\dirmngr\dirmngr.conf"
  Delete "$INSTDIR\etc\dirmngr\trusted-certs"
  Delete "$INSTDIR\etc\dirmngr\trusted-certs\bnetza-10r-ca.crt"
  Delete "$INSTDIR\etc\dirmngr\trusted-certs\README"
  Delete "$INSTDIR\etc\dirmngr\trusted-certs\S-TRUSTQualifiedRootCA2008-001.final.v3.509.crt"
  Delete "$INSTDIR\etc\dirmngr\trusted-certs\S-TRUSTQualifiedRootCA2008-002.final.v3.509.crt"
  RMDir "$INSTDIR\etc\dirmngr"
  RMDir "$INSTDIR\etc"

!endif
SectionEnd

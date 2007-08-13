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

  StrCmp $DirMngrStatus "MISSING" dirmngr_stopped
  # Try to stop the daemon in case it is running.
  g4wihelp::service_stop "DirMngr"
dirmngr_stopped:

  File "${prefix}/bin/dirmngr.exe"
  File "${prefix}/bin/dirmngr-client.exe"
  File "${prefix}/libexec/dirmngr_ldap.exe"

  # We need to create the cache directory, as this is not
  # automatically created by dirmngr.  Actually, the default should be
  # different.  FIXME.
  CreateDirectory "$INSTDIR\cache"

  # FIXME: Error checking.  Also, check if --service really reaches
  # the service both times.

  StrCmp $DirMngrStatus "MISSING" 0 dirmngr_created
    # Create the service.
    g4wihelp::service_create "DirMngr" "DirMngr" '"$INSTDIR\dirmngr.exe" --service'
dirmngr_created:

  # We only start the dirmngr if it was running before.
  StrCmp $DirMngrStatus "RUNNING" 0 dirmngr_restarted
  # Start the service.
  g4wihelp::service_start "DirMngr" "1" "\"$INSTDIR\dirmngr.exe\""
dirmngr_restarted:


  # If requested, install the configuration files.
  ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" AppData
  StrCmp $0 "" no_config_dirmngr_files
  SetOutPath "$0\gnupg"

  g4wihelp::config_fetch "dirmngr.conf"
  StrCmp $R0 "" no_config_dirmngr_conf
    CopyFiles $R0 "$0\gnupg\dirmngr.conf"
  no_config_dirmngr_conf:

  g4wihelp::config_fetch "dirmngr_ldapservers.conf"
  StrCmp $R0 "" no_config_dirmngr_ldapservers_conf
    CopyFiles $R0 "$0\gnupg\dirmngr_ldapservers.conf"
  no_config_dirmngr_ldapservers_conf:

  no_config_dirmngr_files:

!endif
SectionEnd

# installer-finish.nsi - Installer for GPG4Win.      -*- coding: latin-1; -*-
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

Var MYTMP

# Last section is a hidden one.
Section
  WriteUninstaller "$INSTDIR\${PACKAGE}-uninstall.exe"

  # Windows Add/Remove Programs support
  StrCpy $MYTMP "Software\Microsoft\Windows\CurrentVersion\Uninstall\{PRETTY_PACKAGE_SHORT}"
  WriteRegExpandStr HKLM $MYTMP "UninstallString" '"$INSTDIR\${PACKAGE}-uninstall.exe"'
  WriteRegExpandStr HKLM $MYTMP "InstallLocation" "$INSTDIR"
  WriteRegStr       HKLM $MYTMP "DisplayName"     "${PRETTY_PACKAGE}"
  WriteRegStr       HKLM $MYTMP "DisplayIcon"     "$INSTDIR\gpg.exe,0"
  WriteRegStr       HKLM $MYTMP "DisplayVersion"  "${VERSION}"
  WriteRegStr       HKLM $MYTMP "Publisher"       "g10 Code GmbH"
  WriteRegStr       HKLM $MYTMP "URLInfoAbout"    "http://www.gnupg.org/"
  WriteRegDWORD     HKLM $MYTMP "NoModify"        "1"
  WriteRegDWORD     HKLM $MYTMP "NoRepair"        "1"
SectionEnd


Section Uninstall
!ifdef HAVE_STARTMENU
!insertmacro MUI_STARTMENU_GETFOLDER ${STARTMENU_FOLDER} $R0
!ifdef HAVE_PKG_WINPT
  Delete "$SMPROGRAMS\$R0\WINPT.lnk"
!endif
!ifdef HAVE_PKG_GPA
  Delete "$SMPROGRAMS\$R0\GPA.lnk"
!endif
  Delete "$SMPROGRAMS\$R0\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$R0"
  DeleteRegValue HKLM "Software\GNU\${PRETTY_PACKAGE_SHORT}" \
        "Start Menu Folder"
!endif

  Delete "$INSTDIR\${PACKAGE}-uninstall.exe"
  RMDir "$INSTDIR"

  # Clean the registry.
  DeleteRegValue HKLM "Software\GNU\${PRETTY_PACKAGE_SHORT}" \
        "Install Directory"
  DeleteRegKey /ifempty HKLM "Software\GNU\${PRETTY_PACKAGE_SHORT}" \
  # Remove Windows Add/Remove Programs support.
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GnuPG"
SectionEnd

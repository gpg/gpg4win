# installer-finish.nsi - Installer for GPG4Win.      -*- coding: latin-1; -*-
# Copyright (C) 2005, 2008 g10 Code GmbH
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

Function SetupExtensions
System::Call 'Shell32::SHChangeNotify(i 0x8000000, i 0, i 0, i 0)'
FunctionEnd

# Last section is a hidden one.
Section
  WriteUninstaller "$INSTDIR\${PACKAGE}-uninstall.exe"

  # Windows Add/Remove Programs support
  # Note that the version is appended to the DisplayName, despite that
  # this is not necessary as a click on "support information" gives
  # the version number.  Some tools do that, other don't.  I don't
  # like it but others want me to do that.  -wk
  StrCpy $MYTMP "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRETTY_PACKAGE_SHORT}"
  WriteRegExpandStr SHCTX $MYTMP "UninstallString" '"$INSTDIR\${PACKAGE}-uninstall.exe"'
  WriteRegExpandStr SHCTX $MYTMP "InstallLocation" "$INSTDIR"
  WriteRegStr       SHCTX $MYTMP "DisplayName"     "${PRETTY_PACKAGE} (${VERSION})"
  WriteRegStr       SHCTX $MYTMP "DisplayIcon"     "$INSTDIR\bin\kleopatra.exe,0"
  WriteRegStr       SHCTX $MYTMP "DisplayVersion"  "${VERSION}"
  WriteRegStr       SHCTX $MYTMP "Publisher"       "The Gpg4win Project"
  WriteRegStr       SHCTX $MYTMP "URLInfoAbout"    "http://www.gpg4win.org/"
  WriteRegDWORD     SHCTX $MYTMP "NoModify"        "1"
  WriteRegDWORD     SHCTX $MYTMP "NoRepair"        "1"

  WriteRegStr SHCTX "Software\Classes\MIME\Database\Content Type\application/pgp" "Extension" ".gpg"
  WriteRegStr SHCTX "Software\Classes\MIME\Database\Content Type\application/pgp-signature" "Extension" ".sig"
  WriteRegStr SHCTX "Software\Classes\MIME\Database\Content Type\application/pgp-encrypted" "Extension" ".gpg"
  WriteRegStr SHCTX "Software\Classes\MIME\Database\Content Type\application/pgp-keys" "Extension" ".gpg"

  call SetupExtensions
SectionEnd


Section Uninstall
  UserInfo::GetAccountType
  Pop $1
  StrCmp $1 "Admin" is_admin is_no_admin
is_admin:
  SetShellVarContext all
is_no_admin:

  #---------------------------------------------------
  # Delete the menu entries and any empty parent menus
  #---------------------------------------------------
  Delete "$SMPROGRAMS\GPA.lnk"
  Delete "$SMPROGRAMS\Kleopatra.lnk"
  Delete "$SMPROGRAMS\Okular - GnuPG Edition.lnk"

  # Delete Desktop links.
  StrCmp $is_update '1' no_desktop_delete
!ifdef HAVE_PKG_GPA
  Delete "$DESKTOP\GPA.lnk"
!endif
!ifdef HAVE_PKG_KLEOPATRA
  Delete "$DESKTOP\Kleopatra.lnk"
!endif
no_desktop_delete:

  Delete "$INSTDIR\${PACKAGE}-uninstall.exe"

  # If we installed in the default location, try to be really, really
  # nice with sugar on it to clean up behind us.  In any case, try very
  # hard to get rid of directories which could have REBOOTOK files.
  RMDir /REBOOTOK "$INSTDIR\bin"
  RMDir /REBOOTOK "$INSTDIR"

  # Clean the registry.
  DeleteRegValue SHCTX "Software\${PRETTY_PACKAGE_SHORT}" \
        "Install Directory"
  DeleteRegKey /ifempty SHCTX "Software\${PRETTY_PACKAGE_SHORT}"

  # Remove Windows Add/Remove Programs support.
  DeleteRegKey SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRETTY_PACKAGE_SHORT}"

  DeleteRegKey SHCTX "Software\Classes\MIME\Database\Content Type\application/pgp"
  DeleteRegKey SHCTX "Software\Classes\MIME\Database\Content Type\application/pgp-signature"
  DeleteRegKey SHCTX "Software\Classes\MIME\Database\Content Type\application/pgp-encrypted"
  DeleteRegKey SHCTX "Software\Classes\MIME\Database\Content Type\application/pgp-keys"


SectionEnd

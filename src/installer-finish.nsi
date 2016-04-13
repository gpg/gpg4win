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

Function SetupExtRegKeys
  Pop $0
  # .gpg
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.GPG" "" "$(T_File_Type_gpg_Name)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.GPG" "FriendlyTypeName" "$(T_File_Type_gpg_Name)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.GPG" "PercievedType" "Document"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.GPG" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.GPG\CurVer" "" "${VERSION}"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.GPG\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.GPG\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegBin HKLM "Software\Classes\.gpg\OpenWithProgIDs" "gpg4win.AssocFile.$0.GPG" 0

  # .asc
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.ASC" "" "$(T_File_Type_asc_Name)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.ASC" "FriendlyTypeName" "$(T_File_Type_asc_Name)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.ASC" "PercievedType" "Document"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.ASC" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.ASC\CurVer" "" "${VERSION}"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.ASC\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.ASC\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"
  WriteRegBin HKLM "Software\Classes\.asc\OpenWithProgIDs" "gpg4win.AssocFile.$0.ASC" 0

  # .pgp
  WriteRegBin HKLM "Software\Classes\.pgp\OpenWithProgIDs" "gpg4win.AssocFile.$0.GPG" 0

  # .sig
  WriteRegExpandStr HKLM "Software\Classes\gpg4win.AssocFile.$0.PGPSIG\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.PGPSIG" "FriendlyTypeName" "$(T_File_Type_sig_Name)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.PGPSIG" "PercievedType" "Document"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.PGPSIG" "InfoTip" "$(T_File_Type_sig_info_tip)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.PGPSIG\CurVer" "" "${VERSION}"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.PGPSIG\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.PGPSIG\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegBin HKLM "Software\Classes\.sig\OpenWithProgIDs" "gpg4win.AssocFile.$0.PGPSIG" 0

  # CMS
  WriteRegExpandStr HKLM "Software\Classes\gpg4win.AssocFile.$0.CMS\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.CMS" "FriendlyTypeName" "$(T_File_Type_pem_Name)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.CMS" "PercievedType" "Document"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.CMS" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.CMS\CurVer" "" "${VERSION}"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.CMS\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.CMS\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"
#  WriteRegBin HKLM "Software\Classes\gpg4win.AssocFile.$0.CMS" "AllowSilentDefaultTakeOver" 0

  WriteRegBin HKLM "Software\Classes\.p7s\OpenWithProgIDs" "gpg4win.AssocFile.$0.CMS" 0
  WriteRegBin HKLM "Software\Classes\.p7m\OpenWithProgIDs" "gpg4win.AssocFile.$0.CMS" 0
  WriteRegBin HKLM "Software\Classes\.crl\OpenWithProgIDs" "gpg4win.AssocFile.$0.CMS" 0
  WriteRegBin HKLM "Software\Classes\.pem\OpenWithProgIDs" "gpg4win.AssocFile.$0.CMS" 0
  WriteRegBin HKLM "Software\Classes\.arl\OpenWithProgIDs" "gpg4win.AssocFile.$0.CMS" 0

  # X509 Certificates
  WriteRegExpandStr HKLM "Software\Classes\gpg4win.AssocFile.$0.X509\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.X509" "FriendlyTypeName" "$(T_File_Type_x509_Name)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.X509" "PercievedType" "Document"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.X509" "InfoTip" "$(T_File_Type_x509_info_tip)"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.X509\CurVer" "" "${VERSION}"
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.X509\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""
  WriteRegStr HKLM "Software\Classes\gpg4win.AssocFile.$0.X509\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"
  WriteRegBin HKLM "Software\Classes\gpg4win.AssocFile.$0.X509" "AllowSilentDefaultTakeOver" 0

  # Register capabilities
  WriteRegStr HKLM "Software\RegisteredApplications" "Gpg4win.$0.${VERSION}" "SOFTWARE\Gpg4win\$0\Capabilities"

  # File extensions
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".pgp" "gpg4win.AssocFile.$0.GPG"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".asc" "gpg4win.AssocFile.$0.ASC"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".gpg" "gpg4win.AssocFile.$0.GPG"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".cer" "gpg4win.AssocFile.$0.X509"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".p10" "gpg4win.AssocFile.$0.X509"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".p12" "gpg4win.AssocFile.$0.X509"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".p7c" "gpg4win.AssocFile.$0.X509"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".pfx" "gpg4win.AssocFile.$0.X509"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".crt" "gpg4win.AssocFile.$0.X509"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".der" "gpg4win.AssocFile.$0.X509"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".sig" "gpg4win.AssocFile.$0.PGPSIG"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".arl" "gpg4win.AssocFile.$0.CMS"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".crl" "gpg4win.AssocFile.$0.CMS"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".p7m" "gpg4win.AssocFile.$0.CMS"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".p7s" "gpg4win.AssocFile.$0.CMS"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\FileAssociations" ".pem" "gpg4win.AssocFile.$0.CMS"

  WriteRegExpandStr HKLM "Software\Gpg4win\$0\Capabilities\shell\open\command" "" "$\"$INSTDIR\bin\$0.exe$\" $\"%1$\""

  # Mime extensions For PGP this is probably pretty useless
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\MimeAssociations" "application/pgp" "gpg4win.AssocFile.$0.GPG"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\MimeAssociations" "application/pgp-encrypted" "gpg4win.AssocFile.$0.GPG"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\MimeAssociations" "application/pgp-signature" "gpg4win.AssocFile.$0.GPG"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\MimeAssociations" "application/pkcs7-mime" "gpg4win.AssocFile.$0.CMS"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\MimeAssociations" "application/pkix-cert" "gpg4win.AssocFile.$0.CMS"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\MimeAssociations" "application/x-x509-ca-cert" "gpg4win.AssocFile.$0.X509"
  WriteRegStr HKLM "Software\Gpg4win\$0\Capabilities\MimeAssociations" "application/x-pkcs12" "gpg4win.AssocFile.$0.X509"

FunctionEnd

Function SetupExtensions
  g4wihelp::config_fetch_bool "register_extensions"
  StrCmp $R0 "1" reg_set  reg_extensions_not_one
reg_extensions_not_one:
  StrCmp $R0 "0" leave 0

reg_set:
  SetOutPath "$INSTDIR\share\gpg4win"
  File "file-ext.ico"
  !insertmacro SectionFlagIsSet ${SEC_kleopatra} \
        ${SF_SELECTED} have_kleo 0
  !insertmacro SectionFlagIsSet ${SEC_gpa} \
        ${SF_SELECTED} have_gpa 0
  goto leave
have_kleo:
  DetailPrint "Registering file extensions"
  # See:
  # https://msdn.microsoft.com/en-us/library/windows/desktop/cc144104%28v=vs.85%29.aspx
  # For documentation.

  push kleopatra
  call SetupExtRegKeys

  !insertmacro SectionFlagIsSet ${SEC_gpa} \
        ${SF_SELECTED} 0 leave2
have_gpa:
  push gpa
  call SetupExtRegKeys

leave2:
System::Call 'Shell32::SHChangeNotify(i 0x8000000, i 0, i 0, i 0)'
leave:
FunctionEnd

LangString T_File_Type_gpg_Name ${LANG_ENGLISH} \
   "OpenPGP Binary File"

LangString T_File_Type_asc_Name ${LANG_ENGLISH} \
   "OpenPGP Text File"

LangString T_File_Type_sig_Name ${LANG_ENGLISH} \
   "OpenPGP Signature"

LangString T_File_Type_asc_Name ${LANG_ENGLISH} \
   "CMS (S/MIME) File"

LangString T_File_Type_x509_Name ${LANG_ENGLISH} \
   "X509 Certificate File"

LangString T_File_Type_x509_info_tip ${LANG_ENGLISH} \
   "A certificate for CMS (S/MIME)."

LangString T_File_Type_info_tip ${LANG_ENGLISH} \
   "This can be encrypted data, a signature or a certificate."

LangString T_File_Type_sig_info_tip ${LANG_ENGLISH} \
   "A cryptographic signature to verify the authenticity of another file."

# Last section is a hidden one.
Section
  WriteUninstaller "$INSTDIR\${PACKAGE}-uninstall.exe"

  # Windows Add/Remove Programs support
  # Note that the version is appended to the DisplayName, despite that
  # this is not necessary as a click on "support information" gives
  # the version number.  Some tools do that, other don't.  I don't
  # like it but others want me to do that.  -wk
  StrCpy $MYTMP "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRETTY_PACKAGE_SHORT}"
  WriteRegExpandStr HKLM $MYTMP "UninstallString" '"$INSTDIR\${PACKAGE}-uninstall.exe"'
  WriteRegExpandStr HKLM $MYTMP "InstallLocation" "$INSTDIR"
  WriteRegStr       HKLM $MYTMP "DisplayName"     "${PRETTY_PACKAGE} (${VERSION})"
  WriteRegStr       HKLM $MYTMP "DisplayIcon"     "$INSTDIR\bin\kleopatra.exe,0"
  WriteRegStr       HKLM $MYTMP "DisplayVersion"  "${VERSION}"
  WriteRegStr       HKLM $MYTMP "Publisher"       "The Gpg4win Project"
  WriteRegStr       HKLM $MYTMP "URLInfoAbout"    "http://www.gpg4win.org/"
  WriteRegDWORD     HKLM $MYTMP "NoModify"        "1"
  WriteRegDWORD     HKLM $MYTMP "NoRepair"        "1"

  call SetupExtensions
SectionEnd


Section Uninstall
  # Make sure that the context of the automatic variables has been set to
  # the "all users" shell folder.  This guarantees that the menu gets written
  # for all users.  We have already checked that we are running as Admin; or
  # we printed a warning that installation will not succeed.
  SetShellVarContext all

  #---------------------------------------------------
  # Delete the menu entries and any empty parent menus
  #---------------------------------------------------
  Delete "$SMPROGRAMS\GPA.lnk"
  Delete "$SMPROGRAMS\Kleopatra.lnk"

  # Delete Desktop links.
!ifdef HAVE_PKG_GPA
  Delete "$DESKTOP\GPA.lnk"
!endif
!ifdef HAVE_PKG_KLEOPATRA
  Delete "$DESKTOP\Kleopatra.lnk"
!endif

  Delete "$INSTDIR\${PACKAGE}-uninstall.exe"

  Delete "$INSTDIR\share\gpg4win\file-ext.ico"
  RMDir "$INSTDIR\share\gpg4win"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"

  # If we installed in the default location, try to be really, really
  # nice with sugar on it to clean up behind us.  In any case, try very
  # hard to get rid of directories which could have REBOOTOK files.
  RMDir /REBOOTOK "$INSTDIR\bin"
  RMDir /REBOOTOK "$INSTDIR"

  # Clean the registry.
  DeleteRegValue HKLM "Software\${PRETTY_PACKAGE_SHORT}" \
        "Install Directory"
  DeleteRegKey /ifempty HKLM "Software\${PRETTY_PACKAGE_SHORT}"

  # Remove Windows Add/Remove Programs support.
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRETTY_PACKAGE_SHORT}"
SectionEnd

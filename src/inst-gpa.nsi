# inst-gpa.nsi - Installer snippet for gpa.        -*- coding: latin-1; -*-
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


!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/gpa-${gpg4win_pkg_gpa_version}


!ifdef GPG4WIN_VANILLA
  ${MementoUnselectedSection} "GPA" SEC_gpa
!else
!ifdef GPG4WIN_LIGHT
  ${MementoSection} "GPA" SEC_gpa
!else
  ${MementoUnselectedSection} "GPA" SEC_gpa
!endif
!endif

  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gpa}"
!else
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/gpa.exe

  File ${ipdir}/pinentry-${gpg4win_pkg_pinentry_version}/bin/pinentry-gtk-2.exe

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/gpa.mo

  SetOutPath "$INSTDIR\share\locale\ar\LC_MESSAGES"
  File ${prefix}/share/locale/ar/LC_MESSAGES/gpa.mo

  SetOutPath "$INSTDIR\share\locale\es\LC_MESSAGES"
  File ${prefix}/share/locale/es/LC_MESSAGES/gpa.mo

  SetOutPath "$INSTDIR\share\locale\fr\LC_MESSAGES"
  File ${prefix}/share/locale/fr/LC_MESSAGES/gpa.mo

  SetOutPath "$INSTDIR\share\locale\ru\LC_MESSAGES"
  File ${prefix}/share/locale/ru/LC_MESSAGES/gpa.mo

  SetOutPath "$INSTDIR\share\gpa"
  File /nonfatal ${prefix}/share/gpa/gpa-logo.ppm
  File ${prefix}/share/gpa/gpa.png

  # If requested, install the configuration files.
  ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" AppData
  StrCmp $0 "" no_config_gpa_files
  CreateDirectory "$0\gnupg"

  g4wihelp::config_fetch "gpa.conf"
  StrCmp $R0 "" no_config_gpa_conf
    CopyFiles $R0 "$0\gnupg\gpa.conf"
  no_config_gpa_conf:

  no_config_gpa_files:

  WriteRegStr SHCTX "Software\Gpg4win\gpa\Capabilities" "ApplicationDescription" "$(DESC_SEC_gpa)"
  WriteRegStr SHCTX "Software\Gpg4win\gpa\Capabilities" "ApplicationIcon" "$INSTDIR\bin\gpa.exe,0"
  WriteRegStr SHCTX "Software\Gpg4win\gpa\Capabilities" "ApplicationName" "$(DESC_SEC_gpa)"

  SetOutPath "$INSTDIR\share\gpg4win"
  File "file-ext.ico"

  # .gpg
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.GPG\shell\open\command" "" "$\"$INSTDIR\bin\GPA.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.GPG" "" "$(T_File_Type_gpg_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.GPG" "FriendlyTypeName" "$(T_File_Type_gpg_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.GPG" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.GPG" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.GPG\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.GPG\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegBin SHCTX "Software\Classes\.gpg\OpenWithProgIDs" "gpg4win.AssocFile.GPA.GPG" 0

  # .asc
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.ASC\shell\open\command" "" "$\"$INSTDIR\bin\GPA.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.ASC" "" "$(T_File_Type_asc_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.ASC" "FriendlyTypeName" "$(T_File_Type_asc_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.ASC" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.ASC" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.ASC\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.ASC\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"
  WriteRegBin SHCTX "Software\Classes\.asc\OpenWithProgIDs" "gpg4win.AssocFile.GPA.ASC" 0

  # .pgp
  WriteRegBin SHCTX "Software\Classes\.pgp\OpenWithProgIDs" "gpg4win.AssocFile.GPA.GPG" 0

  # .sig
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPSIG\shell\open\command" "" "$\"$INSTDIR\bin\GPA.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPSIG" "" "$(T_File_Type_sig_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPSIG" "FriendlyTypeName" "$(T_File_Type_sig_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPSIG" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPSIG" "InfoTip" "$(T_File_Type_sig_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPSIG\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPSIG\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegBin SHCTX "Software\Classes\.sig\OpenWithProgIDs" "gpg4win.AssocFile.GPA.PGPSIG" 0

  # OpenPGP Key to be used in mime registry
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPKEY\shell\open\command" "" "$\"$INSTDIR\bin\GPA.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPKEY" "" "$(T_File_Type_pgp_key_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPKEY" "FriendlyTypeName" "$(T_File_Type_pgp_key_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPKEY" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPKEY" "InfoTip" "$(T_File_Type_pgp_key_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPKEY\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.PGPKEY\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  # CMS
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.CMS\shell\open\command" "" "$\"$INSTDIR\bin\GPA.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.CMS" "" "$(T_File_Type_pem_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.CMS" "FriendlyTypeName" "$(T_File_Type_pem_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.CMS" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.CMS" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.CMS\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.CMS\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegBin SHCTX "Software\Classes\.p7s\OpenWithProgIDs" "gpg4win.AssocFile.GPA.CMS" 0
  WriteRegBin SHCTX "Software\Classes\.p7m\OpenWithProgIDs" "gpg4win.AssocFile.GPA.CMS" 0
  WriteRegBin SHCTX "Software\Classes\.crl\OpenWithProgIDs" "gpg4win.AssocFile.GPA.CMS" 0
  WriteRegBin SHCTX "Software\Classes\.pem\OpenWithProgIDs" "gpg4win.AssocFile.GPA.CMS" 0
  WriteRegBin SHCTX "Software\Classes\.arl\OpenWithProgIDs" "gpg4win.AssocFile.GPA.CMS" 0

  # X509 Certificates
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.X509\shell\open\command" "" "$\"$INSTDIR\bin\GPA.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.X509" "FriendlyTypeName" "$(T_File_Type_x509_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.X509" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.X509" "InfoTip" "$(T_File_Type_x509_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.X509\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.GPA.X509\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"
  WriteRegBin SHCTX "Software\Classes\gpg4win.AssocFile.GPA.X509" "AllowSilentDefaultTakeOver" 0

  # Register capabilities
  WriteRegStr SHCTX "Software\RegisteredApplications" "Gpg4win.GPA" "SOFTWARE\Gpg4win\GPA\Capabilities"
  WriteRegStr SHCTX "Software\Gpg4win\GPA" "" "GPA"

  # File extensions
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".pgp" "gpg4win.AssocFile.GPA.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".asc" "gpg4win.AssocFile.GPA.ASC"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".gpg" "gpg4win.AssocFile.GPA.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".cer" "gpg4win.AssocFile.GPA.X509"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".p10" "gpg4win.AssocFile.GPA.X509"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".p12" "gpg4win.AssocFile.GPA.X509"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".p7c" "gpg4win.AssocFile.GPA.X509"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".pfx" "gpg4win.AssocFile.GPA.X509"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".crt" "gpg4win.AssocFile.GPA.X509"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".der" "gpg4win.AssocFile.GPA.X509"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".sig" "gpg4win.AssocFile.GPA.PGPSIG"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".arl" "gpg4win.AssocFile.GPA.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".crl" "gpg4win.AssocFile.GPA.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".p7m" "gpg4win.AssocFile.GPA.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".p7s" "gpg4win.AssocFile.GPA.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\FileAssociations" ".pem" "gpg4win.AssocFile.GPA.CMS"

  WriteRegExpandStr SHCTX "Software\Gpg4win\GPA\Capabilities\shell\open\command" "" "$\"$INSTDIR\bin\GPA.exe$\" $\"%1$\""

  # Mime extensions For PGP this is probably pretty useless
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\MimeAssociations" "application/pgp" "gpg4win.AssocFile.GPA.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\MimeAssociations" "application/pgp-keys" "gpg4win.AssocFile.GPA.PGPKEY"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\MimeAssociations" "application/pgp-encrypted" "gpg4win.AssocFile.GPA.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\MimeAssociations" "application/pgp-signature" "gpg4win.AssocFile.GPA.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\MimeAssociations" "application/pkcs7-mime" "gpg4win.AssocFile.GPA.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\MimeAssociations" "application/pkix-cert" "gpg4win.AssocFile.GPA.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\MimeAssociations" "application/x-x509-ca-cert" "gpg4win.AssocFile.GPA.X509"
  WriteRegStr SHCTX "Software\Gpg4win\GPA\Capabilities\MimeAssociations" "application/x-pkcs12" "gpg4win.AssocFile.GPA.X509"

!endif
${MementoSectionEnd}


LangString DESC_SEC_gpa ${LANG_ENGLISH} \
   "GNU Privacy Assistant"

LangString DESC_Menu_gpa ${LANG_ENGLISH} \
   "Run the GNU Privacy Assistant key management tool."

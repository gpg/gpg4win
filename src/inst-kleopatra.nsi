# inst-kleopatra.nsi - Installer snippet for kleopatra.      -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007, 2008 g10 Code GmbH
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
!define prefix ${ipdir}/kleopatra-${gpg4win_pkg_kleopatra_version}

${MementoSection} "Kleopatra" SEC_kleopatra
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  # Kleopatra Source Package also contains kdepimlibs, kdelibs and
  # kde-runtime, as well as win-iconv and attica
  File "${gpg4win_pkg_kleopatra}"
!else

  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/kleopatra.exe
  #File ${prefix}/bin/kwatchgnupg.exe

  File ${prefix}/bin/libkleopatraclientcore.dll
  File ${prefix}/bin/libkleopatraclientgui.dll

  SetOutPath "$INSTDIR\share\kleopatra\pics"

  File ${prefix}/share/kleopatra/pics/gpg4win.png
  File ${prefix}/share/kleopatra/pics/kleopatra_splashscreen.png
  File ${prefix}/share/kleopatra/pics/kleopatra_splashscreen.svgz
  File ${prefix}/share/kleopatra/pics/kleopatra_wizard.png
  File ${prefix}/share/kleopatra/pics/kleopatra_wizard.svgz

#  SetOutPath "$INSTDIR\share\apps\kwatchgnupg\pics"

#  File ${prefix}/share/apps/kwatchgnupg/pics/kwatchgnupg.png
#  File ${prefix}/share/apps/kwatchgnupg/pics/kwatchgnupg2.png

#  # TODO Can't mix localized and en commons when we install
#  # more then one kde langanuage
#  SetOutPath "$INSTDIR\share\doc\HTML\common"
#
#  File ${prefix}/share/doc/HTML/en/common/1.png
#  File ${prefix}/share/doc/HTML/en/common/10.png
#  File ${prefix}/share/doc/HTML/en/common/2.png
#  File ${prefix}/share/doc/HTML/en/common/3.png
#  File ${prefix}/share/doc/HTML/en/common/4.png
#  File ${prefix}/share/doc/HTML/en/common/5.png
#  File ${prefix}/share/doc/HTML/en/common/6.png
#  File ${prefix}/share/doc/HTML/en/common/7.png
#  File ${prefix}/share/doc/HTML/en/common/8.png
#  File ${prefix}/share/doc/HTML/en/common/9.png
#  File ${prefix}/share/doc/HTML/en/common/artistic-license.html
#  File ${prefix}/share/doc/HTML/en/common/block_title_bottom.png
#  File ${prefix}/share/doc/HTML/en/common/block_title_mid.png
#  File ${prefix}/share/doc/HTML/en/common/block_title_top.png
#  File ${prefix}/share/doc/HTML/en/common/bottom-left.png
#  File ${prefix}/share/doc/HTML/en/common/bottom-middle.png
#  File ${prefix}/share/doc/HTML/en/common/bottom-right.png
#  File ${prefix}/share/doc/HTML/en/common/bsd-license.html
#  File ${prefix}/share/doc/HTML/en/common/doxygen.css
#  File ${prefix}/share/doc/HTML/en/common/favicon.ico
#  File ${prefix}/share/doc/HTML/en/common/fdl-license.html
#  File ${prefix}/share/doc/HTML/en/common/fdl-license
#  File ${prefix}/share/doc/HTML/en/common/fdl-notice.html
#  File ${prefix}/share/doc/HTML/en/common/kde-docs.css
#  File ${prefix}/share/doc/HTML/en/common/footer.html
#  File ${prefix}/share/doc/HTML/en/common/gpl-license.html
#  File ${prefix}/share/doc/HTML/en/common/gpl-license
#  File ${prefix}/share/doc/HTML/en/common/header.html
#  File ${prefix}/share/doc/HTML/en/common/kde-default.css
#  File ${prefix}/share/doc/HTML/en/common/kde-docs.css
#  File ${prefix}/share/doc/HTML/en/common/kde_logo_bg.png
#  File ${prefix}/share/doc/HTML/en/common/lgpl-license.html
#  File ${prefix}/share/doc/HTML/en/common/lgpl-license
#  File ${prefix}/share/doc/HTML/en/common/mainfooter.html
#  File ${prefix}/share/doc/HTML/en/common/mainheader.html
#  File ${prefix}/share/doc/HTML/en/common/qpl-license.html
#  File ${prefix}/share/doc/HTML/en/common/tabs.css
#  File ${prefix}/share/doc/HTML/en/common/top-kde.jpg
#  File ${prefix}/share/doc/HTML/en/common/top-left.jpg
#  File ${prefix}/share/doc/HTML/en/common/top-left.png
#  File ${prefix}/share/doc/HTML/en/common/top-middle.png
#  File ${prefix}/share/doc/HTML/en/common/top-right.jpg
#  File ${prefix}/share/doc/HTML/en/common/top-right.png
#  File ${prefix}/share/doc/HTML/en/common/top.jpg
#  File ${prefix}/share/doc/HTML/en/common/x11-license.html
#  File ${prefix}/share/doc/HTML/en/common/xml.dcl
#
#  File ${prefix}/share/doc/HTML/de/common/fdl-translated.html
#  File ${prefix}/share/doc/HTML/de/common/gpl-translated.html
#  File ${prefix}/share/doc/HTML/de/common/kde-localised.css
#  File ${prefix}/share/doc/HTML/de/common/lgpl-translated.html
#
#  SetOutPath "$INSTDIR\share\doc\HTML\de\kleopatra"
#
#  File ${prefix}/share/doc/HTML/de/kleopatra/admin-archive-definitions.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/admin-checksum-definitions.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/admin-key-filters.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/admin.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/commandline-options.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/configuration-appearance.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/configuration-crypto-operations.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/configuration-gnupg-system.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/configuration-smime-validation.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/configuration.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/credits-and-license.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/functions-newkey.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/functions-search.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/functions.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/index.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/introduction.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/menu.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/menucertificates.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/menuhelp.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/menusettings.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/menutools.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/menuview.html
#  File ${prefix}/share/doc/HTML/de/kleopatra/menuwindow.html
#
#  SetOutPath "$INSTDIR\share\doc\HTML\en\kleopatra"
#
#  File ${prefix}/share/doc/HTML/en/kleopatra/admin-archive-definitions.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/admin-checksum-definitions.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/admin-key-filters.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/admin.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/commandline-options.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/configuration-appearance.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/configuration-crypto-operations.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/configuration-gnupg-system.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/configuration-smime-validation.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/configuration.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/credits-and-license.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/functions-newkey.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/functions-search.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/functions.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/index.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/introduction.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/menu.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/menucertificates.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/menuhelp.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/menusettings.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/menutools.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/menuview.html
#  File ${prefix}/share/doc/HTML/en/kleopatra/menuwindow.html

  SetOutPath "$INSTDIR\share\icons\hicolor\128x128\apps"

  File ${prefix}/share/icons/hicolor/128x128/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\hicolor\16x16\apps"

  File ${prefix}/share/kleopatra/pics/gpg4win-compact.png
  File ${prefix}/share/icons/hicolor/16x16/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\hicolor\22x22\apps"

  File ${prefix}/share/icons/hicolor/22x22/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\hicolor\256x256\apps"

  File ${prefix}/share/icons/hicolor/256x256/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\hicolor\32x32\apps"

  File ${prefix}/share/icons/hicolor/32x32/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\hicolor\48x48\apps"

  File ${prefix}/share/icons/hicolor/48x48/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\hicolor\64x64\apps"

  File ${prefix}/share/icons/hicolor/64x64/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\hicolor"
  File ${prefix}/share/icons/hicolor/icon-theme.cache
  File index.theme

  # In KDE 4.10 the locale detection in kdelibs is broken so we
  # install a kdeglobals with the language setting chosen in the
  # installer
  SetOutPath "$INSTDIR\share"
  File kdeglobals
  SetOutPath "$INSTDIR\share\QtProject"
  File qtlogging.ini

  WriteRegStr SHCTX "Software\Gpg4win\kleopatra\Capabilities" "ApplicationDescription" "$(DESC_SEC_kleopatra)"
  WriteRegStr SHCTX "Software\Gpg4win\kleopatra\Capabilities" "ApplicationIcon" "$INSTDIR\bin\kleopatra.exe,0"
  WriteRegStr SHCTX "Software\Gpg4win\kleopatra\Capabilities" "ApplicationName" "Kleopatra"

  SetOutPath "$INSTDIR\share\gpg4win"
  File "file-ext.ico"

  # Openpgp4fpr URI scheme
  WriteRegStr SHCTX "Software\Classes\openpgp4fpr" "" "URL:OpenPGP master key fingerprint"
  WriteRegStr SHCTX "Software\Classes\openpgp4fpr" "URL Protocol" ""
  WriteRegStr SHCTX "Software\Classes\openpgp4fpr\DefaultIcon" "" "$INSTDIR\bin\kleopatra.exe,0"
  WriteRegStr SHCTX "Software\Classes\openpgp4fpr\shell\open\command" "" "$\"$INSTDIR\bin\kleopatra.exe$\" --query -- $\"%1$\""

  # p7s / p7m are special because they are already known
  WriteRegExpandStr SHCTX "Software\Classes\P7MFile\shell\open\command" "" "$\"$INSTDIR\bin\kleopatra.exe$\" -- $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\P7MFile\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegExpandStr SHCTX "Software\Classes\P7SFile\shell\open\command" "" "$\"$INSTDIR\bin\kleopatra.exe$\" -- $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\P7SFile\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  # .gpg
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.GPG\shell\open\command" "" "$\"$INSTDIR\bin\Kleopatra.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.GPG" "" "$(T_File_Type_gpg_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.GPG" "FriendlyTypeName" "$(T_File_Type_gpg_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.GPG" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.GPG" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.GPG\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.GPG\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegBin SHCTX "Software\Classes\.gpg\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.GPG" 0

  # .asc
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.ASC\shell\open\command" "" "$\"$INSTDIR\bin\Kleopatra.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.ASC" "" "$(T_File_Type_asc_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.ASC" "FriendlyTypeName" "$(T_File_Type_asc_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.ASC" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.ASC" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.ASC\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.ASC\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"
  WriteRegBin SHCTX "Software\Classes\.asc\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.ASC" 0

  # .pgp
  WriteRegBin SHCTX "Software\Classes\.pgp\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.GPG" 0

  # .sig
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPSIG\shell\open\command" "" "$\"$INSTDIR\bin\Kleopatra.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPSIG" "" "$(T_File_Type_sig_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPSIG" "FriendlyTypeName" "$(T_File_Type_sig_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPSIG" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPSIG" "InfoTip" "$(T_File_Type_sig_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPSIG\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPSIG\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegBin SHCTX "Software\Classes\.sig\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.PGPSIG" 0

  # OpenPGP Key to be used in mime registry
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPKEY\shell\open\command" "" "$\"$INSTDIR\bin\Kleopatra.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPKEY" "" "$(T_File_Type_pgp_key_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPKEY" "FriendlyTypeName" "$(T_File_Type_pgp_key_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPKEY" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPKEY" "InfoTip" "$(T_File_Type_pgp_key_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPKEY\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.PGPKEY\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  # CMS
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.CMS\shell\open\command" "" "$\"$INSTDIR\bin\Kleopatra.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.CMS" "" "$(T_File_Type_pem_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.CMS" "FriendlyTypeName" "$(T_File_Type_pem_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.CMS" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.CMS" "InfoTip" "$(T_File_Type_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.CMS\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.CMS\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"

  WriteRegBin SHCTX "Software\Classes\.p7s\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.CMS" 0
  WriteRegBin SHCTX "Software\Classes\.p7m\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.CMS" 0
  WriteRegBin SHCTX "Software\Classes\.crl\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.CMS" 0
  WriteRegBin SHCTX "Software\Classes\.pem\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.CMS" 0
  WriteRegBin SHCTX "Software\Classes\.arl\OpenWithProgIDs" "gpg4win.AssocFile.Kleopatra.CMS" 0

  # X509 Certificates
  WriteRegExpandStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.X509\shell\open\command" "" "$\"$INSTDIR\bin\Kleopatra.exe$\" $\"%1$\""
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.X509" "FriendlyTypeName" "$(T_File_Type_x509_Name)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.X509" "PercievedType" "Document"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.X509" "InfoTip" "$(T_File_Type_x509_info_tip)"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.X509\CurVer" "" "${VERSION}"
  WriteRegStr SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.X509\DefaultIcon" "" "$INSTDIR\share\gpg4win\file-ext.ico"
  WriteRegBin SHCTX "Software\Classes\gpg4win.AssocFile.Kleopatra.X509" "AllowSilentDefaultTakeOver" 0

  # Register capabilities
  WriteRegStr SHCTX "Software\RegisteredApplications" "Gpg4win.Kleopatra" "SOFTWARE\Gpg4win\Kleopatra\Capabilities"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra" "" "Kleopatra"

  # File extensions
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".pgp" "gpg4win.AssocFile.Kleopatra.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".asc" "gpg4win.AssocFile.Kleopatra.ASC"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".gpg" "gpg4win.AssocFile.Kleopatra.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".cer" "gpg4win.AssocFile.Kleopatra.X509"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".p10" "gpg4win.AssocFile.Kleopatra.X509"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".p12" "gpg4win.AssocFile.Kleopatra.X509"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".p7c" "gpg4win.AssocFile.Kleopatra.X509"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".pfx" "gpg4win.AssocFile.Kleopatra.X509"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".crt" "gpg4win.AssocFile.Kleopatra.X509"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".der" "gpg4win.AssocFile.Kleopatra.X509"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".sig" "gpg4win.AssocFile.Kleopatra.PGPSIG"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".arl" "gpg4win.AssocFile.Kleopatra.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".crl" "gpg4win.AssocFile.Kleopatra.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".p7m" "gpg4win.AssocFile.Kleopatra.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".p7s" "gpg4win.AssocFile.Kleopatra.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\FileAssociations" ".pem" "gpg4win.AssocFile.Kleopatra.CMS"

  WriteRegExpandStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\shell\open\command" "" "$\"$INSTDIR\bin\Kleopatra.exe$\" $\"%1$\""

  # Mime extensions For PGP this is probably pretty useless
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\MimeAssociations" "application/pgp" "gpg4win.AssocFile.Kleopatra.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\MimeAssociations" "application/pgp-keys" "gpg4win.AssocFile.Kleopatra.PGPKEY"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\MimeAssociations" "application/pgp-encrypted" "gpg4win.AssocFile.Kleopatra.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\MimeAssociations" "application/pgp-signature" "gpg4win.AssocFile.Kleopatra.GPG"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\MimeAssociations" "application/pkcs7-mime" "gpg4win.AssocFile.Kleopatra.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\MimeAssociations" "application/pkix-cert" "gpg4win.AssocFile.Kleopatra.CMS"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\MimeAssociations" "application/x-x509-ca-cert" "gpg4win.AssocFile.Kleopatra.X509"
  WriteRegStr SHCTX "Software\Gpg4win\Kleopatra\Capabilities\MimeAssociations" "application/x-pkcs12" "gpg4win.AssocFile.Kleopatra.X509"

!endif
${MementoSectionEnd}


LangString DESC_SEC_kleopatra ${LANG_ENGLISH} \
   "Keymanager for OpenPGP and X.509 and common crypto dialogs."


LangString DESC_Menu_kleopatra ${LANG_ENGLISH} \
   "Run the Kleopatra key management tool."

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
  File "${gpg4win_pkg_kleopatra_src}"
!else

  # Relocate this when dbus-daemon is relocated.
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/kleopatra.exe
  SetOutPath "$INSTDIR"
  File /oname=kleopatra.exe "${BUILD_DIR}/kleowrap.exe"

  File ${prefix}/bin/kgpgconf.exe
  File ${prefix}/bin/kwatchgnupg.exe
  File ${prefix}/bin/libkleo.dll
  File ${prefix}/bin/libkleopatraclientcore.dll
  File ${prefix}/bin/libkleopatraclientgui.dll

  SetOutPath "$INSTDIR\lib\kde4"

  File ${prefix}/lib/kde4/kcm_kleopatra.dll

  SetOutPath "$INSTDIR\share\applications\kde4"

  File ${prefix}/share/applications/kde4/kleopatra.desktop
  File ${prefix}/share/applications/kde4/kleopatra_import.desktop

  SetOutPath "$INSTDIR\share\apps\kleopatra"

  File ${prefix}/share/apps/kleopatra/kleopatra.rc

  SetOutPath "$INSTDIR\share\apps\kleopatra\pics"

  File ${prefix}/share/apps/kleopatra/pics/gpg4win-compact.png
  File ${prefix}/share/apps/kleopatra/pics/gpg4win.png
  File ${prefix}/share/apps/kleopatra/pics/kleopatra_splashscreen.png
  File ${prefix}/share/apps/kleopatra/pics/kleopatra_splashscreen.svgz
  File ${prefix}/share/apps/kleopatra/pics/kleopatra_wizard.png
  File ${prefix}/share/apps/kleopatra/pics/kleopatra_wizard.svgz

  SetOutPath "$INSTDIR\share\apps\kwatchgnupg"

  File ${prefix}/share/apps/kwatchgnupg/kwatchgnupgui.rc

  SetOutPath "$INSTDIR\share\apps\kwatchgnupg\pics"

  File ${prefix}/share/apps/kwatchgnupg/pics/kwatchgnupg.png
  File ${prefix}/share/apps/kwatchgnupg/pics/kwatchgnupg2.png

  SetOutPath "$INSTDIR\share\apps\libkleopatra\pics"

  File ${prefix}/share/apps/libkleopatra/pics/chiasmus_chi.png
  File ${prefix}/share/apps/libkleopatra/pics/hi16-app-gpg.png
  File ${prefix}/share/apps/libkleopatra/pics/hi16-app-gpgsm.png
  File ${prefix}/share/apps/libkleopatra/pics/hi22-app-gpg.png
  File ${prefix}/share/apps/libkleopatra/pics/hi22-app-gpgsm.png
  File ${prefix}/share/apps/libkleopatra/pics/hi32-app-gpg.png
  File ${prefix}/share/apps/libkleopatra/pics/hi32-app-gpgsm.png
  File ${prefix}/share/apps/libkleopatra/pics/key.png
  File ${prefix}/share/apps/libkleopatra/pics/key_bad.png
  File ${prefix}/share/apps/libkleopatra/pics/key_ok.png
  File ${prefix}/share/apps/libkleopatra/pics/key_unknown.png
  File ${prefix}/share/apps/libkleopatra/pics/smartcard.xpm

  SetOutPath "$INSTDIR\share\config"

  File ${prefix}/share/config/libkleopatrarc

  SetOutPath "$INSTDIR\share\doc\HTML\common"

  File ${prefix}/share/doc/HTML/common/common/1.png
  File ${prefix}/share/doc/HTML/common/common/10.png
  File ${prefix}/share/doc/HTML/common/common/2.png
  File ${prefix}/share/doc/HTML/common/common/3.png
  File ${prefix}/share/doc/HTML/common/common/4.png
  File ${prefix}/share/doc/HTML/common/common/5.png
  File ${prefix}/share/doc/HTML/common/common/6.png
  File ${prefix}/share/doc/HTML/common/common/7.png
  File ${prefix}/share/doc/HTML/common/common/8.png
  File ${prefix}/share/doc/HTML/common/common/9.png
  File ${prefix}/share/doc/HTML/common/common/CMakeLists.txt
  File ${prefix}/share/doc/HTML/common/common/Doxyfile.global
  File ${prefix}/share/doc/HTML/common/common/README.Doxygen
  File ${prefix}/share/doc/HTML/common/common/artistic-license.html
  File ${prefix}/share/doc/HTML/common/common/block_title_bottom.png
  File ${prefix}/share/doc/HTML/common/common/block_title_mid.png
  File ${prefix}/share/doc/HTML/common/common/block_title_top.png
  File ${prefix}/share/doc/HTML/common/common/bottom-left.png
  File ${prefix}/share/doc/HTML/common/common/bottom-middle.png
  File ${prefix}/share/doc/HTML/common/common/bottom-right.png
  File ${prefix}/share/doc/HTML/common/common/bsd-license.html
  File ${prefix}/share/doc/HTML/common/common/doxygen.css
  File ${prefix}/share/doc/HTML/common/common/favicon.ico
  File ${prefix}/share/doc/HTML/common/common/fdl-license
  File ${prefix}/share/doc/HTML/common/common/fdl-license.html
  File ${prefix}/share/doc/HTML/common/common/fdl-notice.html
  File ${prefix}/share/doc/HTML/common/common/flat.css
  File ${prefix}/share/doc/HTML/common/common/footer.html
  File ${prefix}/share/doc/HTML/common/common/gpl-license
  File ${prefix}/share/doc/HTML/common/common/gpl-license.html
  File ${prefix}/share/doc/HTML/common/common/header.html
  File ${prefix}/share/doc/HTML/common/common/kde-default.css
  File ${prefix}/share/doc/HTML/common/common/kde.css
  File ${prefix}/share/doc/HTML/common/common/kde_logo.png
  File ${prefix}/share/doc/HTML/common/common/kde_logo_bg.png
  File ${prefix}/share/doc/HTML/common/common/lgpl-license
  File ${prefix}/share/doc/HTML/common/common/lgpl-license.html
  File ${prefix}/share/doc/HTML/common/common/mainfooter.html
  File ${prefix}/share/doc/HTML/common/common/mainheader.html
  File ${prefix}/share/doc/HTML/common/common/print.css
  File ${prefix}/share/doc/HTML/common/common/qpl-license.html
  File ${prefix}/share/doc/HTML/common/common/tabs.css
  File ${prefix}/share/doc/HTML/common/common/top-kde.jpg
  File ${prefix}/share/doc/HTML/common/common/top-left.jpg
  File ${prefix}/share/doc/HTML/common/common/top-left.png
  File ${prefix}/share/doc/HTML/common/common/top-middle.png
  File ${prefix}/share/doc/HTML/common/common/top-right.jpg
  File ${prefix}/share/doc/HTML/common/common/top-right.png
  File ${prefix}/share/doc/HTML/common/common/top.jpg
  File ${prefix}/share/doc/HTML/common/common/x11-license.html
  File ${prefix}/share/doc/HTML/common/common/xml.dcl

  SetOutPath "$INSTDIR\share\doc\HTML\de\kleopatra"

  File ${prefix}/share/doc/HTML/de/kleopatra/admin-key-filters.html
  File ${prefix}/share/doc/HTML/de/kleopatra/admin.html
  File ${prefix}/share/doc/HTML/de/kleopatra/commandline-options.html
  File ${prefix}/share/doc/HTML/de/kleopatra/configuration-appearance.html
  File ${prefix}/share/doc/HTML/de/kleopatra/configuration-dn-order.html
  File ${prefix}/share/doc/HTML/de/kleopatra/configuration.html
  File ${prefix}/share/doc/HTML/de/kleopatra/credits-and-license.html
  File ${prefix}/share/doc/HTML/de/kleopatra/functions-keybox-management.html
  File ${prefix}/share/doc/HTML/de/kleopatra/functions-newkey.html
  File ${prefix}/share/doc/HTML/de/kleopatra/functions-search.html
  File ${prefix}/share/doc/HTML/de/kleopatra/functions.html
  File ${prefix}/share/doc/HTML/de/kleopatra/index.html
  File ${prefix}/share/doc/HTML/de/kleopatra/introduction.html
  File ${prefix}/share/doc/HTML/de/kleopatra/menu.html
  File ${prefix}/share/doc/HTML/de/kleopatra/menucertificates.html
  File ${prefix}/share/doc/HTML/de/kleopatra/menucrls.html
  File ${prefix}/share/doc/HTML/de/kleopatra/menuhelp.html
  File ${prefix}/share/doc/HTML/de/kleopatra/menusettings.html
  File ${prefix}/share/doc/HTML/de/kleopatra/menutools.html
  File ${prefix}/share/doc/HTML/de/kleopatra/menuview.html

  SetOutPath "$INSTDIR\share\doc\HTML\en\kleopatra"

  File ${prefix}/share/doc/HTML/en/kleopatra/admin-archive-definitions.html
  File ${prefix}/share/doc/HTML/en/kleopatra/admin-checksum-definitions.html
  File ${prefix}/share/doc/HTML/en/kleopatra/admin-key-filters.html
  File ${prefix}/share/doc/HTML/en/kleopatra/admin.html
  File ${prefix}/share/doc/HTML/en/kleopatra/commandline-options.html
  File ${prefix}/share/doc/HTML/en/kleopatra/configuration-appearance.html
  File ${prefix}/share/doc/HTML/en/kleopatra/configuration-crypto-operations.html
  File ${prefix}/share/doc/HTML/en/kleopatra/configuration-gnupg-system.html
  File ${prefix}/share/doc/HTML/en/kleopatra/configuration-smime-validation.html
  File ${prefix}/share/doc/HTML/en/kleopatra/configuration.html
  File ${prefix}/share/doc/HTML/en/kleopatra/credits-and-license.html
  File ${prefix}/share/doc/HTML/en/kleopatra/functions-newkey.html
  File ${prefix}/share/doc/HTML/en/kleopatra/functions-search.html
  File ${prefix}/share/doc/HTML/en/kleopatra/functions.html
  File ${prefix}/share/doc/HTML/en/kleopatra/index.html
  File ${prefix}/share/doc/HTML/en/kleopatra/introduction.html
  File ${prefix}/share/doc/HTML/en/kleopatra/menu.html
  File ${prefix}/share/doc/HTML/en/kleopatra/menucertificates.html
  File ${prefix}/share/doc/HTML/en/kleopatra/menuhelp.html
  File ${prefix}/share/doc/HTML/en/kleopatra/menusettings.html
  File ${prefix}/share/doc/HTML/en/kleopatra/menutools.html
  File ${prefix}/share/doc/HTML/en/kleopatra/menuview.html
  File ${prefix}/share/doc/HTML/en/kleopatra/menuwindow.html

  SetOutPath "$INSTDIR\share\icons\oxygen\128x128\apps"

  File ${prefix}/share/icons/oxygen/128x128/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\apps"

  File ${prefix}/share/icons/oxygen/16x16/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\apps"

  File ${prefix}/share/icons/oxygen/22x22/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\256x256\apps"

  File ${prefix}/share/icons/oxygen/256x256/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\apps"

  File ${prefix}/share/icons/oxygen/32x32/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\48x48\apps"

  File ${prefix}/share/icons/oxygen/48x48/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\64x64\apps"

  File ${prefix}/share/icons/oxygen/64x64/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\scalable\apps"

  File ${prefix}/share/icons/oxygen/scalable/apps/kleopatra.svgz

  SetOutPath "$INSTDIR\share\kde4\services"

  File ${prefix}/share/kde4/services/kleopatra_config_appear.desktop
  File ${prefix}/share/kde4/services/kleopatra_config_cryptooperations.desktop
  File ${prefix}/share/kde4/services/kleopatra_config_dirserv.desktop
  File ${prefix}/share/kde4/services/kleopatra_config_gnupgsystem.desktop
  File ${prefix}/share/kde4/services/kleopatra_config_smimevalidation.desktop
  File ${prefix}/share/kde4/services/kleopatra_decryptverifyfiles.desktop
  File ${prefix}/share/kde4/services/kleopatra_decryptverifyfolders.desktop
  File ${prefix}/share/kde4/services/kleopatra_signencryptfiles.desktop
  File ${prefix}/share/kde4/services/kleopatra_signencryptfolders.desktop

!endif
${MementoSectionEnd}


LangString DESC_SEC_kleopatra ${LANG_ENGLISH} \
   "Keymanager for OpenPGP and X.509 and common crypto dialogs."


LangString DESC_Menu_kleopatra ${LANG_ENGLISH} \
   "Run the Kleopatra key management tool."

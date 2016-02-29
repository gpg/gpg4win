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

  # The KCM lib is directly linked
  File ${prefix}/lib/plugins/kcm_kleopatra.dll

  SetOutPath "$INSTDIR\share\kleopatra\pics"

  File ${prefix}/share/kleopatra/pics/gpg4win.png
  File ${prefix}/share/kleopatra/pics/kleopatra_splashscreen.png
  File ${prefix}/share/kleopatra/pics/kleopatra_splashscreen.svgz
  File ${prefix}/share/kleopatra/pics/kleopatra_wizard.png
  File ${prefix}/share/kleopatra/pics/kleopatra_wizard.svgz

  SetOutPath "$INSTDIR\share\kservices5"
  File ${prefix}/share/kservices5/kleopatra_config_appear.desktop
  File ${prefix}/share/kservices5/kleopatra_config_gnupgsystem.desktop
  File ${prefix}/share/kservices5/kleopatra_config_cryptooperations.desktop
  File ${prefix}/share/kservices5/kleopatra_config_smimevalidation.desktop
  File ${prefix}/share/kservices5/kleopatra_config_dirserv.desktop

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
  push $1
  FileOpen $1 "$INSTDIR\share\kdeglobals" "w"
  # Writing out icon theme is important here otherwise you have
  # weird effects like no toolbar icons.
  FileWrite $1 '[Icons]$\r$\n'
  FileWrite $1 'Theme=breeze$\r$\n$\r$\n'
  FileClose $1
  pop $1

  push $1
  FileOpen $1 "$INSTDIR\share\klanguageoverridesrc" "w"
  FileWrite $1 '[Language] $\r$\n'
  StrCmp $LANGUAGE "1031" german_locale 0
  StrCmp $LANGUAGE "1025" arabic 0
  StrCmp $LANGUAGE "1029" czech 0
  StrCmp $LANGUAGE "1049" russian 0
  StrCmp $LANGUAGE "1036" french 0
  StrCmp $LANGUAGE "1034" spanish 0
  StrCmp $LANGUAGE "1040" italian 0
  StrCmp $LANGUAGE "1046" portugese 0
  StrCmp $LANGUAGE "2070" portugese_br 0
  StrCmp $LANGUAGE "2052" simpchinese 0
  StrCmp $LANGUAGE "1028" tradchinese 0
  FileWrite $1 'kleopatra=@ByteArray(en) $\r$\n'
  Goto lang_done
german_locale:
  FileWrite $1 'kleopatra=@ByteArray(de) $\r$\n'
  Goto lang_done
arabic:
  FileWrite $1 'kleopatra=@ByteArray(ar) $\r$\n'
  Goto lang_done
czech:
  FileWrite $1 'kleopatra=@ByteArray(cs) $\r$\n'
  Goto lang_done
russian:
  FileWrite $1 'kleopatra=@ByteArray(ru) $\r$\n'
  Goto lang_done
french:
  FileWrite $1 'kleopatra=@ByteArray(fr) $\r$\n'
  Goto lang_done
spanish:
  FileWrite $1 'kleopatra=@ByteArray(es) $\r$\n'
  Goto lang_done
italian:
  FileWrite $1 'kleopatra=@ByteArray(it) $\r$\n'
  Goto lang_done
portugese:
  FileWrite $1 'kleopatra=@ByteArray(pt) $\r$\n'
  Goto lang_done
portugese_br:
  FileWrite $1 'kleopatra=@ByteArray(pt_BR) $\r$\n'
  Goto lang_done
simpchinese:
  FileWrite $1 'kleopatra=@ByteArray(zh_CN) $\r$\n'
  Goto lang_done
tradchinese:
  FileWrite $1 'kleopatra=@ByteArray(zh_TW) $\r$\n'
  Goto lang_done
lang_done:
  FileClose $1
  pop $1

  SetOutPath "$INSTDIR\share\QtProject"
  # We want kleopatra logging for debugging
  push $1
  FileOpen $1 "$INSTDIR\share\QtProject\qtlogging.ini" "w"
  FileWrite $1 '[Rules]$\r$\n'
  FileWrite $1 'log_kleopatra.debug=true$\r$\n'
  FileClose $1
  pop $1



!endif
${MementoSectionEnd}


LangString DESC_SEC_kleopatra ${LANG_ENGLISH} \
   "Keymanager for OpenPGP and X.509 and common crypto dialogs."


LangString DESC_Menu_kleopatra ${LANG_ENGLISH} \
   "Run the Kleopatra key management tool."

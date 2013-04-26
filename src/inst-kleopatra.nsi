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
  File "${gpg4win_pkg_kleopatra_src}"
!else

  # Relocate this when dbus-daemon is relocated.
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/kleopatra.exe
  SetOutPath "$INSTDIR"
  File /oname=kleopatra.exe "${BUILD_DIR}/kleowrap.exe"

  File ${prefix}/bin/kgpgconf.exe
  File ${prefix}/bin/kwatchgnupg.exe
  File ${prefix}/bin/kcmdwrapper.exe
  File ${prefix}/bin/kbuildsycoca4.exe
  File ${prefix}/bin/libattica.dll
  File ${prefix}/bin/libdbus-1.dll
  File ${prefix}/bin/libdbusmenu-qt.dll
  File ${prefix}/bin/libgcc_s_sjlj-1.dll
  File ${prefix}/bin/libgpg-error-0.dll
  File ${prefix}/bin/libgpgme-11.dll
  File ${prefix}/bin/libgpgme++.dll
  File ${prefix}/bin/wconv.dll
  File ${prefix}/bin/libintl.dll
  File ${prefix}/bin/libjasper.dll
  File ${prefix}/bin/libkcmutils.dll
  File ${prefix}/bin/libkdecore.dll
  File ${prefix}/bin/libkdeui.dll
  File ${prefix}/bin/libkdewin.dll
  File ${prefix}/bin/libkleo.dll
  File ${prefix}/bin/libkleopatraclientcore.dll
  File ${prefix}/bin/libkleopatraclientgui.dll
  File ${prefix}/bin/libkmime.dll
  File ${prefix}/bin/libqgpgme.dll

  SetOutPath "$INSTDIR\lib\kde4"

  # This should be made build static
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

  # TODO
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

  # Parts formerly in the kdelibs section:
  SetOutPath "$INSTDIR\share\apps\kcharselect"

  File ${prefix}/share/apps/kcharselect/kcharselect-data

  SetOutPath "$INSTDIR\share\apps\kdeui\about"

  File ${prefix}/share/apps/kdeui/about/bar-bottom-left.png
  File ${prefix}/share/apps/kdeui/about/bar-bottom-middle.png
  File ${prefix}/share/apps/kdeui/about/bar-bottom-right.png
  File ${prefix}/share/apps/kdeui/about/bar-middle-left.png
  File ${prefix}/share/apps/kdeui/about/bar-middle-right.png
  File ${prefix}/share/apps/kdeui/about/bar-top-left.png
  File ${prefix}/share/apps/kdeui/about/bar-top-middle.png
  File ${prefix}/share/apps/kdeui/about/bar-top-right.png
  File ${prefix}/share/apps/kdeui/about/bottom-left.png
  File ${prefix}/share/apps/kdeui/about/bottom-middle.png
  File ${prefix}/share/apps/kdeui/about/bottom-right.png
  File ${prefix}/share/apps/kdeui/about/box-bottom-left.png
  File ${prefix}/share/apps/kdeui/about/box-bottom-middle.png
  File ${prefix}/share/apps/kdeui/about/box-bottom-right.png
  File ${prefix}/share/apps/kdeui/about/box-middle-left.png
  File ${prefix}/share/apps/kdeui/about/box-middle-right.png
  File ${prefix}/share/apps/kdeui/about/box-top-left.png
  File ${prefix}/share/apps/kdeui/about/box-top-middle.png
  File ${prefix}/share/apps/kdeui/about/box-top-right.png
  File ${prefix}/share/apps/kdeui/about/kde_infopage.css
  File ${prefix}/share/apps/kdeui/about/kde_infopage_rtl.css
  File ${prefix}/share/apps/kdeui/about/top-middle.png
  File ${prefix}/share/apps/kdeui/about/top-right.png

  SetOutPath "$INSTDIR\share\apps\kdeui\pics"

  File ${prefix}/share/apps/kdeui/pics/aboutkde.png
  File ${prefix}/share/apps/kdeui/pics/kdeprint_nup1.png
  File ${prefix}/share/apps/kdeui/pics/kdeprint_nup2.png
  File ${prefix}/share/apps/kdeui/pics/kdeprint_nup4.png
  File ${prefix}/share/apps/kdeui/pics/kdeprint_nupother.png
  File ${prefix}/share/apps/kdeui/pics/ktip-bulb.png

  SetOutPath "$INSTDIR\share\config\colors"

  File ${prefix}/share/config/colors/40.colors
  File ${prefix}/share/config/colors/Oxygen.colors
  File ${prefix}/share/config/colors/Rainbow.colors
  File ${prefix}/share/config/colors/Royal.colors
  File ${prefix}/share/config/colors/Web.colors

  SetOutPath "$INSTDIR\share\config"

  File ${prefix}/share/config/kdebug.areas
  File ${prefix}/share/config/kdebugrc

  SetOutPath "$INSTDIR\share\config\ui"

  File ${prefix}/share/config/ui/ui_standards.rc

  SetOutPath "$INSTDIR\share\kde4\services\kded"

  File ${prefix}/share/kde4/services/kded/kdedglobalaccel.desktop

  SetOutPath "$INSTDIR\share\kde4\servicetypes"

  File ${prefix}/share/kde4/servicetypes/kconfigbackend.desktop
  File ${prefix}/share/kde4/servicetypes/kplugininfo.desktop
  File ${prefix}/share/kde4/servicetypes/sonnetspeller.desktop

  SetOutPath "$INSTDIR\share\locale"

  File ${prefix}/share/locale/all_languages

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"

  File ${prefix}/share/locale/de/LC_MESSAGES/akonaditray.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/akregator.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/desktop_kdepim.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/desktop_kdepimlibs.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc2mutt.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc_dir.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc_file.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc_ldapkio.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc_net.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc_slox.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabcakonadi.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabcclient.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabcformat_binary.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kaddressbook.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kalarm.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcmkabconfig.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcmkontactnt.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdepimresources.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdepimwizards.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdgantt1.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kfile_vcf.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_groupwise.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_imap4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_ldap.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_mbox.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_nntp.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_pop3.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_sieve.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_smtp.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kitchensync.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kjots.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kleopatra.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kmail.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kmail_text_calendar_plugin.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kmail_text_vcard_plugin.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kmail_text_xdiff_plugin.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kmailcvt.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kmobiletools.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kmobiletools_at_engine.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/knode.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/knotes.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kode.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/konsolekalendar.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kontact.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kontactinterfaces.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/korganizer.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/korn.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kpilot.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_birthday.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_blog.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_featureplan.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_groupware.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_groupwise.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_kolab.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_remote.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_scalix.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_tvanytime.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kres_xmlrpc.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/ktexteditorkabcbridge_plugin.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/ktimetracker.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/ktnef.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kwatchgnupg.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kxforms.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libakonadi.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkblog.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkcal.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkdepim.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkholidays.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkldap.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkleopatra.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkmime.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkpgp.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkpimidentities.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkpimutils.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkresources.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libksieve.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libktnef.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkxmlrpcclient.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libmailtransport.mo

  File ${prefix}/share/locale/de/LC_MESSAGES/desktop_kdelibs.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/desktop_l10n.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/katepart4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcertpart.mo
  #File ${prefix}/share/locale/de/LC_MESSAGES/kcm_phonon.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcmcrypto.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdelibs4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdelibs_colors4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdeqt.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kfileaudiopreview4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_help4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/ktexteditor_plugins.mo
  #File ${prefix}/share/locale/de/LC_MESSAGES/libphonon.mo
  #File ${prefix}/share/locale/de/LC_MESSAGES/phonon_kde.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/timezones4.mo



!endif
${MementoSectionEnd}


LangString DESC_SEC_kleopatra ${LANG_ENGLISH} \
   "Keymanager for OpenPGP and X.509 and common crypto dialogs."


LangString DESC_Menu_kleopatra ${LANG_ENGLISH} \
   "Run the Kleopatra key management tool."

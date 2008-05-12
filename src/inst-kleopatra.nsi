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
  File ${prefix}/lib/kde4/kcm_kleopatra.dll

  SetOutPath "$INSTDIR\share\applications\kde4"

  File ${prefix}/share/applications/kde4/kleopatra_import.desktop

  SetOutPath "$INSTDIR\share\apps\kleopatra"

  File ${prefix}/share/apps/kleopatra/kleopatra.rc

  SetOutPath "$INSTDIR\share\apps\kleopatra\pics"

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
  File ${prefix}/share/apps/libkleopatra/pics/key.png
  File ${prefix}/share/apps/libkleopatra/pics/key_bad.png
  File ${prefix}/share/apps/libkleopatra/pics/key_ok.png
  File ${prefix}/share/apps/libkleopatra/pics/key_unknown.png

  SetOutPath "$INSTDIR\share\config"

  File ${prefix}/share/config/libkleopatrarc

  SetOutPath "$INSTDIR\share\icons\oxygen\128x128\apps"

  File ${prefix}/share/icons/oxygen/128x128/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\apps"

  File ${prefix}/share/icons/oxygen/16x16/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\apps"

  File ${prefix}/share/icons/oxygen/22x22/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\apps"

  File ${prefix}/share/icons/oxygen/32x32/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\48x48\apps"

  File ${prefix}/share/icons/oxygen/48x48/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\64x64\apps"

  File ${prefix}/share/icons/oxygen/64x64/apps/kleopatra.png

  SetOutPath "$INSTDIR\share\icons\oxygen\scalable\apps"

  File ${prefix}/share/icons/oxygen/scalable/apps/kleopatra.svgz

  # FIXME: The kcm .desktop files belong to share/kde4/services
  # actually, but are not found if installed there.
  SetOutPath "$INSTDIR\share\applications\kde4"

  File ${prefix}/share/kde4/services/kleopatra_config_appear.desktop
  File ${prefix}/share/kde4/services/kleopatra_config_dirserv.desktop
  File ${prefix}/share/kde4/services/kleopatra_config_dnorder.desktop
  File ${prefix}/share/kde4/services/kleopatra_config_smimevalidation.desktop

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"

  File ${prefix}/share/locale/de/LC_MESSAGES/akregator.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/desktop_kdelibs.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/desktop_kdepim.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/desktop_l10n.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc2mutt.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabc_slox.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabcakonadi.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kabcclient.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kaddressbook.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kalarm.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/katepart4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcertpart.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcm_phonon.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcmcrypto.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcmkabconfig.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kcmkontactnt.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdelibs4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdelibs_colors4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdepimresources.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdepimwizards.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kdgantt1.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kfile_vcf.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kfileaudiopreview4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_groupwise.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kio_help4.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kitchensync.mo
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
  File ${prefix}/share/locale/de/LC_MESSAGES/ktexteditor_plugins.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/ktexteditorkabcbridge_plugin.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/ktimetracker.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/ktnef.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kwatchgnupg.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/kxforms.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libakonadi.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkdepim.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkholidays.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkleopatra.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libkpgp.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libksieve.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/libphonon.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/phonon_kde.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/timezones4.mo

  SetOutPath "$INSTDIR\share\locale\de"

  File ${prefix}/share/locale/de/entry.desktop

!endif
${MementoSectionEnd}


LangString DESC_SEC_kleopatra ${LANG_ENGLISH} \
   "Kleopatra"

LangString DESC_Menu_kleopatra ${LANG_ENGLISH} \
   "Run the Kleopatra key management tool."

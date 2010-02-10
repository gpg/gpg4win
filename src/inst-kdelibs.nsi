# inst-kdelibs.nsi - Installer snippet for kdelibs.      -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/kdelibs-${gpg4win_pkg_kdelibs_version}

!ifdef DEBUG
Section "kdelibs" SEC_kdelibs
!else
Section "-kdelibs" SEC_kdelibs
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_kdelibs_src}"
!else

  # Relocate this when dbus-daemon is relocated.
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/kcmdwrapper.exe
  File ${prefix}/bin/kbuildsycoca4.exe
  SetOutPath "$INSTDIR"

  File ${prefix}/bin/libgpgme++-glib.dll
  File ${prefix}/bin/libgpgme++.dll
  File ${prefix}/bin/libkdecore.dll
  File ${prefix}/bin/libkdeui.dll
  File ${prefix}/bin/libkmime.dll
  File ${prefix}/bin/libqgpgme.dll
  File ${prefix}/lib/libkcmutils.dll
  File ${prefix}/lib/kde4/kded_globalaccel.dll

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
SectionEnd

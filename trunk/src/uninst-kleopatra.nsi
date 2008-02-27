# uninst-kleopatra.nsi - Installer snippet for kleopatra.    -*- coding: latin-1; -*-
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


; Uninstaller section.
Section "-un.kleopatra"
!ifdef SOURCES
  Push "${gpg4win_pkg_kleopatra_src}"
  Call un.SourceDelete
!else

  # FIXME: See inst-kleopatra.nsi
  Delete "$INSTDIR\bin\kleopatra.exe"
  RMDir "$INSTDIR\bin"
  Delete "$INSTDIR\kleopatra.exe"

  # FIXME: See inst-kleopatra.nsi

  Delete "$INSTDIR\share\kde4\applications\kleopatra_config_smimevalidation.desktop"
  Delete "$INSTDIR\share\applications\kde4\kleopatra_config_dnorder.desktop"
  Delete "$INSTDIR\share\applications\kde4\kleopatra_config_dirserv.desktop"
  Delete "$INSTDIR\share\applications\kde4\kleopatra_config_appear.desktop"

  Delete "$INSTDIR\kcm_kleopatra.dll"
  Delete "$INSTDIR\libkleo.dll"
  Delete "$INSTDIR\kgpgconf.exe"

  Delete "$INSTDIR\share\locale\de\entry.desktop"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\timezones4.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\phonon_kde.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\libphonon.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\libksieve.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\libkpgp.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\libkleopatra.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\libkholidays.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\libkdepim.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\libakonadi.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kxforms.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kwatchgnupg.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\ktnef.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\ktimetracker.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\ktexteditorkabcbridge_plugin.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\ktexteditor_plugins.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_xmlrpc.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_tvanytime.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_scalix.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_remote.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_kolab.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_groupwise.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_groupware.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_featureplan.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_blog.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kres_birthday.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kpilot.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\korn.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\korganizer.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kontact.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\konsolekalendar.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kode.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\knotes.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\knode.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kmobiletools_at_engine.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kmobiletools.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kmailcvt.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kmail_text_xdiff_plugin.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kmail_text_vcard_plugin.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kmail_text_calendar_plugin.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kmail.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kleopatra.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kitchensync.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kio_help4.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kio_groupwise.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kio4.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kfileaudiopreview4.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kfile_vcf.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kdgantt1.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kdepimwizards.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kdepimresources.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kdelibs_colors4.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kdelibs4.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kcmkontactnt.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kcmkabconfig.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kcmcrypto.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kcm_phonon.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kcertpart.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\katepart4.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kalarm.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kaddressbook.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kabcclient.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kabcakonadi.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kabc_slox.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\kabc2mutt.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\desktop_l10n.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\desktop_kdepim.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\desktop_kdelibs.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\akregator.mo"
  Delete "$INSTDIR\share\icons\oxygen\scalable\apps\kleopatra.svgz"
  Delete "$INSTDIR\share\icons\oxygen\64x64\apps\kleopatra.png"
  Delete "$INSTDIR\share\icons\oxygen\48x48\apps\kleopatra.png"
  Delete "$INSTDIR\share\icons\oxygen\32x32\apps\kleopatra.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\apps\kleopatra.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\apps\kleopatra.png"
  Delete "$INSTDIR\share\icons\oxygen\128x128\apps\kleopatra.png"
  Delete "$INSTDIR\share\config\libkleopatrarc"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\key_unknown.png"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\key_ok.png"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\key_bad.png"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\key.png"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\chiasmus_chi.png"
  Delete "$INSTDIR\share\apps\kleopatra\pics\kleopatra_wizard.svgz"
  Delete "$INSTDIR\share\apps\kleopatra\pics\kleopatra_wizard.png"
  Delete "$INSTDIR\share\apps\kleopatra\pics\kleopatra_splashscreen.svgz"
  Delete "$INSTDIR\share\apps\kleopatra\pics\kleopatra_splashscreen.png"
  Delete "$INSTDIR\share\apps\kleopatra\kleopatraui.rc"
  Delete "$INSTDIR\share\apps\kleopatra\kleopatra_newui.rc"
  Delete "$INSTDIR\share\applications\kde4\kleopatra_import.desktop"

  RMDir "$INSTDIR\share\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\de"
  RMDir "$INSTDIR\share\locale"
  RMDir "$INSTDIR\share\icons\oxygen\scalable\apps"
  RMDir "$INSTDIR\share\icons\oxygen\scalable"
  RMDir "$INSTDIR\share\icons\oxygen\64x64\apps"
  RMDir "$INSTDIR\share\icons\oxygen\64x64"
  RMDir "$INSTDIR\share\icons\oxygen\48x48\apps"
  RMDir "$INSTDIR\share\icons\oxygen\48x48"
  RMDir "$INSTDIR\share\icons\oxygen\32x32\apps"
  RMDir "$INSTDIR\share\icons\oxygen\32x32"
  RMDir "$INSTDIR\share\icons\oxygen\22x22\apps"
  RMDir "$INSTDIR\share\icons\oxygen\22x22"
  RMDir "$INSTDIR\share\icons\oxygen\16x16\apps"
  RMDir "$INSTDIR\share\icons\oxygen\16x16"
  RMDir "$INSTDIR\share\icons\oxygen\128x128\apps"
  RMDir "$INSTDIR\share\icons\oxygen\128x128"
  RMDir "$INSTDIR\share\icons\oxygen"
  RMDir "$INSTDIR\share\icons"
  RMDir "$INSTDIR\share\config"
  RMDir "$INSTDIR\share\apps\libkleopatra\pics"
  RMDir "$INSTDIR\share\apps\libkleopatra"
  RMDir "$INSTDIR\share\apps\kleopatra\pics"
  RMDir "$INSTDIR\share\apps\kleopatra"
  RMDir "$INSTDIR\share\apps"
  RMDir "$INSTDIR\share\applications\kde4"
  RMDir "$INSTDIR\share\applications"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR\lib\kde4"
  RMDir "$INSTDIR"

!endif
SectionEnd

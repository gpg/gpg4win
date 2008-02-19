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
  File ${prefix}/lib/libgpgme++-glib.dll
  File ${prefix}/lib/libgpgme++-qt.dll
  File ${prefix}/lib/libgpgme++.dll
  File ${prefix}/bin/libqgpgme.dll
  File ${prefix}/bin/libkmime.dll
  File ${prefix}/bin/libkleo.dll

  SetOutPath "$INSTDIR\share\applications\kde4"

  File ${prefix}/share/applications/kde4/kleopatra_import.desktop

  SetOutPath "$INSTDIR\share\apps\kleopatra"

  File ${prefix}/share/apps/kleopatra/kleopatra_newui.rc
  File ${prefix}/share/apps/kleopatra/kleopatraui.rc

  SetOutPath "$INSTDIR\share\apps\kleopatra\pics"

  File ${prefix}/share/apps/kleopatra/pics/kleopatra_splashscreen.png
  File ${prefix}/share/apps/kleopatra/pics/kleopatra_splashscreen.svgz
  File ${prefix}/share/apps/kleopatra/pics/kleopatra_wizard.png
  File ${prefix}/share/apps/kleopatra/pics/kleopatra_wizard.svgz

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

!endif
${MementoSectionEnd}


LangString DESC_SEC_kleopatra ${LANG_ENGLISH} \
   "Kleopatra"

LangString DESC_Menu_kleopatra ${LANG_ENGLISH} \
   "Run the Kleopatra key management tool."

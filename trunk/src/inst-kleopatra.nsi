# inst-kleopatra.nsi - Installer snippet for kleopatra.      -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007 g10 Code GmbH
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

Section "Kleopatra" SEC_kleopatra
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_kleopatra_src}"
!else

  # Relocate this when dbus-daemon is relocated.
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/kleopatra.exe
  SetOutPath "$INSTDIR"
  File ${SRCDIR}/kleopatra.bat

  File ${prefix}/lib/libgpgme++-glib.dll
  File ${prefix}/lib/libgpgme++-qt.dll
  File ${prefix}/lib/libgpgme++.dll
  File ${prefix}/bin/libqgpgme.dll
  File ${prefix}/bin/libkmime.dll
  File ${prefix}/bin/libkleo.dll

  SetOutPath "$INSTDIR\lib\kde4"

  SetOutPath "$INSTDIR\share\applications\kde4"

  File ${prefix}/share/applications/kde4/kleopatra_import.desktop

  SetOutPath "$INSTDIR\share\apps\kleopatra"

  File ${prefix}/share/apps/kleopatra/kleopatraui.rc

  SetOutPath "$INSTDIR\share\apps\libkleopatra\pics"

  File ${prefix}/share/apps/libkleopatra/pics/chiasmus_chi.png
  File ${prefix}/share/apps/libkleopatra/pics/key.png
  File ${prefix}/share/apps/libkleopatra/pics/key_bad.png
  File ${prefix}/share/apps/libkleopatra/pics/key_ok.png
  File ${prefix}/share/apps/libkleopatra/pics/key_unknown.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\apps"

  File ${prefix}/share/icons/oxygen/16x16/apps/gpg.png
  File ${prefix}/share/icons/oxygen/16x16/apps/gpgsm.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\apps"

  File ${prefix}/share/icons/oxygen/22x22/apps/gpg.png
  File ${prefix}/share/icons/oxygen/22x22/apps/gpgsm.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\apps"

  File ${prefix}/share/icons/oxygen/32x32/apps/gpg.png
  File ${prefix}/share/icons/oxygen/32x32/apps/gpgsm.png

!endif
SectionEnd


LangString DESC_SEC_kleopatra ${LANG_ENGLISH} \
   "Kleopatra"

LangString DESC_Menu_kleopatra ${LANG_ENGLISH} \
   "Run the Kleopatra key management tool."

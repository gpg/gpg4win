# uninst-kleopatra.nsi - Installer snippet for kleopatra.    -*- coding: latin-1; -*-
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


; Uninstaller section.
Section "-un.kleopatra"
!ifdef SOURCES
  Push "${gpg4win_pkg_kleopatra_src}"
  Call un.SourceDelete
!else

  Delete "$INSTDIR\kleopatra.exe"
  Delete "$INSTDIR\test_uiserver.exe"
  Delete "$INSTDIR\libgpgme++-glib.dll"
  Delete "$INSTDIR\libgpgme++-qt.dll"
  Delete "$INSTDIR\libgpgme++.dll"
  Delete "$INSTDIR\libkleo.dll"
  Delete "$INSTDIR\libqgpgme.dll"

  Delete "$INSTDIR\share\applications\kde4\kleopatra_import.desktop"

  RMDir "$INSTDIR\share\applications\kde4"
  RMDir "$INSTDIR\share\applications"

  Delete "$INSTDIR\share\apps\kleopatra\kleopatraui.rc"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\chiasmus_chi.png"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\key.png"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\key_bad.png"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\key_ok.png"
  Delete "$INSTDIR\share\apps\libkleopatra\pics\key_unknown.png"

  RMDir "$INSTDIR\share\apps\libkleopatra\pics"
  RMDir "$INSTDIR\share\apps\libkleopatra"
  RMDir "$INSTDIR\share\apps"

  Delete "$INSTDIR\share\icons\oxygen\16x16\apps\gpg.png"
  Delete "$INSTDIR\share\icons\oxygen\16x16\apps\gpgsm.png"

  RMDir "$INSTDIR\share\icons\oxygen\16x16\apps"
  RMDir "$INSTDIR\share\icons\oxygen\16x16"

  Delete "$INSTDIR\share\icons\oxygen\22x22\apps\gpg.png"
  Delete "$INSTDIR\share\icons\oxygen\22x22\apps\gpgsm.png"

  RMDir "$INSTDIR\share\icons\oxygen\22x22\apps"
  RMDir "$INSTDIR\share\icons\oxygen\22x22"

  Delete "$INSTDIR\share\icons\oxygen\32x32\apps\gpg.png"
  Delete "$INSTDIR\share\icons\oxygen\32x32\apps\gpgsm.png"

  RMDir "$INSTDIR\share\icons\oxygen\32x32\apps"
  RMDir "$INSTDIR\share\icons\oxygen\32x32"
  RMDir "$INSTDIR\share\icons\oxygen"
  RMDir "$INSTDIR\share\icons"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"

!endif
SectionEnd

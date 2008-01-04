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

  # FIXME: See inst-kleopatra.nsi
  Delete "$INSTDIR\bin\kleopatra.exe"
  RMDir "$INSTDIR\bin"
  Delete "$INSTDIR\kleopatra.bat"

  Delete "$INSTDIR\kgpgconf.exe"
  Delete "$INSTDIR\libgpgme++-glib.dll"
  Delete "$INSTDIR\libgpgme++-qt.dll"
  Delete "$INSTDIR\libgpgme++.dll"
  Delete "$INSTDIR\libqgpgme.dll"
  Delete "$INSTDIR\libkmime.dll"
  Delete "$INSTDIR\libkleo.dll"

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

  RMDir "$INSTDIR\share\config"
  RMDir "$INSTDIR\share\apps\libkleopatra\pics"
  RMDir "$INSTDIR\share\apps\libkleopatra"
  RMDir "$INSTDIR\share\apps\kleopatra\pics"
  RMDir "$INSTDIR\share\apps\kleopatra"
  RMDir "$INSTDIR\share\apps"
  RMDir "$INSTDIR\share\applications\kde4"
  RMDir "$INSTDIR\share\applications"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"

!endif
SectionEnd

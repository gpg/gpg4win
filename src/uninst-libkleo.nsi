# Copyright (C) 2015 Intevation GmbH
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
!define prefix ${ipdir}/libkleo-${gpg4win_pkg_libkleo_version}

; Uninstaller section.
Section "-un.libkleo"
!ifdef SOURCES
  Push "${gpg4win_pkg_libkleo}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\etc\xdg\libkleopatrarc"
  RmDir "$INSTDIR\etc\xdg"
  RmDir "$INSTDIR\etc"

  Delete "$INSTDIR\bin\libKF5Libkleo.dll"
  RmDir "$INSTDIR\bin"

  Delete "$INSTDIR\share\libkleopatra\pics\chiasmus_chi.png"
  Delete "$INSTDIR\share\libkleopatra\pics\hi16-app-gpg.png"
  Delete "$INSTDIR\share\libkleopatra\pics\hi16-app-gpgsm.png"
  Delete "$INSTDIR\share\libkleopatra\pics\hi22-app-gpg.png"
  Delete "$INSTDIR\share\libkleopatra\pics\hi22-app-gpgsm.png"
  Delete "$INSTDIR\share\libkleopatra\pics\hi32-app-gpg.png"
  Delete "$INSTDIR\share\libkleopatra\pics\hi32-app-gpgsm.png"
  Delete "$INSTDIR\share\libkleopatra\pics\key_bad.png"
  Delete "$INSTDIR\share\libkleopatra\pics\key_ok.png"
  Delete "$INSTDIR\share\libkleopatra\pics\key.png"
  Delete "$INSTDIR\share\libkleopatra\pics\key_unknown.png"
  Delete "$INSTDIR\share\libkleopatra\pics\smartcard.xpm"
  RmDir "$INSTDIR\share\libkleopatra\pics"
  RmDir "$INSTDIR\share\libkleopatra"
  RmDir "$INSTDIR\share"

!endif
SectionEnd

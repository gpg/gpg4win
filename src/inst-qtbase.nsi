# inst-qtbase.nsi - Installer snippet for qt.     -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007, 2008 g10 Code GmbH
#               2015 Intevation GmbH
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
!define prefix ${ipdir}/qtbase-${gpg4win_pkg_qtbase_version}

!ifdef DEBUG
Section "qtbase" SEC_qtbase
!else
Section "-qtbase" SEC_qtbase
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_qtbase}"
!else
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/Qt5Core.dll
  File ${prefix}/bin/Qt5Gui.dll
  File ${prefix}/bin/Qt5Widgets.dll
  File ${prefix}/bin/Qt5Network.dll
  File ${prefix}/bin/Qt5PrintSupport.dll
  File ${prefix}/bin/Qt5Xml.dll

  push $1
  FileOpen $1 "$INSTDIR\bin\qt.conf" "w"
  FileWrite $1 '[StandardPaths]$\r$\n'
  FileWrite $1 'GenericConfigLocation=%APPDATA%/kleopatra$\r$\n'
  FileWrite $1 'GenericDataLocation=%APPDATA%/kleopatra$\r$\n'
  FileClose $1
  pop $1

  SetOutPath "$INSTDIR\bin\platforms"
  File ${prefix}/plugins/platforms/qwindows.dll

  SetOutPath "$INSTDIR\bin\printsupport"
  File ${prefix}/plugins/printsupport/windowsprintersupport.dll

  SetOutPath "$INSTDIR\bin\styles"
  File ${prefix}/plugins/styles/qwindowsvistastyle.dll

!endif
SectionEnd

# uninst-qt.nsi - Installer snippet for qt.    -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/qt-${gpg4win_pkg_qt_version}


; Uninstaller section.
Section "-un.qt"
!ifdef SOURCES
  Push "${gpg4win_pkg_qt_src}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\qt.conf"

  Delete "$INSTDIR\qdbus.exe"

  Delete "$INSTDIR\QtCore4.dll"
  Delete "$INSTDIR\QtDBus4.dll"
  Delete "$INSTDIR\QtGui4.dll"
  Delete "$INSTDIR\QtNetwork4.dll"
  Delete "$INSTDIR\QtSvg4.dll"
  Delete "$INSTDIR\QtXml4.dll"

  Delete "$INSTDIR\plugins\imageformats\qgif4.dll"
  Delete "$INSTDIR\plugins\imageformats\qico4.dll"
  Delete "$INSTDIR\plugins\imageformats\qjpeg4.dll"
  Delete "$INSTDIR\plugins\imageformats\qmng4.dll"
  Delete "$INSTDIR\plugins\imageformats\qsvg4.dll"
  Delete "$INSTDIR\plugins\imageformats\qtiff4.dll"

  RMDir "$INSTDIR\plugins\imageformats"

  RMDir  "$INSTDIR\plugins"

  RMDir "$INSTDIR"
!endif
SectionEnd

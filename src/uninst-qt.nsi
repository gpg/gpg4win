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

  # Files installed by previous versions
  Delete "$INSTDIR\mingwm10.dll"
  Delete "$INSTDIR\Qt3Support4.dll"
  Delete "$INSTDIR\QtHelp4.dll"
  Delete "$INSTDIR\QtOpenGL4.dll"
  Delete "$INSTDIR\QtScript4.dll"
  Delete "$INSTDIR\QtSql4.dll"
  Delete "$INSTDIR\translations\assistant_adp_de.qm"
  Delete "$INSTDIR\translations\assistant_de.qm"
  Delete "$INSTDIR\translations\designer_de.qm"
  Delete "$INSTDIR\translations\linguist_de.qm"
  Delete "$INSTDIR\translations\qt_de.qm"
  Delete "$INSTDIR\translations\qt_help_de.qm"

  Delete "$INSTDIR\plugins\accessible\qtaccessiblecompatwidgets4.dll"
  Delete "$INSTDIR\plugins\accessible\qtaccessiblewidgets4.dll"

  RMDir "$INSTDIR\plugins\accessible"

  Delete "$INSTDIR\plugins\codecs\qcncodecs4.dll"
  Delete "$INSTDIR\plugins\codecs\qjpcodecs4.dll"
  Delete "$INSTDIR\plugins\codecs\qkrcodecs4.dll"
  Delete "$INSTDIR\plugins\codecs\qtwcodecs4.dll"

  RMDir "$INSTDIR\plugins\codecs"

  Delete "$INSTDIR\plugins\designer\qwebview.dll"
  Delete "$INSTDIR\plugins\designer\qt3supportwidgets.dll"
  # Not in Qt anymore since 4.3.3.
  Delete "$INSTDIR\plugins\designer\arthurplugin.dll"
  Delete "$INSTDIR\plugins\designer\containerextension.dll"
  Delete "$INSTDIR\plugins\designer\customwidgetplugin.dll"
  Delete "$INSTDIR\plugins\designer\taskmenuextension.dll"
  Delete "$INSTDIR\plugins\designer\worldtimeclockplugin.dll"

  RMDir "$INSTDIR\plugins\designer"

  Delete "$INSTDIR\plugins\iconengines\qsvg4.dll"
  Delete "$INSTDIR\plugins\iconengines\qsvgicon4.dll"

  RMDir "$INSTDIR\plugins\iconengines"

  Delete "$INSTDIR\plugins\script\qtscriptdbus4.dll"
  RMDir "$INSTDIR\plugins\script"

  Delete "$INSTDIR\plugins\sqldrivers\qsqlite4.dll"
  RMDir  "$INSTDIR\plugins\sqldrivers"


  RMDir "$INSTDIR\translations"

  RMDir "$INSTDIR\plugins\imageformats"

  RMDir  "$INSTDIR\plugins"

  RMDir "$INSTDIR"
!endif
SectionEnd

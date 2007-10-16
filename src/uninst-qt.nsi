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
  Delete "$INSTDIR\mingwm10.dll"
  Delete "$INSTDIR\qt.conf"

  Delete "$INSTDIR\Qt3Support4.dll"
  Delete "$INSTDIR\QtAssistantClient4.dll"
  Delete "$INSTDIR\QtCore4.dll"
  Delete "$INSTDIR\QtDBus4.dll"
  Delete "$INSTDIR\QtDesigner4.dll"
  Delete "$INSTDIR\QtDesignerComponents4.dll"
  Delete "$INSTDIR\QtGui4.dll"
  Delete "$INSTDIR\QtNetwork4.dll"
  Delete "$INSTDIR\QtOpenGL4.dll"
  Delete "$INSTDIR\QtScript4.dll"
  Delete "$INSTDIR\QtSql4.dll"
  Delete "$INSTDIR\QtSvg4.dll"
  Delete "$INSTDIR\QtTest4.dll"
  Delete "$INSTDIR\QtXml4.dll"

  Delete "$INSTDIR\plugins\accessible\qtaccessiblecompatwidgets4.dll"
  Delete "$INSTDIR\plugins\accessible\qtaccessiblewidgets4.dll"

  RMDir "$INSTDIR\plugins\accessible"

  Delete "$INSTDIR\plugins\codecs\qcncodecs4.dll"
  Delete "$INSTDIR\plugins\codecs\qjpcodecs4.dll"
  Delete "$INSTDIR\plugins\codecs\qkrcodecs4.dll"
  Delete "$INSTDIR\plugins\codecs\qtwcodecs4.dll"

  RMDir "$INSTDIR\plugins\codecs"

  Delete "$INSTDIR\plugins\designer\arthurplugin.dll"
  Delete "$INSTDIR\plugins\designer\containerextension.dll"
  Delete "$INSTDIR\plugins\designer\customwidgetplugin.dll"
  Delete "$INSTDIR\plugins\designer\qt3supportwidgets.dll"
  Delete "$INSTDIR\plugins\designer\taskmenuextension.dll"
  Delete "$INSTDIR\plugins\designer\worldtimeclockplugin.dll"

  RMDir "$INSTDIR\plugins\designer"

  Delete "$INSTDIR\plugins\iconengines\qsvg4.dll"

  RMDir "$INSTDIR\plugins\iconengines"

  Delete "$INSTDIR\plugins\imageformats\qgif4.dll"
  Delete "$INSTDIR\plugins\imageformats\qjpeg4.dll"
  Delete "$INSTDIR\plugins\imageformats\qmng4.dll"
  Delete "$INSTDIR\plugins\imageformats\qsvg4.dll"
  Delete "$INSTDIR\plugins\imageformats\qtiff4.dll"

  RMDir "$INSTDIR\plugins\imageformats"

  Delete "$INSTDIR\plugins\sqldrivers\qsqlite4.dll"

  RMDir "$INSTDIR\plugins\sqldrivers"
  RMDir "$INSTDIR\plugins"

  Delete "$INSTDIR\translations\assistant_de.qm"
#  Delete "$INSTDIR\translations\assistant_ja.qm"
  Delete "$INSTDIR\translations\designer_de.qm"
#  Delete "$INSTDIR\translations\designer_ja.qm"
#  Delete "$INSTDIR\translations\linguist_ja.qm"
#  Delete "$INSTDIR\translations\qt_ar.qm"
  Delete "$INSTDIR\translations\qt_de.qm"
#  Delete "$INSTDIR\translations\qt_es.qm"
#  Delete "$INSTDIR\translations\qt_fr.qm"
#  Delete "$INSTDIR\translations\qt_iw.qm"
#  Delete "$INSTDIR\translations\qt_ja_jp.qm"
#  Delete "$INSTDIR\translations\qt_pt.qm"
#  Delete "$INSTDIR\translations\qt_ru.qm"
#  Delete "$INSTDIR\translations\qt_sk.qm"
#  Delete "$INSTDIR\translations\qt_sv.qm"
#  Delete "$INSTDIR\translations\qt_uk.qm"
#  Delete "$INSTDIR\translations\qt_zh_CN.qm"

  RMDir "$INSTDIR\translations"

  RMDir "$INSTDIR"
!endif
SectionEnd

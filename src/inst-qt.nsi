# inst-qt.nsi - Installer snippet for qt.      -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/qt-${gpg4win_pkg_qt_version}

!ifdef DEBUG
Section "qt" SEC_qt
!else
Section "-qt" SEC_qt
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_qt_src}"
!else
  # Qt needs some help to find itself.
  File ${SRCDIR}/qt.conf
  # Qt uses -mthreads, so install the support library.
  File ${BUILD_DIR}/mingwm10.dll

  File ${prefix}/bin/Qt3Support4.dll
  File ${prefix}/bin/QtCore4.dll
  File ${prefix}/bin/QtDBus4.dll
  File ${prefix}/bin/QtGui4.dll
  File ${prefix}/bin/QtHelp4.dll
  File ${prefix}/bin/QtNetwork4.dll
  File ${prefix}/bin/QtOpenGL4.dll
  File ${prefix}/bin/QtScript4.dll
  File ${prefix}/bin/QtSql4.dll
  File ${prefix}/bin/QtSvg4.dll
  File ${prefix}/bin/QtXml4.dll

  SetOutPath "$INSTDIR\plugins\accessible"

  File ${prefix}/plugins/accessible/qtaccessiblecompatwidgets4.dll
  File ${prefix}/plugins/accessible/qtaccessiblewidgets4.dll

  SetOutPath "$INSTDIR\plugins\codecs"

  File ${prefix}/plugins/codecs/qcncodecs4.dll
  File ${prefix}/plugins/codecs/qjpcodecs4.dll
  File ${prefix}/plugins/codecs/qkrcodecs4.dll
  File ${prefix}/plugins/codecs/qtwcodecs4.dll

  SetOutPath "$INSTDIR\plugins\designer"

  File ${prefix}/plugins/designer/qt3supportwidgets.dll
  File ${prefix}/plugins/designer/qwebview.dll

  SetOutPath "$INSTDIR\plugins\iconengines"

  File ${prefix}/plugins/iconengines/qsvgicon4.dll

  SetOutPath "$INSTDIR\plugins\imageformats"

  File ${prefix}/plugins/imageformats/qgif4.dll
  File ${prefix}/plugins/imageformats/qico4.dll
  File ${prefix}/plugins/imageformats/qjpeg4.dll
  File ${prefix}/plugins/imageformats/qmng4.dll
  File ${prefix}/plugins/imageformats/qsvg4.dll
  File ${prefix}/plugins/imageformats/qtiff4.dll

  SetOutPath "$INSTDIR\plugins\script"

  File ${prefix}/plugins/script/qtscriptdbus4.dll

  SetOutPath "$INSTDIR\plugins\sqldrivers"

  File ${prefix}/plugins/sqldrivers/qsqlite4.dll

  SetOutPath "$INSTDIR\translations"

  File ${prefix}/translations/assistant_adp_de.qm
#  File ${prefix}/translations/assistant_adp_ja.qm
#  File ${prefix}/translations/assistant_adp_pl.qm
#  File ${prefix}/translations/assistant_adp_zh_CN.qm
#  File ${prefix}/translations/assistant_adp_zh_TW.qm
  File ${prefix}/translations/assistant_de.qm
#  File ${prefix}/translations/assistant_pl.qm
#  File ${prefix}/translations/assistant_zh_CN.qm
#  File ${prefix}/translations/assistant_zh_TW.qm
  File ${prefix}/translations/designer_de.qm
#  File ${prefix}/translations/designer_ja.qm
#  File ${prefix}/translations/designer_pl.qm
#  File ${prefix}/translations/designer_zh_CN.qm
#  File ${prefix}/translations/designer_zh_TW.qm
  File ${prefix}/translations/linguist_de.qm
#  File ${prefix}/translations/linguist_ja.qm
#  File ${prefix}/translations/linguist_pl.qm
#  File ${prefix}/translations/linguist_zh_CN.qm
#  File ${prefix}/translations/linguist_zh_TW.qm
#  File ${prefix}/translations/qt_ar.qm
  File ${prefix}/translations/qt_de.qm
#  File ${prefix}/translations/qt_es.qm
#  File ${prefix}/translations/qt_fr.qm
  File ${prefix}/translations/qt_help_de.qm
#  File ${prefix}/translations/qt_help_pl.qm
#  File ${prefix}/translations/qt_help_zh_CN.qm
#  File ${prefix}/translations/qt_help_zh_TW.qm
#  File ${prefix}/translations/qt_iw.qm
#  File ${prefix}/translations/qt_ja_jp.qm
#  File ${prefix}/translations/qt_pl.qm
#  File ${prefix}/translations/qt_pt.qm
#  File ${prefix}/translations/qt_ru.qm
#  File ${prefix}/translations/qt_sk.qm
#  File ${prefix}/translations/qt_sv.qm
#  File ${prefix}/translations/qt_uk.qm
#  File ${prefix}/translations/qt_zh_CN.qm
#  File ${prefix}/translations/qt_zh_TW.qm
#  File ${prefix}/translations/qtconfig_pl.qm
#  File ${prefix}/translations/qtconfig_zh_CN.qm
#  File ${prefix}/translations/qvfb_pl.qm
#  File ${prefix}/translations/qvfb_zh_CN.qm
#  File ${prefix}/translations/qvfb_zh_TW.qm

  # FIXME: From the lib package.  This is wrong.
!undef prefix
!define prefix ${ipdir}/qt-dev-${gpg4win_pkg_qt_version}

  SetOutPath "$INSTDIR"
  File ${prefix}/bin/qdbus.exe

!endif
SectionEnd

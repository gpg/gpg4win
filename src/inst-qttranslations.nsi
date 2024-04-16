# Copyright (C) 2017 Intevation GmbH
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
!define prefix ${ipdir}/qttranslations-${gpg4win_pkg_qttranslations_version}

!ifdef DEBUG
Section "qttranslations" SEC_qttranslations
!else
Section "-qttranslations" SEC_qttranslations
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_qttranslations}"
!else
# Needs all the files included in the qt_$lang.qm which are as of
# qt 5.8.0 the files below.
  SetOutPath "$INSTDIR\bin\translations"
  File ${prefix}/translations/qt_ar.qm
  File ${prefix}/translations/qtbase_ca.qm
  File ${prefix}/translations/qtbase_cs.qm
  File ${prefix}/translations/qtbase_de.qm
  File ${prefix}/translations/qtbase_en.qm
  File ${prefix}/translations/qtbase_fi.qm
  File ${prefix}/translations/qtbase_fr.qm
  File ${prefix}/translations/qtbase_he.qm
  File ${prefix}/translations/qtbase_hu.qm
  File ${prefix}/translations/qtbase_it.qm
  File ${prefix}/translations/qtbase_ja.qm
  File ${prefix}/translations/qtbase_ko.qm
  File ${prefix}/translations/qtbase_lv.qm
  File ${prefix}/translations/qtbase_pl.qm
  File ${prefix}/translations/qtbase_ru.qm
  File ${prefix}/translations/qtbase_sk.qm
  File ${prefix}/translations/qtbase_uk.qm
  File ${prefix}/translations/qt_ca.qm
  File ${prefix}/translations/qt_cs.qm
  File ${prefix}/translations/qt_da.qm
  File ${prefix}/translations/qt_de.qm
  File ${prefix}/translations/qt_en.qm
  File ${prefix}/translations/qt_es.qm
  File ${prefix}/translations/qt_fa.qm
  File ${prefix}/translations/qt_fi.qm
  File ${prefix}/translations/qt_fr.qm
  File ${prefix}/translations/qt_gl.qm
  File ${prefix}/translations/qt_he.qm
  File ${prefix}/translations/qt_hu.qm
  File ${prefix}/translations/qt_it.qm
  File ${prefix}/translations/qt_ja.qm
  File ${prefix}/translations/qt_ko.qm
  File ${prefix}/translations/qt_lt.qm
  File ${prefix}/translations/qt_pl.qm
  File ${prefix}/translations/qt_pt_PT.qm
  File ${prefix}/translations/qt_pt_BR.qm
  File ${prefix}/translations/qt_ru.qm
  File ${prefix}/translations/qt_sk.qm
  File ${prefix}/translations/qt_sl.qm
  File ${prefix}/translations/qt_sv.qm
  File ${prefix}/translations/qt_uk.qm
  File ${prefix}/translations/qt_zh_CN.qm
  File ${prefix}/translations/qt_zh_TW.qm
!endif
SectionEnd

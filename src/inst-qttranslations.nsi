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
  File ${prefix}/qttranslations/qt_ar.qm
  File ${prefix}/qttranslations/qtbase_ca.qm
  File ${prefix}/qttranslations/qtbase_cs.qm
  File ${prefix}/qttranslations/qtbase_de.qm
  File ${prefix}/qttranslations/qtbase_en.qm
  File ${prefix}/qttranslations/qtbase_en.ts
  File ${prefix}/qttranslations/qtbase_fi.qm
  File ${prefix}/qttranslations/qtbase_fr.qm
  File ${prefix}/qttranslations/qtbase_he.qm
  File ${prefix}/qttranslations/qtbase_hu.qm
  File ${prefix}/qttranslations/qtbase_it.qm
  File ${prefix}/qttranslations/qtbase_ja.qm
  File ${prefix}/qttranslations/qtbase_ko.qm
  File ${prefix}/qttranslations/qtbase_lv.qm
  File ${prefix}/qttranslations/qtbase_pl.qm
  File ${prefix}/qttranslations/qtbase_ru.qm
  File ${prefix}/qttranslations/qtbase_sk.qm
  File ${prefix}/qttranslations/qtbase_uk.qm
  File ${prefix}/qttranslations/qt_ca.qm
  File ${prefix}/qttranslations/qt_cs.qm
  File ${prefix}/qttranslations/qt_da.qm
  File ${prefix}/qttranslations/qt_de.qm
  File ${prefix}/qttranslations/qt_en.qm
  File ${prefix}/qttranslations/qt_en.ts
  File ${prefix}/qttranslations/qt_es.qm
  File ${prefix}/qttranslations/qt_fa.qm
  File ${prefix}/qttranslations/qt_fi.qm
  File ${prefix}/qttranslations/qt_fr.qm
  File ${prefix}/qttranslations/qt_gl.qm
  File ${prefix}/qttranslations/qt_he.qm
  File ${prefix}/qttranslations/qt_hu.qm
  File ${prefix}/qttranslations/qt_it.qm
  File ${prefix}/qttranslations/qt_ja.qm
  File ${prefix}/qttranslations/qt_ko.qm
  File ${prefix}/qttranslations/qt_lt.qm
  File ${prefix}/qttranslations/qtmultimedia_ca.qm
  File ${prefix}/qttranslations/qtmultimedia_cs.qm
  File ${prefix}/qttranslations/qtmultimedia_de.qm
  File ${prefix}/qttranslations/qtmultimedia_en.qm
  File ${prefix}/qttranslations/qtmultimedia_fi.qm
  File ${prefix}/qttranslations/qtmultimedia_fr.qm
  File ${prefix}/qttranslations/qtmultimedia_hu.qm
  File ${prefix}/qttranslations/qtmultimedia_it.qm
  File ${prefix}/qttranslations/qtmultimedia_ja.qm
  File ${prefix}/qttranslations/qtmultimedia_ko.qm
  File ${prefix}/qttranslations/qtmultimedia_pl.qm
  File ${prefix}/qttranslations/qtmultimedia_ru.qm
  File ${prefix}/qttranslations/qtmultimedia_sk.qm
  File ${prefix}/qttranslations/qtmultimedia_uk.qm
  File ${prefix}/qttranslations/qt_pl.qm
  File ${prefix}/qttranslations/qt_pt.qm
  File ${prefix}/qttranslations/qtquick1_ca.qm
  File ${prefix}/qttranslations/qtquick1_cs.qm
  File ${prefix}/qttranslations/qtquick1_de.qm
  File ${prefix}/qttranslations/qtquick1_en.qm
  File ${prefix}/qttranslations/qtquick1_fi.qm
  File ${prefix}/qttranslations/qtquick1_fr.qm
  File ${prefix}/qttranslations/qtquick1_he.qm
  File ${prefix}/qttranslations/qtquick1_hu.qm
  File ${prefix}/qttranslations/qtquick1_it.qm
  File ${prefix}/qttranslations/qtquick1_ja.qm
  File ${prefix}/qttranslations/qtquick1_ko.qm
  File ${prefix}/qttranslations/qtquick1_pl.qm
  File ${prefix}/qttranslations/qtquick1_ru.qm
  File ${prefix}/qttranslations/qtquick1_sk.qm
  File ${prefix}/qttranslations/qtquick1_uk.qm
  File ${prefix}/qttranslations/qt_ru.qm
  File ${prefix}/qttranslations/qtscript_ca.qm
  File ${prefix}/qttranslations/qtscript_cs.qm
  File ${prefix}/qttranslations/qtscript_de.qm
  File ${prefix}/qttranslations/qtscript_en.qm
  File ${prefix}/qttranslations/qtscript_fi.qm
  File ${prefix}/qttranslations/qtscript_fr.qm
  File ${prefix}/qttranslations/qtscript_he.qm
  File ${prefix}/qttranslations/qtscript_hu.qm
  File ${prefix}/qttranslations/qtscript_it.qm
  File ${prefix}/qttranslations/qtscript_ja.qm
  File ${prefix}/qttranslations/qtscript_ko.qm
  File ${prefix}/qttranslations/qtscript_lv.qm
  File ${prefix}/qttranslations/qtscript_pl.qm
  File ${prefix}/qttranslations/qtscript_ru.qm
  File ${prefix}/qttranslations/qtscript_sk.qm
  File ${prefix}/qttranslations/qtscript_uk.qm
  File ${prefix}/qttranslations/qt_sk.qm
  File ${prefix}/qttranslations/qt_sl.qm
  File ${prefix}/qttranslations/qt_sv.qm
  File ${prefix}/qttranslations/qt_uk.qm
  File ${prefix}/qttranslations/qtxmlpatterns_ca.qm
  File ${prefix}/qttranslations/qtxmlpatterns_cs.qm
  File ${prefix}/qttranslations/qtxmlpatterns_de.qm
  File ${prefix}/qttranslations/qtxmlpatterns_en.qm
  File ${prefix}/qttranslations/qtxmlpatterns_fr.qm
  File ${prefix}/qttranslations/qtxmlpatterns_hu.qm
  File ${prefix}/qttranslations/qtxmlpatterns_it.qm
  File ${prefix}/qttranslations/qtxmlpatterns_ja.qm
  File ${prefix}/qttranslations/qtxmlpatterns_ko.qm
  File ${prefix}/qttranslations/qtxmlpatterns_pl.qm
  File ${prefix}/qttranslations/qtxmlpatterns_ru.qm
  File ${prefix}/qttranslations/qtxmlpatterns_sk.qm
  File ${prefix}/qttranslations/qtxmlpatterns_uk.qm
  File ${prefix}/qttranslations/qt_zh_CN.qm
  File ${prefix}/qttranslations/qt_zh_TW.qm
!endif
SectionEnd

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
!define prefix ${ipdir}/qtsvg-${gpg4win_pkg_qttranslations}

; Uninstaller section.
Section "-un.qttranslations"
!ifdef SOURCES
  Push "${gpg4win_pkg_qttranslations}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\bin\translations\qt_ar.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ca.qm"
  Delete "$INSTDIR\bin\translations\qtbase_cs.qm"
  Delete "$INSTDIR\bin\translations\qtbase_de.qm"
  Delete "$INSTDIR\bin\translations\qtbase_en.qm"
  Delete "$INSTDIR\bin\translations\qtbase_en.ts"
  Delete "$INSTDIR\bin\translations\qtbase_fi.qm"
  Delete "$INSTDIR\bin\translations\qtbase_fr.qm"
  Delete "$INSTDIR\bin\translations\qtbase_he.qm"
  Delete "$INSTDIR\bin\translations\qtbase_hu.qm"
  Delete "$INSTDIR\bin\translations\qtbase_it.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ja.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ko.qm"
  Delete "$INSTDIR\bin\translations\qtbase_lv.qm"
  Delete "$INSTDIR\bin\translations\qtbase_pl.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ru.qm"
  Delete "$INSTDIR\bin\translations\qtbase_sk.qm"
  Delete "$INSTDIR\bin\translations\qtbase_uk.qm"
  Delete "$INSTDIR\bin\translations\qt_ca.qm"
  Delete "$INSTDIR\bin\translations\qt_cs.qm"
  Delete "$INSTDIR\bin\translations\qt_da.qm"
  Delete "$INSTDIR\bin\translations\qt_de.qm"
  Delete "$INSTDIR\bin\translations\qt_en.qm"
  Delete "$INSTDIR\bin\translations\qt_en.ts"
  Delete "$INSTDIR\bin\translations\qt_es.qm"
  Delete "$INSTDIR\bin\translations\qt_fa.qm"
  Delete "$INSTDIR\bin\translations\qt_fi.qm"
  Delete "$INSTDIR\bin\translations\qt_fr.qm"
  Delete "$INSTDIR\bin\translations\qt_gl.qm"
  Delete "$INSTDIR\bin\translations\qt_he.qm"
  Delete "$INSTDIR\bin\translations\qt_hu.qm"
  Delete "$INSTDIR\bin\translations\qt_it.qm"
  Delete "$INSTDIR\bin\translations\qt_ja.qm"
  Delete "$INSTDIR\bin\translations\qt_ko.qm"
  Delete "$INSTDIR\bin\translations\qt_lt.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_ca.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_cs.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_de.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_en.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_fi.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_fr.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_hu.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_it.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_ja.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_ko.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_pl.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_ru.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_sk.qm"
  Delete "$INSTDIR\bin\translations\qtmultimedia_uk.qm"
  Delete "$INSTDIR\bin\translations\qt_pl.qm"
  Delete "$INSTDIR\bin\translations\qt_pt.qm"
  Delete "$INSTDIR\bin\translations\qt_pt_PT.qm"
  Delete "$INSTDIR\bin\translations\qt_pt_BR.qm"
  Delete "$INSTDIR\bin\translations\qt_ru.qm"
  Delete "$INSTDIR\bin\translations\qtscript_ca.qm"
  Delete "$INSTDIR\bin\translations\qtscript_cs.qm"
  Delete "$INSTDIR\bin\translations\qtscript_de.qm"
  Delete "$INSTDIR\bin\translations\qtscript_en.qm"
  Delete "$INSTDIR\bin\translations\qtscript_fi.qm"
  Delete "$INSTDIR\bin\translations\qtscript_fr.qm"
  Delete "$INSTDIR\bin\translations\qtscript_he.qm"
  Delete "$INSTDIR\bin\translations\qtscript_hu.qm"
  Delete "$INSTDIR\bin\translations\qtscript_it.qm"
  Delete "$INSTDIR\bin\translations\qtscript_ja.qm"
  Delete "$INSTDIR\bin\translations\qtscript_ko.qm"
  Delete "$INSTDIR\bin\translations\qtscript_lv.qm"
  Delete "$INSTDIR\bin\translations\qtscript_pl.qm"
  Delete "$INSTDIR\bin\translations\qtscript_ru.qm"
  Delete "$INSTDIR\bin\translations\qtscript_sk.qm"
  Delete "$INSTDIR\bin\translations\qtscript_uk.qm"
  Delete "$INSTDIR\bin\translations\qt_sk.qm"
  Delete "$INSTDIR\bin\translations\qt_sl.qm"
  Delete "$INSTDIR\bin\translations\qt_sv.qm"
  Delete "$INSTDIR\bin\translations\qt_uk.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_ca.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_cs.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_de.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_en.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_fr.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_hu.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_it.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_ja.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_ko.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_pl.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_ru.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_sk.qm"
  Delete "$INSTDIR\bin\translations\qtxmlpatterns_uk.qm"
  Delete "$INSTDIR\bin\translations\qt_zh_CN.qm"
  Delete "$INSTDIR\bin\translations\qt_zh_TW.qm"
  RmDir "$INSTDIR\bin\translations"
  RmDir "$INSTDIR\bin"
!endif
SectionEnd

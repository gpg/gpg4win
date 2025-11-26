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
  Delete "$INSTDIR\bin\translations\qtbase_ar.qm"
  Delete "$INSTDIR\bin\translations\qtbase_bg.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ca.qm"
  Delete "$INSTDIR\bin\translations\qtbase_cs.qm"
  Delete "$INSTDIR\bin\translations\qtbase_da.qm"
  Delete "$INSTDIR\bin\translations\qtbase_de.qm"
  Delete "$INSTDIR\bin\translations\qtbase_en.qm"
  Delete "$INSTDIR\bin\translations\qtbase_es.qm"
  Delete "$INSTDIR\bin\translations\qtbase_fa.qm"
  Delete "$INSTDIR\bin\translations\qtbase_fi.qm"
  Delete "$INSTDIR\bin\translations\qtbase_fr.qm"
  Delete "$INSTDIR\bin\translations\qtbase_gd.qm"
  Delete "$INSTDIR\bin\translations\qtbase_he.qm"
  Delete "$INSTDIR\bin\translations\qtbase_hr.qm"
  Delete "$INSTDIR\bin\translations\qtbase_hu.qm"
  Delete "$INSTDIR\bin\translations\qtbase_it.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ja.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ka.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ko.qm"
  Delete "$INSTDIR\bin\translations\qtbase_lv.qm"
  Delete "$INSTDIR\bin\translations\qtbase_nl.qm"
  Delete "$INSTDIR\bin\translations\qtbase_nn.qm"
  Delete "$INSTDIR\bin\translations\qtbase_pl.qm"
  Delete "$INSTDIR\bin\translations\qtbase_pt_BR.qm"
  Delete "$INSTDIR\bin\translations\qtbase_ru.qm"
  Delete "$INSTDIR\bin\translations\qtbase_sk.qm"
  Delete "$INSTDIR\bin\translations\qtbase_tr.qm"
  Delete "$INSTDIR\bin\translations\qtbase_uk.qm"
  Delete "$INSTDIR\bin\translations\qtbase_zh_CN.qm"
  Delete "$INSTDIR\bin\translations\qtbase_zh_TW.qm"
  Delete "$INSTDIR\bin\translations\qt_ar.qm"
  Delete "$INSTDIR\bin\translations\qt_bg.qm"
  Delete "$INSTDIR\bin\translations\qt_ca.qm"
  Delete "$INSTDIR\bin\translations\qt_cs.qm"
  Delete "$INSTDIR\bin\translations\qt_da.qm"
  Delete "$INSTDIR\bin\translations\qt_de.qm"
  Delete "$INSTDIR\bin\translations\qt_en.qm"
  Delete "$INSTDIR\bin\translations\qt_es.qm"
  Delete "$INSTDIR\bin\translations\qt_fa.qm"
  Delete "$INSTDIR\bin\translations\qt_fi.qm"
  Delete "$INSTDIR\bin\translations\qt_fr.qm"
  Delete "$INSTDIR\bin\translations\qt_gd.qm"
  Delete "$INSTDIR\bin\translations\qt_gl.qm"
  Delete "$INSTDIR\bin\translations\qt_he.qm"
  Delete "$INSTDIR\bin\translations\qt_hr.qm"
  Delete "$INSTDIR\bin\translations\qt_hu.qm"
  Delete "$INSTDIR\bin\translations\qt_it.qm"
  Delete "$INSTDIR\bin\translations\qt_ja.qm"
  Delete "$INSTDIR\bin\translations\qt_ka.qm"
  Delete "$INSTDIR\bin\translations\qt_ko.qm"
  Delete "$INSTDIR\bin\translations\qt_lt.qm"
  Delete "$INSTDIR\bin\translations\qt_lv.qm"
  Delete "$INSTDIR\bin\translations\qt_nl.qm"
  Delete "$INSTDIR\bin\translations\qt_nn.qm"
  Delete "$INSTDIR\bin\translations\qt_pl.qm"
  Delete "$INSTDIR\bin\translations\qt_pt_BR.qm"
  Delete "$INSTDIR\bin\translations\qt_pt_PT.qm"
  Delete "$INSTDIR\bin\translations\qt_ru.qm"
  Delete "$INSTDIR\bin\translations\qt_sk.qm"
  Delete "$INSTDIR\bin\translations\qt_sl.qm"
  Delete "$INSTDIR\bin\translations\qt_sv.qm"
  Delete "$INSTDIR\bin\translations\qt_tr.qm"
  Delete "$INSTDIR\bin\translations\qt_uk.qm"
  Delete "$INSTDIR\bin\translations\qt_zh_CN.qm"
  Delete "$INSTDIR\bin\translations\qt_zh_TW.qm"
  RmDir "$INSTDIR\bin\translations"
  RmDir "$INSTDIR\bin"
!endif
SectionEnd

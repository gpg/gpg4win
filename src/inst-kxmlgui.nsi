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
!define prefix ${ipdir}/kxmlgui-${gpg4win_pkg_kxmlgui_version}

!ifdef DEBUG
Section "kxmlgui" SEC_kxmlgui
!else
Section "-kxmlgui" SEC_kxmlgui
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_kxmlgui}"
!else
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/libKF5XmlGui.dll

  SetOutPath "$INSTDIR\share\locale\csb\LC_MESSAGES"
  File ${prefix}/share/locale/csb/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\hi\LC_MESSAGES"
  File ${prefix}/share/locale/hi/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\cy\LC_MESSAGES"
  File ${prefix}/share/locale/cy/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\it\LC_MESSAGES"
  File ${prefix}/share/locale/it/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\sl\LC_MESSAGES"
  File ${prefix}/share/locale/sl/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\gd\LC_MESSAGES"
  File ${prefix}/share/locale/gd/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ka\LC_MESSAGES"
  File ${prefix}/share/locale/ka/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\crh\LC_MESSAGES"
  File ${prefix}/share/locale/crh/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\sq\LC_MESSAGES"
  File ${prefix}/share/locale/sq/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\hne\LC_MESSAGES"
  File ${prefix}/share/locale/hne/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\mk\LC_MESSAGES"
  File ${prefix}/share/locale/mk/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\pt_BR\LC_MESSAGES"
  File ${prefix}/share/locale/pt_BR/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\bg\LC_MESSAGES"
  File ${prefix}/share/locale/bg/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ar\LC_MESSAGES"
  File ${prefix}/share/locale/ar/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\eu\LC_MESSAGES"
  File ${prefix}/share/locale/eu/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\sv\LC_MESSAGES"
  File ${prefix}/share/locale/sv/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\sk\LC_MESSAGES"
  File ${prefix}/share/locale/sk/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ko\LC_MESSAGES"
  File ${prefix}/share/locale/ko/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ga\LC_MESSAGES"
  File ${prefix}/share/locale/ga/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\tg\LC_MESSAGES"
  File ${prefix}/share/locale/tg/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ug\LC_MESSAGES"
  File ${prefix}/share/locale/ug/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\nds\LC_MESSAGES"
  File ${prefix}/share/locale/nds/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\oc\LC_MESSAGES"
  File ${prefix}/share/locale/oc/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\fa\LC_MESSAGES"
  File ${prefix}/share/locale/fa/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\lb\LC_MESSAGES"
  File ${prefix}/share/locale/lb/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\th\LC_MESSAGES"
  File ${prefix}/share/locale/th/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\sr\LC_MESSAGES"
  File ${prefix}/share/locale/sr/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\uz\LC_MESSAGES"
  File ${prefix}/share/locale/uz/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\mai\LC_MESSAGES"
  File ${prefix}/share/locale/mai/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ja\LC_MESSAGES"
  File ${prefix}/share/locale/ja/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\eo\LC_MESSAGES"
  File ${prefix}/share/locale/eo/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\uk\LC_MESSAGES"
  File ${prefix}/share/locale/uk/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ne\LC_MESSAGES"
  File ${prefix}/share/locale/ne/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\bn\LC_MESSAGES"
  File ${prefix}/share/locale/bn/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\fi\LC_MESSAGES"
  File ${prefix}/share/locale/fi/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\hy\LC_MESSAGES"
  File ${prefix}/share/locale/hy/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\mr\LC_MESSAGES"
  File ${prefix}/share/locale/mr/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\sr@ijekavianlatin\LC_MESSAGES"
  File ${prefix}/share/locale/sr@ijekavianlatin/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\xh\LC_MESSAGES"
  File ${prefix}/share/locale/xh/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\bs\LC_MESSAGES"
  File ${prefix}/share/locale/bs/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\zh_HK\LC_MESSAGES"
  File ${prefix}/share/locale/zh_HK/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\cs\LC_MESSAGES"
  File ${prefix}/share/locale/cs/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\hsb\LC_MESSAGES"
  File ${prefix}/share/locale/hsb/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\vi\LC_MESSAGES"
  File ${prefix}/share/locale/vi/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\hr\LC_MESSAGES"
  File ${prefix}/share/locale/hr/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\kk\LC_MESSAGES"
  File ${prefix}/share/locale/kk/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\hu\LC_MESSAGES"
  File ${prefix}/share/locale/hu/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\zh_TW\LC_MESSAGES"
  File ${prefix}/share/locale/zh_TW/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\nn\LC_MESSAGES"
  File ${prefix}/share/locale/nn/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\nb\LC_MESSAGES"
  File ${prefix}/share/locale/nb/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\pl\LC_MESSAGES"
  File ${prefix}/share/locale/pl/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\et\LC_MESSAGES"
  File ${prefix}/share/locale/et/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ast\LC_MESSAGES"
  File ${prefix}/share/locale/ast/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\he\LC_MESSAGES"
  File ${prefix}/share/locale/he/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ia\LC_MESSAGES"
  File ${prefix}/share/locale/ia/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\si\LC_MESSAGES"
  File ${prefix}/share/locale/si/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\lt\LC_MESSAGES"
  File ${prefix}/share/locale/lt/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ps\LC_MESSAGES"
  File ${prefix}/share/locale/ps/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\sr@ijekavian\LC_MESSAGES"
  File ${prefix}/share/locale/sr@ijekavian/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ru\LC_MESSAGES"
  File ${prefix}/share/locale/ru/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ro\LC_MESSAGES"
  File ${prefix}/share/locale/ro/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\br\LC_MESSAGES"
  File ${prefix}/share/locale/br/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\kn\LC_MESSAGES"
  File ${prefix}/share/locale/kn/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\fy\LC_MESSAGES"
  File ${prefix}/share/locale/fy/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\be@latin\LC_MESSAGES"
  File ${prefix}/share/locale/be@latin/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\pt\LC_MESSAGES"
  File ${prefix}/share/locale/pt/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\is\LC_MESSAGES"
  File ${prefix}/share/locale/is/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\wa\LC_MESSAGES"
  File ${prefix}/share/locale/wa/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\fr\LC_MESSAGES"
  File ${prefix}/share/locale/fr/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\or\LC_MESSAGES"
  File ${prefix}/share/locale/or/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ha\LC_MESSAGES"
  File ${prefix}/share/locale/ha/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\tt\LC_MESSAGES"
  File ${prefix}/share/locale/tt/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\lv\LC_MESSAGES"
  File ${prefix}/share/locale/lv/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\uz@cyrillic\LC_MESSAGES"
  File ${prefix}/share/locale/uz@cyrillic/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\tr\LC_MESSAGES"
  File ${prefix}/share/locale/tr/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\gl\LC_MESSAGES"
  File ${prefix}/share/locale/gl/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ta\LC_MESSAGES"
  File ${prefix}/share/locale/ta/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\gu\LC_MESSAGES"
  File ${prefix}/share/locale/gu/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\af\LC_MESSAGES"
  File ${prefix}/share/locale/af/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\es\LC_MESSAGES"
  File ${prefix}/share/locale/es/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ku\LC_MESSAGES"
  File ${prefix}/share/locale/ku/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\en_GB\LC_MESSAGES"
  File ${prefix}/share/locale/en_GB/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\bn_IN\LC_MESSAGES"
  File ${prefix}/share/locale/bn_IN/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ca\LC_MESSAGES"
  File ${prefix}/share/locale/ca/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\el\LC_MESSAGES"
  File ${prefix}/share/locale/el/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\se\LC_MESSAGES"
  File ${prefix}/share/locale/se/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\sr@latin\LC_MESSAGES"
  File ${prefix}/share/locale/sr@latin/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\km\LC_MESSAGES"
  File ${prefix}/share/locale/km/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\te\LC_MESSAGES"
  File ${prefix}/share/locale/te/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\be\LC_MESSAGES"
  File ${prefix}/share/locale/be/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\as\LC_MESSAGES"
  File ${prefix}/share/locale/as/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ml\LC_MESSAGES"
  File ${prefix}/share/locale/ml/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\pa\LC_MESSAGES"
  File ${prefix}/share/locale/pa/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\id\LC_MESSAGES"
  File ${prefix}/share/locale/id/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ms\LC_MESSAGES"
  File ${prefix}/share/locale/ms/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\ca@valencia\LC_MESSAGES"
  File ${prefix}/share/locale/ca@valencia/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\da\LC_MESSAGES"
  File ${prefix}/share/locale/da/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\nl\LC_MESSAGES"
  File ${prefix}/share/locale/nl/LC_MESSAGES/kxmlgui5.mo
  SetOutPath "$INSTDIR\share\locale\zh_CN\LC_MESSAGES"
  File ${prefix}/share/locale/zh_CN/LC_MESSAGES/kxmlgui5.mo
!endif
SectionEnd

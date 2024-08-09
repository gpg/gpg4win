# Copyright (C) 2024 g10 Code GmbH
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
; Uninstaller section.
Section "-un.breeze"
  Delete "$INSTDIR\bin\styles\breeze6.dll"
  Delete "$INSTDIR\share\kstyle\themes\breeze.themerc"
  Delete "$INSTDIR\share\color-schemes\BreezeDark.colors"
  Delete "$INSTDIR\share\color-schemes\BreezeClassic.colors"
  Delete "$INSTDIR\share\color-schemes\BreezeLight.colors"

  RmDir "$INSTDIR\share\color-schemes"
  RmDir "$INSTDIR\share\kstyle\themes"
  RmDir "$INSTDIR\share\kstyle"
  RmDir "$INSTDIR\share"
  RmDir "$INSTDIR\bin\styles"
  RmDir "$INSTDIR\bin"
SectionEnd

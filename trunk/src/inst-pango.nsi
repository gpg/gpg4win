# inst-pango.nsi - Installer snippet for pango.     -*- coding: latin-1; -*-
# Copyright (C) 2005 g10 Code GmbH
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
!define prefix ${ipdir}/pango-${gpg4win_pkg_pango_version}

!ifdef DEBUG
Section "pango" SEC_pango
!else
Section "-pango" SEC_pango
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_pango_src}"
!else
  File ${prefix}/bin/pango-querymodules.exe
  File ${prefix}/bin/libpango-1.0-0.dll
  File ${prefix}/bin/libpangoft2-1.0-0.dll
  File ${prefix}/bin/libpangowin32-1.0-0.dll

  SetOutPath "$INSTDIR\etc\pango"
  File ${prefix}/etc/pango/pango.aliases
  File ${prefix}/etc/pango/pango.modules

  SetOutPath "$INSTDIR\lib\pango\1.4.0\modules"
  File ${prefix}/lib/pango/1.4.0/modules/pango-arabic-fc.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-basic-fc.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-basic-win32.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-hangul-fc.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-hebrew-fc.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-indic-fc.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-khmer-fc.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-syriac-fc.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-thai-fc.dll
  File ${prefix}/lib/pango/1.4.0/modules/pango-tibetan-fc.dll
!endif
SectionEnd


; Uninstaller section.
Section "-un.pango"
!ifdef SOURCES
  Push "${gpg4win_pkg_pango_src}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\pango-querymodules.exe"
  Delete "$INSTDIR\libpango-1.0-0.dll"
  Delete "$INSTDIR\libpangoft2-1.0-0.dll"
  Delete "$INSTDIR\libpangowin32-1.0-0.dll"

  Delete "$INSTDIR\etc\pango\pango.aliases"
  Delete "$INSTDIR\etc\pango\pango.modules"
  RMDir "$INSTDIR\etc\pango"
  RMDir "$INSTDIR\etc"

  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-arabic-fc.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-basic-fc.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-basic-win32.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-hangul-fc.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-hebrew-fc.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-indic-fc.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-khmer-fc.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-syriac-fc.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-thai-fc.dll"
  Delete "$INSTDIR\lib\pango\1.4.0\modules\pango-tibetan-fc.dll"
  RMDir "$INSTDIR\lib\pango\1.4.0\modules"
  RMDir "$INSTDIR\lib\pango\1.4.0"
  RMDir "$INSTDIR\lib\pango"
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR"
!endif
SectionEnd

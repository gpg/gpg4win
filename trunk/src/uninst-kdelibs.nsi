# uninst-kdelibs.nsi - Installer snippet for kdelibs.    -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/kdelibs-${gpg4win_pkg_kdelibs_version}


; Uninstaller section.
Section "-un.kdelibs"
!ifdef SOURCES
  Push "${gpg4win_pkg_kdelibs_src}"
  Call un.SourceDelete
!else

  Delete "$INSTDIR\kcmdwrapper.exe"
  Delete "$INSTDIR\libkdecore.dll"
  Delete "$INSTDIR\libkdeui.dll"
  Delete "$INSTDIR\libkdefx.dll"

  Delete "$INSTDIR\lib\kde4\kded_globalaccel.dll"

  RMDir "$INSTDIR\lib\kde4"
  RMDir "$INSTDIR\lib"

  Delete "$INSTDIR\share\apps\kcharselect\kcharselect-data"

  RMDir "$INSTDIR\share\apps\kcharselect"

  Delete "$INSTDIR\share\apps\kdeui\pics\ktip-background.png"
  Delete "$INSTDIR\share\apps\kdeui\pics\aboutkde.png"
  Delete "$INSTDIR\share\apps\kdeui\pics\ktip-bulb.png"

  RMDir "$INSTDIR\share\apps\kdeui\pics"
  RMDir "$INSTDIR\share\apps\kdeui"

  Delete "$INSTDIR\share\apps\kdeui\about\box-middle-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bottom-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-middle-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-bottom-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-top-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-bottom-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-bottom-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-top-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-bottom-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-bottom-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-middle-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-middle-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\kde_infopage.css"
  Delete "$INSTDIR\share\apps\kdeui\about\bottom-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-top-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\kde_infopage_rtl.css"
  Delete "$INSTDIR\share\apps\kdeui\about\top-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-bottom-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-top-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-top-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\top-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-top-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bottom-left.png"

  RMDir "$INSTDIR\share\apps\kdeui\about"
  RMDir "$INSTDIR\share\apps\kdeui"
  RMDir "$INSTDIR\share\apps"

  Delete "$INSTDIR\share\config\kdebug.areas"
  Delete "$INSTDIR\share\config\kdebugrc"

  Delete "$INSTDIR\share\config\colors\Web.colors"
  Delete "$INSTDIR\share\config\colors\Royal.colors"
  Delete "$INSTDIR\share\config\colors\Rainbow.colors"
  Delete "$INSTDIR\share\config\colors\40.colors"

  RMDir "$INSTDIR\share\config\colors"

  Delete "$INSTDIR\share\config\ui\ui_standards.rc"

  RMDir "$INSTDIR\share\ui"

  Delete "$INSTDIR\share\kde4\services\kded\kdedglobalaccel.desktop"

  RMDir "$INSTDIR\share\kde4\services\kded"

  Delete "$INSTDIR\share\kde4\servicetypes\sonnetspeller.desktop"
  Delete "$INSTDIR\share\kde4\servicetypes\kplugininfo.desktop"

  RMDir "$INSTDIR\share\kde4\servicetypes"

  Delete "$INSTDIR\share\locale\all_languages"

  RMDir "$INSTDIR\share\locale"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"

!endif
SectionEnd

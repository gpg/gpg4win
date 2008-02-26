# uninst-kdelibs.nsi - Installer snippet for kdelibs.    -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/kdelibs-${gpg4win_pkg_kdelibs_version}


; Uninstaller section.
Section "-un.kdelibs"
!ifdef SOURCES
  Push "${gpg4win_pkg_kdelibs_src}"
  Call un.SourceDelete
!else

  # FIXME: See inst-kleopatra.nsi
  Delete "$INSTDIR\bin\kcmdwrapper.exe"
  RMDir "$INSTDIR\bin"

  Delete "$INSTDIR\libkdeui.dll"
  Delete "$INSTDIR\libkdeinit4_kbuildsycoca4.dll"
  Delete "$INSTDIR\libkdecore.dll"
  Delete "$INSTDIR\libkcmutils.dll"
  Delete "$INSTDIR\libqgpgme.dll"
  Delete "$INSTDIR\libkmime.dll"
  Delete "$INSTDIR\libgpgme++.dll"
  Delete "$INSTDIR\libgpgme++-qt.dll"
  Delete "$INSTDIR\libgpgme++-glib.dll"
  Delete "$INSTDIR\kbuildsycoca4.exe"

  Delete "$INSTDIR\share\locale\all_languages"
  Delete "$INSTDIR\share\kde4\servicetypes\sonnetspeller.desktop"
  Delete "$INSTDIR\share\kde4\servicetypes\kplugininfo.desktop"
  Delete "$INSTDIR\share\kde4\services\kded\kdedglobalaccel.desktop"
  Delete "$INSTDIR\share\config\ui\ui_standards.rc"
  Delete "$INSTDIR\share\config\kdebugrc"
  Delete "$INSTDIR\share\config\kdebug.areas"
  Delete "$INSTDIR\share\config\colors\Web.colors"
  Delete "$INSTDIR\share\config\colors\Royal.colors"
  Delete "$INSTDIR\share\config\colors\Rainbow.colors"
  Delete "$INSTDIR\share\config\colors\Oxygen.colors"
  Delete "$INSTDIR\share\config\colors\40.colors"
  Delete "$INSTDIR\share\apps\kdeui\pics\ktip-bulb.png"
  Delete "$INSTDIR\share\apps\kdeui\pics\aboutkde.png"
  Delete "$INSTDIR\share\apps\kdeui\about\top-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\top-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\kde_infopage_rtl.css"
  Delete "$INSTDIR\share\apps\kdeui\about\kde_infopage.css"
  Delete "$INSTDIR\share\apps\kdeui\about\box-top-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-top-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-top-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-middle-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-middle-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-bottom-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-bottom-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\box-bottom-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bottom-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bottom-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bottom-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-top-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-top-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-top-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-middle-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-middle-left.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-bottom-right.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-bottom-middle.png"
  Delete "$INSTDIR\share\apps\kdeui\about\bar-bottom-left.png"
  Delete "$INSTDIR\share\apps\kcharselect\kcharselect-data"
  Delete "$INSTDIR\lib\kde4\kded_globalaccel.dll"
  Delete "$INSTDIR\etc\xdg\menus\applications.menu"

  RMDir "$INSTDIR\share\locale"
  RMDir "$INSTDIR\share\kde4\servicetypes"
  RMDir "$INSTDIR\share\kde4\services\kded"
  RMDir "$INSTDIR\share\kde4\services"
  RMDir "$INSTDIR\share\kde4"
  RMDir "$INSTDIR\share\config\ui"
  RMDir "$INSTDIR\share\config\colors"
  RMDir "$INSTDIR\share\config"
  RMDir "$INSTDIR\share\apps\kdeui\pics"
  RMDir "$INSTDIR\share\apps\kdeui\about"
  RMDir "$INSTDIR\share\apps\kdeui"
  RMDir "$INSTDIR\share\apps\kcharselect"
  RMDir "$INSTDIR\share\apps"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR\lib\kde4"
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR\etc\xdg\menus"
  RMDir "$INSTDIR\etc\xdg"
  RMDir "$INSTDIR\etc"
  RMDir "$INSTDIR"

!endif
SectionEnd

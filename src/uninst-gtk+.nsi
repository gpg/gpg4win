# uninst-gtk+.nsi - Installer snippet for gtk+.   -*- coding: latin-1; -*-
# Copyright (C) 2005, 2008 g10 Code GmbH
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
!define prefix ${ipdir}/gtk+-${gpg4win_pkg_gtk__version}


; Uninstaller section.
Section "-un.gtk+"
!ifdef SOURCES
  Push "${gpg4win_pkg_gtk__src}"
  Call un.SourceDelete
!else

  Delete "$INSTDIR\libgdk_pixbuf-2.0-0.dll"
  Delete "$INSTDIR\libgdk-win32-2.0-0.dll"
  Delete "$INSTDIR\libgtk-win32-2.0-0.dll"

  Delete "$INSTDIR\libgailutil-18.dll"
  Delete "$INSTDIR\gdk-pixbuf-query-loaders.exe"
  Delete "$INSTDIR\gtk-query-immodules-2.0.exe"

  Delete "$INSTDIR\etc\gtk-2.0\gdk-pixbuf.loaders"
  Delete "$INSTDIR\etc\gtk-2.0\gtk.immodules"
  Delete "$INSTDIR\etc\gtk-2.0\im-multipress.conf"
  Delete "$INSTDIR\etc\gtk-2.0\gtkrc"
  RMDir "$INSTDIR\etc\gtk-2.0"
  RMDir "$INSTDIR\etc"

  Delete "$INSTDIR\lib\gtk-2.0\2.4.0\loaders\*.dll"
  RMDir "$INSTDIR\lib\gtk-2.0\2.10.0\loaders"
  Delete "$INSTDIR\lib\gtk-2.0\2.10.0\loaders\*.dll"
  RMDir "$INSTDIR\lib\gtk-2.0\2.10.0\loaders"

  Delete "$INSTDIR\lib\gtk-2.0\2.4.0\immodules\*.dll"
  RMDir "$INSTDIR\lib\gtk-2.0\2.4.0\immodules"
  Delete "$INSTDIR\lib\gtk-2.0\2.10.0\immodules\*.dll"
  RMDir "$INSTDIR\lib\gtk-2.0\2.10.0\immodules"

  Delete "$INSTDIR\lib\gtk-2.0\2.10.0\engines\*.dll"
  RMDir "$INSTDIR\lib\gtk-2.0\2.10.0\engines"

  RMDir "$INSTDIR\lib\gtk-2.0\2.4.0"
  RMDir "$INSTDIR\lib\gtk-2.0\2.10.0"

  Delete "$INSTDIR\lib\gtk-2.0\modules\*.dll"
  RMDir "$INSTDIR\lib\gtk-2.0\modules"

  RMDir "$INSTDIR\lib\gtk-2.0"

  Delete "$INSTDIR\lib\locale\de\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\lib\locale\de\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\lib\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\de"
  Delete "$INSTDIR\lib\locale\ar\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\lib\locale\ar\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\lib\locale\ar\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\ar"
  Delete "$INSTDIR\lib\locale\es\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\lib\locale\es\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\lib\locale\es\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\es"
  Delete "$INSTDIR\lib\locale\fr\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\lib\locale\fr\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\lib\locale\fr\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\fr"
  Delete "$INSTDIR\lib\locale\ru\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\lib\locale\ru\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\lib\locale\ru\LC_MESSAGES"
  RMDir "$INSTDIR\lib\locale\ru"
  RMDir "$INSTDIR\lib\locale"

  RMDir "$INSTDIR\lib"

  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\share\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\de"
  Delete "$INSTDIR\share\locale\ar\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\share\locale\ar\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\share\locale\ar\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ar"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\share\locale\es\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\es"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\share\locale\fr\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\fr"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\gtk20.mo"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\gtk20-properties.mo"
  RMDir "$INSTDIR\share\locale\ru\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ru"
  RMDir "$INSTDIR\share\locale"

  Delete "$INSTDIR\share\themes\Default\gtk-2.0\gtkrc"
  RMDir "$INSTDIR\share\themes\Default\gtk-2.0"
  Delete "$INSTDIR\share\themes\Default\gtk-2.0-key\gtkrc"
  RMDir "$INSTDIR\share\themes\Default\gtk-2.0-key"
  RMDir "$INSTDIR\share\themes\Default"

  Delete "$INSTDIR\share\themes\Emacs\gtk-2.0-key\gtkrc"
  RMDir "$INSTDIR\share\themes\Emacs\gtk-2.0-key"
  RMDir "$INSTDIR\share\themes\Emacs"

  Delete "$INSTDIR\share\themes\Raleigh\gtk-2.0\gtkrc"
  RMDir "$INSTDIR\share\themes\Raleigh\gtk-2.0"
  RMDir "$INSTDIR\share\themes\Raleigh"

  Delete "$INSTDIR\share\themes\MS-Windows\gtk-2.0\gtkrc"
  RMDir "$INSTDIR\share\themes\MS-Windows\gtk-2.0"
  RMDir "$INSTDIR\share\themes\MS-Windows"

  RMDir "$INSTDIR\share\themes"

  RMDir "$INSTDIR\share"

  RMDir "$INSTDIR"
!endif
SectionEnd

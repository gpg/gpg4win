# inst-gtk+.nsi - Installer snippet for gtk+.     -*- coding: latin-1; -*-
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

!ifdef DEBUG
Section "gtk+" SEC_gtk_
!else
Section "-gtk+" SEC_gtk_
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gtk__src}"
!else
  File ${prefix}/bin/libgdk_pixbuf-2.0-0.dll
  File ${prefix}/bin/libgdk-win32-2.0-0.dll
  File ${prefix}/bin/libgtk-win32-2.0-0.dll

  File ${prefix}/bin/libgailutil-18.dll
  File ${prefix}/bin/gdk-pixbuf-query-loaders.exe
  File ${prefix}/bin/gtk-query-immodules-2.0.exe

  SetOutPath "$INSTDIR\etc\gtk-2.0"
  File ${prefix}/etc/gtk-2.0/gdk-pixbuf.loaders
  File ${prefix}/etc/gtk-2.0/gtk.immodules
  File ${prefix}/etc/gtk-2.0/im-multipress.conf

  SetOutPath "$INSTDIR\lib\gtk-2.0\2.10.0\engines"
  File ${prefix}/lib/gtk-2.0/2.10.0/engines/libpixmap.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/engines/libwimp.dll

  SetOutPath "$INSTDIR\lib\gtk-2.0\modules"
  File ${prefix}/lib/gtk-2.0/modules/libgail.dll

  SetOutPath "$INSTDIR\share\themes\Default\gtk-2.0-key"
  File ${prefix}/share/themes/Default/gtk-2.0-key/gtkrc

  SetOutPath "$INSTDIR\share\themes\Emacs\gtk-2.0-key"
  File ${prefix}/share/themes/Emacs/gtk-2.0-key/gtkrc

  SetOutPath "$INSTDIR\share\themes\Raleigh\gtk-2.0"
  File ${prefix}/share/themes/Raleigh/gtk-2.0/gtkrc

  SetOutPath "$INSTDIR\share\themes\MS-Windows\gtk-2.0"
  File ${prefix}/share/themes/MS-Windows/gtk-2.0/gtkrc

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/gtk20.mo
  File ${prefix}/share/locale/de/LC_MESSAGES/gtk20-properties.mo

  SetOutPath "$INSTDIR\share\locale\ar\LC_MESSAGES"
  File ${prefix}/share/locale/ar/LC_MESSAGES/gtk20.mo
  File ${prefix}/share/locale/ar/LC_MESSAGES/gtk20-properties.mo

  SetOutPath "$INSTDIR\share\locale\es\LC_MESSAGES"
  File ${prefix}/share/locale/es/LC_MESSAGES/gtk20.mo
  File ${prefix}/share/locale/es/LC_MESSAGES/gtk20-properties.mo

  SetOutPath "$INSTDIR\share\locale\fr\LC_MESSAGES"
  File ${prefix}/share/locale/fr/LC_MESSAGES/gtk20.mo
  File ${prefix}/share/locale/fr/LC_MESSAGES/gtk20-properties.mo

  SetOutPath "$INSTDIR\share\locale\ru\LC_MESSAGES"
  File ${prefix}/share/locale/ru/LC_MESSAGES/gtk20.mo
  File ${prefix}/share/locale/ru/LC_MESSAGES/gtk20-properties.mo

!endif
SectionEnd

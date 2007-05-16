# inst-gtk+.nsi - Installer snippet for gtk+.     -*- coding: latin-1; -*-
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

  SetOutPath "$INSTDIR\etc\gtk-2.0"
  File ${prefix}/etc/gtk-2.0/gdk-pixbuf.loaders
  File ${prefix}/etc/gtk-2.0/gtk.immodules

  SetOutPath "$INSTDIR\lib\gtk-2.0\2.10.0\loaders"
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-ani.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-bmp.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-gif.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-ico.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-jpeg.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-pcx.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-pnm.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-ras.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-tga.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-tiff.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-wbmp.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-xbm.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-xpm.dll

  SetOutPath "$INSTDIR\lib\gtk-2.0\2.10.0\immodules"
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-am-et.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-cedilla.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-cyrillic-translit.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-ime.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-inuktitut.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-ipa.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-thai.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-ti-er.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-ti-et.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/immodules/im-viqr.dll

  SetOutPath "$INSTDIR\lib\gtk-2.0\2.10.0\engines"
  File ${prefix}/lib/gtk-2.0/2.10.0/engines/libpixmap.dll
  File ${prefix}/lib/gtk-2.0/2.10.0/engines/libwimp.dll

  SetOutPath "$INSTDIR\share\themes\Default\gtk-2.0-key"
  File ${prefix}/share/themes/Default/gtk-2.0-key/gtkrc

  SetOutPath "$INSTDIR\share\themes\Emacs\gtk-2.0-key"
  File ${prefix}/share/themes/Emacs/gtk-2.0-key/gtkrc

  SetOutPath "$INSTDIR\share\themes\Raleigh\gtk-2.0"
  File ${prefix}/share/themes/Raleigh/gtk-2.0/gtkrc

  SetOutPath "$INSTDIR\share\themes\MS-Windows\gtk-2.0"
  File ${prefix}/share/themes/MS-Windows/gtk-2.0/gtkrc

  SetOutPath "$INSTDIR\lib\locale\de\LC_MESSAGES"
  File ${prefix}/lib/locale/de/LC_MESSAGES/gtk20.mo

!endif
SectionEnd

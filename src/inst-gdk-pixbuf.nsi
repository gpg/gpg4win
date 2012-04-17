# inst-gdk-pixbuf.nsi - Installer part for gdk-pixbuf  -*- coding: latin-1; -*-
# Copyright (C) 2012 g10 Code GmbH
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
!define prefix ${ipdir}/gdk-pixbuf-${gpg4win_pkg_gdk_pixbuf_version}

!ifdef DEBUG
Section "gdk_pixbuf" SEC_gdk_pixbuf
!else
Section "-gdk_pixbuf" SEC_gdk_pixbuf
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File ${gpg4win_pkg_gdk_pixbuf}
!else
  File ${prefix}/bin/libgdk_pixbuf-2.0-0.dll
  File ${prefix}/bin/gdk-pixbuf-query-loaders.exe
  File ${prefix}/bin/gdk-pixbuf-pixdata.exe

!endif
SectionEnd

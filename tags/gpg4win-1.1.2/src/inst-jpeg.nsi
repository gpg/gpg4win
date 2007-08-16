# inst-libpng.nsi - Installer snippet for jpeg.   -*- coding: latin-1; -*-
# Copyright (C) 2005, 2006 g10 Code GmbH
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
!define prefix ${ipdir}/jpeg-${gpg4win_pkg_jpeg_version}

!ifdef DEBUG
Section "jpeg" SEC_jpeg
!else
Section "-jpeg" SEC_jpeg
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_jpeg_src}"
!else
  File ${prefix}/bin/jpeg62.dll
!ifdef DEBUG
  # We install a couple of binaries that may be useful for testing.
  File ${prefix}/bin/cjpeg.exe
  File ${prefix}/bin/djpeg.exe
  File ${prefix}/bin/exifautotran
  File ${prefix}/bin/jpegexiforient.exe
  File ${prefix}/bin/jpegtran.exe
  File ${prefix}/bin/rdjpgcom.exe
  File ${prefix}/bin/wrjpgcom.exe
!endif
!endif
SectionEnd

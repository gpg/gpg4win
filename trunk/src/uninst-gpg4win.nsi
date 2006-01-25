# uninst-gpg4win.nsi - Hidden uninstaller.           -*- coding: latin-1; -*-
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


# This is the very last section of the uninstaller.
Section "-un.gpg4win"
!ifdef SOURCES
  Delete "gpg4win-${VERSION}.tar.bz2"
!else

  Delete "$INSTDIR\share\gpg4win\README.en.txt"
  Delete "$INSTDIR\share\gpg4win\README.de.txt"
  Delete "$INSTDIR\share\gpg4win\versioninfo.txt"

  RMDir "$INSTDIR\share\gpg4win"

  # Try to remove otehr top directories.
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"

!endif
SectionEnd

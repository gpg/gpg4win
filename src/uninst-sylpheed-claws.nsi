# uninst-sylpheed.nsi - Installer snippet.        -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/sylpheed-claws-${gpg4win_pkg_sylpheed_version}


# Uninstaller section.
Section "-un.sylpheed"
!ifdef SOURCES
  Push "${gpg4win_pkg_sylpheed_claws}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\sylpheed-claws.exe"

!ifndef GPG4WIN_LIGHT
  Delete "$INSTDIR\sylpheed-claws-manual.pdf"
!endif

  Delete "$INSTDIR\lib\sylpheed-claws\plugins\pgpcore.dll"
  Delete "$INSTDIR\lib\sylpheed-claws\plugins\pgpinline.dll"
  Delete "$INSTDIR\lib\sylpheed-claws\plugins\pgpinline.deps"
  Delete "$INSTDIR\lib\sylpheed-claws\plugins\pgpmime.dll"
  Delete "$INSTDIR\lib\sylpheed-claws\plugins\pgpmime.deps"
  RMDir "$INSTDIR\lib\sylpheed-claws\plugins"
  RMDir "$INSTDIR\lib\sylpheed-claws"
  RMDir "$INSTDIR\lib"

  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\sylpheed-claws.mo"

  RMDir "$INSTDIR\share\sylpheed-claws"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"
!endif
SectionEnd

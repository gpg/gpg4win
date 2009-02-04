# inst-paperkey.nsi - Installer snippet for paperkey -*- coding: latin-1; -*-
# Copyright (C) 2009 g10 Code GmbH
# 
# This file is part of Gpg4win.
# 
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.


!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/paperkey-${gpg4win_pkg_paperkey_version}


!ifdef DEBUG
Section "Paperkey" SEC_paperkey
!else
Section "-Paperkey" SEC_paperkey
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_paperkey}"
!else

  File "${prefix}/bin/paperkey.exe"

  # Instead of creating a new subdirectory we put the man page into
  # the gnupg directory.
  SetOutPath "$INSTDIR\share\gnupg"
  File "${prefix}/share/man/man1/paperkey.man"

!endif
SectionEnd


LangString DESC_SEC_paperkey ${LANG_ENGLISH} \
   "A tool to backup keys on paper"

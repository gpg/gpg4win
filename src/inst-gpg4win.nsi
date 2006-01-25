# inst-gpg4win.nsi - Hidden section for common files. -*- coding: latin-1; -*-
# Copyright (C) 2006 g10 Code GmbH
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


# This is the very first section installed.
Section "-gpg4win"
!ifdef SOURCES
  SetOutPath "$INSTDIR"
  File "${BUILD_DIR}/../gpg4win-${VERSION}.tar.bz2"
!else 
  SetOutPath "$INSTDIR\share\gpg4win"

  File "${BUILD_DIR}/README.en.txt"
  File "${BUILD_DIR}/README.de.txt"
  File "${BUILD_DIR}/versioninfo.txt"

!endif

SectionEnd

LangString DESC_Menu_gpg4win_readme ${LANG_ENGLISH} \
   "General information on Gpg4Win"
LangString DESC_Menu_gpg4win_readme ${LANG_GERMAN} \
   "Allgemeine Informationen zu Gpg4Win"




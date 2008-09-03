# inst-scute.nsi - Installer snippet for scute.     -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/scute-${gpg4win_pkg_scute_version}

${MementoSection} "Scute" SEC_scute
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_scute}"
!else
  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/libscute-0.dll"

  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=libscute-0.dll.tmp "${prefix}/bin/libscute-0.dll"
      Rename /REBOOTOK libscute-0.dll.tmp libscute-0.dll

!endif
${MementoSectionEnd}


LangString DESC_SEC_scute ${LANG_ENGLISH} \
   "PKCS #11 with GnuPG Agent"

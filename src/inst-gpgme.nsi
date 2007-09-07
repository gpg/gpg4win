# inst-gpgme.nsi - Installer snippet for gpgme.     -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007 g10 Code GmbH
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
!define prefix ${ipdir}/gpgme-${gpg4win_pkg_gpgme_version}

!ifdef DEBUG
Section "gpgme" SEC_gpgme
!else
Section "-gpgme" SEC_gpgme
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gpgme}"
!else
  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/libgpgme-11.dll"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=libgpgme-11.dll.tmp "${prefix}/bin/libgpgme-11.dll"
      Rename /REBOOTOK libgpgme-11.dll.tmp libgpgme-11.dll

  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/libgpgme-glib-11.dll"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=libgpgme-glib-11.dll.tmp "${prefix}/bin/libgpgme-glib-11.dll"
      Rename /REBOOTOK libgpgme-glib-11.dll.tmp libgpgme-glib-11.dll

!ifndef GPG4WIN_LIGHT
  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/libgpgme-qt-11.dll"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=libgpgme-qt-11.dll.tmp "${prefix}/bin/libgpgme-qt-11.dll"
      Rename /REBOOTOK libgpgme-qt-11.dll.tmp libgpgme-qt-11.dll
!endif

!endif
SectionEnd

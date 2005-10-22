# uninst-libgpg-error.nsi - Installer f. libgpg-error. -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/libgpg-error-${gpg4win_pkg_libgpg_error_version}


; Uninstaller section.
Section "-un.libgpg-error"
!ifdef SOURCES
  Push "${gpg4win_pkg_libgpg_error}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\libgpg-error-0.dll"
!ifdef DEBUG
  Delete "$INSTDIR\gpg-error.exe"
!endif
  RMDir "$INSTDIR"
!endif
SectionEnd

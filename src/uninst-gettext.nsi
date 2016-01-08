# uninst-gettext.nsi - Installer snippet for gettext. -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/gettext-${gpg4win_pkg_gettext_version}


; Uninstaller section.
Section "-un.gettext"
!ifdef SOURCES
  Push "${gpg4win_pkg_gettext}"
  Call un.SourceDelete
!else
  Delete /REBOOTOK "$INSTDIR\bin\libintl-8.dll"
  Delete /REBOOTOK "$INSTDIR\bin\intl.dll"
!ifdef DEBUG
  Delete "$INSTDIR\bin\gettext.exe"
  Delete "$INSTDIR\bin\ngettext.exe"
  Delete "$INSTDIR\bin\envsubst.exe"
  Delete "$INSTDIR\bin\asprintf.dll"
!endif
  RMDir "$INSTDIR"
!endif
SectionEnd

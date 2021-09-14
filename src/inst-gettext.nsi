# inst-gettext.nsi - Installer snippet for gettext.   -*- coding: latin-1; -*-
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

!ifdef DEBUG
Section "gettext" SEC_gettext
!else
Section "-gettext" SEC_gettext
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File ${gpg4win_pkg_gettext}
!else
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/libintl-8.dll
  File /oname=intl.dll ${prefix}/bin/libintl-8.dll

!ifdef DEBUG
  # We install a couple of binaries that may be useful for testing.
  File ${prefix}/bin/gettext.exe
  File ${prefix}/bin/ngettext.exe
  File ${prefix}/bin/envsubst.exe
  File ${prefix}/bin/asprintf.dll
!endif
!endif
SectionEnd

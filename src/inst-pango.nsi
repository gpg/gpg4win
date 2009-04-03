# inst-pango.nsi - Installer snippet for pango.     -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/pango-${gpg4win_pkg_pango_version}

!ifdef DEBUG
Section "pango" SEC_pango
!else
Section "-pango" SEC_pango
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_pango_src}"
!else
  File ${prefix}/bin/pango-querymodules.exe
  File ${prefix}/bin/libpango-1.0-0.dll
  File ${prefix}/bin/libpangoft2-1.0-0.dll
  File ${prefix}/bin/libpangowin32-1.0-0.dll
  File ${prefix}/bin/libpangocairo-1.0-0.dll

  SetOutPath "$INSTDIR\etc\pango"
#  File ${prefix}/etc/pango/pango.aliases
  File ${prefix}/etc/pango/pango.modules

!endif
SectionEnd

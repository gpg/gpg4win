# Copyright (C) 2015 Intevation GmbH
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
!define prefix ${ipdir}/kitemviews-${gpg4win_pkg_kitemviews_version}

!ifdef DEBUG
Section "kitemviews" SEC_kitemviews
!else
Section "-kitemviews" SEC_kitemviews
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_kitemviews}"
!else
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/libKF5ItemViews.dll
!endif
SectionEnd

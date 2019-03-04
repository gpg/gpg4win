# inst-breeze-icons.nsi - Snippet for breeze-icons.   -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/breeze-icons-${gpg4win_pkg_breeze_icons_version}

!ifdef DEBUG
Section "breeze-icons" SEC_breeze_icons
!else
Section "-breeze-icons" SEC_breeze_icons
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_breeze_icons}"
!else

  #
  # Note: You may want to use the pkg-to-nsi.pl script to create the
  # list of icons.
  #
  SetOutPath "$INSTDIR\share\icons\breeze\actions\16"

  File ${prefix}/share/icons/breeze/actions/16/document-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/16/help-contextual.svg
  File ${prefix}/share/icons/breeze/actions/16/tools-report-bug.svg

 SetOutPath "$INSTDIR\share\icons\breeze\actions\22"

  File ${prefix}/share/icons/breeze/actions/22/document-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/22/help-contextual.svg
  File ${prefix}/share/icons/breeze/actions/22/tools-report-bug.svg

 SetOutPath "$INSTDIR\share\icons\breeze\actions\24"

  File ${prefix}/share/icons/breeze/actions/24/document-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/24/help-contextual.svg
  File ${prefix}/share/icons/breeze/actions/24/tools-report-bug.svg

  SetOutPath "$INSTDIR\share\icons\breeze"

  File ${prefix}/share/icons/breeze/index.theme
  File ${prefix}/share/icons/breeze/icon-theme.cache

  SetOutPath "$INSTDIR\share\icons\kf5_rcc_theme"

  File ${prefix}/share/icons/breeze/index.theme
  File ${prefix}/share/icons/breeze/icon-theme.cache

  SetOutPath "$INSTDIR\share"

  File /oname=icontheme.rcc ${prefix}/share/icons/breeze/breeze-icons.rcc

!endif
SectionEnd

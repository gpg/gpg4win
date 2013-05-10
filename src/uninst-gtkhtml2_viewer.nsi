# uninst-gtkhtml2_viewer.nsi - Installer snippet for gtkhtml2_viewer.-*- coding: latin-1; -*-
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
!define prefix ${ipdir}/gtkhtml2_viewer-${gpg4win_pkg_gtkhtml2_viewer_version}


; Uninstaller section.
Section "-un.gtkhtml2_viewer"
!ifdef SOURCES
  Push "${gpg4win_pkg_gtkhtml2_viewer}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\lib\claws-mail\plugins\gtkhtml2_viewer.dll"
  RMDir "$INSTDIR\lib\claws-mail\plugins"
  RMDir "$INSTDIR\lib\claws-mail"
  Delete "$INSTDIR\share\locale\ca\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\cs\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\fi\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\hu\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\id_ID\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\it\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\ja\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\nl\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\pl\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\pt_BR\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\sk\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\sr\LC_MESSAGES\gtkhtml2_viewer.mo"
  Delete "$INSTDIR\share\locale\zh_CN\LC_MESSAGES\gtkhtml2_viewer.mo"
!endif
SectionEnd

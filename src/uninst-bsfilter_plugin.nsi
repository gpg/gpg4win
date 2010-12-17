# uninst-bsfilter_plugin.nsi - Installer snippet for bsfilter_plugin.-*- coding: latin-1; -*-
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
!define prefix ${ipdir}/bsfilter_plugin-${gpg4win_pkg_bsfilter_plugin_version}


; Uninstaller section.
Section "-un.bsfilter_plugin"
!ifdef SOURCES
  Push "${gpg4win_pkg_bsfilter_plugin}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\lib\claws-mail\plugins\bsfilter.dll"
  RMDir "$INSTDIR\lib\claws-mail\plugins"
  RMDir "$INSTDIR\lib\claws-mail"
  Delete "$INSTDIR\share\locale\pt_BR\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\pt_BR\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\pt_BR"
  Delete "$INSTDIR\share\locale\ja\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\ja\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\ja"
  Delete "$INSTDIR\share\locale\fi\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\fi\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\fi"
  Delete "$INSTDIR\share\locale\it\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\it\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\it"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\es\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\es"
  Delete "$INSTDIR\share\locale\id\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\id\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\id"
  Delete "$INSTDIR\share\locale\nl\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\nl\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\nl"
  Delete "$INSTDIR\share\locale\cs\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\cs\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\cs"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\ru\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\ru"
  Delete "$INSTDIR\share\locale\sk\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\sk\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\sk"
  Delete "$INSTDIR\share\locale\ca\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\ca\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\ca"
  Delete "$INSTDIR\share\locale\hu\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\hu\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\hu"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\bsfilter_plugin.mo"
  RMDir  "$INSTDIR\share\locale\fr\LC_MESSAGES"
  RMDir  "$INSTDIR\share\locale\fr"
  RMDir  "$INSTDIR\share\locale"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR"

!endif
SectionEnd

# uninst-claws-mail.nsi - Installer snippet.        -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/claws-mail-${gpg4win_pkg_claws_mail_version}


# Uninstaller section.
Section "-un.claws-mail"
!ifdef SOURCES
  Push "${gpg4win_pkg_claws_mail}"
  Call un.SourceDelete
!else
  Delete "$INSTDIR\claws-mail.exe"

  Delete "$INSTDIR\claws-mail-manual.pdf"

  Delete "$INSTDIR\share\claws-mail\ca-certificates.crt"
  Delete "$INSTDIR\lib\claws-mail\plugins\pgpcore.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\pgpinline.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\pgpinline.deps"
  Delete "$INSTDIR\lib\claws-mail\plugins\pgpmime.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\pgpmime.deps"
  Delete "$INSTDIR\lib\claws-mail\plugins\smime.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\smime.deps"
  RMDir "$INSTDIR\lib\claws-mail\plugins"
  RMDir "$INSTDIR\lib\claws-mail"
  RMDir "$INSTDIR\share\claws-mail"
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR\share"

  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\claws-mail.mo"
  RMDir "$INSTDIR\share\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\de"
  RMDir "$INSTDIR\share\locale\fr\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\fr"
  RMDir "$INSTDIR\share\locale"

  RMDir "$INSTDIR\share\claws-mail"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR"
  DeleteRegKey HKLM "SOFTWARE\Clients\Mail\Claws Mail"
  DeleteRegKey HKLM "SOFTWARE\Classes\Claws-Mail.Url.mailto"

!endif
SectionEnd

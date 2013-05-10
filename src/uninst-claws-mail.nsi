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
  # We delete this file from the old (and removed) jpeg package, that
  # was only installed if claws was selected.
  Delete "$INSTDIR\jpeg62.dll"

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
  Delete "$INSTDIR\lib\claws-mail\plugins\address_keeper.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\att_remover.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\attachwarner.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\bsfilter.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\fetchinfo.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\notification.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\tnef_parse.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\rssyl.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\spamreport.dll"
  Delete "$INSTDIR\lib\claws-mail\plugins\vcalendar.dll"

  RMDir "$INSTDIR\lib\claws-mail\plugins"
  RMDir "$INSTDIR\lib\claws-mail"
  RMDir "$INSTDIR\share\claws-mail"
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR\share"

  Delete "$INSTDIR\share\locale\pt_BR\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\uk\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\bg\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\pl\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\ja\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\pt_PT\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\fi\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\it\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\id\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\zh_CN\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\nl\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\cs\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\sv\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\sk\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\ca\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\hu\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\claws-mail.mo"
  Delete "$INSTDIR\share\locale\en_GB\LC_MESSAGES\claws-mail.mo"

  RMDir "$INSTDIR\share\claws-mail"

  DeleteRegKey HKLM "SOFTWARE\Clients\Mail\Claws Mail"
  DeleteRegKey HKLM "SOFTWARE\Classes\Claws-Mail.Url.mailto"

!endif
SectionEnd

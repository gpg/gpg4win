# uninst-claws-mail-cmds.nsi - Installer snippet.    -*- coding: latin-1; -*-
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


# We delete this file from the old (and removed) jpeg package, that
# was only installed if claws was selected.
Delete "$INSTDIR\bin\jpeg62.dll"

Delete "$INSTDIR\bin\claws-mail.exe"

Delete "$INSTDIR\claws-mail-manual.pdf"

Delete "$INSTDIR\share\claws-mail\ca-certificates.crt"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\pgpcore.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\pgpinline.dll"
Delete "$INSTDIR\lib\claws-mail\plugins\pgpinline.deps"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\pgpmime.dll"
Delete "$INSTDIR\lib\claws-mail\plugins\pgpmime.deps"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\smime.dll"
Delete "$INSTDIR\lib\claws-mail\plugins\smime.deps"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\address_keeper.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\att_remover.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\attachwarner.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\bsfilter.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\fetchinfo.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\notification.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\tnef_parse.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\rssyl.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\spamreport.dll"
Delete "$INSTDIR\bin\lib\claws-mail\plugins\vcalendar.dll"

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

; libetpan
Delete "$INSTDIR\bin\libetpan-13.dll"

; libxml2
Delete "$INSTDIR\bin\libxml2-2.dll"

; regex
# Old version.
Delete "$INSTDIR\bin\regex.dll"

Delete "$INSTDIR\bin\libregex-1.dll"

; crypt had nothing to uninstall

; enchant
Delete "$INSTDIR\bin\libenchant-1.dll"
Delete "$INSTDIR\bin\lib\enchant\libenchant_myspell.dll"

RMDir "$INSTDIR\lib\enchant"
RMDir "$INSTDIR\lib"

# Dictionaries
Delete "$INSTDIR\share\enchant\myspell\en_US.aff"
Delete "$INSTDIR\share\enchant\myspell\en_US.dic"
Delete "$INSTDIR\share\enchant\myspell\de.aff"
Delete "$INSTDIR\share\enchant\myspell\de.dic"
Delete "$INSTDIR\share\enchant\myspell\fr.aff"
Delete "$INSTDIR\share\enchant\myspell\fr.dic"

RMDir "$INSTDIR\share\enchant\myspell"
RMDIR "$INSTDIR\share\enchant"

; gtkhtmlviewer2
Delete "$INSTDIR\bin\lib\claws-mail\plugins\gtkhtml2_viewer.dll"
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

; pthreads
Delete "$INSTDIR\bin\pthreadGC2.dll"

RMDir "$INSTDIR\share"
RMDir "$INSTDIR"

# inst-sylpheed.nsi - Installer snippet for Sylpheed. -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/sylpheed-claws-${gpg4win_pkg_sylpheed_claws_version}


Section "Sylpheed" SEC_sylpheed
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_sylpheed_claws}"
!else
  File ${prefix}/bin/sylpheed-claws.exe

  SetOutPath "$INSTDIR\lib\sylpheed-claws\plugins"
  File ${prefix}/lib/sylpheed-claws/plugins/pgpcore.dll
  File ${prefix}/lib/sylpheed-claws/plugins/pgpinline.dll
  File ${prefix}/lib/sylpheed-claws/plugins/pgpinline.deps
  File ${prefix}/lib/sylpheed-claws/plugins/pgpmime.dll
  File ${prefix}/lib/sylpheed-claws/plugins/pgpmime.deps

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/sylpheed-claws.mo
!endif
SectionEnd


LangString DESC_SEC_sylpheed ${LANG_ENGLISH} \
   "Sylpheed Mail-User-Agent"
LangString DESC_SEC_sylpheed ${LANG_GERMAN} \
   "Sylpheed ist ein vollständiges Mail- und News-Programm mit sehr guter \
    Unterstützung for GnuPG.  Dies ist die Sylpheed-Claws Variante."

LangString DESC_Menu_sylpheed ${LANG_ENGLISH} \
   "Run the Sylpheed mailprogram."
LangString DESC_Menu_sylpheed ${LANG_GERMAN} \
   "Das Mailprogramm Sylpheed aufrufen."

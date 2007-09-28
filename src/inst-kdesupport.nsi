# inst-kdesupport.nsi - Snippet for kdesupport.      -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/kdesupport-${gpg4win_pkg_kdesupport_version}

!ifdef DEBUG
Section "kdesupport" SEC_kdesupport
!else
Section "-kdesupport" SEC_kdesupport
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_kdesupport_src}"
!else
  # FIXME: Figure out how to relocate dbus-daemon (and kleopatra).
  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/dbus-daemon.exe
  SetOutPath "$INSTDIR"

  File ${prefix}/bin/dbus-launch.exe
  File ${prefix}/bin/dbus-monitor.exe
  File ${prefix}/bin/dbus-send.exe
  File ${prefix}/bin/pcregrep.exe
  File ${prefix}/bin/update-mime-database.exe
  File ${prefix}/bin/xmlcatalog.exe
  File ${prefix}/bin/xmllint.exe
  File ${prefix}/bin/xsltproc.exe

  # FIXME: From the lib package.  This is wrong.
!undef prefix
!define prefix ${ipdir}/kdesupport-dev-${gpg4win_pkg_kdesupport_version}

  SetOutPath "$INSTDIR"
  File ${prefix}/bin/giflib4.dll
  File ${prefix}/bin/libdbus-1.dll
  File ${prefix}/bin/libeay32.dll
  File ${prefix}/bin/libexpat.dll
  File ${prefix}/bin/libexpatw.dll
  File ${prefix}/bin/libexslt.dll
  File ${prefix}/bin/libkdewin32.dll
  File ${prefix}/bin/libxml2.dll
  File ${prefix}/bin/libxslt.dll
  File ${prefix}/bin/mingw-pcrecpp.dll
  File ${prefix}/bin/pcre.dll
  File ${prefix}/bin/pcrecpp.dll
  File ${prefix}/bin/pcreposix.dll
  File ${prefix}/bin/ssleay32.dll

  SetOutPath "$INSTDIR\etc"
  File ${prefix}/etc/session.conf
  File ${prefix}/etc/system.conf

!endif
SectionEnd

# inst-pinentry.nsi - Installer snippet.            -*- coding: latin-1; -*-
# Copyright (C) 2007 g10 Code GmbH
#
# This file is part of Gpg4win.
#
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.


!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/pinentry-${gpg4win_pkg_pinentry_version}

!ifdef DEBUG
Section "Pinentry" SEC_pinentry
!else
Section "-Pinentry" SEC_pinentry
!endif

  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_pinentry}"
!else

  File "${prefix}/bin/pinentry-w32.exe"
!ifdef GPG4WIN_VANILLA
  File /oname=pinentry.exe "${prefix}/bin/pinentry-w32.exe"
!else
  File "${prefix}/bin/pinentry-gtk-2.exe"

!ifndef GPG4WIN_LIGHT
!ifdef HAVE_PKG_QTBASE
  File "${prefix}/bin/pinentry-qt.exe"

  # If Qt is installed (usually by selecting kleopatra), we want
  # the Qt pinentry as well.  Otherwise punt to gtk pinentry,
  # which is always available.
  !insertmacro SectionFlagIsSet ${SEC_qtbase} \
                ${SF_SELECTED} inst_pinentry_have_qt inst_pinentry_skip_qt
  inst_pinentry_have_qt:
  File /oname=pinentry.exe "${prefix}/bin/pinentry-qt.exe"
  Goto inst_pinentry_done
  inst_pinentry_skip_qt:
!endif
!endif
  File /oname=pinentry.exe "${prefix}/bin/pinentry-gtk-2.exe"

!endif
  inst_pinentry_done:

!endif
SectionEnd

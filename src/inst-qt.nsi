# inst-qt.nsi - Installer snippet for qt.      -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/qt-${gpg4win_pkg_qt_version}

!ifdef DEBUG
Section "qt" SEC_qt
!else
Section "-qt" SEC_qt
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_qt_src}"
!else
  # Qt needs some help to find itself.
  File ${SRCDIR}/qt.conf

  File ${prefix}/bin/QtCore4.dll
  File ${prefix}/bin/QtDBus4.dll
  File ${prefix}/bin/QtGui4.dll
  File ${prefix}/bin/QtNetwork4.dll
  File ${prefix}/bin/QtSvg4.dll
  File ${prefix}/bin/QtXml4.dll

  SetOutPath "$INSTDIR\plugins\imageformats"

  File ${prefix}/plugins/imageformats/qgif4.dll
  File ${prefix}/plugins/imageformats/qico4.dll
  File ${prefix}/plugins/imageformats/qjpeg4.dll
  File ${prefix}/plugins/imageformats/qmng4.dll
  File ${prefix}/plugins/imageformats/qsvg4.dll
  File ${prefix}/plugins/imageformats/qtiff4.dll

  # For what is this needed? Scripting?
  SetOutPath "$INSTDIR"
  File ${prefix}/bin/qdbus.exe

!endif
SectionEnd

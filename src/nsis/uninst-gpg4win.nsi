# uninst-gpg4win.nsi - Hidden uninstaller.           -*- coding: latin-1; -*-
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


# This is the very last section of the uninstaller.
Section "-un.gpg4win"
!ifdef SOURCES
  Delete "gpg4win-${VERSION}.tar.bz2"
!else

  DeleteRegValue SHCTX "Software\GNU\GnuPG" "Install Directory"

  # Delete gpg4win included tools
  Delete "$INSTDIR\bin\sha1sum.exe"
  Delete "$INSTDIR\bin\sha256sum.exe"
  Delete "$INSTDIR\bin\md5sum.exe"

  # Delete the runtime libaries
  Delete "$INSTDIR\bin\libstdc++-6.dll"
  Delete "$INSTDIR\bin\libgcc_s_sjlj-1.dll"
  Delete "$INSTDIR\bin\libgcc_s_dw2-1.dll"
  Delete "$INSTDIR\bin\libgcc_s_seh-1.dll"
  Delete "$INSTDIR\bin\libwinpthread-1.dll"
  Delete /REBOOTOK "$INSTDIR\${EX_BINDIR}\libwinpthread-1.dll"

  # Delete standard stuff.
  Delete "$INSTDIR\share\gpg4win\HOWTO-SMIME.*.txt"

  Delete "$INSTDIR\versioninfo.txt"

  Delete "$INSTDIR\VERSION"

  Delete "$INSTDIR\pkg-licenses.txt"

  RMDir "$INSTDIR\share\gpg4win"

  # Remove the locale directories.
  RMDir "$INSTDIR\share\locale\ar\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ar"
  RMDir "$INSTDIR\share\locale\be\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\be"
  RMDir "$INSTDIR\share\locale\bg\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\bg"
  RMDir "$INSTDIR\share\locale\ca\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ca"
  RMDir "$INSTDIR\share\locale\cs\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\cs"
  RMDir "$INSTDIR\share\locale\da\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\da"
  RMDir "$INSTDIR\share\locale\de\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\de"
  RMDir "$INSTDIR\share\locale\el\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\el"
  RMDir "$INSTDIR\share\locale\en@boldquot\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\en@boldquot"
  RMDir "$INSTDIR\share\locale\en@quot\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\en@quot"
  RMDir "$INSTDIR\share\locale\en_GB\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\en_GB"
  RMDir "$INSTDIR\share\locale\eo\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\eo"
  RMDir "$INSTDIR\share\locale\es\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\es"
  RMDir "$INSTDIR\share\locale\et\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\et"
  RMDir "$INSTDIR\share\locale\fi\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\fi"
  RMDir "$INSTDIR\share\locale\fr\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\fr"
  RMDir "$INSTDIR\share\locale\gl\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\gl"
  RMDir "$INSTDIR\share\locale\hu\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\hu"
  RMDir "$INSTDIR\share\locale\id\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\id"
  RMDir "$INSTDIR\share\locale\id_ID\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\id_ID"
  RMDir "$INSTDIR\share\locale\it\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\it"
  RMDir "$INSTDIR\share\locale\ja\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ja"
  RMDir "$INSTDIR\share\locale\nb\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\nb"
  RMDir "$INSTDIR\share\locale\nl\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\nl"
  RMDir "$INSTDIR\share\locale\pl\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\pl"
  RMDir "$INSTDIR\share\locale\pt_BR\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\pt_BR"
  RMDir "$INSTDIR\share\locale\pt_PT\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\pt_PT"
  RMDir "$INSTDIR\share\locale\pt\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\pt"
  RMDir "$INSTDIR\share\locale\ro\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ro"
  RMDir "$INSTDIR\share\locale\ru\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\ru"
  RMDir "$INSTDIR\share\locale\sk\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\sk"
  RMDir "$INSTDIR\share\locale\sv\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\sv"
  RMDir "$INSTDIR\share\locale\sr\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\sr"
  RMDir "$INSTDIR\share\locale\tr\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\tr"
  RMDir "$INSTDIR\share\locale\uk\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\uk"
  RMDir "$INSTDIR\share\locale\zh_CN\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\zh_CN"
  RMDir "$INSTDIR\share\locale\zh_TW\LC_MESSAGES"
  RMDir "$INSTDIR\share\locale\zh_TW"

  RMDir "$INSTDIR\share\locale"

  # Try again to remove the scdaemon.  This is useful because scdaemon
  # needs some time to stop after gpg-agent has been stopped.
  Delete "$INSTDIR\bin\scdaemon.exe"

  # Try to remove other top directories.
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR\include"
  RMDir "$INSTDIR\share"
  RMDir "$INSTDIR\pub"
  RMDir "$INSTDIR\etc"
  RMDir "$INSTDIR\bin"
  RMDir "$INSTDIR\bin_64"
  RMDir "$INSTDIR\${EX_BINDIR}"
  RMDir "$INSTDIR"

!endif
SectionEnd

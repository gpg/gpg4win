# Copyright (C) 2023 g10 Code GmbH
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
!define prefix ${ipdir}/gpgpass-${gpg4win_pkg_gpgpass_version}

# gpgpass - Opt in for now.
${MementoUnselectedSection} "GnuPG Password Manager" SEC_gpgpass

  SetOutPath "$INSTDIR\bin"
  File ${prefix}/bin/gpgpass.exe

${MementoSectionEnd}

LangString DESC_SEC_gpgpass ${LANG_ENGLISH} \
   "A password manager which uses GnuPG to decrypt and encrypt your passwords."

LangString DESC_Menu_gpgpass ${LANG_ENGLISH} \
   "Run the GnuPG Password Manager"

# uninst-gpa.nsi - Installer snippet for gpa.      -*- coding: latin-1; -*-
# Copyright (C) 2005, 2008 g10 Code GmbH
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
!define prefix ${ipdir}/gpa-${gpg4win_pkg_gpa_version}


; Uninstaller section.
Section "-un.gpa"
!ifdef SOURCES
  Push "${gpg4win_pkg_gpa}"
  Call un.SourceDelete
!else
  Delete /REBOOTOK "$INSTDIR\bin\gpa.exe"

  Delete "$INSTDIR\share\locale\de\LC_MESSAGES\gpa.mo"
  Delete "$INSTDIR\share\locale\ar\LC_MESSAGES\gpa.mo"
  Delete "$INSTDIR\share\locale\es\LC_MESSAGES\gpa.mo"
  Delete "$INSTDIR\share\locale\fr\LC_MESSAGES\gpa.mo"
  Delete "$INSTDIR\share\locale\ru\LC_MESSAGES\gpa.mo"

  Delete "$INSTDIR\share\gpa\gpa_tips.en"
  Delete "$INSTDIR\share\gpa\gpa_tips.de"
  Delete "$INSTDIR\share\gpa\gpa-logo.ppm"
  Delete "$INSTDIR\share\gpa\gpa.png"
  RMDir "$INSTDIR\share\gpa"

  DeleteRegKey HKLM "Software\Classes\gpg4win.AssocFile.gpa.GPG"
  DeleteRegKey HKLM "Software\Classes\gpg4win.AssocFile.gpa.ASC"
  DeleteRegKey HKLM "Software\Classes\gpg4win.AssocFile.gpa.CMS"
  DeleteRegKey HKLM "Software\Classes\gpg4win.AssocFile.gpa.X509"
  DeleteRegKey HKLM "Software\Classes\gpg4win.AssocFile.gpa.PGPSIG"
  DeleteRegKey HKLM "Software\Gpg4win\gpa"
  DeleteRegValue HKLM "Software\RegisteredApplications" "Gpg4win.gpa.${VERSION}"
  DeleteRegValue HKLM "Software\Classes\.gpg" "gpg4win.AssocFile.gpa.GPG"
  DeleteRegValue HKLM "Software\Classes\.asc" "gpg4win.AssocFile.gpa.ASC"
  DeleteRegValue HKLM "Software\Classes\.pgp" "gpg4win.AssocFile.gpa.PGP"
  DeleteRegValue HKLM "Software\Classes\.pem" "gpg4win.AssocFile.gpa.CMS"
  DeleteRegValue HKLM "Software\Classes\.p7s" "gpg4win.AssocFile.gpa.CMS"
  DeleteRegValue HKLM "Software\Classes\.p7m" "gpg4win.AssocFile.gpa.CMS"
  DeleteRegValue HKLM "Software\Classes\.arl" "gpg4win.AssocFile.gpa.CMS"
  DeleteRegValue HKLM "Software\Classes\.crl" "gpg4win.AssocFile.gpa.CMS"

  DeleteRegKey /ifempty HKLM "Software\Classes\.gpg"
  DeleteRegKey /ifempty HKLM "Software\Classes\.asc"
  DeleteRegKey /ifempty HKLM "Software\Classes\.pgp"
  DeleteRegKey /ifempty HKLM "Software\Classes\.sig"
  DeleteRegKey /ifempty HKLM "Software\Classes\.pem"
  DeleteRegKey /ifempty HKLM "Software\Classes\.p7m"
  DeleteRegKey /ifempty HKLM "Software\Classes\.p7s"
  DeleteRegKey /ifempty HKLM "Software\Classes\.crl"
  DeleteRegKey /ifempty HKLM "Software\Classes\.arl"

!endif
SectionEnd

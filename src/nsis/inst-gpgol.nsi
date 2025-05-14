# inst-gpgol.nsi - Installer snippet for gpgol.      -*- coding: latin-1; -*-
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
!ifdef exprefix
!undef exprefix
!endif
!define prefix ${ipdir}/gpgol-${gpg4win_pkg_gpgol_version}
!define bdir ${bpdir}/gpgol-${gpg4win_pkg_gpgol_version}-build
!define exprefix ${exipdir}/gpgol-${gpg4win_pkg_gpgol_version}


${MementoSection} "GpgOL" SEC_gpgol
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gpgol}"
!else

  SetOutPath "$INSTDIR\bin"
  ClearErrors
  SetOverwrite try
  File ${prefix}/bin/gpgol.dll
  SetOverwrite lastused
  ifErrors 0 do_reg
      File /oname=gpgol.dll.tmp ${prefix}/bin/gpgol.dll
      Rename /REBOOTOK gpgol.dll.tmp gpgol.dll

 do_reg:
  # Register the DLL.
!ifdef IS_W64_INST
  # Do the 64 bit call with the bin gpgol.dll
  ExecWait '"$SYSDIR\regsvr32" /s "$INSTDIR\bin\gpgol.dll"'
!else
  # Do the 32 bit call with the bin gpgol.dll
  RegDLL "$INSTDIR\bin\gpgol.dll"
!endif
  ifErrors 0 +2
     MessageBox MB_OK "$(T_GpgOL_RegFailed)"

  SetOutPath "$INSTDIR\share\locale\de\LC_MESSAGES"
  File ${prefix}/share/locale/de/LC_MESSAGES/gpgol.mo
  SetOutPath "$INSTDIR\share\locale\sv\LC_MESSAGES"
  File ${prefix}/share/locale/sv/LC_MESSAGES/gpgol.mo
  SetOutPath "$INSTDIR\share\locale\pt\LC_MESSAGES"
  File ${prefix}/share/locale/pt/LC_MESSAGES/gpgol.mo
  SetOutPath "$INSTDIR\share\locale\fr\LC_MESSAGES"
  File ${prefix}/share/locale/fr/LC_MESSAGES/gpgol.mo
  SetOutPath "$INSTDIR\share\locale\zh_CN\LC_MESSAGES"
  File ${prefix}/share/locale/zh_CN/LC_MESSAGES/gpgol.mo
  SetOutPath "$INSTDIR\share\locale\zh_TW\LC_MESSAGES"
  File ${prefix}/share/locale/zh_TW/LC_MESSAGES/gpgol.mo
  SetOutPath "$INSTDIR\share\locale\nl\LC_MESSAGES"
  File ${prefix}/share/locale/nl/LC_MESSAGES/gpgol.mo
  SetOutPath "$INSTDIR\share\locale\uk\LC_MESSAGES"
  File ${prefix}/share/locale/uk/LC_MESSAGES/gpgol.mo
  SetOutPath "$INSTDIR\share\locale\it\LC_MESSAGES"
  File ${prefix}/share/locale/it/LC_MESSAGES/gpgol.mo

  SetOutPath "$INSTDIR\share\gpgol"
  File "${prefix}/share/gpgol/gpgol.cfg"
  File "${prefix}/share/gpgol/gpgol-cs.cfg"
  File "${prefix}/share/gpgol/gpgol-form-signed.cfg"
  File "${prefix}/share/gpgol/gpgol-ms.cfg"
  File "${prefix}/share/gpgol/gpgol-form-encrypted.cfg"

  File "${prefix}/share/gpgol/encr-l.ico"
  File "${prefix}/share/gpgol/encr-s.ico"
  File "${prefix}/share/gpgol/encr-s-smime.ico"
  File "${prefix}/share/gpgol/sign-l.ico"
  File "${prefix}/share/gpgol/sign-s.ico"
  File "${prefix}/share/gpgol/sign-s-smime.ico"

  SetOutPath "$INSTDIR\share\doc\gpgol"
  File "${bdir}/doc/gpgol.pdf"

${If} ${RunningX64}

  # Install the 64 bit version of the dll.
  SetOutPath "$INSTDIR\${EX_BINDIR}"
  ClearErrors
  SetOverwrite try
  File ${exprefix}/bin/gpgol.dll
  SetOverwrite lastused
  ifErrors 0 do_reg64
      File /oname=gpgol.dll.tmp ${exprefix}/bin/gpgol.dll
      Rename /REBOOTOK gpgol.dll.tmp gpgol.dll

 do_reg64:
  # Register the DLL. We need to register both versions.  However
  # RegDLL can't be used for 64 bit and InstallLib seems to be a
  # registry hack.
  ClearErrors
!ifdef IS_W64_INST
  # Register the 32 bit DLL that is installed under the ex prefix
  RegDLL "$INSTDIR\${EX_BINDIR}\gpgol.dll"
!else
  ExecWait '"$SYSDIR\regsvr32" /s "$INSTDIR\${EX_BINDIR}\gpgol.dll"'
!endif
${EndIf}

!endif

${MementoSectionEnd}


LangString T_GpgOL_RegFailed ${LANG_ENGLISH} \
   "Warning: Registration of the GpgOL Outlook plugin failed."

LangString DESC_SEC_gpgol ${LANG_ENGLISH} \
   "GnuPG for Outlook"

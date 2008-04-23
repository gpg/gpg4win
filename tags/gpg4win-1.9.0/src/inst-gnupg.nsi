# inst-gnupg.nsi - Installer snippet for gnupg.     -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/gnupg-${gpg4win_pkg_gnupg_version}


${MementoSection} "GnuPG" SEC_gnupg
  SectionIn RO

  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gnupg}"
!else
  File "${prefix}/bin/gpg.exe"
  File "${prefix}/bin/gpgsplit.exe"
  File "${prefix}/bin/gpgv.exe"

  # As a special exception, these programs are not kept in
  # libexec/gnupg, where they belong.  Please see the comment in
  # gnupg/g10/keyserver.c::keyserver_spawn() for an explanation.
  File "${prefix}/libexec/gnupg/gpgkeys_finger.exe"
  File "${prefix}/libexec/gnupg/gpgkeys_hkp.exe"
  File "${prefix}/libexec/gnupg/gpgkeys_curl.exe"
  File "${prefix}/libexec/gnupg/gpgkeys_ldap.exe"

  SetOutPath "$INSTDIR\pub"
  File /oname=gpg.exe      "${BUILD_DIR}/gpgwrap.exe"
  File /oname=gpgv.exe     "${BUILD_DIR}/gpgwrap.exe"
  File /oname=gpgsplit.exe "${BUILD_DIR}/gpgwrap.exe"

  SetOutPath "$INSTDIR\share\gnupg"
  File "${prefix}/share/gnupg/options.skel"
  File "${prefix}/share/gnupg/FAQ"
  File "${prefix}/share/gnupg/faq.html"
  File "${prefix}/share/man/man1/gpg.man"
  File "${prefix}/share/man/man1/gpgv.man"
  File "${prefix}/share/man/man7/gnupg.man"

  # Install the language files for gpg.  Note that the PO files are
  # required to be UTF-8 encoded and that the post-install macro in
  # Makefile.am needs to build them.

  # Note that we do not install the mo files for gpg1 anymore.  This
  # is because the build systems can't cope with it (stow conflicts)
  # and becuase translations for the server version are usually not
  # required.  Instead we install the gnupg2 mo files.
  #SetOutPath "$INSTDIR\gnupg.nls"


  # If requested, install the configured gpg.conf.
  Var /GLOBAL ConfigGPGConf
  g4wihelp::config_fetch "gpg.conf"
  StrCpy $ConfigGPGConf $R0
  StrCmp $ConfigGPGConf "" no_config_gpg_conf
    ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" AppData
    StrCmp $0 "" no_config_gpg_conf
    CreateDirectory "$0\gnupg"
    CopyFiles $ConfigGPGConf "$0\gnupg\gpg.conf"
  no_config_gpg_conf:


  WriteRegStr HKLM "Software\GNU\GnuPG" "Install Directory" $INSTDIR

  # We used to determine the language using a Registry entry.
  # Although we don't want to delete the user's Lang Resgistry Setting
  # becuase he might have have selected a different language than his
  # default.  We delete the gloabl Lang of the installation.
  DeleteRegValue HKLM "Software\GNU\GnuPG" "Lang" 

  # This old key is required for GPGee.  Please do not use in new
  # applications.
  # Note: We don't use it anymore so that gpgme decides what gpg to use
  #       For the new gpg4win we actually use gpg2.exe.
  #       To cope with old installations we actually remove this value.
  #       However we can only remove the HKLM version not those set by
  #       the user under HKCU.
  #WriteRegStr HKLM "Software\GNU\GnuPG" "gpgProgram" "$INSTDIR\gpg.exe"
  DeleteRegValue HKLM "Software\GNU\GnuPG" "gpgProgram"

  # Add the public directory to the PATH
  Push "$INSTDIR\pub"
  Call AddToPath

!endif
${MementoSectionEnd}


LangString DESC_SEC_gnupg ${LANG_ENGLISH} \
   "GNU Privacy Guard"


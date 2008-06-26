# inst-gnupg2.nsi - Installer snippet for gnupg2.     -*- coding: latin-1; -*-
# Copyright (C) 2007, 2008 g10 Code GmbH
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
!define prefix ${ipdir}/gnupg2-${gpg4win_pkg_gnupg2_version}
!define source ${bpdir}/gnupg2-${gpg4win_pkg_gnupg2_version}


${MementoSection} "GnuPG" SEC_gnupg2
  SectionIn RO

  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_gnupg2}"
!else
  File "${prefix}/bin/gpg2.exe"
  File "${prefix}/bin/gpgv2.exe"
  File "${prefix}/bin/gpgsm.exe"

  # Fixme: gpgsplit is missing.  I doubt that it makes sense to rename
  # it like we did with gpg.  It might be better to install this tool
  # into a subdirectory.

  # If we are reinstalling, try to kill a possible running agent 
  ifFileExists "$INSTDIR\gpg-connect-agent.exe"  0 no_gpg_connect_agent
    ExecWait '"$INSTDIR\gpg-connect-agent.exe" killagent /bye'
  no_gpg_connect_agent:

  ClearErrors
  SetOverwrite try
  File "${prefix}/bin/gpg-agent.exe"
  SetOverwrite lastused
  ifErrors 0 +3
      File /oname=gpg-agent.exe.tmp "${prefix}/bin/gpg-agent.exe"
      Rename /REBOOTOK gpg-agent.exe.tmp gpg-agent.exe

  File "${prefix}/bin/scdaemon.exe"
  File "${prefix}/bin/gpgconf.exe"
  File "${prefix}/bin/gpg-connect-agent.exe"


  # As a special exception, these programs are not kept in
  # libexec/gnupg, where they belong.  Please see the comment in
  # gnupg/g10/keyserver.c::keyserver_spawn() for an explanation.
  File "${prefix}/libexec/gpg2keys_finger.exe"
  File "${prefix}/libexec/gpg2keys_hkp.exe"
  File "${prefix}/libexec/gpg2keys_curl.exe"
  File "${prefix}/libexec/gpg2keys_ldap.exe"
  File /nonfatal "${prefix}/libexec/gpg2keys_kdns.exe"
  File "${prefix}/libexec/gpg-protect-tool.exe"
  File "${prefix}/libexec/gpg-preset-passphrase.exe"

  # Install the wrappers into the PATH included directory.  These are
  # our poor hacker's symlinks.  We always install wrappers
  # gpg[v]->gpg[v]2.  If old applications are not able to to work with
  # gpg2, they may still install a gpg1 version and use the installed
  # version directly without the wrapper.
  SetOutPath "$INSTDIR\pub"
  File /oname=gpg.exe       "${BUILD_DIR}/gpgwrap-2.exe"
  File /oname=gpgv.exe      "${BUILD_DIR}/gpgwrap-2.exe"
  File /oname=gpg2.exe      "${BUILD_DIR}/gpgwrap.exe"
  File /oname=gpgsm.exe     "${BUILD_DIR}/gpgwrap.exe"
  File /oname=gpg-connect-agent.exe  "${BUILD_DIR}/gpgwrap.exe"
  # fixme: gpgsplit is missing; see above

  SetOutPath "$INSTDIR\share\gnupg"
  File "${prefix}/share/gnupg/qualified.txt"
  # Due to problems with kleoptra we currently do not install the
  # common certificates anymore.
  #File "${prefix}/share/gnupg/com-certs.pem"
  File "${prefix}/share/gnupg/gpg-conf.skel"
  # [fixme: Missing in gnupg2] File "${prefix}/share/gnupg/options.skel"
  # [fixme: Missing in gnupg2] File "${prefix}/share/gnupg/FAQ"
  # [fixme: Missing in gnupg2] File "${prefix}/share/gnupg/faq.html"
  File "${prefix}/share/man/man1/gpg2.man"
  File "${prefix}/share/man/man1/gpgv2.man"
  File "${prefix}/share/man/man1/gpgsm.man"
  File "${prefix}/share/man/man1/gpg-agent.man"
  File "${prefix}/share/man/man1/scdaemon.man"
  File "${prefix}/share/man/man1/gpg-connect-agent.man"
  File "${prefix}/share/man/man1/gpgconf.man"

  # Install the language files for gpg.  Note that the PO files are
  # required to be UTF-8 encoded and that the post-install macro in
  # Makefile.am needs to build them.  The language used is selected by
  # using a Registry entry; see inst-gnupg.nsi.
  File /nonfatal "${prefix}/share/gnupg/help.*.txt"
  SetOutPath "$INSTDIR\gnupg2.nls"
  File /nonfatal "${prefix}/share/gnupg/*.mo"

  # Always install the new template into COMMON_APPDATA folder.
  SetShellVarContext all
  SetOutPath "$APPDATA\GNU\etc\gnupg"
  File /oname=gpgconf-conf.skel "${source}/doc/examples/gpgconf.conf"
  SetShellVarContext current


  # If requested, install the configuration files.
  ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" AppData
  StrCmp $0 "" no_config_gpg_conf_files
  CreateDirectory "$0\gnupg"

  g4wihelp::config_fetch "gpg.conf"
  StrCmp $R0 "" no_config_gpg2_conf
    CopyFiles $R0 "$0\gnupg\gpg.conf"
  no_config_gpg2_conf:

  g4wihelp::config_fetch "gpg-agent.conf"
  StrCmp $R0 "" no_config_gpg_agent_conf
    CopyFiles $R0 "$0\gnupg\gpg-agent.conf"
  no_config_gpg_agent_conf:

  g4wihelp::config_fetch "scdaemon.conf"
  StrCmp $R0 "" no_config_scdaemon_conf
    CopyFiles $R0 "$0\gnupg\scdaemon.conf"
  no_config_scdaemon_conf:

  g4wihelp::config_fetch "trustlist.txt"
  StrCmp $R0 "" no_config_trustlist_txt
    CopyFiles $R0 "$0\gnupg\trustlist.txt"
  no_config_trustlist_txt:

  no_config_gpg_conf_files:

!endif
${MementoSectionEnd}

LangString DESC_SEC_gnupg2 ${LANG_ENGLISH} \
   "GNU Privacy Guard"

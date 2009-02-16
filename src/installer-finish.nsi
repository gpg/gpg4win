# installer-finish.nsi - Installer for GPG4Win.      -*- coding: latin-1; -*-
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

Var MYTMP

# Last section is a hidden one.
Section
  WriteUninstaller "$INSTDIR\${PACKAGE}-uninstall.exe"

!ifdef HAVE_STARTMENU
  # Check if the start menu entries where requested.
  !insertmacro MUI_INSTALLOPTIONS_READ $R0 "installer-options.ini" \
        "Field 2" "State"
  IntCmp $R0 0 no_start_menu_uninstall

  # Create a shortcut named "new shortcut" in the start menu programs
  # directory point the new shortcut at the program uninstaller
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" \
    "$INSTDIR\${PACKAGE}-uninstall.exe" \
    "" "$INSTDIR\${PACKAGE}-uninstall.exe" "" SW_SHOWNORMAL "" $(DESC_Menu_uninstall)
  no_start_menu_uninstall:
!endif

  # Windows Add/Remove Programs support
  # Note that the version is appended to the DisplayName, despite that
  # this is not necessary as a click on "support information" gives
  # the version number.  Some tools do that, other don't.  I don't
  # like it but others want me to do that.  -wk
  StrCpy $MYTMP "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRETTY_PACKAGE_SHORT}"
  WriteRegExpandStr HKLM $MYTMP "UninstallString" '"$INSTDIR\${PACKAGE}-uninstall.exe"'
  WriteRegExpandStr HKLM $MYTMP "InstallLocation" "$INSTDIR"
  WriteRegStr       HKLM $MYTMP "DisplayName"     "${PRETTY_PACKAGE} (${VERSION})"
  WriteRegStr       HKLM $MYTMP "DisplayIcon"     "$INSTDIR\gpg.exe,0"
  WriteRegStr       HKLM $MYTMP "DisplayVersion"  "${VERSION}"
  WriteRegStr       HKLM $MYTMP "Publisher"       "The Gpg4win Project"
  WriteRegStr       HKLM $MYTMP "URLInfoAbout"    "http://www.gpg4win.org/"
  WriteRegDWORD     HKLM $MYTMP "NoModify"        "1"
  WriteRegDWORD     HKLM $MYTMP "NoRepair"        "1"
SectionEnd


Section Uninstall

!ifdef HAVE_STARTMENU
  # Make sure that the context of the automatic variables has been set to
  # the "all users" shell folder.  This guarantees that the menu gets written
  # for all users.  We have already checked that we are running as Admin; or
  # we printed a warning that installation will not succeed.
  SetShellVarContext all

  #---------------------------------------------------
  # Delete the menu entries and any empty parent menus
  #---------------------------------------------------
  !insertmacro MUI_STARTMENU_GETFOLDER Application $MYTMP
  g4wihelp::config_fetch "inst_start_menu_folder"
  StrCmp $R0 "" +2
  StrCpy $MYTMP $R0
  Delete "$SMPROGRAMS\$MYTMP\*.lnk"
  Delete "$SMPROGRAMS\$MYTMP\$(DESC_Menu_manuals)\*.lnk"
  RMDir "$SMPROGRAMS\$MYTMP\$(DESC_Menu_manuals)"

  RMDir "$SMPROGRAMS\$MYTMP\$(DESC_Desktop_manuals)"
  StrCpy $MYTMP "$SMPROGRAMS\$MYTMP"
  startMenuDeleteLoop:
    ClearErrors
    RMDir $MYTMP
    GetFullPathName $MYTMP "$MYTMP\.."
    IfErrors startMenuDeleteLoopDone
    StrCmp $MYTMP $SMPROGRAMS startMenuDeleteLoopDone startMenuDeleteLoop
  startMenuDeleteLoopDone:

  DeleteRegValue HKLM "Software\GNU\${PRETTY_PACKAGE_SHORT}" \
        "Start Menu Folder"


  # Delete Desktop links.
!ifdef HAVE_PKG_WINPT
  Delete "$DESKTOP\WinPT.lnk"
!endif
!ifdef HAVE_PKG_GPA
  Delete "$DESKTOP\GPA.lnk"
!endif
!ifdef HAVE_PKG_KLEOPATRA
  Delete "$DESKTOP\Kleopatra.lnk"
!endif
!ifdef HAVE_PKG_SYLPHEED_CLAWS
  Delete "$DESKTOP\Sylpheed-Claws.lnk"
  Delete "$DESKTOP\Sylpheed-Claws Manual.lnk" \
  # We better delete also the name we used prior to 1.0.3
  Delete "$DESKTOP\Sylpheed.lnk"
!endif
!ifdef HAVE_PKG_CLAWS_MAIL
  Delete "$DESKTOP\Claws-Mail.lnk"
  Delete "$DESKTOP\$(DESC_Desktop_manuals)\Claws-Mail Manual.lnk"
!endif
!ifdef HAVE_PKG_COMPENDIUM_DE
  Delete "$DESKTOP\$(DESC_Desktop_manuals)\$(DESC_Name_compendium_de).lnk"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
  Delete "$DESKTOP\$(DESC_Desktop_manuals)\$(DESC_Name_man_novice_de).lnk"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_EN
  Delete "$DESKTOP\$(DESC_Desktop_manuals)\$(DESC_Name_man_novice_en).lnk"
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_DE
  Delete "$DESKTOP\$(DESC_Desktop_manuals)\$(DESC_Name_man_advanced_de).lnk"
!endif
!ifdef HAVE_PKG_GPGEE
  Delete "$DESKTOP\$(DESC_Desktop_manuals)\GPGee Manual.lnk"
!endif
  Delete "$DESKTOP\$(DESC_Desktop_manuals)\GnuPG FAQ.lnk"
  Delete "$DESKTOP\$(DESC_Desktop_manuals)\Gpg4Win README.lnk"
  RMDir "$DESKTOP\$(DESC_Desktop_manuals)"

  # Delete Quick Launch Bar links.
  StrCmp $QUICKLAUNCH $TEMP no_quick_launch_uninstall
!ifdef HAVE_PKG_WINPT
  Delete "$QUICKLAUNCH\WinPT.lnk"
!endif
!ifdef HAVE_PKG_GPA
  Delete "$QUICKLAUNCH\GPA.lnk"
!endif
!ifdef HAVE_PKG_KLEOPATRA
  Delete "$QUICKLAUNCH\Kleopatra.lnk"
!endif
!ifdef HAVE_PKG_SYLPHEED_CLAWS
  Delete "$QUICKLAUNCH\Sylpheed-Claws.lnk"
  # We better delete also the name we used prior to 1.0.3
  Delete "$QUICKLAUNCH\Sylpheed.lnk"
!endif
!ifdef HAVE_PKG_CLAWS_MAIL
  Delete "$QUICKLAUNCH\Claws-Mail.lnk"
!endif
!ifdef HAVE_PKG_COMPENDIUM_DE
  Delete "$QUICKLAUNCH\$(DESC_Name_compendium_de).lnk"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
  Delete "$QUICKLAUNCH\$(DESC_Name_man_novice_de).lnk"
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_DE
  Delete "$QUICKLAUNCH\$(DESC_Name_man_advanced_de).lnk"
!endif
!ifdef HAVE_PKG_GPGEE
  Delete "$QUICKLAUNCH\GPGee Manual.lnk"
!endif
  Delete "$QUICKLAUNCH\GnuPG FAQ.lnk"
  Delete "$QUICKLAUNCH\Gpg4Win README.lnk"
no_quick_launch_uninstall:

!endif

  Delete "$INSTDIR\${PACKAGE}-uninstall.exe"
  RMDir "$INSTDIR"

  # If we installed in the default location, try to be really, really
  # nice with sugar on it to clean up behind us.
  StrCmp "$INSTDIR" "$PROGRAMFILES\GNU\${INSTALL_DIR}" 0 +2
  RMDir "$PROGRAMFILES\GNU"

  # Clean the registry.
  DeleteRegValue HKLM "Software\GNU\${PRETTY_PACKAGE_SHORT}" \
        "Install Directory"
  DeleteRegKey /ifempty HKLM "Software\GNU\${PRETTY_PACKAGE_SHORT}"
  DeleteRegKey /ifempty HKLM "Software\GNU\GnuPG"
  DeleteRegKey /ifempty HKLM "Software\GNU"

  # Remove Windows Add/Remove Programs support.
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRETTY_PACKAGE_SHORT}"
SectionEnd

# installer.nsi - Installer for GnuPG 4 Windows.    -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007 g10 Code GmbH
# Copyright (C) 2017 Intevation GmbH
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

# No servicable parts beyond this line.  Stay clear :)

!ifdef REQUIRE_W32_NSIS
!ifdef PACKAGE_LIBRARY
!include "Library.nsh"
!endif
!else
!macro InstallLib libtype shared install localfile destfile tempbasedir
  File "${localfile}"
!macroend
!endif

!include "WinMessages.nsh"
!include "WinVer.nsh"

# We use the modern UI 2.
!include "MUI2.nsh"
!ifdef DEBUG
!undef DEBUG
!endif

# Set the package name.  Note that this name should not be sufficed
#  with the version because this would get displayed in the start menu.
Name "${PRETTY_PACKAGE}"
OutFile "${PACKAGE}-${VERSION}.exe"
BrandingText "${PRETTY_PACKAGE}-${VERSION}"

# Details button conflicts with splashscreen
ShowInstDetails nevershow

# Set the installation directory.
!ifndef INSTALL_DIR
!define INSTALL_DIR "${PACKAGE}"
!endif
InstallDir "$PROGRAMFILES\${INSTALL_DIR}"

# Add version information to the file properties.
VIProductVersion "${PROD_VERSION}"
VIAddVersionKey "ProductName" "${PRETTY_PACKAGE_SHORT} (${VERSION})"
!ifdef LICENSE_GPL
VIAddVersionKey "Comments" \
   "${PRETTY_PACKAGE_SHORT} is Free Software; you can redistribute it  \
    and/or modify it under the terms of the GNU General Public License.  \
    You should have received a copy of the GNU General Public License  \
    along with this software; if not, write to the Free Software  \
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,  \
    MA 02110-1301, USA"
!else
VIAddVersionKey "Comments" \
   "${PRETTY_PACKAGE_SHORT} is Free Software; you can redistribute it  \
    and/or modify it under the terms of the GNU Lesser General Public  \
    License. You should have received a copy of the GNU Lesser General  \
    Public License along with this software; if not, write to the Free  \
    Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,  \
    MA 02110-1301, USA"
!endif
VIAddVersionKey "CompanyName" "${COMPANY}"
VIAddVersionKey "LegalTrademarks" ""
VIAddVersionKey "LegalCopyright" "${COPYRIGHT}"
VIAddVersionKey "FileDescription" "${DESCRIPTION}"
VIAddVersionKey "FileVersion" "${PROD_VERSION}"

# Set to the name of another GnuPG installation if one has been detected
Var OtherGnuPGDetected

# Interface Settings

# !define MUI_ABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP \
               "${TOP_SRCDIR}/doc/logo/gpg4win-nsis-header-install-150x57.bmp"
!define MUI_HEADERIMAGE_UNBITMAP \
               "${TOP_SRCDIR}/doc/logo/gpg4win-nsis-header-uninstall-150x57.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP \
               "${TOP_SRCDIR}/doc/logo/gpg4win-nsis-wizard-install-164x314.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP \
               "${TOP_SRCDIR}/doc/logo/gpg4win-nsis-wizard-uninstall-164x314.bmp"
!define MUI_ICON "${TOP_SRCDIR}/doc/logo/gpg4win-nsis-install.ico"
!define MUI_UNICON "${TOP_SRCDIR}/doc/logo/gpg4win-nsis-uninstall.ico"

# Remember the installer language

!define MUI_LANGDLL_REGISTRY_ROOT "SHCTX"
!define MUI_LANGDLL_REGISTRY_KEY "Software\${PRETTY_PACKAGE_SHORT}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

# No Umlaute, please!
!define MUI_LANGDLL_INFO "Please choose a language for the setup.$\r$\n\
Bitte die Sprache des Installations-Vorgangs angeben."

# The list of wizard pages.

!define MUI_WELCOMEPAGE_TITLE "${WELCOME_TITLE_STR}"
!define MUI_WELCOMEPAGE_TEXT "${ABOUT_STR}"

!insertmacro MUI_PAGE_WELCOME

#!define MUI_LICENSEPAGE_BUTTON "$(^NextBtn)"
#!define MUI_PAGE_HEADER_SUBTEXT "$(T_GPLHeader)"
#!insertmacro MUI_PAGE_LICENSE "license.blurb"

!define MUI_PAGE_CUSTOMFUNCTION_SHOW PrintNonAdminWarning
!insertmacro MUI_PAGE_COMPONENTS

!define MUI_PAGE_CUSTOMFUNCTION_LEAVE CheckExistingVersion
!insertmacro MUI_PAGE_DIRECTORY

!define MUI_PAGE_CUSTOMFUNCTION_PRE BeforeInstallHooks
!insertmacro MUI_PAGE_INSTFILES
# Finish page
!ifndef SOURCES
!define MUI_PAGE_CUSTOMFUNCTION_PRE ShowFinalWarnings

!define MUI_PAGE_CUSTOMFUNCTION_SHOW FinishFunction
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_FUNCTION RunAsUser
!define MUI_FINISHPAGE_SHOWREADME "share\gpg4win\README.$(T_LangCode).txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "$(T_ShowReadme)"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_LINK "$(T_MoreInfo)"
!define MUI_FINISHPAGE_LINK_LOCATION "$(T_MoreInfoURL)"
!insertmacro MUI_PAGE_FINISH

Function FinishFunction
  IfSilent leave
  !insertmacro SectionFlagIsSet ${SEC_kleopatra} \
        ${SF_SELECTED} have_kleo check_gpa
check_gpa:
  !insertmacro SectionFlagIsSet ${SEC_gpa} \
        ${SF_SELECTED} have_gpa have_nothing
have_nothing:
  ShowWindow $mui.FinishPage.Run ${SW_HIDE}
  goto leave
have_kleo:
  SendMessage $mui.FinishPage.Run.Text ${WM_SETTEXT} 0 "STR:$(T_RunKleopatra)"
  goto leave
have_gpa:
  SendMessage $mui.FinishPage.Run.Text ${WM_SETTEXT} 0 "STR:$(T_RunGPA)"
leave:
FunctionEnd

Function RunAsUser
  !insertmacro SectionFlagIsSet ${SEC_kleopatra} \
        ${SF_SELECTED} do_kleo skip_kleo
do_kleo:
  g4wihelp::DesktopShellRun "$INSTDIR\bin\kleopatra.exe"
  goto leave
skip_kleo:
  !insertmacro SectionFlagIsSet ${SEC_gpa} \
        ${SF_SELECTED} do_gpa leave
do_gpa:
  g4wihelp::DesktopShellRun "$INSTDIR\bin\gpa.exe"
leave:
FunctionEnd

LangString T_RunKleopatra ${LANG_ENGLISH} \
   "Run Kleopatra"

LangString T_RunGPA ${LANG_ENGLISH} \
   "Run GPA"

# /SOURCES
!endif

# Uninstaller pages.

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!ifndef SOURCES
!define MUI_PAGE_CUSTOMFUNCTION_PRE un.CloseApps
!endif
!insertmacro MUI_UNPAGE_INSTFILES
#!insertmacro MUI_UNPAGE_FINISH

#Page license
#Page components
#Page directory
#Page instfiles
#UninstPage uninstConfirm
#UninstPage instfiles


# Language support.  This has to be done after defining the pages, but
# before defining the translation strings.  Confusing.

# Enable this to not filter languages for the current code page.  Note
# that languages which are then not filtered out may not be displayed
# correctly in the Windows version the user is using.  Not recommended,
# but can be useful for testing.
!ifdef DEBUG
!define MUI_LANGDLL_ALLLANGUAGES
!endif

!insertmacro MUI_LANGUAGE "English"
!define PO_HEADER
!include "../po/catalogs.nsi"
!undef PO_HEADER

!insertmacro MUI_RESERVEFILE_LANGDLL
ReserveFile "${BUILD_DIR}\g4wihelp.dll"
!ifdef SOURCES
ReserveFile "${TOP_SRCDIR}\doc\logo\gpg4win-logo-400px.bmp"
ReserveFile "${TOP_SRCDIR}\src\gpg4win-splash.wav"
!endif
ReserveFile "${TOP_SRCDIR}\COPYING"
ReserveFile "${TOP_SRCDIR}\doc\logo\gpg4win-logo-164x314.bmp"

# Language support

LangString T_LangCode ${LANG_ENGLISH} "en"

# Startup page
LangString T_GPLHeader ${LANG_ENGLISH} \
  "This software is licensed under the terms of the GNU General Public \
   License (GPL)."

LangString T_GPLShort ${LANG_ENGLISH} \
  "In short: You are allowed to run this software for any purpose. \
   You may distribute it as long as you give the recipients the same \
   rights you have received."

LangString T_MoreInfo ${LANG_ENGLISH} \
   "Click here for the project's homepage"
LangString T_MoreInfoURL ${LANG_ENGLISH} "http://www.gpg4win.org"

LangString T_ShowReadme ${LANG_ENGLISH} \
   "Show the README file"

LangString T_NoKeyManager ${LANG_ENGLISH} \
   "No key manager has been installed, thus we can't run one now."

# Used as subdirectory name in Start Menu.

LangString DESC_Menu_manuals ${LANG_ENGLISH} \
   "Documentation"

LangString DESC_Menu_uninstall ${LANG_ENGLISH} \
   "Uninstall"

# Used as subdirectory name on Desktop.
LangString DESC_Desktop_manuals ${LANG_ENGLISH} \
   "Gpg4win Documentation"


# Functions

# Custom functions and macros for gpg4win.
!include "g4wihelp.nsi"

# Display a warning if this is a Beta version.
#Function PrintBetaWarning
#   MessageBox MB_OK "$(T_BetaWarning)"
#FunctionEnd


# Display a warning if GnuPP has been detected and allow the user to abort
# the installation.
Function PrintGnuPPWarning
   MessageBox MB_YESNO "$(T_FoundOldGnuPP)" IDYES cont
     Abort
 cont:
   StrCpy $OtherGnuPGDetected "GnuPP"
FunctionEnd

# Display a warning if GnuPT has been detected and allow the user to abort
# the installation.
Function PrintGnuPTWarning
   MessageBox MB_YESNO "$(T_FoundOldGnuPT)" IDYES cont
     Abort
 cont:
   StrCpy $OtherGnuPGDetected "GnuPT"
FunctionEnd

# Display a warning if the Sourceforge WinPT has been detected and
# allow the user to abort the installation.
Function PrintWinPTSFWarning
   MessageBox MB_YESNO "$(T_FoundOldWinPTSF)" IDYES cont
     Abort
 cont:
   StrCpy $OtherGnuPGDetected "WinPT-SF"
FunctionEnd

# Display a warning if GnuPG Pack has been detected and abort the
# the installation.  This one clobbers our own Registry space.
Function PrintGnuPackWarning
   MessageBox MB_OK "$(T_FoundOldGnuPack)"
   Abort
FunctionEnd


# Check whether one of the other GnuPG systems has already been
# installed.  We do this by looking at the registry.
Function CheckOtherGnuPGApps
  StrCpy $OtherGnuPGDetected ""
  ClearErrors
  ReadRegStr $0 SHCTX "Software\GNU\GnuPP\Settings" "Path"
  IfErrors +2 0
    Call PrintGnuPPWarning

  EnumRegKey $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\MenuOrder\Start Menu\Programs\GnuPT" 0
  StrCmp $0 "" +2
    Call PrintGnuPTWarning

  ClearErrors
  ReadRegStr $0 SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\Windows Privacy Tools" "DisplayVersion"
  IfErrors +2 0
    Call PrintWinPTSFWarning

  ReadRegStr $0 SHCTX "Software\GNU\GnuPG" "Install Directory"
  Push $0
  Push "GnuPG-Pack"
  Call StrStr
  Pop $0
  StrCmp $0 "" +2
    Call PrintGnuPackWarning


FunctionEnd

# Check whether gpg4win has already been installed.  This is called as
# a leave function from the directory page.  A call to abort will get
# back to the directory selection.
Function CheckExistingVersion
  ClearErrors
  FileOpen $0 "$INSTDIR\VERSION" r
  IfErrors leave
  FileRead $0 $R0
  FileRead $0 $R1
  FileClose $0

  Push $R1
  Call TrimNewLines
  Pop $R1

  # Extract major version.
  StrCpy $0 $R1 2
  StrCmp $0 "1." 0 leave
    MessageBox MB_YESNO "$(T_FoundExistingOldVersion)" IDYES leave
    Abort

 leave:
FunctionEnd



# PrintNonAdminWarning

# Check whether the current user is in the Administrator group or an
# OS version without the need for an Administrator is in use.  Print a
# diagnostic if this is not the case and abort installation.
Function PrintNonAdminWarning

  #Call PrintBetaWarning

  ClearErrors
  UserInfo::GetName
  IfErrors leave
  Pop $0
  UserInfo::GetAccountType
  Pop $1
  StrCmp $1 "Admin" leave +1
  MessageBox MB_YESNO "$(T_AdminWanted)" IDNO exit
  goto leave
exit:
  Quit
 leave:
FunctionEnd


# Check for claws mail installation which was shipped in Gpg4win
# versions < 2.2.6
Function CheckClawsUninstall
    IfFileExists $INSTDIR\claws-mail.exe 0 leave
    MessageBox MB_YESNO "$(T_FoundOldClaws)" IDYES uninstall IDNO leave
   uninstall:
    !insertmacro SelectSection ${SecUninstClawsMail}
   leave:
FunctionEnd

# Check whether this is a reinstall and popup a message box to explain
# that it is better to close other apps before continuing
Function PrintCloseOtherApps
   g4wihelp::KillProc "kleopatra.exe"
   g4wihelp::KillProc "gpa.exe"
goto leave
# TODO check for running outlook and offer to kill it.
   print_warning:
    MessageBox MB_OK|MB_ICONEXCLAMATION "$(T_CloseOtherApps)"
leave:
FunctionEnd

Function un.CloseApps
   g4wihelp::KillProc "kleopatra.exe"
   g4wihelp::KillProc "gpa.exe"
FunctionEnd

# Called right before installation
Function BeforeInstallHooks
    Call PrintCloseOtherApps
    Call CheckClawsUninstall
FunctionEnd

# Called right before the final page to show more warnings.
Function ShowFinalWarnings
   StrCmp $OtherGnupgDetected "" +2
     MessageBox MB_OK "$(T_FoundOldSeeManual)"
   leave:
FunctionEnd

#-----------------------------------------------
# Strings pertaining to the install options page
#-----------------------------------------------

# Installation options title
LangString T_InstallOptions ${LANG_ENGLISH} "Install Options"

# Installation options subtitle 1
LangString T_InstallOptLinks ${LANG_ENGLISH} "Start links"

LangString T_InstOptLabelA  ${LANG_ENGLISH} \
     "Please select where Gpg4win shall install links:"

LangString T_InstOptLabelB  ${LANG_ENGLISH} \
     "(Only programs will be linked into the quick launch bar.)"

LangString T_InstOptFieldA  ${LANG_ENGLISH} \
     "Start Menu"

LangString T_InstOptFieldB  ${LANG_ENGLISH} \
     "Desktop"

LangString T_InstOptFieldC  ${LANG_ENGLISH} \
     "Quick Launch Bar"

#------------------------------------------------
# String pertaining to the existing version check
#------------------------------------------------
LangString T_FoundExistingVersion ${LANG_ENGLISH} \
     "Version $R1 has already been installed.  $\r$\n\
      Do you want to overwrite it with version ${VERSION}?"
LangString T_FoundExistingOldVersion ${LANG_ENGLISH} \
     "An old version $R1 has already been installed.  It is \
      strongly recommended to deinstall previous versions on \
      major upgrades. $\r$\n\
      Do you want to continue installing Gpg4win ${VERSION} anyway?"
LangString T_UninstallingOldVersion ${LANG_ENGLISH} \
     "Uninstalling Gpg4win-"


#---------------------------------------------
# From the old installation checking functions
#---------------------------------------------
LangString T_FoundOldSeeManual ${LANG_ENGLISH} \
     "Please see the Gpg4win user manual to learn how to migrate existing \
      keys from other GnuPG based installations to Gpg4win."

#---------
LangString T_FoundOldGnuPP ${LANG_ENGLISH} \
     "An old installation of GnuPP (GNU Privacy Project) has been been \
      detected.  That software is not maintained anymore and thus should \
      be removed. $\r$\n\
          $\r$\n\
      Do you want to continue installing Gpg4win and take care of the old \
      installation later?"

#---------
LangString T_FoundOldGnuPT ${LANG_ENGLISH} \
     "An installation of GnuPT has been been detected.  This may cause \
      problems when used along with Gpg4win. $\r$\n\
          $\r$\n\
      Do you want to continue installing Gpg4win?"

#---------
LangString T_FoundOldWinPTSF ${LANG_ENGLISH} \
     "An old installation of the Sourceforge hosted WinPT has been been \
      detected.  That software is not maintained anymore and should \
      be removed. $\r$\n\
          $\r$\n\
      Do you want to continue installing Gpg4win and take care of the old \
      installation later?"


#--------
LangString T_FoundOldGnuPack ${LANG_ENGLISH} \
     "An installation of GnuPG-Pack has been been detected. You need to \
      uninstall it before you can continue with Gpg4win installation. $\r$\n\
        $\r$\n\
      The installation will be aborted now!"



# From Function PrintBetaWarning
LangString T_BetaWarning ${LANG_ENGLISH} \
   "Note: This is a BETA version of Gpg4win. $\r$\n\
     $\r$\n\
    Beta versions are only intended for testing and \
    shall not be used in a production environment."

# From Function PrintNonAdminWarning
LangString T_AdminWanted ${LANG_ENGLISH} \
    "Warning: It is recommended to install Gpg4win system-wide with \
        administrator rights. \
          $\r$\n\
          $\r$\n\
    Do you want to continue installing Gpg4win without administrator rights?"

# From Function PrintCloseOtherApps
LangString T_CloseOtherApps ${LANG_ENGLISH} \
   "Please make sure that other applications are not running. \
    In particular you should close Outlook and all Explorer \
    windows.  Gpg4win will try to install anyway but a reboot \
    will be required then."
LangString T_ShuttingDownWinPT ${LANG_ENGLISH} \
   "Trying to shutdown a possible running instance of WinPT."

# From Function CheckClawsUninstall
LangString T_FoundOldClaws ${LANG_ENGLISH} \
   "An old version of Claws Mail was found in your Installation directory. \
    $\r$\nPlease note that Claws Mail is no longer bundled with Gpg4win \
    and is now available as a standalone package.$\r$\n\
    You should uninstall Claws Mail now, and if you wish to \
    continue to use it, install an up-to-date version from:$\r$\n\
    http://www.claws-mail.org/win32 $\r$\n$\r$\n\
    Uninstall Claws Mail from Gpg4win now?"

# From Function CheckClawsUninstall
LangString T_XPisDeprecated ${LANG_ENGLISH} \
   "Windows Versions before Windows Vista are no longer maintained by Gpg4win. \
    $\r$\nSupport for them may be removed in a future version."

# FIXME: The GetAfterChar function comes from the NSIS wiki.
Function un.GetAfterChar
  Exch $0 ; chop char
  Exch
  Exch $1 ; input string
  Push $2
  Push $3
  StrCpy $2 0
  loop:
    IntOp $2 $2 - 1
    StrCpy $3 $1 1 $2
    StrCmp $3 "" 0 +3
      StrCpy $0 ""
      Goto exit2
    StrCmp $3 $0 exit1
    Goto loop
  exit1:
    IntOp $2 $2 + 1
    StrCpy $0 $1 "" $2
  exit2:
    Pop $3
    Pop $2
    Pop $1
    Exch $0 ; output
FunctionEnd


Function un.SourceDelete
  Push "/"
  Call un.GetAfterChar
  Pop $R0
  Delete "$INSTDIR\$R0"
FunctionEnd


# StrStr  - taken from the NSIS reference
# input, top of stack = string to search for
#        top of stack-1 = string to search in
# output, top of stack (replaces with the portion of the string remaining)
# modifies no other variables.
#
# Usage:
#   Push "this is a long ass string"
#   Push "ass"
#   Call StrStr
#   Pop $R0
#  ($R0 at this point is "ass string")
#
!macro StrStr un
Function ${un}StrStr
   Exch $R1 # st=haystack,old$R1, $R1=needle
   Exch     # st=old$R1,haystack
   Exch $R2 # st=old$R1,old$R2, $R2=haystack
   Push $R3
   Push $R4
   Push $R5
   StrLen $R3 $R1
   StrCpy $R4 0
   # $R1=needle
   # $R2=haystack
   # $R3=len(needle)
   # $R4=cnt
   # $R5=tmp
   loop:
     StrCpy $R5 $R2 $R3 $R4
     StrCmp $R5 $R1 done
     StrCmp $R5 "" done
     IntOp $R4 $R4 + 1
     Goto loop
 done:
   StrCpy $R1 $R2 "" $R4
   Pop $R5
   Pop $R4
   Pop $R3
   Pop $R2
   Exch $R1
FunctionEnd
!macroend


# TrimNewlines  - taken from the NSIS reference
# input, top of stack  (e.g. whatever$\r$\n)
# output, top of stack (replaces, with e.g. whatever)
# modifies no other variables.
Function TrimNewlines
   Exch $R0
   Push $R1
   Push $R2
   StrCpy $R1 0

 loop:
   IntOp $R1 $R1 - 1
   StrCpy $R2 $R0 1 $R1
   StrCmp $R2 "$\r" loop
   StrCmp $R2 "$\n" loop
   IntOp $R1 $R1 + 1
   IntCmp $R1 0 no_trim_needed
   StrCpy $R0 $R0 $R1

 no_trim_needed:
   Pop $R2
   Pop $R1
   Exch $R0
FunctionEnd


Function .onInit
  Call G4wRunOnce

  SetOutPath $TEMP
!ifdef SOURCES
  File /oname=gpgspltmp.bmp "${TOP_SRCDIR}/doc/logo/gpg4win-logo-400px.bmp"
  # We play the tune only for the source installer
  File /oname=gpgspltmp.wav "${TOP_SRCDIR}/src/gpg4win-splash.wav"
  g4wihelp::playsound $TEMP\gpgspltmp.wav
  g4wihelp::showsplash 2500 $TEMP\gpgspltmp.bmp

  Delete $TEMP\gpgspltmp.bmp
  # Note that we delete gpgspltmp.wav in .onInst{Failed,Success}
!endif
  Var /GLOBAL changed_dir
  # Check if the install directory was modified on the command line
  StrCmp "$INSTDIR" "$PROGRAMFILES\${INSTALL_DIR}" unmodified 0
  # It is modified. Save that value.
  StrCpy $changed_dir "$INSTDIR"

  # MULITUSER_INIT overwrites directory setting from command line
  !insertmacro MULTIUSER_INIT
  StrCpy $INSTDIR "$changed_dir"
  goto initDone
unmodified:
  !insertmacro MULTIUSER_INIT
initDone:
  # Enable this to force a language selection dialog on every run (the
  # preferred language is the default).  Otherwise, the preferred
  # language is stored in the registry, and the installer does not ask
  # on upgrades.
!ifdef DEBUG
!define MUI_LANGDLL_ALWAYSSHOW
!endif
  !insertmacro MUI_LANGDLL_DISPLAY

${IfNot} ${AtLeastWinVista}
    MessageBox MB_OK "$(T_XPisDeprecated)"
${Endif}

  ${MementoSectionRestore}
  Call CalcDefaults
  Call CalcDepends
  Call CheckOtherGnuPGApps
FunctionEnd


Function un.onInit
  !insertmacro MULTIUSER_UNINIT
  # Remove the language preference.
  !insertmacro MUI_UNGETLANGUAGE
FunctionEnd

# This must be in a central place.  Urgs.

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!ifdef HAVE_PKG_GNUPG_W32
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_gnupg_w32} $(DESC_SEC_gnupg_w32)
!endif
!ifdef HAVE_PKG_GPGOL
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_gpgol} $(DESC_SEC_gpgol)
!endif
!ifdef HAVE_PKG_GPGEX
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_gpgex} $(DESC_SEC_gpgex)
!endif
!ifdef HAVE_PKG_PAPERKEY
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_paperkey} $(DESC_SEC_paperkey)
!endif
!ifdef HAVE_PKG_GPA
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_gpa} $(DESC_SEC_gpa)
!endif
!ifdef HAVE_PKG_KLEOPATRA
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_kleopatra} $(DESC_SEC_kleopatra)
!endif
!ifdef HAVE_PKG_MAN_NOVICE_EN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_man_novice_en} $(DESC_SEC_man_novice_en)
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_EN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_man_advanced_en} $(DESC_SEC_man_advanced_en)
!endif
!ifdef HAVE_PKG_COMPENDIUM
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_compendium} $(DESC_SEC_compendium)
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_man_novice_de} $(DESC_SEC_man_novice_de)
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_DE
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_man_advanced_de} $(DESC_SEC_man_advanced_de)
!endif
!insertmacro MUI_FUNCTION_DESCRIPTION_END


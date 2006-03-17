# installer.nsi - Installer for GnuPG 4 Windows.    -*- coding: latin-1; -*-
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


# We use the modern UI.
!include "MUI.nsh"

# Set the package name.  Note that this name should not be sufficed
#  with the version because this would get displayed in the start menu.
Name "${PRETTY_PACKAGE}"


# Set the output filename.
OutFile "${PACKAGE}-${VERSION}.exe"

Icon "${TOP_SRCDIR}/doc/logo/gpg4win-logo-icon.ico"
UninstallIcon "${TOP_SRCDIR}/doc/logo/gpg4win-logo-icon.ico"

# Set the installation directory.
!ifndef INSTALL_DIR
!define INSTALL_DIR "${PACKAGE}"
!endif
InstallDir "$PROGRAMFILES\GNU\${INSTALL_DIR}" 


InstallDirRegKey HKLM "Software\GNU\${PRETTY_PACKAGE_SHORT}" \
	"Install Directory"


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

# Set to the name of another GnupG installation if one has been detected
Var OtherGnuPGDetected

# Interface Settings

# !define MUI_ABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

# Remember the installer language

#!define MUI_LANGDLL_REGISTRY_ROOT "HKCU" 
#!define MUI_LANGDLL_REGISTRY_KEY "Software\GNU\${PRETTY_PACKAGE_SHORT}" 
#!define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

# The list of wizard pages.

!define MUI_WELCOMEPAGE_TITLE "$(T_WelcomeTitle)"
!define MUI_WELCOMEPAGE_TEXT  "$(T_About)"
!insertmacro MUI_PAGE_WELCOME

!define MUI_LICENSEPAGE_BUTTON "$(^NextBtn)"
!define MUI_PAGE_HEADER_SUBTEXT "$(T_GPLHeader)"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "$(T_GPLShort)"
!insertmacro MUI_PAGE_LICENSE "${TOP_SRCDIR}/COPYING"

!define MUI_PAGE_CUSTOMFUNCTION_SHOW PrintNonAdminWarning
!insertmacro MUI_PAGE_COMPONENTS

!insertmacro MUI_PAGE_DIRECTORY

!ifdef HAVE_STARTMENU
Var STARTMENU_FOLDER

!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\GNU\${PRETTY_PACKAGE_SHORT}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER
!endif

!define MUI_PAGE_CUSTOMFUNCTION_PRE PrintCloseOtherApps
!insertmacro MUI_PAGE_INSTFILES

!define MUI_PAGE_CUSTOMFUNCTION_PRE ShowFinalWarnings
!define MUI_FINISHPAGE_SHOWREADME "README.$(T_LangCode).txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "$(T_ShowReadme)"
#!define MUI_FINISHPAGE_RUN
#!define MUI_FINISHPAGE_RUN_FUNCTION RunOnFinish
#!define MUI_FINISHPAGE_RUN_TEXT "$(T_RunKeyManager)"
#!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define MUI_FINISHPAGE_LINK "$(T_MoreInfo)"
!define MUI_FINISHPAGE_LINK_LOCATION http://www.gpg4win.org
!insertmacro MUI_PAGE_FINISH


# Uninstaller pages.

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES


#Page license
#Page components
#Page directory
#Page instfiles
#UninstPage uninstConfirm
#UninstPage instfiles


# Language support.  This has to be done after defining the pages, but
# before defining the translation strings.  Confusing.

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "German"

#!insertmacro MUI_RESERVEFILE_LANGDLL
#!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
ReserveFile "${BUILD_DIR}\g4wihelp.dll"
ReserveFile "${TOP_SRCDIR}\doc\logo\gpg4win-logo-400px.bmp"
!ifdef SOURCES
ReserveFile "${TOP_SRCDIR}\src\gpg4win-splash.wav"
!endif
ReserveFile "${TOP_SRCDIR}\COPYING"

# Language support

LangString T_LangCode ${LANG_ENGLISH} "en"
LangString T_LangCode ${LANG_GERMAN}  "de"


# The WelcomeTitle is displayed on the first page.
LangString T_WelcomeTitle ${LANG_ENGLISH} "${WELCOME_TITLE_ENGLISH}"
LangString T_WelcomeTitle ${LANG_GERMAN} "${WELCOME_TITLE_GERMAN}"

# The About string as displayed on the first page.
LangString T_About ${LANG_ENGLISH} "${ABOUT_ENGLISH}"
LangString T_About ${LANG_GERMAN} "${ABOUT_GERMAN}"

# Startup page
LangString T_GPLHeader ${LANG_ENGLISH} \
  "This software is licensed under the terms of the GNU General Public \
   License (GPL) which guarantees your freedom to share and change Free \
   Software."
LangString T_GPLHeader ${LANG_GERMAN}} \
  "Diese Software ist unter der GNU General Public License \
   (GPL) lizensiert; dies gibt Ihnen die Freiheit, sie \
   zu ändern und weiterzugeben."

LangString T_GPLShort ${LANG_ENGLISH} \
  "In short: You are allowed to run this software for any purpose. \
   You may distribute it as long as you give the recipients the same \
   rights you have received."
LangString T_GPLShort ${LANG_GERMAN} \
  "In aller Kürze: Sie haben das Recht, die Software zu jedem Zweck \
   einzusetzen.  Sie können die Software weitergeben, sofern Sie dem \
   Empfänger dieselben Rechte einräumen, die auch Sie erhalten haben."

LangString T_RunKeyManager ${LANG_ENGLISH} \
   "Run the key manager"
LangString T_RunKeyManager ${LANG_GERMAN} \
   "Die Schlüsselverwaltung aufrufen"

LangString T_MoreInfo ${LANG_ENGLISH} \
   "Click here for the project's homepage"
LangString T_MoreInfo ${LANG_GERMAN} \
   "Hier klicken um zur Homepage des Projekts zu gelangen"

LangString T_ShowReadme ${LANG_ENGLISH} \
   "Show the README file"
LangString T_ShowReadme ${LANG_GERMAN} \
   "Die README Datei anzeigen"

LangString T_NoKeyManager ${LANG_ENGLISH} \
   "No key manager has been installed, thus we can't run one now."
LangString T_NoKeyManager ${LANG_GERMAN} \
   "Es wurde keine Schlüsselverwaltung installiert. \
    Deswegen kann sie jetzt auch nicht ausgeführt werden."


# Functions

# Custom functions and macros for gpg4win. 
!include "g4wihelp.nsi"


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
  ReadRegStr $0 HKLM "Software\GNU\GnuPP\Settings" "Path"
  IfErrors +2 0
    Call PrintGnuPPWarning

  EnumRegKey $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\MenuOrder\Start Menu\Programs\GnuPT" 0
  StrCmp $0 "" +2
    Call PrintGnuPTWarning

  ReadRegStr $0 HKLM "Software\GNU\GnuPG" "Install Directory"
  Push $0
  Push "GnuPG-Pack"
  Call StrStr
  Pop $0
  StrCmp $0 "" +2
    Call PrintGnuPackWarning

FunctionEnd


# PrintNonAdminWarning

# Check whether the current user is in the Administrator group or an
# OS version without the need for an Administrator is in use.  Print a
# warning if this is not the case.
Function PrintNonAdminWarning
  ClearErrors
  UserInfo::GetName
  IfErrors leave
  Pop $0
  UserInfo::GetAccountType
  Pop $1
  StrCmp $1 "Admin" leave +1
  MessageBox MB_OK "$(T_AdminNeeded)"

 leave:
FunctionEnd


# Check whether this is a reinstall and popup a message box to explain
# that it is better to close other apps before continuing
Function PrintCloseOtherApps
    IfFileExists $INSTDIR\gnupg.exe print_warning
    IfFileExists $INSTDIR\winpt.exe print_warning
    IfFileExists $INSTDIR\gpa.exe   print_warning
    IfFileExists $INSTDIR\gpgol.dll print_warning
    IfFileExists $INSTDIR\gpgee.dll print_warning
    Return
   print_warning:
    MessageBox MB_OK|MB_ICONEXCLAMATION "$(T_CloseOtherApps)"
    IfFileExists $INSTDIR\winpt.exe 0 +2
      ExecWait '"$INSTDIR\winpt.exe" --stop'
   leave:
FunctionEnd

# Called right before the final page to show more warnings.
Function ShowFinalWarnings
   StrCmp $OtherGnupgDetected "" +2
     MessageBox MB_OK "$(T_FoundOldSeeManual)"
   leave:
FunctionEnd

#---------------------------------------------
# From the old installation checking functions
#---------------------------------------------
LangString T_FoundOldSeeManual ${LANG_ENGLISH} \
     "Please see the Gpg4win manual to learn how to migrate existing \
      keys from other GnuPG based installations to Gpg4win."
LangString T_FoundOldSeeManual ${LANG_GERMAN} \
     "Bitte sehen Sie im Gpg4win für Durchblicker Handbuch nach, wie Sie \
      Schlüssel aus anderen - GnuPG basierten - Installationen in Gpg4win \
      überführen."

#---------
LangString T_FoundOldGnuPP ${LANG_ENGLISH} \
     "An old installation of GnuPP (GNU Privacy Project) has been been \
      detected.  That software is not maintained anymore and thus should \
      be removed. \
          \
      Do you want to continue installing Gpg4win and take care of the old \
      installation later?"
LangString T_FoundOldGnuPP ${LANG_GERMAN} \
     "Eine alte Installation von GnuPP (GNU Privacy Project) wurde gefunden. \
      Diese Software wird nicht mehr gepflegt und sollte deshalb vom \
      System entfernt werden. \
        \
      Möchten Sie die Installation von Gpg4win weiter durchführen und sich \
      dann später um die Entfernung von GnuPP kümmern?"

#---------
LangString T_FoundOldGnuPT ${LANG_ENGLISH} \
     "An installation of GnuPT has been been detected.  This may cause \
      problems when used along with Gpg4win. \
          \
      Do you want to continue installing Gpg4win?"
LangString T_FoundOldGnuPT ${LANG_GERMAN} \
     "Eine Installation von GnuPT wurde gefunden.  Dies kann zu Problemen \
      führen, falls GnuPT zusammem mit Gpg4win benutzt wird. \r\n\r\n \
      Möchten Sie die Installation von Gpg4win fortführen?"

#--------
LangString T_FoundOldGnuPack ${LANG_ENGLISH} \
     "An installation of GnuPG-Pack has been been detected. You need to \
      uninstall it before you can continue with Gpg4win installation. \
        \
      The installation will be aborted now!"
LangString T_FoundOldGnuPack ${LANG_GERMAN} \
     "Eine Installation con GnuPG-Pack wurde gefunden.  Sie müssen diese \
      zuerst deinstallieren bevor Sie mit der Installation von Gpg4win \
      fortfahren können. \
        \
      Die Installation von Gpg4win wird nun abgebrochen!"



# From Function PrintNonAdminWarning
LangString T_AdminNeeded ${LANG_ENGLISH} \
   "Warning: Administrator permissions required for a successful installation"
LangString T_AdminNeeded ${LANG_GERMAN} \
   "Achtung: Für eine erfolgreiche Installation werden \
    Administratorrechte benötigt."

# From Function PrintCloseOtherApps
LangString T_CloseOtherApps ${LANG_ENGLISH} \
   "Please make sure that other applications are not running. \
    In particular you should close Outlook and all Explorer \
    windows.  Gpg4Win will try to install anyway but a reboot \
    will be required then."
LangString T_CloseOtherApps ${LANG_GERMAN} \
   "Bitte stellen Sie sicher, daß alle anderen Anwendugen geschlossen \
    sind.  Insbesondere sollten Sie Outlook und alle Explorer Fenster \
    schliessen bevor Sie die Installation fortsetzen.  Gpg4Win wird auf \
    jeden Fall versuchen, eine Installation durchzuführen; es ist dann aber \
    u.U. notwendig, das System neu zu starten."

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
Function StrStr
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

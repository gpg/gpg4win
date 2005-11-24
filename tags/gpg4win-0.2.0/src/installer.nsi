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


# Set the installation directory.
!ifndef INSTALL_DIR
!define INSTALL_DIR "${PACKAGE}"
!endif
InstallDir "$PROGRAMFILES\GNU\${INSTALL_DIR}\\" 


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

!ifdef HAVE_STARTMENU
Var STARTMENU_FOLDER
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\GNU\${PRETTY_PACKAGE_SHORT}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER
!endif

!define MUI_PAGE_CUSTOMFUNCTION_PRE PrintCloseOtherApps
!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_RUN "$INSTDIR\gpa.exe"
!define MUI_FINISHPAGE_RUN_PARAMETERS "--keyring"
!define MUI_FINISHPAGE_RUN_TEXT "$(T_RunKeyManager)"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
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

!insertmacro MUI_RESERVEFILE_LANGDLL
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
ReserveFile "${NSISDIR}\Plugins\advsplash.dll"
ReserveFile "${BUILD_DIR}\g4wihelp.dll"
ReserveFile "${TOP_SRCDIR}\src\gpg4win-splash.bmp"
ReserveFile "${TOP_SRCDIR}\src\gpg4win-splash.wav"
ReserveFile "${TOP_SRCDIR}\COPYING"

# Language support

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


# Functions

# Custom functions and macros for gpg4win. 
!include "g4wihelp.nsi"

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

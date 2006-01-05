# inst-sections.nsi - Installer for GPG4Win sections.  -*- coding: latin-1; -*-
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

# Sections

!ifdef HAVE_PKG_GNUPG
!include "inst-gnupg.nsi"
!endif
!ifdef HAVE_PKG_LIBGPG_ERROR
!include "inst-libgpg-error.nsi"
!endif
!ifdef HAVE_PKG_LIBICONV
!include "inst-libiconv.nsi"
!endif
!ifdef HAVE_PKG_PKGCONFIG
!include "inst-pkgconfig.nsi"
!endif
!ifdef HAVE_PKG_ZLIB
!include "inst-zlib.nsi"
!endif
!ifdef HAVE_PKG_CRYPT
!include "inst-crypt.nsi"
!endif
!ifdef HAVE_PKG_REGEX
!include "inst-regex.nsi"
!endif
!ifdef HAVE_PKG_PTHREADS_W32
!include "inst-pthreads-w32.nsi"
!endif
!ifdef HAVE_PKG_GPGME
!include "inst-gpgme.nsi"
!endif
!ifdef HAVE_PKG_GETTEXT
!include "inst-gettext.nsi"
!endif
!ifdef HAVE_PKG_GLIB
!include "inst-glib.nsi"
!endif
!ifdef HAVE_PKG_LIBPNG
!include "inst-libpng.nsi"
!endif
!ifdef HAVE_PKG_GPGOL
!include "inst-gpgol.nsi"
!endif
!ifdef HAVE_PKG_PANGO
!include "inst-pango.nsi"
!endif
!ifdef HAVE_PKG_ATK
!include "inst-atk.nsi"
!endif
!ifdef HAVE_PKG_GTK_
!include "inst-gtk+.nsi"
!endif
!ifdef HAVE_PKG_GPA
!include "inst-gpa.nsi"
!endif
!ifdef HAVE_PKG_WINPT
!include "inst-winpt.nsi"
!endif
!ifdef HAVE_PKG_GPGEE
!include "inst-gpgee.nsi"
!endif
!ifdef HAVE_PKG_SYLPHEED_CLAWS
!include "inst-sylpheed-claws.nsi"
!endif
!ifdef HAVE_PKG_EUDORAGPG
!include "inst-eudoragpg.nsi"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
!include "inst-man_novice_de.nsi"
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_DE
!include "inst-man_advanced_de.nsi"
!endif

# We have to invoke the uninstallers in reverse order!

!ifdef HAVE_PKG_MAN_ADVANCED_DE
!include "uninst-man_advanced_de.nsi"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
!include "uninst-man_novice_de.nsi"
!endif
!ifdef HAVE_PKG_EUDORAGPG
!include "uninst-eudoragpg.nsi"
!endif
!ifdef HAVE_PKG_SYLPHEED_CLAWS
!include "uninst-sylpheed-claws.nsi"
!endif
!ifdef HAVE_PKG_GPGEE
!include "uninst-gpgee.nsi"
!endif
!ifdef HAVE_PKG_WINPT
!include "uninst-winpt.nsi"
!endif
!ifdef HAVE_PKG_GPA
!include "uninst-gpa.nsi"
!endif
!ifdef HAVE_PKG_GTK_
!include "uninst-gtk+.nsi"
!endif
!ifdef HAVE_PKG_ATK
!include "uninst-atk.nsi"
!endif
!ifdef HAVE_PKG_PANGO
!include "uninst-pango.nsi"
!endif
!ifdef HAVE_PKG_GPGOL
!include "uninst-gpgol.nsi"
!endif
!ifdef HAVE_PKG_LIBPNG
!include "uninst-libpng.nsi"
!endif
!ifdef HAVE_PKG_GLIB
!include "uninst-glib.nsi"
!endif
!ifdef HAVE_PKG_GETTEXT
!include "uninst-gettext.nsi"
!endif
!ifdef HAVE_PKG_GPGME
!include "uninst-gpgme.nsi"
!endif
!ifdef HAVE_PKG_PTHREADS_W32
!include "uninst-pthreads-w32.nsi"
!endif
!ifdef HAVE_PKG_REGEX
!include "uninst-regex.nsi"
!endif
!ifdef HAVE_PKG_CRYPT
!include "uninst-crypt.nsi"
!endif
!ifdef HAVE_PKG_ZLIB
!include "uninst-zlib.nsi"
!endif
!ifdef HAVE_PKG_PKGCONFIG
!include "uninst-pkgconfig.nsi"
!endif
!ifdef HAVE_PKG_LIBICONV
!include "uninst-libiconv.nsi"
!endif
!ifdef HAVE_PKG_LIBGPG_ERROR
# Note that the uninstaller of libgpg-error is supposed to remove the shareed
# directories.  We might want to move this to an extra section.
!include "uninst-libgpg-error.nsi"
!endif
!ifdef HAVE_PKG_GNUPG
!include "uninst-gnupg.nsi"
!endif

# Dependency Management

!include "Sections.nsh"

Function CalcDepends
  # This section could very well be autogenerated from the
  # information in configure.ac.  Note that it doesn't hurt to have
  # stuff here for packages that we don't include.

  # First clear all indirect dependencies.
!ifdef HAVE_PKG_LIBICONV
  !insertmacro UnselectSection ${SEC_libiconv}
!endif
!ifdef HAVE_PKG_GETTEXT
  !insertmacro UnselectSection ${SEC_gettext}
!endif
!ifdef HAVE_PKG_ZLIB
  !insertmacro UnselectSection ${SEC_zlib}
!endif
!ifdef HAVE_PKG_CRYPT
  !insertmacro UnselectSection ${SEC_crypt}
!endif
!ifdef HAVE_PKG_REGEX
  !insertmacro UnselectSection ${SEC_regex}
!endif
!ifdef HAVE_PKG_PTHREADS_W32
  !insertmacro UnselectSection ${SEC_pthreads_w32}
!endif
!ifdef HAVE_PKG_LIBPNG
  !insertmacro UnselectSection ${SEC_libpng}
!endif
!ifdef HAVE_PKG_PKGCONFIG
  !insertmacro UnselectSection ${SEC_pkgconfig}
!endif
!ifdef HAVE_PKG_GLIB
  !insertmacro UnselectSection ${SEC_glib}
!endif
!ifdef HAVE_PKG_ATK
  !insertmacro UnselectSection ${SEC_atk}
!endif
!ifdef HAVE_PKG_PANGO
  !insertmacro UnselectSection ${SEC_pango}
!endif
!ifdef HAVE_PKG_GTK_
  !insertmacro UnselectSection ${SEC_gtk_}
!endif
!ifdef HAVE_PKG_LIBGPG_ERROR
  !insertmacro UnselectSection ${SEC_libgpg_error}
!endif
!ifdef HAVE_PKG_GPGME
  !insertmacro UnselectSection ${SEC_gpgme}
!endif

  # Then enable all dependencies in reverse build list order!

!ifdef HAVE_PKG_GPGEE
  !insertmacro SectionFlagIsSet ${SEC_gpgee} ${SF_SELECTED} have_gpgee skip_gpgee
  have_gpgee:
  !insertmacro SelectSection ${SEC_gpgme}
  !insertmacro SelectSection ${SEC_gnupg}
  skip_gpgee:
!endif

!ifdef HAVE_PKG_WINPT
  !insertmacro SectionFlagIsSet ${SEC_winpt} ${SF_SELECTED} have_winpt skip_winpt
  have_winpt:
  !insertmacro SelectSection ${SEC_gpgme}
  !insertmacro SelectSection ${SEC_gnupg}
  skip_winpt:
!endif

!ifdef HAVE_PKG_GPA
  !insertmacro SectionFlagIsSet ${SEC_gpa} ${SF_SELECTED} have_gpa skip_gpa
  have_gpa:
  !insertmacro SelectSection ${SEC_zlib}
  !insertmacro SelectSection ${SEC_gtk_}
  !insertmacro SelectSection ${SEC_libpng}
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_gpgme}
  !insertmacro SelectSection ${SEC_gnupg}
  skip_gpa:
!endif

!ifdef HAVE_PKG_SYLPHEED_CLAWS
  !insertmacro SectionFlagIsSet ${SEC_sylpheed} ${SF_SELECTED} have_sylpheed skip_sylpheed
  have_sylpheed:
  !insertmacro SelectSection ${SEC_zlib}
  !insertmacro SelectSection ${SEC_gtk_}
  !insertmacro SelectSection ${SEC_libpng}
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_gpgme}
  !insertmacro SelectSection ${SEC_gnupg}
  !insertmacro SelectSection ${SEC_pthreads_w32}
  !insertmacro SelectSection ${SEC_crypt}
  !insertmacro SelectSection ${SEC_regex}
  skip_sylpheed:
!endif

!ifdef HAVE_PKG_EUDORAGPG
  !insertmacro SectionFlagIsSet ${SEC_eudoragpg} ${SF_SELECTED} have_eudoragpg skip_eudoragpg
  have_eudoragpg:
  !insertmacro SelectSection ${SEC_zlib}
  !insertmacro SelectSection ${SEC_gtk_}
  !insertmacro SelectSection ${SEC_libpng}
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_gpgme}
  !insertmacro SelectSection ${SEC_gnupg}
  skip_eudoragpg:
!endif

!ifdef HAVE_PKG_GTK_
  !insertmacro SectionFlagIsSet ${SEC_gtk_} \
		${SF_SELECTED} have_gtk_ skip_gtk_
  have_gtk_:
  !insertmacro SelectSection ${SEC_atk}
  !insertmacro SelectSection ${SEC_pango}
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_libiconv}
  !insertmacro SelectSection ${SEC_gettext}
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_gtk_:
!endif

!ifdef HAVE_PKG_ATK
  !insertmacro SectionFlagIsSet ${SEC_atk} \
		${SF_SELECTED} have_atk skip_atk
  have_atk:
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_atk:
!endif

!ifdef HAVE_PKG_PANGO
  !insertmacro SectionFlagIsSet ${SEC_pango} \
		${SF_SELECTED} have_pango skip_pango
  have_pango:
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_pango:
!endif

!ifdef HAVE_PKG_GPGOL
  !insertmacro SectionFlagIsSet ${SEC_gpgol} \
		${SF_SELECTED} have_gpgol skip_gpgol
  have_gpgol:
  !insertmacro SelectSection ${SEC_gpgme}
  !insertmacro SelectSection ${SEC_gnupg}
  skip_gpgol:
!endif

!ifdef HAVE_PKG_LIBPNG
  !insertmacro SectionFlagIsSet ${SEC_libpng} \
		${SF_SELECTED} have_libpng skip_libpng
  have_libpng:
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_libpng:
!endif

!ifdef HAVE_PKG_GLIB
  !insertmacro SectionFlagIsSet ${SEC_glib} \
		${SF_SELECTED} have_glib skip_glib
  have_glib:
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_glib:
!endif

!ifdef HAVE_PKG_GETTEXT
  !insertmacro SectionFlagIsSet ${SEC_gettext} \
		${SF_SELECTED} have_gettext skip_gettext
  have_gettext:
  !insertmacro SelectSection ${SEC_libiconv}
  skip_gettext:
!endif

!ifdef HAVE_PKG_GPGME
  !insertmacro SectionFlagIsSet ${SEC_gpgme} \
		${SF_SELECTED} have_gpgme skip_gpgme
  have_gpgme:
  !insertmacro SelectSection ${SEC_libgpg_error}
  skip_gpgme:
!endif

  # Package "zlib" has no dependencies.
  # Package "pkgconfig" has no dependencies.
  # Package "libiconv" has no dependencies.
  # Package "libgpg-error" has no dependencies.
  # Package "gnupg" has no dependencies.

FunctionEnd


Function .onInit
  Call G4wRunOnce

  SetOutPath $TEMP
  File /oname=gpgspltmp.bmp "${TOP_SRCDIR}/src/gpg4win-splash.bmp"
  File /oname=gpgspltmp.wav "${TOP_SRCDIR}/src/gpg4win-splash.wav"
  g4wihelp::playsound $TEMP\gpgspltmp.wav
  g4wihelp::showsplash 3000 $TEMP\gpgspltmp.bmp

  Delete $TEMP\gpgspltmp.bmp
  ; Note that we delete gpgspltmp.wav in .onInst{Failed,Success}

  Call CalcDepends
FunctionEnd


Function .onInstFailed
  Delete $TEMP\gpgspltmp.wav
FunctionEnd

Function .onInstSuccess
  Delete $TEMP\gpgspltmp.wav
FunctionEnd

Function .onSelChange
  Call CalcDepends
FunctionEnd


# This function is run from the finish page.
Function RunOnFinish
!ifdef HAVE_PKG_GPA
    SectionGetFlags ${SEC_gpa} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_gpa_avail
       Exec "$INSTDIR\gpa.exe"
       Return
   no_gpa_avail:
!endif
!ifdef HAVE_PKG_WINPT
    SectionGetFlags ${SEC_winpt} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_winpt_avail
       Exec "$INSTDIR\WinPT.exe --keymanager"
       Return
   no_winpt_avail:
!endif
  MessageBox MB_OK "$(T_NoKeyManager)"
FunctionEnd


# This must be in a central place.  Urgs.

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!ifdef HAVE_PKG_GNUPG
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_gnupg} $(DESC_SEC_gnupg)
!endif
!ifdef HAVE_PKG_GPGOL
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_gpgol} $(DESC_SEC_gpgol)
!endif
!ifdef HAVE_PKG_GPA
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_gpa} $(DESC_SEC_gpa)
!endif
!ifdef HAVE_PKG_WINPT
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_winpt} $(DESC_SEC_winpt)
!endif
!ifdef HAVE_PKG_GPGEE
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_gpgee} $(DESC_SEC_gpgee)
!endif
!ifdef HAVE_PKG_SYLPHEED_CLAWS
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_sylpheed} $(DESC_SEC_sylpheed)
!endif
!ifdef HAVE_PKG_EUDORAGPG
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_eudoragpg} $(DESC_SEC_eudoragpg)
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_man_novice_de} $(DESC_SEC_man_novice_de)
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_DE
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_man_advanced_de} $(DESC_SEC_man_advanced_de)
!endif
!insertmacro MUI_FUNCTION_DESCRIPTION_END


# This also must be in a central place.  Also Urgs.

Section "-startmenu"

!ifdef HAVE_STARTMENU
  # Make sure that the context of the automatic variables has been set to
  # the "all users" shell folder.  This guarantees that the menu gets written
  # for all users.  We have already checked that we are running as Admin; or
  # we printed a warning that installation will not succeed.
  SetShellVarContext all

!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"

!ifdef HAVE_PKG_WINPT
    SectionGetFlags ${SEC_winpt} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_winpt_menu 
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\WinPT.lnk" \
	"$INSTDIR\winpt.exe" \
        "" "$INSTDIR\winpt.exe" "" SW_SHOWNORMAL "" $(DESC_Menu_winpt)
   no_winpt_menu:
!endif

!ifdef HAVE_PKG_GPA
    SectionGetFlags ${SEC_gpa} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_gpa_menu 
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GPA.lnk" \
	"$INSTDIR\gpa.exe" \
        "" "" "" SW_SHOWNORMAL "" $(DESC_Menu_gpa)
  no_gpa_menu:
!endif

!ifdef HAVE_PKG_SYLPHEED_CLAWS
    SectionGetFlags ${SEC_sylpheed} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_sylpheed_menu 
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Sylpheed.lnk" \
	"$INSTDIR\sylpheed-claws.exe" \
        "" "" "" SW_SHOWNORMAL "" $(DESC_Menu_sylpheed)
  no_sylpheed_menu:
!endif

!ifdef HAVE_PKG_EUDORAGPG
    SectionGetFlags ${SEC_eudoragpg} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_eudoragpg_menu 
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\EudoraGPG Plugin.lnk" \
	"$INSTDIR\share\eudoragpg\eudoragpg.html" \
        "" "" "" SW_SHOWNORMAL "" ""
  no_eudoragpg_menu:
!endif

!ifdef HAVE_PKG_MAN_NOVICE_DE
    SectionGetFlags ${SEC_man_novice_de} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_man_novice_de_menu 
    CreateShortCut \
        "$SMPROGRAMS\$STARTMENU_FOLDER\$(DESC_Name_man_novice_de).lnk" \
	"$INSTDIR\share\gpg4win\man_novice_de.html" \
        "" "" "" SW_SHOWNORMAL "" $(DESC_Menu_man_novice_de)
  no_man_novice_de_menu:
!endif

!ifdef HAVE_PKG_MAN_ADVANCED_DE
    SectionGetFlags ${SEC_man_advanced_de} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_man_advanced_de_menu 
    CreateShortCut \
        "$SMPROGRAMS\$STARTMENU_FOLDER\$(DESC_Name_man_advanced_de).lnk" \
	"$INSTDIR\share\gpg4win\man_novice_de.html" \
        "" "" "" SW_SHOWNORMAL "" $(DESC_Menu_man_advanced_de)
  no_man_advanced_de_menu:
!endif

!ifdef HAVE_PKG_GPGEE
    SectionGetFlags ${SEC_gpgee} $R0 
    IntOp $R0 $R0 & ${SF_SELECTED} 
    IntCmp $R0 ${SF_SELECTED} 0 no_gpgee_menu 
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GPGee Manual.lnk" \
	"$INSTDIR\GPGee.hlp" "" "" "" SW_SHOWNORMAL "" $(DESC_Menu_gpgee_hlp)
  no_gpgee_menu:
!endif


    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GnuPG FAQ.lnk" \
                   "$INSTDIR\share\gnupg\faq.html" \
                   "" "" "" SW_SHOWNORMAL "" $(DESC_Menu_gnupg_faq)

# No more uninstall link becuase Windows has its wom feature to call
#  the uninstaller.
#    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" \
#	"$INSTDIR\${PACKAGE}-uninstall.exe"
!insertmacro MUI_STARTMENU_WRITE_END
!endif
SectionEnd

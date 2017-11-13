# inst-sections.nsi - Installer for GPG4Win sections.  -*- coding: latin-1; -*-
# Copyright (C) 2005, 2006, 2007, 2008, 2009 g10 Code GmbH
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
# along with this program; if not, see <http://www.gnu.org/licenses/>.

!include "inst-gpg4win.nsi"

# The order of installation must be the same as the build order.  You
# can use tsort on the info in configure.ac, or just check out
# gpg4win_build_list in config.nsi.  The order determines also the
# order in the packages selection dialog.

!ifdef HAVE_PKG_BZIP2
!include "inst-bzip2.nsi"
!endif
!ifdef HAVE_PKG_LIBICONV
!include "inst-libiconv.nsi"
!endif
!ifdef HAVE_PKG_LIBTASN1
!include "inst-libtasn1.nsi"
!endif
!ifdef HAVE_PKG_BREEZE_ICONS
!include "inst-breeze-icons.nsi"
!endif
!ifdef HAVE_PKG_PKGCONFIG
!include "inst-pkgconfig.nsi"
!endif
!ifdef HAVE_PKG_W32PTH
!include "inst-w32pth.nsi"
!endif
!ifdef HAVE_PKG_ZLIB
!include "inst-zlib.nsi"
!endif
!ifdef HAVE_PKG_QTBASE
!include "inst-qtbase.nsi"
!endif
!ifdef HAVE_PKG_GETTEXT
!include "inst-gettext.nsi"
!endif
!ifdef HAVE_PKG_LIBPNG
!include "inst-libpng.nsi"
!endif
!ifdef HAVE_PKG_LIBASSUAN
!include "inst-libassuan.nsi"
!endif
!ifdef HAVE_PKG_LIBGPG_ERROR
!include "inst-libgpg-error.nsi"
!endif
!ifdef HAVE_PKG_LIBFFI
!include "inst-libffi.nsi"
!endif
!ifdef HAVE_PKG_GLIB
!include "inst-glib.nsi"
!endif
!ifdef HAVE_PKG_EXPAT
!include "inst-expat.nsi"
!endif
!ifdef HAVE_PKG_FREETYPE
!include "inst-freetype.nsi"
!endif
!ifdef HAVE_PKG_FONTCONFIG
!include "inst-fontconfig.nsi"
!endif
!ifdef HAVE_PKG_CAIRO
!include "inst-cairo.nsi"
!endif
!ifdef HAVE_PKG_PANGO
!include "inst-pango.nsi"
!endif
!ifdef HAVE_PKG_ATK
!include "inst-atk.nsi"
!endif
!ifdef HAVE_PKG_GDK_PIXBUF
!include "inst-gdk-pixbuf.nsi"
!endif
!ifdef HAVE_PKG_GTK_
!include "inst-gtk+.nsi"
!endif
!ifdef HAVE_PKG_PINENTRY
!include "inst-pinentry.nsi"
!endif
!ifdef HAVE_PKG_GNUPG_W32
!include "inst-gnupg-w32.nsi"
!endif
!ifdef HAVE_PKG_GPGME
!include "inst-gpgme.nsi"
!endif
!ifdef HAVE_PKG_QTTOOLS
!include "inst-qttools.nsi"
!endif
!ifdef HAVE_PKG_QTWINEXTRAS
!include "inst-qtwinextras.nsi"
!endif
!ifdef HAVE_PKG_BOOST
!include "inst-boost.nsi"
!endif
!ifdef HAVE_PKG_KCONFIG
!include "inst-kconfig.nsi"
!endif
!ifdef HAVE_PKG_KI18N
!include "inst-ki18n.nsi"
!endif
!ifdef HAVE_PKG_KWIDGETSADDONS
!include "inst-kwidgetsaddons.nsi"
!endif
!ifdef HAVE_PKG_KCOMPLETION
!include "inst-kcompletion.nsi"
!endif
!ifdef HAVE_PKG_KWINDOWSYSTEM
!include "inst-kwindowsystem.nsi"
!endif
!ifdef HAVE_PKG_KCOREADDONS
!include "inst-kcoreaddons.nsi"
!endif
!ifdef HAVE_PKG_KCODECS
!include "inst-kcodecs.nsi"
!endif
!ifdef HAVE_PKG_KCONFIGWIDGETS
!include "inst-kconfigwidgets.nsi"
!endif
!ifdef HAVE_PKG_KXMLGUI
!include "inst-kxmlgui.nsi"
!endif
!ifdef HAVE_PKG_KGUIADDONS
!include "inst-kguiaddons.nsi"
!endif
!ifdef HAVE_PKG_KMIME
!include "inst-kmime.nsi"
!endif
!ifdef HAVE_PKG_KDE_L10N
!include "inst-kde-l10n.nsi"
!endif
!ifdef HAVE_PKG_KICONTHEMES
!include "inst-kiconthemes.nsi"
!endif
!ifdef HAVE_PKG_KARCHIVE
!include "inst-karchive.nsi"
!endif
!ifdef HAVE_PKG_KITEMVIEWS
!include "inst-kitemviews.nsi"
!endif
!ifdef HAVE_PKG_KITEMMODELS
!include "inst-kitemmodels.nsi"
!endif
!ifdef HAVE_PKG_LIBKLEO
!include "inst-libkleo.nsi"
!endif
!ifdef HAVE_PKG_EXTRA_CMAKE_MODULES
!include "inst-extra-cmake-modules.nsi"
!endif
!ifdef HAVE_PKG_QTSVG
!include "inst-qtsvg.nsi"
!endif
!ifdef HAVE_PKG_QTTRANSLATIONS
!include "inst-qttranslations.nsi"
!endif

# These are displayed in the selection dialog.

!ifdef HAVE_PKG_KLEOPATRA
!include "inst-kleopatra.nsi"
!endif
!ifdef HAVE_PKG_GPA
!include "inst-gpa.nsi"
!endif
!ifdef HAVE_PKG_GPGOL
!include "inst-gpgol.nsi"
!endif
!ifdef HAVE_PKG_GPGEX
!include "inst-gpgex.nsi"
!endif
!ifdef HAVE_PKG_PAPERKEY
!include "inst-paperkey.nsi"
!endif
!ifdef HAVE_PKG_COMPENDIUM
!include "inst-compendium.nsi"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_EN
!include "inst-man_novice_en.nsi"
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_EN
!include "inst-man_advanced_en.nsi"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
!include "inst-man_novice_de.nsi"
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_DE
!include "inst-man_advanced_de.nsi"
!endif

!include "inst-final.nsi"

# We have to invoke the uninstallers in reverse order!

!ifdef HAVE_PKG_MAN_ADVANCED_DE
!include "uninst-man_advanced_de.nsi"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
!include "uninst-man_novice_de.nsi"
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_EN
!include "uninst-man_advanced_en.nsi"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_EN
!include "uninst-man_novice_en.nsi"
!endif
!ifdef HAVE_PKG_COMPENDIUM
!include "uninst-compendium.nsi"
!endif
!ifdef HAVE_PKG_PAPERKEY
!include "uninst-paperkey.nsi"
!endif
!ifdef HAVE_PKG_GPGEX
!include "uninst-gpgex.nsi"
!endif
!ifdef HAVE_PKG_GPGOL
!include "uninst-gpgol.nsi"
!endif
!ifdef HAVE_PKG_GPA
!include "uninst-gpa.nsi"
!endif
!ifdef HAVE_PKG_KLEOPATRA
!include "uninst-kleopatra.nsi"
!endif

!ifdef HAVE_PKG_GPGME
!include "uninst-gpgme.nsi"
!endif
!ifdef HAVE_PKG_GNUPG_W32
!include "uninst-gnupg-w32.nsi"
!endif
!ifdef HAVE_PKG_PINENTRY
!include "uninst-pinentry.nsi"
!endif
!ifdef HAVE_PKG_GNUTLS
!include "uninst-gnutls.nsi"
!endif
!ifdef HAVE_PKG_CURL
!include "uninst-curl.nsi"
!endif
!ifdef HAVE_PKG_GTK_
!include "uninst-gtk+.nsi"
!endif
!ifdef HAVE_PKG_GDK_PIXBUF
!include "uninst-gdk-pixbuf.nsi"
!endif
!ifdef HAVE_PKG_ATK
!include "uninst-atk.nsi"
!endif
!ifdef HAVE_PKG_PANGO
!include "uninst-pango.nsi"
!endif
!ifdef HAVE_PKG_CAIRO
!include "uninst-cairo.nsi"
!endif
!ifdef HAVE_PKG_FONTCONFIG
!include "uninst-fontconfig.nsi"
!endif
!ifdef HAVE_PKG_FREETYPE
!include "uninst-freetype.nsi"
!endif
!ifdef HAVE_PKG_EXPAT
!include "uninst-expat.nsi"
!endif
!ifdef HAVE_PKG_GLIB
!include "uninst-glib.nsi"
!endif
!ifdef HAVE_PKG_LIBFFI
!include "uninst-libffi.nsi"
!endif
!ifdef HAVE_PKG_LIBGPG_ERROR
!include "uninst-libgpg-error.nsi"
!endif
!ifdef HAVE_PKG_LIBASSUAN
!include "uninst-libassuan.nsi"
!endif
!ifdef HAVE_PKG_LIBPNG
!include "uninst-libpng.nsi"
!endif
!ifdef HAVE_PKG_GETTEXT
!include "uninst-gettext.nsi"
!endif
!ifdef HAVE_PKG_QTBASE
!include "uninst-qtbase.nsi"
!endif
!ifdef HAVE_PKG_ZLIB
!include "uninst-zlib.nsi"
!endif
!ifdef HAVE_PKG_W32PTH
!include "uninst-w32pth.nsi"
!endif
!ifdef HAVE_PKG_PKGCONFIG
!include "uninst-pkgconfig.nsi"
!endif
!ifdef HAVE_PKG_BREEZE_ICONS
!include "uninst-breeze-icons.nsi"
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_DE
!include "uninst-man_advanced_de.nsi"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_DE
!include "uninst-man_novice_de.nsi"
!endif
!ifdef HAVE_PKG_MAN_ADVANCED_EN
!include "uninst-man_advanced_en.nsi"
!endif
!ifdef HAVE_PKG_MAN_NOVICE_EN
!include "uninst-man_novice_en.nsi"
!endif
!ifdef HAVE_PKG_LIBICONV
!include "uninst-libiconv.nsi"
!endif
!ifdef HAVE_PKG_QTTOOLS
!include "uninst-qttools.nsi"
!endif
!ifdef HAVE_PKG_QTWINEXTRAS
!include "uninst-qtwinextras.nsi"
!endif
!ifdef HAVE_PKG_BOOST
!include "uninst-boost.nsi"
!endif
!ifdef HAVE_PKG_KCONFIG
!include "uninst-kconfig.nsi"
!endif
!ifdef HAVE_PKG_KI18N
!include "uninst-ki18n.nsi"
!endif
!ifdef HAVE_PKG_KWIDGETSADDONS
!include "uninst-kwidgetsaddons.nsi"
!endif
!ifdef HAVE_PKG_KCOMPLETION
!include "uninst-kcompletion.nsi"
!endif
!ifdef HAVE_PKG_KWINDOWSYSTEM
!include "uninst-kwindowsystem.nsi"
!endif
!ifdef HAVE_PKG_KCOREADDONS
!include "uninst-kcoreaddons.nsi"
!endif
!ifdef HAVE_PKG_KCODECS
!include "uninst-kcodecs.nsi"
!endif
!ifdef HAVE_PKG_KCONFIGWIDGETS
!include "uninst-kconfigwidgets.nsi"
!endif
!ifdef HAVE_PKG_KGUIADDONS
!include "uninst-kguiaddons.nsi"
!endif
!ifdef HAVE_PKG_KXMLGUI
!include "uninst-kxmlgui.nsi"
!endif
!ifdef HAVE_PKG_KICONTHEMES
!include "uninst-kiconthemes.nsi"
!endif
!ifdef HAVE_PKG_KARCHIVE
!include "uninst-karchive.nsi"
!endif
!ifdef HAVE_PKG_KITEMVIEWS
!include "uninst-kitemviews.nsi"
!endif
!ifdef HAVE_PKG_KITEMMODELS
!include "uninst-kitemmodels.nsi"
!endif
!ifdef HAVE_PKG_KMIME
!include "uninst-kmime.nsi"
!endif
!ifdef HAVE_PKG_KDE_L10N
!include "uninst-kde-l10n.nsi"
!endif
!ifdef HAVE_PKG_LIBKLEO
!include "uninst-libkleo.nsi"
!endif
!ifdef HAVE_PKG_EXTRA_CMAKE_MODULES
!include "uninst-extra-cmake-modules.nsi"
!endif
!ifdef HAVE_PKG_BZIP2
!include "uninst-bzip2.nsi"
!endif
!ifdef HAVE_PKG_QTSVG
!include "uninst-qtsvg.nsi"
!endif
!ifdef HAVE_PKG_QTTRANSLATIONS
!include "uninst-qttranslations.nsi"
!endif

!include "uninst-gpg4win.nsi"


# Dependency Management

${MementoSectionDone}

Function CalcDefaults

!ifdef HAVE_PKG_KLEOPATRA
  g4wihelp::config_fetch_bool "inst_kleopatra"
  StrCmp $R0 "1" 0 calc_defaults_kleopatra_not_one
   !insertmacro SelectSection ${SEC_kleopatra}
   Goto calc_defaults_kleopatra_done
  calc_defaults_kleopatra_not_one:
  StrCmp $R0 "0" 0 calc_defaults_kleopatra_done
   !insertmacro UnselectSection ${SEC_kleopatra}
calc_defaults_kleopatra_done:
!endif

!ifdef HAVE_PKG_GPGOL
  g4wihelp::config_fetch_bool "inst_gpgol"
  StrCmp $R0 "1" 0 calc_defaults_gpgol_not_one
   !insertmacro SelectSection ${SEC_gpgol}
   Goto calc_defaults_gpgol_done
  calc_defaults_gpgol_not_one:
  StrCmp $R0 "0" 0 calc_defaults_gpgol_done
   !insertmacro UnselectSection ${SEC_gpgol}
calc_defaults_gpgol_done:
!endif

!ifdef HAVE_PKG_GPGEX
  g4wihelp::config_fetch_bool "inst_gpgex"
  StrCmp $R0 "1" 0 calc_defaults_gpgex_not_one
   !insertmacro SelectSection ${SEC_gpgex}
   Goto calc_defaults_gpgex_done
  calc_defaults_gpgex_not_one:
  StrCmp $R0 "0" 0 calc_defaults_gpgex_done
   !insertmacro UnselectSection ${SEC_gpgex}
calc_defaults_gpgex_done:
!endif

!ifdef HAVE_PKG_PAPERKEY
  g4wihelp::config_fetch_bool "inst_paperkey"
  StrCmp $R0 "1" 0 calc_defaults_paperkey_not_one
   !insertmacro SelectSection ${SEC_paperkey}
   Goto calc_defaults_paperkey_done
  calc_defaults_paperkey_not_one:
  StrCmp $R0 "0" 0 calc_defaults_paperkey_done
   !insertmacro UnselectSection ${SEC_paperkey}
calc_defaults_paperkey_done:
!endif

!ifdef HAVE_PKG_GPA
  g4wihelp::config_fetch_bool "inst_gpa"
  StrCmp $R0 "1" 0 calc_defaults_gpa_not_one
   !insertmacro SelectSection ${SEC_gpa}
   Goto calc_defaults_gpa_done
  calc_defaults_gpa_not_one:
  StrCmp $R0 "0" 0 calc_defaults_gpa_done
   !insertmacro UnselectSection ${SEC_gpa}
calc_defaults_gpa_done:
!endif

!ifdef HAVE_PKG_COMPENDIUM
  g4wihelp::config_fetch_bool "inst_compendium"
  StrCmp $R0 "1" 0 calc_defaults_compendium_not_one
   !insertmacro SelectSection ${SEC_compendium}
   Goto calc_defaults_compendium_done
  calc_defaults_compendium_not_one:
  StrCmp $R0 "0" 0 calc_defaults_compendium_done
   !insertmacro UnselectSection ${SEC_compendium}
calc_defaults_compendium_done:
!endif


!ifdef HAVE_PKG_MAN_NOVICE_DE
  g4wihelp::config_fetch_bool "inst_man_novice_de"
  StrCmp $R0 "1" 0 calc_defaults_man_novice_de_not_one
   !insertmacro SelectSection ${SEC_man_novice_de}
   Goto calc_defaults_man_novice_de_done
  calc_defaults_man_novice_de_not_one:
  StrCmp $R0 "0" 0 calc_defaults_man_novice_de_done
   !insertmacro UnselectSection ${SEC_man_novice_de}
calc_defaults_man_novice_de_done:
!endif

!ifdef HAVE_PKG_MAN_NOVICE_EN
  g4wihelp::config_fetch_bool "inst_man_novice_en"
  StrCmp $R0 "1" 0 calc_defaults_man_novice_en_not_one
   !insertmacro SelectSection ${SEC_man_novice_en}
   Goto calc_defaults_man_novice_en_done
  calc_defaults_man_novice_en_not_one:
  StrCmp $R0 "0" 0 calc_defaults_man_novice_en_done
   !insertmacro UnselectSection ${SEC_man_novice_en}
calc_defaults_man_novice_en_done:
!endif

!ifdef HAVE_PKG_MAN_ADVANCED_DE
  g4wihelp::config_fetch_bool "inst_man_advanced_de"
  StrCmp $R0 "1" 0 calc_defaults_man_advanced_de_not_one
   !insertmacro SelectSection ${SEC_man_advanced_de}
   Goto calc_defaults_man_advanced_de_done
  calc_defaults_man_advanced_de_not_one:
  StrCmp $R0 "0" 0 calc_defaults_man_advanced_de_done
   !insertmacro UnselectSection ${SEC_man_advanced_de}
calc_defaults_man_advanced_de_done:
!endif

!ifdef HAVE_PKG_MAN_ADVANCED_EN
  g4wihelp::config_fetch_bool "inst_man_advanced_en"
  StrCmp $R0 "1" 0 calc_defaults_man_advanced_en_not_one
   !insertmacro SelectSection ${SEC_man_advanced_en}
   Goto calc_defaults_man_advanced_en_done
  calc_defaults_man_advanced_en_not_one:
  StrCmp $R0 "0" 0 calc_defaults_man_advanced_en_done
   !insertmacro UnselectSection ${SEC_man_advanced_en}
calc_defaults_man_advanced_en_done:
!endif

# Check if minimal install was requested on the command line

StrCmp $is_minimal '1' select_minimal continue
select_minimal:
   !insertmacro UnselectSection ${SEC_kleopatra}
   !insertmacro UnselectSection ${SEC_gpgol}
   !insertmacro UnselectSection ${SEC_gpgex}
   !insertmacro UnselectSection ${SEC_gpa}
   !insertmacro UnselectSection ${SEC_compendium}

# We only do pinentry and gnupg-w32
   !insertmacro SelectSection ${SEC_paperkey}
   !insertmacro SelectSection ${SEC_gnupg_w32}
   !insertmacro SelectSection ${SEC_pinentry}
continue:
FunctionEnd


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
!ifdef HAVE_PKG_EXPAT
  !insertmacro UnselectSection ${SEC_expat}
!endif
!ifdef HAVE_PKG_FREETYPE
  !insertmacro UnselectSection ${SEC_freetype}
!endif
!ifdef HAVE_PKG_FONTCONFIG
  !insertmacro UnselectSection ${SEC_fontconfig}
!endif
!ifdef HAVE_PKG_CAIRO
  !insertmacro UnselectSection ${SEC_cairo}
!endif
!ifdef HAVE_PKG_GTK_
  !insertmacro UnselectSection ${SEC_gtk_}
!endif
!ifdef HAVE_PKG_BZIP2
  !insertmacro UnselectSection ${SEC_bzip2}
!endif
!ifdef HAVE_PKG_LIBGPG_ERROR
  !insertmacro UnselectSection ${SEC_libgpg_error}
!endif
!ifdef HAVE_PKG_W32PTH
  !insertmacro UnselectSection ${SEC_w32pth}
!endif
!ifdef HAVE_PKG_LIBASSUAN
  !insertmacro UnselectSection ${SEC_libassuan}
!endif
!ifdef HAVE_PKG_PINENTRY
  !insertmacro UnselectSection ${SEC_pinentry}
!endif
!ifdef HAVE_PKG_GPGME
  !insertmacro UnselectSection ${SEC_gpgme}
!endif
!ifdef HAVE_PKG_LIBGSASL
  !insertmacro UnselectSection ${SEC_libgsasl}
!endif
!ifdef HAVE_PKG_LIBTASN1
  !insertmacro UnselectSection ${SEC_libtasn1}
!endif
!ifdef HAVE_PKG_GNUTLS
  !insertmacro UnselectSection ${SEC_gnutls}
!endif
!ifdef HAVE_PKG_CURL
  !insertmacro UnselectSection ${SEC_curl}
!endif
!ifdef HAVE_PKG_QTBASE
  !insertmacro UnselectSection ${SEC_qtbase}
!endif
!ifdef HAVE_PKG_QTTOOLS
  !insertmacro UnselectSection ${SEC_qttools}
!endif
!ifdef HAVE_PKG_QTWINEXTRAS
  !insertmacro UnselectSection ${SEC_qtwinextras}
!endif
!ifdef HAVE_PKG_BREEZE_ICONS
  !insertmacro UnselectSection ${SEC_breeze_icons}
!endif
!ifdef HAVE_PKG_KCONFIG
  !insertmacro UnselectSection ${SEC_kconfig}
!endif
!ifdef HAVE_PKG_KI18N
  !insertmacro UnselectSection ${SEC_ki18n}
!endif
!ifdef HAVE_PKG_KWIDGETSADDONS
  !insertmacro UnselectSection ${SEC_kwidgetsaddons}
!endif
!ifdef HAVE_PKG_KCOMPLETION
  !insertmacro UnselectSection ${SEC_kcompletion}
!endif
!ifdef HAVE_PKG_KWINDOWSYSTEM
  !insertmacro UnselectSection ${SEC_kwindowsystem}
!endif
!ifdef HAVE_PKG_KCOREADDONS
  !insertmacro UnselectSection ${SEC_kcoreaddons}
!endif
!ifdef HAVE_PKG_KCODECS
  !insertmacro UnselectSection ${SEC_kcodecs}
!endif
!ifdef HAVE_PKG_KCONFIGWIDGETS
  !insertmacro UnselectSection ${SEC_kconfigwidgets}
!endif
!ifdef HAVE_PKG_KXMLGUI
  !insertmacro UnselectSection ${SEC_kxmlgui}
!endif
!ifdef HAVE_PKG_KICONTHEMES
  !insertmacro UnselectSection ${SEC_kiconthemes}
!endif
!ifdef HAVE_PKG_KARCHIVE
  !insertmacro UnselectSection ${SEC_karchive}
!endif
!ifdef HAVE_PKG_KITEMVIEWS
  !insertmacro UnselectSection ${SEC_kitemviews}
!endif
!ifdef HAVE_PKG_KITEMMODELS
  !insertmacro UnselectSection ${SEC_kitemmodels}
!endif
!ifdef HAVE_PKG_KGUIADDONS
  !insertmacro UnselectSection ${SEC_kguiaddons}
!endif
!ifdef HAVE_PKG_LIBKLEO
  !insertmacro UnselectSection ${SEC_libkleo}
!endif
!ifdef HAVE_PKG_KMIME
  !insertmacro UnselectSection ${SEC_kmime}
!endif
!ifdef HAVE_PKG_KDE_L10N
  !insertmacro UnselectSection ${SEC_kde-l10n}
!endif
!ifdef HAVE_PKG_QTSVG
  !insertmacro UnselectSection ${SEC_qtsvg}
!endif
!ifdef HAVE_PKG_QTTRANSLATIONS
  !insertmacro UnselectSection ${SEC_qttranslations}
!endif

  # Always install gnupg2.  This is also ensured by putting
  # these packages in the RO section and enabling them by default, but
  # it doesn't harm to add it explicitely here as well.

  # TODO: Handle newer / other gnupg versions
  !insertmacro SelectSection ${SEC_gnupg_w32}

  # Then enable all dependencies, mostly in reverse build list order!

  # First the explicitely installed packages.


!ifdef HAVE_PKG_PAPERKEY
  !insertmacro SectionFlagIsSet ${SEC_paperkey} \
		${SF_SELECTED} have_paperkey skip_paperkey
  have_paperkey:
  # All dependencies are linked in statically.
  skip_paperkey:
!endif

!ifdef HAVE_PKG_GPGEX
  !insertmacro SectionFlagIsSet ${SEC_gpgex} \
		${SF_SELECTED} have_gpgex skip_gpgex
  have_gpgex:

  # This is not a build dependency, but it is a run-time dependency.
  !insertmacro SectionFlagIsSet ${SEC_gpa} \
		${SF_SELECTED} skipa_gpgex_dep_kleopatra need_gpgex_dep_kleopatra
  need_gpgex_dep_kleopatra:
  !insertmacro SelectSection ${SEC_kleopatra}
  skipa_gpgex_dep_kleopatra:

  # Other dependencies are linked in statically.
  skip_gpgex:
!endif

!ifdef HAVE_PKG_GPGOL
  !insertmacro SectionFlagIsSet ${SEC_gpgol} \
		${SF_SELECTED} have_gpgol skip_gpgol
  have_gpgol:
  !insertmacro SelectSection ${SEC_gpgme}

  # This is not a build dependency, but it is a run-time dependency.
  !insertmacro SectionFlagIsSet ${SEC_gpa} \
		${SF_SELECTED} skipa_gpgol_dep_kleopatra need_gpgol_dep_kleopatra
  need_gpgol_dep_kleopatra:
  !insertmacro SelectSection ${SEC_kleopatra}
  skipa_gpgol_dep_kleopatra:

  skip_gpgol:
!endif

!ifdef HAVE_PKG_KLEOPATRA
  !insertmacro SectionFlagIsSet ${SEC_kleopatra} ${SF_SELECTED} have_kleopatra skip_kleopatra
  have_kleopatra:
  !insertmacro SelectSection ${SEC_gpgme}
  # This drags in all the other KDE and Qt stuff.
  !insertmacro SelectSection ${SEC_kleopatra}
  skip_kleopatra:
!ifndef SOURCES
  ${IfNot} ${AtLeastWin7}
    # Disable Kleo for Windows below 7
    SectionSetFlags ${SEC_kleopatra} 16
    !insertmacro SelectSection ${SEC_gpa}
  ${Endif}
!endif
!endif

!ifdef HAVE_PKG_GNUPG_W32
  !insertmacro SectionFlagIsSet ${SEC_gnupg_w32} ${SF_SELECTED} have_gnupg_w32 skip_gnupg_w32
  have_gnupg_w32:
  !insertmacro SelectSection ${SEC_pinentry}
  skip_gnupg_w32:
!endif

!ifdef HAVE_PKG_GPA
  !insertmacro SectionFlagIsSet ${SEC_gpa} ${SF_SELECTED} have_gpa skip_gpa
  have_gpa:
  !insertmacro SelectSection ${SEC_libiconv}
  !insertmacro SelectSection ${SEC_gettext}
  !insertmacro SelectSection ${SEC_zlib}
  !insertmacro SelectSection ${SEC_gtk_}
  !insertmacro SelectSection ${SEC_libpng}
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_gpgme}
  skip_gpa:
!endif

  # Now the implicitely installed packages.

!ifdef HAVE_PKG_KLEOPATRA
  !insertmacro SectionFlagIsSet ${SEC_kleopatra} \
		${SF_SELECTED} have_kleopatra_libs skip_kleopatra_libs
  have_kleopatra_libs:
  !insertmacro SelectSection ${SEC_qtbase}
  !insertmacro SelectSection ${SEC_breeze_icons}
  !insertmacro SelectSection ${SEC_kconfig}
  !insertmacro SelectSection ${SEC_ki18n}
  !insertmacro SelectSection ${SEC_kwidgetsaddons}
  !insertmacro SelectSection ${SEC_kcompletion}
  !insertmacro SelectSection ${SEC_kwindowsystem}
  !insertmacro SelectSection ${SEC_kcoreaddons}
  !insertmacro SelectSection ${SEC_kcodecs}
  !insertmacro SelectSection ${SEC_kconfigwidgets}
  !insertmacro SelectSection ${SEC_kxmlgui}
  !insertmacro SelectSection ${SEC_kitemviews}
  !insertmacro SelectSection ${SEC_kitemmodels}
  !insertmacro SelectSection ${SEC_kiconthemes}
  !insertmacro SelectSection ${SEC_karchive}
  !insertmacro SelectSection ${SEC_kguiaddons}
  !insertmacro SelectSection ${SEC_qtsvg}
  !insertmacro SelectSection ${SEC_qttranslations}
  !insertmacro SelectSection ${SEC_kmime}
  !insertmacro SelectSection ${SEC_kde-l10n}
  !insertmacro SelectSection ${SEC_libkleo}
  !insertmacro SelectSection ${SEC_qttools}
  !insertmacro SelectSection ${SEC_qtwinextras}
  !insertmacro SelectSection ${SEC_boost}
  !insertmacro SelectSection ${SEC_extra-cmake-modules}
   skip_kleopatra_libs:
!endif

!ifdef HAVE_PKG_GPGME
  !insertmacro SectionFlagIsSet ${SEC_gpgme} \
		${SF_SELECTED} have_gpgme skip_gpgme
  have_gpgme:
  # GPGME does not depend on gnupg2.  Do this in the
  # actual application instead.
  !insertmacro SelectSection ${SEC_libgpg_error}
  !insertmacro SelectSection ${SEC_libassuan}
!ifdef HAVE_PKG_QTBASE
  !insertmacro SelectSection ${SEC_qtbase}
!endif
   skip_gpgme:
!endif

!ifdef HAVE_PKG_PINENTRY
  !insertmacro SectionFlagIsSet ${SEC_pinentry} \
		${SF_SELECTED} have_pinentry skip_pinentry
  have_pinentry:
  !insertmacro SelectSection ${SEC_libiconv}
!ifdef HAVE_PKG_QTBASE
  !insertmacro SelectSection ${SEC_qtbase}
!endif
!ifdef HAVE_PKG_GTK_
  !insertmacro SelectSection ${SEC_gtk_}
!endif
   skip_pinentry:
!endif

!ifdef HAVE_PKG_QTBASE
  !ifndef SOURCES
  ${IfNot} ${AtLeastWin7}
    # Disable qt for Windows below 7
    !insertmacro UnSelectSection ${SEC_qtbase}
  ${Endif}
  !endif
  !insertmacro SectionFlagIsSet ${SEC_qtbase} \
		${SF_SELECTED} have_qt skip_qt
  have_qt:
  !insertmacro SelectSection ${SEC_libpng}
  !insertmacro SelectSection ${SEC_zlib}
  !insertmacro SelectSection ${SEC_qttranslations}
  skip_qt:
!endif

!ifdef HAVE_PKG_LIBASSUAN
  !insertmacro SectionFlagIsSet ${SEC_libassuan} ${SF_SELECTED} have_libassuan skip_libassuan
  have_libassuan:
  !insertmacro SelectSection ${SEC_libgpg_error}
  !insertmacro SelectSection ${SEC_w32pth}
  skip_libassuan:
!endif

  # Package "w32pth" has no dependencies.

!ifdef HAVE_PKG_LIBGPG_ERROR
  !insertmacro SectionFlagIsSet ${SEC_libgpg_error} ${SF_SELECTED} have_libgpg_error skip_libgpg_error
  have_libgpg_error:
  !insertmacro SelectSection ${SEC_libiconv}
  !insertmacro SelectSection ${SEC_gettext}
  skip_libgpg_error:
!endif

  # Package "bzip2" has no dependencies.

!ifdef HAVE_PKG_GTK_
  !insertmacro SectionFlagIsSet ${SEC_gtk_} \
		${SF_SELECTED} have_gtk_ skip_gtk_
  have_gtk_:
  !insertmacro SelectSection ${SEC_libiconv}
  !insertmacro SelectSection ${SEC_gettext}
  !insertmacro SelectSection ${SEC_pkgconfig}
  !insertmacro SelectSection ${SEC_atk}
  !insertmacro SelectSection ${SEC_pango}
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_cairo}
  skip_gtk_:
!endif

!ifdef HAVE_PKG_CAIRO
  !insertmacro SectionFlagIsSet ${SEC_cairo} \
		${SF_SELECTED} have_cairo skip_cairo
  have_cairo:
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_pkgconfig}
  !insertmacro SelectSection ${SEC_expat}
  !insertmacro SelectSection ${SEC_freetype}
  !insertmacro SelectSection ${SEC_fontconfig}
  skip_cairo:
!endif

!ifdef HAVE_PKG_FONTCONFIG
  !insertmacro SectionFlagIsSet ${SEC_fontconfig} \
		${SF_SELECTED} have_fontconfig skip_fontconfig
  have_fontconfig:
  !insertmacro SelectSection ${SEC_pkgconfig}
  !insertmacro SelectSection ${SEC_freetype}
  skip_fontconfig:
!endif

!ifdef HAVE_PKG_FREETYPE
  !insertmacro SectionFlagIsSet ${SEC_freetype} \
		${SF_SELECTED} have_freetype skip_freetype
  have_freetype:
  !insertmacro SelectSection ${SEC_pkgconfig}
  !insertmacro SelectSection ${SEC_expat}
  skip_freetype:
!endif

# Package "expat" has no dependencies.

!ifdef HAVE_PKG_PANGO
  !insertmacro SectionFlagIsSet ${SEC_pango} \
		${SF_SELECTED} have_pango skip_pango
  have_pango:
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_pango:
!endif

!ifdef HAVE_PKG_ATK
  !insertmacro SectionFlagIsSet ${SEC_atk} \
		${SF_SELECTED} have_atk skip_atk
  have_atk:
  !insertmacro SelectSection ${SEC_glib}
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_atk:
!endif

!ifdef HAVE_PKG_GLIB
  !insertmacro SectionFlagIsSet ${SEC_glib} \
		${SF_SELECTED} have_glib skip_glib
  have_glib:
  !insertmacro SelectSection ${SEC_libiconv}
  !insertmacro SelectSection ${SEC_gettext}
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_glib:
!endif

  # Package "pkgconfig" has no dependencies.

!ifdef HAVE_PKG_LIBPNG
  !insertmacro SectionFlagIsSet ${SEC_libpng} \
		${SF_SELECTED} have_libpng skip_libpng
  have_libpng:
  !insertmacro SelectSection ${SEC_pkgconfig}
  skip_libpng:
!endif

  # Package "zlib" has no dependencies.

!ifdef HAVE_PKG_GETTEXT
  !insertmacro SectionFlagIsSet ${SEC_gettext} \
		${SF_SELECTED} have_gettext skip_gettext
  have_gettext:
  !insertmacro SelectSection ${SEC_libiconv}
  skip_gettext:
!endif

  # Package "libiconv" has no dependencies.

FunctionEnd

Function .onInstFailed
  Delete $TEMP\gpgspltmp.wav
FunctionEnd

Function .onInstSuccess
  ${MementoSectionSave}
  Delete $TEMP\gpgspltmp.wav
FunctionEnd

Function .onSelChange
  Call CalcDepends
FunctionEnd


# Note used anymore:
# This function is run from the finish page.
#Function RunOnFinish
#!ifdef HAVE_PKG_GPA
#    SectionGetFlags ${SEC_gpa} $R0
#    IntOp $R0 $R0 & ${SF_SELECTED}
#    IntCmp $R0 ${SF_SELECTED} 0 no_gpa_avail
#       Exec "$INSTDIR\gpa.exe"
#       Return
#   no_gpa_avail:
#!endif
#  MessageBox MB_OK "$(T_NoKeyManager)"
#FunctionEnd



# This also must be in a central place.  Also Urgs.

Section "-startmenu"

  UserInfo::GetAccountType
  Pop $1
  StrCmp $1 "Admin" is_admin is_no_admin
is_admin:
  SetShellVarContext all

is_no_admin:

  # NOT SetOutPath.
  StrCpy $OUTDIR "%HOMEDRIVE%%HOMEPATH%"

  # Check if the start menu entries where requested.
  g4wihelp::config_fetch_bool "inst_start_menu"
  StrCmp $R0 "0" no_start_menu

!ifdef HAVE_PKG_GPA
    SectionGetFlags ${SEC_gpa} $R0
    IntOp $R0 $R0 & ${SF_SELECTED}
    IntCmp $R0 ${SF_SELECTED} 0 no_gpa_menu
    CreateShortCut "$SMPROGRAMS\GPA.lnk" \
	"$INSTDIR\bin\gpa.exe" \
        "" "" "" SW_SHOWNORMAL "" $(DESC_Menu_gpa)
  no_gpa_menu:
!endif

!ifdef HAVE_PKG_KLEOPATRA
    SectionGetFlags ${SEC_kleopatra} $R0
    IntOp $R0 $R0 & ${SF_SELECTED}
    IntCmp $R0 ${SF_SELECTED} 0 no_kleopatra_menu
    CreateShortCut "$SMPROGRAMS\Kleopatra.lnk" \
	"$INSTDIR\bin\kleopatra.exe" \
        "" "$INSTDIR\bin\kleopatra.exe" "" SW_SHOWNORMAL "" $(DESC_Menu_kleopatra)
  no_kleopatra_menu:
!endif

 no_start_menu:

  # Check if the desktop entries where requested.
  g4wihelp::config_fetch_bool "inst_desktop"
  StrCmp $R0 "0" no_desktop

!ifdef HAVE_PKG_GPA
    SectionGetFlags ${SEC_gpa} $R0
    IntOp $R0 $R0 & ${SF_SELECTED}
    IntCmp $R0 ${SF_SELECTED} 0 no_gpa_desktop
    CreateShortCut "$DESKTOP\GPA.lnk" \
	"$INSTDIR\bin\gpa.exe" \
        "" "" "" SW_SHOWNORMAL "" $(DESC_Menu_gpa)
  no_gpa_desktop:
!endif

!ifdef HAVE_PKG_KLEOPATRA
    SectionGetFlags ${SEC_kleopatra} $R0
    IntOp $R0 $R0 & ${SF_SELECTED}
    IntCmp $R0 ${SF_SELECTED} 0 no_kleopatra_desktop
    CreateShortCut "$DESKTOP\Kleopatra.lnk" \
	"$INSTDIR\bin\kleopatra.exe" \
        "" "$INSTDIR\bin\kleopatra.exe" "" SW_SHOWNORMAL "" $(DESC_Menu_kleopatra)
  no_kleopatra_desktop:
!endif

no_desktop:

SectionEnd

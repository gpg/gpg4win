# Makefile.am - Makefile for building AppImage of Kleopatra
# Copyright (C) 2005, 2006, 2007, 2008, 2009, 2021 g10 Code GmbH
#
# Software engineering by Ingo Klöcker <dev@ingo-kloecker.de>
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
# along with this program; if not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-2.0+

EXTRA_DIST = AppRun

root := /build
stampdir := $(root)/stamps

# Source packages for the AppImage
appimage_spkgs = sqlite libgpg-error libassuan npth libgcrypt libksba gnupg \
		 pinentry gpgme paperkey

# Qt packages for the AppImage
appimage_qtpkgs = qtbase qttools qtx11extras qtwayland qtsvg qttranslations

# KDE packages for the AppImage
appimage_kdepkgs = kconfig kwidgetsaddons ki18n extra-cmake-modules \
		   kcompletion kwindowsystem kcoreaddons libkleo kcodecs \
		   kmime kconfigwidgets kxmlgui kguiaddons kitemviews \
		   kiconthemes kleopatra breeze-icons kitemmodels karchive \
		   kcrash kdbusaddons

# Binary packages for the AppImage
appimage_bpkgs = kde-l10n

appimage_pkg_gpgme_configure = --enable-languages=cpp,qt \
  --disable-gpg-test \
  --disable-gpgsm-test

# TODO: Disable Qt Sql?
# TODO: Disable Qt Testlib?
appimage_pkg_qtbase_configure = ../$$$${pkg_version}/configure -opensource \
            -confirm-license \
            -platform linux-g++ \
            -release \
            -shared \
            -prefix $$$${pkgidir} \
            -I '$(idir)/include' \
            -L '$(idir)/lib' \
            -opengl desktop \
            -no-glib \
            -accessibility \
            -nomake examples \
            -nomake tests \
            -no-sql-mysql \
            -no-sql-sqlite \
            -no-sql-odbc \
            -no-sql-psql \
            -no-sql-tds \
            -v \
            OPENSSL_INCDIR=/usr/include/openssl11

define appimage_pkg_qtbase_post_install
	(cd $$$${pkgbdir}; \
	 make install;)
endef

appimage_pkg_qttools_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

define appimage_pkg_qttools_post_install
	 (cd $$$${pkgbdir}; \
	  mkdir -p $$$${pkgidir}; \
	  cp -r bin lib include $$$${pkgidir})
endef

appimage_pkg_qtx11extras_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

define appimage_pkg_qtx11extras_post_install
	 (cd $$$${pkgbdir}; \
	  mkdir -p $$$${pkginstallroot}; \
	  make install INSTALL_ROOT=$$$${pkginstallroot}; \
	  mkdir -p $$$${pkgidir}; \
	  mv $$$${pkgbladir}/* $$$${pkgidir}; \
	  rm -rf $$$${pkginstallroot};)
endef

appimage_pkg_qtwayland_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

define appimage_pkg_qtwayland_post_install
	 (cd $$$${pkgbdir}; \
	  mkdir -p $$$${pkginstallroot}; \
	  make install INSTALL_ROOT=$$$${pkginstallroot}; \
	  mkdir -p $$$${pkgidir}; \
	  mv $$$${pkgbladir}/* $$$${pkgidir}; \
	  rm -rf $$$${pkginstallroot};)
endef

appimage_pkg_qtsvg_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

# XXX Adding the qtconf after qtsvg is a weird hack
# because somhow (yay qmake) zlib is not linked if
# the qt conf exists before that. The qt conf is
# needed for qttranslations to find the correct path
# of the translation tools.
define appimage_pkg_qtsvg_post_install
 (cd $$$${pkgbdir}; \
  mkdir -p $$$${pkgidir}; \
  cp -r lib include plugins $$$${pkgidir}; \
  mkdir -p $$$${pkgidir}/bin; \
  echo "[Paths]" > $$$${pkgidir}/bin/qt.conf; \
  echo "Prefix = .." >> $$$${pkgidir}/bin/qt.conf)
endef

appimage_pkg_qttranslations_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

define appimage_pkg_qttranslations_post_install
 ( rm -rf $$$${pkgidir}/translations; \
   mkdir -p $$$${pkgidir}; \
   cp -r $$$${pkgbdir}/translations $$$${pkgidir}/translations;)
endef

# do not create the huge icon resource files
appimage_pkg_breeze_icons_configure = -DBINARY_ICONS_RESOURCE=OFF

appimage_pkg_kcompletion_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

appimage_pkg_kconfigwidgets_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

appimage_pkg_ki18n_configure = -DBUILD_WITH_QML=OFF

appimage_pkg_kiconthemes_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

appimage_pkg_kitemviews_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

appimage_pkg_kwidgetsaddons_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

# FIXME: Uses spaces in distribution text
appimage_pkg_kxmlgui_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF \
    -DFORCE_DISABLE_KGLOBALACCEL=ON \
    -DXMLGUI_DISTRIBUTION_TEXT=g10_Code_GmbH_AppImage

appimage_pkg_libkleo_configure = \
    -DBOOST_INCLUDEDIR=/usr/include/boost169 \
    -DBOOST_LIBRARYDIR=/usr/lib64/boost169

appimage_pkg_kleopatra_configure = \
    -DBOOST_INCLUDEDIR=/usr/include/boost169 \
    -DBOOST_LIBRARYDIR=/usr/lib64/boost169 \
    -DDISABLE_KWATCHGNUPG=ON \
    -DRELEASE_SERVICE_VERSION=AppImage-$(VERSION)


########################################################################

# Now do the bunch of the work.  This is a bunch of dirty magic to
# integrate our special makefile into automake, while not actually
# including it (make should include it).  This is in turn necessary
# because automake can't deal with the elegant magic in the actual
# Makefile.

define INCLUDE_BY_MAKE
include $(1)
endef

$(eval $(call INCLUDE_BY_MAKE,appimage.mk))

clean-local: clean-appimage

license.blurb: $(top_srcdir)/doc/license-page $(top_srcdir)/doc/GPLv3
	cat $(top_srcdir)/doc/license-page $(top_srcdir)/doc/GPLv3 >$@

all-local: $(stampdir)/stamp-final
	@echo "###################################################"
	@echo " AppDir prepared successfully for the AppImage!"
	@echo " Now run linuxdeploy to create the AppImage."
	@echo "###################################################"

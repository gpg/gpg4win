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

EXTRA_DIST = AppRun start-shell build-appimage.sh

SUBDIRS = rsync-filters

root := /build/src/playground
stampdir := $(root)/stamps

# Source packages for the AppImage (see also ../src/Makefile.am)
appimage_spkgs = sqlite libgpg-error libassuan npth libgcrypt libksba gnupg \
		 pinentry gpgme paperkey ntbtls \
		 freetype qrencode jpeg libpng xcb-util-cursor


appimage_pkg_libgpg_error_configure = --enable-install-gpg-error-config


# KDE packages for the AppImage
appimage_kdepkgs = kconfig kwidgetsaddons ki18n extra-cmake-modules \
		   kcompletion kwindowsystem kcoreaddons libkleo kcodecs \
		   kmime kmbox kconfigwidgets kxmlgui kguiaddons kitemviews \
		   kiconthemes kleopatra breeze-icons kitemmodels karchive \
		   kcrash kdbusaddons kio kbookmarks kservice solid \
		   kjobwidgets libical kcalendarcore mimetreeparser \
		   kcolorscheme sonnet ktextwidgets kauth kstatusnotifieritem \
		   threadweaver kparts poppler okular \
		   prison gpgpass zstd pcre2 \
		   qtbase qttools qtsvg qttranslations qtwayland \
		   plasma-wayland-protocols

appimage_bpkgs = wayland-protocols

define appimage_pkg_wayland_protocols_post_install
( \
	cd ..; \
	mv $$$${pkgidir}/* $$$${pkgsdir};\
	cd $$$${pkgsdir}; \
	meson setup --prefix $$$${pkgidir} build; \
	cd build; \
	ninja && ninja install; \
	cd $$$${pkgidir}; \
)
endef

appimage_pkg_gpgme_configure = --enable-languages=cpp,qt \
  --disable-gpg-test \
  --disable-gpgsm-test

appimage_pkg_qtbase_configure = \
        -DQT_BUILD_EXAMPLES=OFF \
        -DQT_BUILD_TESTS=OFF \
        -DBUILD_WITH_PCH=OFF \
        -DFEATURE_accessibility=ON \
        -DFEATURE_glib=OFF \
        -DFEATURE_opengl_desktop=ON \
        -DFEATURE_pkg_config=ON \
        -DFEATURE_sql_mysql=OFF \
        -DFEATURE_sql_odbc=OFF \
        -DFEATURE_sql_psql=OFF \
        -DFEATURE_system_freetype=ON \
        -DFEATURE_system_pcre=ON \
        -DFEATURE_system_jpeg=ON \
        -DFEATURE_system_zstd=ON \
        -DFEATURE_xcb=ON \
        -DFEATURE_use_gold_linker_alias=OFF \
        -DCMAKE_MESSAGE_LOG_LEVEL=STATUS \
        -DCMAKE_VERBOSE_MAKEFILE=ON

# do not create the huge icon resource files
appimage_pkg_breeze_icons_configure = -DBINARY_ICONS_RESOURCE=OFF

appimage_pkg_karchive_configure = -DWITH_BZIP2=OFF

appimage_pkg_kcompletion_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

appimage_pkg_kconfigwidgets_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

appimage_pkg_kconfig_configure = -DKCONFIG_USE_DBUS=OFF -DKCONFIG_USE_QML=OFF

appimage_pkg_kguiaddons_configure = -DWITH_WAYLAND=OFF

appimage_pkg_sonnet_configure = -DSONNET_USE_QML=OFF

appimage_pkg_ki18n_configure = -DBUILD_WITH_QML=OFF

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

appimage_pkg_poppler_configure = \
    -DENABLE_BOOST=OFF \
    -DENABLE_NSS3=OFF \
    -DENABLE_GOBJECT_INTROSPECTION=OFF \
    -DENABLE_QT5=OFF \
    -DENABLE_LCMS=OFF \
    -DENABLE_LIBCURL=OFF

appimage_pkg_okular_configure = \
    -DFORCE_NOT_REQUIRED_DEPENDENCIES="PlasmaActivities\;KF6Wallet\;KF6Purpose\;Qt6TextToSpeech\;LibZip\;KF6DocTools\;Phonon4Qt6\;LibSpectre\;KExiv2Qt6\;CHM\;DjVuLibre\;EPub\;QMobipocket\;Discount\;Qt6Qml\;Qt6DBus\;KF6Pty"

appimage_pkg_libical_configure = \
    -DICAL_GLIB=false \
    -DENABLE_GTK_DOC=false

appimage_pkg_prison_configure = \
    -DWITH_QUICK=OFF \
    -DWITH_MULTIMEDIA=OFF

appimage_pkg_kiconthemes_configure = \
    -DKICONTHEMES_USE_QTQUICK=OFF

appimage_pkg_kcoreaddons_configure = -DKCOREADDONS_USE_QML=OFF

appimage_pkg_ktextwidgets_configure = -DWITH_TEXT_TO_SPEECH=OFF

appimage_pkg_kio_configure = -DWITH_WAYLAND=OFF
appimage_pkg_kwindowsystem_configure = -DKWINDOWSYSTEM_QML=OFF

appimage_pkg_xcb_util_cursor_configure = --enable-static --disable-shared
appimage_pkg_xcb_util_cursor_extracflags = -fPIC

appimage_pkg_zstd_conf_subdir = /build/cmake
appimage_pkg_zstd_configure = -DZSTD_BUILD_PROGRAMS=OFF

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

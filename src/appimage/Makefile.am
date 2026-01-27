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

# Define macros for the various directories.  These directory names
# must be absolute, as we switch pretty often between them and don't
# want to track relative names.  The directories are created as needed
# by the $(stampdir)/stamp-directories target.  tsdir is used instead
# of the predefined top_srcdir so that we can override it using make
# variables.
#
# tsdir    :: The top source directory.
# root     :: Our build root.  The make variable PLAYGROUND can be used
#             to override the default.
# stampdir :: The directory to hold stamp files.
# logdir   :: The directory for the build logs.
# bdir     :: The build dir for the individual packages.
# idir     :: The directory with the installed files from the packages.
# ipdir    :: A subdir of the install directory to hold the installed
#             packages which will be stowed to other subdirs of $(idir).
# appdir   :: The directory for preparing the content of the AppImage.
# patdir   :: The source directory patches-appimage/ below tsdir.
# rsyncfilterdir :: The source directory with the package-specific
#                   rsync filters (rsync replaces stow in the AppImage
#                   build).

tsdir     := $(TOPSRCDIR)
root      := $(PLAYGROUND)
stampdir  := $(root)/stamps
logdir    := $(root)/logs
bdir      := $(root)/build
idir      := $(root)/install
ipdir     := $(root)/install/pkgs
appdir    := $(root)/AppDir
patdir    := $(tsdir)/patches-appimage
rsyncfilterdir := $(tsdir)/src/appimage/rsync-filters

$(info -------------------------------------------------)
$(info Topsource ....: $(tsdir))
$(info Playground ...: $(root))
$(info Stamps at ....: $(stampdir))
$(info Building at ..: $(bdir))
$(info Logs at ......: $(logdir))
$(info -------------------------------------------------)


# Source packages for the AppImage (see also ../src/Makefile.am)
appimage_spkgs = sqlite libgpg-error libassuan npth libgcrypt libksba gnupg \
		 pinentry gpgme paperkey ntbtls \
		 freetype libpng xcb-util-cursor


appimage_pkg_libgpg_error_configure = --enable-install-gpg-error-config


# KDE packages for the AppImage
appimage_kdepkgs = gpgmepp qgpgme \
		   kconfig kwidgetsaddons ki18n extra-cmake-modules \
		   kcompletion kwindowsystem kcoreaddons libkleo kcodecs \
		   kmime kmbox kconfigwidgets kxmlgui kguiaddons kitemviews \
		   kiconthemes kleopatra breeze-icons kitemmodels karchive \
		   kcrash kdbusaddons kio kbookmarks kservice solid \
		   kjobwidgets libical kcalendarcore mimetreeparser \
		   kcolorscheme sonnet ktextwidgets kauth kstatusnotifieritem \
		   threadweaver kparts poppler okular \
		   libqrencode \
		   prison gpgpass \
		   qtbase qttools qtsvg qttranslations qtwayland \
		   plasma-wayland-protocols breeze

appimage_bpkgs = wayland-protocols

define appimage_pkg_wayland_protocols_post_install
( \
	cd ..; \
	mv $$$${pkgidir}/$$$${pkg_version} $$$${pkgsdir};\
	cd $$$${pkgsdir}; \
	meson setup --prefix $$$${pkgidir} build -Dtests=false; \
	cd build; \
	ninja && ninja install; \
	cd $$$${pkgidir}; \
)
endef

appimage_pkg_gpgme_configure = \
    --enable-languages= \
    --disable-gpg-test \
    --disable-gpgsm-test

appimage_pkg_qgpgme_configure = -DBUILD_WITH_QT5=OFF

appimage_pkg_qtbase_configure = \
        -DQT_BUILD_EXAMPLES=OFF \
        -DQT_BUILD_TESTS=OFF \
        -DBUILD_WITH_PCH=OFF \
        -DFEATURE_accessibility=ON \
        -DFEATURE_glib=OFF \
        -DFEATURE_dynamicgl=OFF \
        -DFEATURE_egl=OFF \
        -DFEATURE_opengl_desktop=OFF \
        -DFEATURE_opengl_dynamic=OFF \
        -DFEATURE_opengles2=OFF \
        -DFEATURE_opengl=OFF \
        -DINPUT_opengl=no \
        -DFEATURE_pkg_config=ON \
        -DFEATURE_sql_mysql=OFF \
        -DFEATURE_sql_odbc=OFF \
        -DFEATURE_sql_psql=OFF \
        -DFEATURE_qt_freetype=ON \
        -DFEATURE_system_pcre=ON \
        -DFEATURE_system_jpeg=ON \
        -DFEATURE_system_zstd=ON \
        -DFEATURE_xcb=ON \
        -DFEATURE_use_gold_linker_alias=OFF \
        -DCMAKE_MESSAGE_LOG_LEVEL=STATUS \
        -DCMAKE_VERBOSE_MAKEFILE=ON

appimage_pkg_qttools_configure = \
	-DFEATURE_assistant=OFF \
	-DFEATURE_qdoc=OFF \
	-DFEATURE_designer=OFF \
	-DFEATURE_distancefieldgenerator=OFF \
	-DFEATURE_kmap2qmap=OFF \
	-DFEATURE_pixeltool=OFF \
	-DFEATURE_qdbus=OFF \
	-DFEATURE_qev=OFF \
	-DFEATURE_qtattributionsscanner=OFF \
	-DFEATURE_qtdiag=OFF \
	-DFEATURE_qtplugininfo=OFF

# do not create the huge icon resource files
appimage_pkg_breeze_icons_configure = -DBINARY_ICONS_RESOURCE=OFF

appimage_pkg_breeze_configure = \
    -DBUILD_QT6=ON \
    -DBUILD_QT5=OFF \
    -DWITH_DECORATIONS=OFF \
    -DCMAKE_DISABLE_FIND_PACKAGE_KF6KCMUtils=ON

appimage_pkg_karchive_configure = -DWITH_BZIP2=OFF

appimage_pkg_kcompletion_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

appimage_pkg_kconfigwidgets_configure = \
    -DBUILD_DESIGNERPLUGIN=OFF

appimage_pkg_kconfig_configure = -DKCONFIG_USE_DBUS=OFF -DKCONFIG_USE_QML=OFF

appimage_pkg_kcrash_configure = -DWITH_OPENGL=OFF

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
    -DFORCE_DISABLE_KGLOBALACCEL=ON

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
    -DENABLE_LIBCURL=OFF \
    -DFONT_CONFIGURATION=generic

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
appimage_pkg_kcalendarcore_configure = -DUSE_QML=OFF

appimage_pkg_ktextwidgets_configure = -DWITH_TEXT_TO_SPEECH=OFF

appimage_pkg_kio_configure = -DWITH_WAYLAND=OFF
appimage_pkg_kwindowsystem_configure = -DKWINDOWSYSTEM_QML=OFF

appimage_pkg_xcb_util_cursor_configure = --enable-static --disable-shared
appimage_pkg_xcb_util_cursor_extracflags = -fPIC

########################################################################

# The build area is our scratch area, where we unpack, build and
# install the packages.
$(stampdir)/stamp-directories:
	$(MKDIR) -p $(root)
	$(MKDIR) -p $(stampdir)
	$(MKDIR) -p $(logdir)
	$(MKDIR) -p $(bdir)
	$(MKDIR) -p $(idir)
	$(MKDIR) -p $(ipdir)
	$(MKDIR) -p $(appdir)/usr
	touch $(bdir)/versioninfo.txt
	touch $(stampdir)/stamp-directories

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

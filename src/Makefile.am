# Makefile.am - Installer for GnuPG 4 Windows Makefile.
# Copyright (C) 2005, 2006, 2007, 2008, 2009 g10 Code GmbH
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
# along with this program; if not, see <http://www.gnu.org/licenses/>.

EXTRA_DIST = pkg-config gpg4win.nsi gpg4win-src.nsi \
	config.site config.nsi.in \
        libiconv.def libintl.def loreley.mid \
        gpg4win-splash.wav exdll.h exdll.c g4wihelp.c desktopshellrun.cpp \
        g4wihelp.nsi slideshow.cpp gpgwrap.c \
        gpg-enable-keyboxd.bat gpg-disable-keyboxd.bat \
        inst-sections.nsi installer.nsi installer-finish.nsi  \
	zlib.pc sha1sum.c \
        potomo Memento.nsh \
        inst-gpg4win.nsi	   uninst-gpg4win.nsi	      \
        inst-gettext.nsi	   uninst-gettext.nsi	      \
        inst-gnupg-w32.nsi	   uninst-gnupg-w32.nsi	      \
        inst-gpgme.nsi		   uninst-gpgme.nsi	      \
        inst-paperkey.nsi	   uninst-paperkey.nsi	      \
        inst-gpgol.nsi		   uninst-gpgol.nsi	      \
        inst-gpgex.nsi		   uninst-gpgex.nsi	      \
        inst-libassuan.nsi	   uninst-libassuan.nsi	      \
        inst-libgpg-error.nsi	   uninst-libgpg-error.nsi    \
        inst-libiconv.nsi	   uninst-libiconv.nsi	      \
        inst-compendium.nsi	   uninst-compendium.nsi   \
        inst-man_advanced_de.nsi   uninst-man_advanced_de.nsi \
        inst-man_advanced_en.nsi   uninst-man_advanced_en.nsi \
        inst-man_novice_de.nsi	   uninst-man_novice_de.nsi   \
        inst-man_novice_en.nsi	   uninst-man_novice_en.nsi   \
        inst-pinentry.nsi	   uninst-pinentry.nsi	      \
        inst-pkgconfig.nsi	   uninst-pkgconfig.nsi	      \
        inst-zlib.nsi        	   uninst-zlib.nsi            \
        inst-kconfig.nsi        uninst-kconfig.nsi              \
        inst-kleopatra.nsi  	   uninst-kleopatra.nsi       \
        inst-bzip2.nsi             uninst-bzip2.nsi           \
        inst-qtbase.nsi uninst-qtbase.nsi \
        inst-ki18n.nsi uninst-ki18n.nsi \
        inst-kio.nsi uninst-kio.nsi \
        inst-kbookmarks.nsi uninst-kbookmarks.nsi \
        inst-kservice.nsi uninst-kservice.nsi \
        inst-solid.nsi uninst-solid.nsi \
        inst-kjobwidgets.nsi uninst-kjobwidgets.nsi \
        inst-kwidgetsaddons.nsi uninst-kwidgetsaddons.nsi \
        inst-kcompletion.nsi uninst-kcompletion.nsi \
        inst-kwindowsystem.nsi uninst-kwindowsystem.nsi \
        inst-ktextwidgets.nsi uninst-ktextwidgets.nsi \
        inst-sonnet.nsi uninst-sonnet.nsi \
        inst-libkleo.nsi uninst-libkleo.nsi \
        inst-kcoreaddons.nsi uninst-kcoreaddons.nsi \
        inst-kcodecs.nsi uninst-kcodecs.nsi \
        inst-kconfigwidgets.nsi uninst-kconfigwidgets.nsi \
        inst-kxmlgui.nsi uninst-kxmlgui.nsi \
        inst-kiconthemes.nsi uninst-kiconthemes.nsi \
        inst-breeze-icons.nsi uninst-breeze-icons.nsi \
        inst-karchive.nsi uninst-karchive.nsi \
        inst-kcrash.nsi uninst-kcrash.nsi \
        inst-kitemviews.nsi uninst-kitemviews.nsi \
        inst-kitemmodels.nsi uninst-kitemmodels.nsi \
        inst-kguiaddons.nsi uninst-kguiaddons.nsi \
        inst-kmime.nsi uninst-kmime.nsi \
        inst-kde-l10n.nsi uninst-kde-l10n.nsi \
        inst-qtsvg.nsi uninst-qtsvg.nsi \
        inst-qttools.nsi uninst-qttools.nsi \
        inst-qttranslations.nsi uninst-qttranslations.nsi \
        inst-qtwinextras.nsi uninst-qtwinextras.nsi \
        inst-scute.nsi uninst-scute.nsi \
        inst-extra-cmake-modules.nsi uninst-extra-cmake-modules.nsi \
        inst-gpg4win-tools.nsi uninst-gpg4win-tools.nsi \
        inst-gpgme-browser.nsi \
        inst-poppler.nsi uninst-poppler.nsi \
        inst-libpng.nsi uninst-libpng.nsi \
        inst-openjpeg.nsi uninst-openjpeg.nsi \
        inst-jpeg.nsi uninst-jpeg.nsi \
        inst-tiff.nsi uninst-tiff.nsi \
        inst-freetype.nsi uninst-freetype.nsi \
        inst-threadweaver.nsi uninst-threadweaver.nsi \
        inst-kparts.nsi uninst-kparts.nsi \
        inst-okular.nsi uninst-okular.nsi \
        inst-mimetreeparser.nsi uninst-mimetreeparser.nsi \
        inst-kcalendarcore.nsi uninst-kcalendarcore.nsi \
        inst-libical.nsi uninst-libical.nsi \
        inst-final.nsi index.theme \
        slideshow/slides.dat \
        slideshow/slide1-gpgol.png \
        slideshow/slide2-gpgex.png \
        slideshow/slide3-kleopatra.png \
        slideshow/slide4-summary.png \
        icons/file-ext.ico \
        kdeglobals qtlogging.ini \
        make-msi.pl make-msi.guids \
        build-gpg4win.sh \
        WixUI_Gpg4win.wxs icons/shield.ico

if BUILD_APPIMAGE
appimage = appimage
else
appimage =
endif

SUBDIRS = ${appimage}

# These paths must be absolute, as we switch directories pretty often.
root := $(shell pwd)/playground
stampdir := $(shell pwd)/stamps

gpg4win_readme_ll = en de ar es fr ru pt zh

README_files = $(addsuffix .txt,$(addprefix README.,$(gpg4win_readme_ll)))

gpg4win_howto_smime_ll = en de

HOWTO_files = $(addsuffix .txt, \
                $(addprefix HOWTO-SMIME.,$(gpg4win_howto_smime_ll)))

foosum_exe = sha1sum.exe md5sum.exe sha256sum.exe

# Need to clean the dll because we bypassed automake.
CLEANFILES = g4wihelp.dll desktopshellrun.o versioninfo.txt $(README_files) \
			 $(HOWTO_files) NEWS.tmp COMPONENTS-list.tmp \
			 license.blurb cdversioninfo.tmp slideshow.o \
			 $(foosum_exe) gpgwrap.exe

# Supported source packages. (see also ../appimage/Makefile.am)
gpg4win_spkgs = glib libffi gdk-pixbuf gtk+ \
                libgpg-error gpgme gpgol gpgex libpng \
		gpa opencdk jpeg \
		pinentry libassuan ntbtls pcre \
		paperkey regex libiconv gettext scute

gpg4win_qtpkgs = qtbase qttools qtwinextras qtsvg qttranslations

# Source packages following the KDE pattern
gpg4win_kdepkgs = kconfig kwidgetsaddons ki18n extra-cmake-modules \
                  kcompletion kwindowsystem kcoreaddons libkleo kcodecs \
                  kmime kconfigwidgets kxmlgui kguiaddons kitemviews \
                  kiconthemes kleopatra breeze-icons kitemmodels karchive \
                  gpg4win-tools kcrash kio kbookmarks kservice solid \
                  kjobwidgets poppler okular freetype threadweaver \
                  kparts tiff openjpeg sonnet ktextwidgets mimetreeparser \
                  libical kcalendarcore

# Supported source packages to build in an additional architecture
gpg4win_expkgs = libgpg-error libassuan libiconv gettext gpgex gpgol \
                 gpgme

# Some variables
WINE = wine
WINHOST = win10
WINLIGHT = c:/wix/light.exe

# Extra options to configure for individual packages.
# We can use $(idir) here for the installation prefix.

gpg4win_pkg_libiconv_ex_configure = \
	--enable-shared=no --enable-static=yes

gpg4win_pkg_gettext_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  CPPFLAGS=-I$(idir)/include CFLAGS=-O2 LDFLAGS=-L$(idir)/lib

gpg4win_pkg_scute_configure = \
  LDFLAGS=-lws2_32

gpg4win_pkg_gettext_ex_configure = \
  --with-lib-prefix=$(ex_idir) --with-libiconv-prefix=$(ex_idir) \
  CPPFLAGS=-I$(ex_idir)/include CFLAGS=-O2 LDFLAGS=-L$(ex_idir)/lib

# We only need gettext-runtime and there is sadly no top level
# configure option for this
gpg4win_pkg_gettext_make_dir = gettext-runtime
gpg4win_pkg_gettext_make_dir_inst = gettext-runtime
gpg4win_pkg_gettext_ex_make_dir = gettext-runtime
gpg4win_pkg_gettext_ex_make_dir_inst = gettext-runtime


# Paperkey comes with a man pages which we have to convert.
define gpg4win_pkg_paperkey_post_install
(for i in paperkey ; \
  do man -Tlatin1 -l $$$${pkgidir}/share/man/man1/$$$${i}.1 | \
    sed `printf "s/_\b//g;s/\b.//g"` | \
    sed -e 's/$$$$/\r/' > $$$${pkgidir}/share/man/man1/$$$${i}.man ; \
 done)
endef



# Build the reference manual.
define gpg4win_pkg_gpgol_post_install
( cd $$$${pkgbdir}/doc; make pdf )
endef

# We would like to use --with-libiconv-prefix and
# --with-libintl-prefix, but these don't work with the cheesy
# non-"libfoo.la" versions of iconv and gettext that we are using.
#gpg4win_pkg_libgpg_error_configure = \
#  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir)
gpg4win_pkg_libgpg_error_configure = --silent \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib \
  --enable-static --enable-install-gpg-error-config

gpg4win_pkg_libgpg_error_ex_configure = --silent \
  --enable-static --enable-install-gpg-error-config

# We convert the PO files to UTF-8.  FIXME: This should be done in
# libgpg-error proper.
define gpg4win_pkg_libgpg_error_post_install
(for i in `$(tsdir)/src/potomo --get-linguas $$$${pkgsdir}/po` ; do \
   rm $$$${pkgidir}/share/locale/$$$${i}/LC_MESSAGES/libgpg-error.mo \
       2>/dev/null|| true; \
   $(tsdir)/src/potomo $$$${pkgsdir}/po/$$$${i}.po \
             $$$${pkgidir}/share/locale/$$$${i}/LC_MESSAGES/libgpg-error.mo; \
 done)
endef

gpg4win_pkg_libassuan_configure =  --silent --enable-static

gpg4win_pkg_libassuan_ex_configure = --with-gpg-error-prefix=$(ex_idir) --silent --enable-static

gpg4win_pkg_libpng_configure = HAVE_SOLARIS_LD_FALSE=yes CPPFLAGS=\"-I$(idir)/include -DPNG_BUILD_DLL\" LDFLAGS=\"-L$(idir)/lib\" LIBPNG_DEFINES=\"-DPNG_BUILD_DLL\"

# We would like to use --with-libiconv-prefix and
# --with-libintl-prefix, but these don't work with the cheesy
# non-"libfoo.la" versions of iconv and gettext that we are using.
gpg4win_pkg_pinentry_configure = \
  --enable-pinentry-qt \
  --disable-pinentry-fltk \
  --disable-pinentry-curses \
  --disable-fallback-curses \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib
#  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir)

# The LDFLAGS is needed for -lintl for glib.  The QT4 variables work
# around the lack of cross compilation support in qt-dev.
gpg4win_pkg_gpgme_configure = --silent \
  --with-gpg-error-prefix=$(idir) --enable-static \
  LDFLAGS=-L$(idir)/lib \
  --enable-languages=qt,cpp \
  --disable-gpg-test \
  --disable-gpgsm-test

gpg4win_pkg_gpgme_ex_configure = --silent \
  --with-gpg-error-prefix=$(ex_idir) --enable-static \
  --with-libassuan-prefix=$(ex_idir) \
  LDFLAGS=-L$(ex_idir)/lib \
  --enable-languages=cpp \
  --disable-gpg-test \
  --disable-gpgsm-test

gpg4win_pkg_gpgol_configure = --silent \
  --with-gpgme-prefix=$(idir) --with-gpg-error-prefix=$(idir) \
  --with-libassuan-prefix=$(idir)

gpg4win_pkg_gpgol_ex_configure = --silent \
  --with-gpgme-prefix=$(ex_idir) --with-gpg-error-prefix=$(ex_idir) \
  --with-libassuan-prefix=$(ex_idir)

gpg4win_pkg_gpgex_configure = --silent \
  --with-gpg-error-prefix=$(idir) \
  --with-libassuan-prefix=$(idir)

gpg4win_pkg_gpgex_ex_configure = --silent \
  --with-gpg-error-prefix=$(ex_idir) \
  --with-libassuan-prefix=$(ex_idir)

gpg4win_pkg_openjpeg_configure = -DBUILD_CODEC=OFF

gpg4win_pkg_paperkey_configure = --silent

gpg4win_pkg_sonnet_configure = -DSONNET_USE_QML=OFF

gpg4win_pkg_ki18n_configure = -DBUILD_WITH_QML=OFF
gpg4win_pkg_kconfig_configure = -DKCONFIG_USE_DBUS=OFF -DKCONFIG_USE_QML=OFF

gpg4win_pkg_qtbase_configure = ../$$$${pkg_version}/configure -opensource \
            -confirm-license \
            -xplatform win32-g++ \
            -device-option CROSS_COMPILE=$(host)- \
            -device-option PKG_CONFIG='$(host)-pkg-config' \
            -no-use-gold-linker \
            -release \
            -shared \
            -prefix $$$${pkgidir} \
            -I '$(idir)/include' \
            -L '$(idir)/lib' \
            -no-icu \
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
            -qt-zlib \
            -qt-libpng \
            -qt-libjpeg \
            -qt-freetype \
            -qt-pcre \
            -no-openssl \
            -no-dbus \
            -v

# qtbase
# invoke qmake with removed debug options as a workaround for
# https://bugreports.qt-project.org/browse/QTBUG-30898
gpg4win_pkg_qtbase_make_args = \
    QMAKE='$$$${pkgbdir}/bin/qmake'

# Make install step. Somehow qtprintsupport is now installed automatically.
define gpg4win_pkg_qtbase_post_install
	(cd $$$${pkgbdir}; \
	 make install; \
	 cd $$$${pkgbdir}/src/printsupport; \
	 make install;)
endef


gpg4win_pkg_qttools_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

define gpg4win_pkg_qttools_post_install
	 (cd $$$${pkgbdir}; \
	  mkdir -p $$$${pkgidir}; \
	  cp -r bin lib include $$$${pkgidir})
endef

# Qmake does not support setting the installation path.
# really https://bugreports.qt.io/browse/QTBUG-12341
gpg4win_pkg_qtwinextras_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

define gpg4win_pkg_qtwinextras_post_install
 (cd $$$${pkgbdir}; \
  mkdir -p $$$${pkgidir}/bin; \
  cp -r lib include $$$${pkgidir}; \
  mv $$$${pkgidir}/lib/*.dll $$$${pkgidir}/bin;)
endef

gpg4win_pkg_qtsvg_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

# XXX Adding the qtconf after qtsvg is a weird hack
# because somhow (yay qmake) zlib is not linked if
# the qt conf exists before that. The qt conf is
# needed for qttranslations to find the correct path
# of the translation tools.
define gpg4win_pkg_qtsvg_post_install
 (cd $$$${pkgbdir}; \
  mkdir -p $$$${pkgidir}; \
  cp -r lib include plugins $$$${pkgidir}; \
  mkdir -p $$$${pkgidir}/bin; \
  mv $$$${pkgidir}/lib/*.dll $$$${pkgidir}/bin; \
  echo "[Paths]" > $$$${pkgidir}/bin/qt.conf; \
  echo "Prefix = .." >> $$$${pkgidir}/bin/qt.conf)
endef

gpg4win_pkg_qttranslations_configure = \
	"$(idir)/bin/qmake" ../$$$${pkg_version}

define gpg4win_pkg_qttranslations_post_install
 ( rm -fR $$$${pkgidir}/qttranslations; \
   mkdir -p $$$${pkgidir}; \
   cp -r $$$${pkgbdir}/translations $$$${pkgidir}/qttranslations;)
endef

define gpg4win_pkg_okular_post_install
 ( rm $$$${pkgidir}/share/icons/hicolor/icon-theme.cache; )
endef

gpg4win_pkg_kleopatra_configure = \
    -DFORCE_DISABLE_KCMUTILS=ON \
    -DDISABLE_KWATCHGNUPG=ON \
    -DRELEASE_SERVICE_VERSION=Gpg4win-$(VERSION) \
    -DKLEOPATRA_DISTRIBUTION_TEXT="$(DISTRIBUTION_TEXT)"

gpg4win_pkg_kxmlgui_configure = \
    -DFORCE_DISABLE_KGLOBALACCEL=ON \
    -DFORCE_DISABLE_DBUS=ON \
    -DXMLGUI_COMPILER_VERSION="i686-w64-mingw32-gcc" \
    -DXMLGUI_DISTRIBUTION_TEXT="$(DISTRIBUTION_TEXT)"

gpg4win_pkg_breeze_icons_configure = \
    -DBINARY_ICONS_RESOURCE=ON

gpg4win_pkg_kbookmarks_configure = \
    -DANDROID=ON

gpg4win_pkg_kservice_configure = \
    -DANDROID=ON

gpg4win_pkg_kjobwidgets_configure = \
    -DANDROID=ON

gpg4win_pkg_okular_configure = \
    -DFORCE_NOT_REQUIRED_DEPENDENCIES="KF5Purpose\;Qt5TextToSpeech\;LibZip\;KF5Wallet\;KF5DocTools\;KF5JS\;Phonon4Qt5\;TIFF\;JPEG\;LibSpectre\;KF5KExiv2\;CHM\;KF5KHtml\;DjVuLibre\;EPub\;QMobipocket\;Discount\;Qt5Qml\;Qt5DBus"

gpg4win_pkg_libical_configure = \
    -DICAL_GLIB=false \
    -DENABLE_GTK_DOC=false

# Supported make-only source packages.
gpg4win_mpkgs = bzip2 zlib

# Extra options for the make invocations for individual packages.
# make_flags is used for building, make_args_inst is used for installing.
gpg4win_pkg_bzip2_make_args = \
  CC=$(CC) AR=$(AR) RANLIB=$(RANLIB)

gpg4win_pkg_bzip2_make_args_inst = \
  PREFIX=$$$${pkgidir} CC=$(CC) AR=$(AR) RANLIB=$(RANLIB)

gpg4win_pkg_zlib_make_args = \
  -fwin32/Makefile.gcc PREFIX=$(host)- IMPLIB=libz.dll.a

gpg4win_pkg_zlib_make_args_inst = -fwin32/Makefile.gcc install \
	BINARY_PATH=$$$${pkgidir}/bin INCLUDE_PATH=$$$${pkgidir}/include \
	LIBRARY_PATH=$$$${pkgidir}/lib SHARED_MODE=1 IMPLIB=libz.dll.a

# Supported binary packages.
gpg4win_bpkgs = pkgconfig gnupg-w32 kde-l10n

# libiconv needs some special magic to generate a usable import
# library.
# define gpg4win_pkg_libiconv_post_install
# (cp $(srcdir)/libiconv.def $$$${pkgidir}/lib;		\
# cd $$$${pkgidir}/lib;					\
# $(DLLTOOL) --output-lib libiconv.dll.a --def libiconv.def)
# endef

# libiconv needs some special magic to generate a usable import
# library.  Note that we include some internal symbols that are not
# actually part of the DLL.  They are needed by the AM_GNU_GETTEXT
# configure test, but not used otherwise.
# define gpg4win_pkg_gettext_post_install
# (cp $(srcdir)/libintl.def $$$${pkgidir}/lib;		\
# cd $$$${pkgidir}/lib;					\
# $(DLLTOOL) --output-lib libintl.dll.a --def libintl.def)
# endef


# Zlib needs some special magic to generate a libtool file.
# We also install the pc file here.
define gpg4win_pkg_zlib_post_install
(mkdir $$$${pkgidir}/lib/pkgconfig || true;             \
cp $(abs_srcdir)/zlib.pc $$$${pkgidir}/lib/pkgconfig/;  \
cd $$$${pkgidir};					\
echo "# Generated by libtool" > lib/libz.la		\
echo "dlname='../bin/zlib1.dll'" >> lib/libz.la;	\
echo "library_names='libz.dll.a'" >> lib/libz.la;	\
echo "old_library='libz.a'" >> lib/libz.la;		\
echo "dependency_libs=''" >> lib/libz.la;		\
echo "current=1" >> lib/libz.la;			\
echo "age=2" >> lib/libz.la;				\
echo "revision=5" >> lib/libz.la;			\
echo "installed=yes" >> lib/libz.la;			\
echo "shouldnotlink=no" >> lib/libz.la;			\
echo "dlopen=''" >> lib/libz.la;			\
echo "dlpreopen=''" >> lib/libz.la;			\
echo "libdir=\"$$$${pkgidir}/lib\"" >> lib/libz.la)
endef

# We don't use khelpcenter in kleopatra so remove the help links and
# point to the correct common folder
# TODO Needs to be fixed with current doc
#define gpg4win_pkg_kleopatra_post_install
# (for i in de en ; do \
#    (cd $$$${pkgidir}/share/doc/HTML/$$$${i}; \
#     perl -pi -e 's/help:\///g' `find . -name \*.html`; \
#     perl -pi -e 's@common/@../../common/@g' `find . -name \*.html`); \
# done)
#endef


#define gpg4win_pkg_libiconv_post_install
#(cp $(srcdir)/libiconv.def $$$${pkgidir}/lib;		\
#cd $$$${pkgidir}/lib;					\
#$(DLLTOOL) --output-lib libiconv.dll.a --def libiconv.def)
#endef

# Supported internal packages.  Internal packages do not require any
# special support.  Thus, this variable is actually unused, and no
# rules are added in gpg4win.mk.
gpg4win_ipkgs = man_novice_de man_advanced_de man_novice_en man_advanced_en \
		compendium

# Default to same version.
VSD_VERSION=$(VERSION)
# Include installer targets for customized packages
-include gnupg-vsd/custom.mk
# Signging host/key setup for codesigning
-include gnupg-vsd/sign.mk

$(stampdir)/stamp-msi-base: icons/shield.ico Makefile.am \
                       $(top_srcdir)/doc/logo/gpg4win-msi*.bmp \
                       $(top_srcdir)/po/gpg4win-de.wxl \
                       $(top_srcdir)/po/gpg4win-en.wxl
	ssh $(WINHOST) "mkdir AppData\\Local\\Temp\\gpg4win-$(VERSION)" || true
	scp $(top_srcdir)/packages/gnupg-msi-$(gpg4win_pkg_gnupg_msi_version)-bin.wixlib \
		$(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION);
	scp $(top_srcdir)/src/icons/shield.ico $(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)
	scp $(top_srcdir)/doc/logo/gpg4win-msi-header_install-493x58.bmp \
		$(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)/header.bmp
	scp $(top_srcdir)/doc/logo/gpg4win-msi-wizard_install-493x312.bmp \
		$(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)/dialog.bmp
	scp $(top_srcdir)/doc/logo/gpg4win-msi-wizard_install-493x312.bmp \
		$(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)/dialog.bmp
	scp $(top_srcdir)/doc/logo/gpg4win-msi-wizard_install-info-32x32.bmp \
		$(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)/info.bmp
	scp $(top_srcdir)/doc/logo/gpg4win-msi-wizard_install-exclamation-32x32.bmp \
		$(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)/exclamation.bmp
	scp $(top_srcdir)/po/gpg4win-en.wxl $(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)
	scp $(top_srcdir)/po/gpg4win-de.wxl $(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)
	scp WixUI_Gpg4win.wxs $(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)
	touch $(stampdir)/stamp-msi-base

# Now do the bunch of the work.  This is a bunch of dirty magic to
# integrate our special makefile into automake, while not actually
# including it (make should include it).  This is in turn necessary
# because automake can't deal with the elegant magic in the actual
# Makefile.

define INCLUDE_BY_MAKE
include $(1)
endef

if BUILD_GPG4WIN
$(eval $(call INCLUDE_BY_MAKE,gpg4win.mk))
gpg4win_clean = clean-gpg4win
endif

clean-local: $(gpg4win_clean)

common_nsi = inst-sections.nsi installer.nsi installer-finish.nsi	\
  $(addsuffix .nsi,$(addprefix inst-,$(gpg4win_build_list)))		\
  $(addsuffix .nsi,$(addprefix uninst-,$(gpg4win_build_list)))

# Sign additional files as per signing setup
# This is a bit of a hack.
$(stampdir)/stamp-additional-signedfiles: $(stampdir)/stamp-binaries
	(set -e;\
     cd "$(idir)"; \
     for f in $(AUTHENTICODE_FILES); do \
       if [ -f "$$f" ]; then \
         $(call AUTHENTICODE_sign,"$$f","$$f");\
       else \
         echo "speedo: WARNING: file '$$f' not available for signing";\
       fi;\
     done \
     )
	touch $(stampdir)/stamp-additional-signedfiles

# Prepare the versioninfo file.  The pipeline extracts the last
# occurrence of a package with the same name, sorts the entries and
# writes the file with DOS line endings.  This helps to avoid
# duplicate entries in case one package has been rebuild (which is
# common when developing a new version).
versioninfo.txt:
	$(SHA1SUM) $(pkg_files) </dev/null > versioninfo.tmp
	set -e; \
	( while read a b; do echo "$$a $$(basename $$b)"; \
            done < versioninfo.tmp \
          | sort -k2 -sf | tac | uniq -f1 ; \
          echo '=========== SHA-1 checksum ============= == package ==' \
         ) | tac | awk '{printf "%s\r\n", $$0}' > versioninfo.txt
	-rm versioninfo.tmp

NEWS.tmp : $(top_srcdir)/NEWS
	 awk '/^#/ {next} /^\(de\)/ {skip=1;next} /^[^[:space:]]/ {skip=0} \
             !skip { sub(/^\(en\)/,"   *"); print }' \
             <$(top_srcdir)/NEWS >NEWS.tmp

NEWS.de : $(top_srcdir)/NEWS
	 awk '/^#/ {next} /^\(en\)/ {skip=1;next} /^[^[:space:]]/ {skip=0} \
             !skip { sub(/^\(de\)/,"-"); print }' \
             <$(top_srcdir)/NEWS >NEWS.de; \
     sed -i 's/^     /  /' NEWS.de

NEWS.en : $(top_srcdir)/NEWS
	 awk '/^#/ {next} /^\(de\)/ {skip=1;next} /^[^[:space:]]/ {skip=0} \
             !skip { sub(/^\(en\)/,"-"); print }'  \
             <$(top_srcdir)/NEWS >NEWS.en; \
     sed -i 's/^     /  /' NEWS.en

COMPONENTS-list.tmp : $(top_srcdir)/NEWS
	awk '/^~~~~~~~~~~~/ { ok++; next} ok==1 {print "    "$$0}' \
            < $(top_srcdir)/NEWS > COMPONENTS-list.tmp

# For some nut-crazy reason someone thought it would be a great idea
# if makensis changed to the directory of the source file at startup.
# So we have to pull a couple of strings to correct this.
installers/gpg4win-$(VERSION).exe: gpg4win.nsi $(common_nsi) $(stampdir)/stamp-final \
                        g4wihelp.dll gpgwrap.exe \
		        $(foosum_exe) \
			$(README_files) $(HOWTO_files) \
	                license.blurb versioninfo.txt
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
           -DSRCDIR=$(srcdir) $(EXTRA_MAKENSIS_FLAGS) $(srcdir)/gpg4win.nsi && \
		   mv gpg4win-$(VERSION).exe installers/gpg4win-$(VERSION).exe

$(stampdir)/stamp-dist-self: versioninfo.txt
	(set -e; cd ..; make dist-xz)
	touch $(stampdir)/stamp-dist-self

installers/gpg4win-src-$(VERSION).exe: gpg4win-src.nsi $(common_nsii) \
                            $(stampdir)/stamp-final \
                            $(stampdir)/stamp-dist-self \
		            license.blurb
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
	  -DSRCDIR=$(srcdir) $(EXTRA_MAKENSIS_FLAGS) $(srcdir)/gpg4win-src.nsi && \
	mv gpg4win-src-$(VERSION).exe installers/gpg4win-src-$(VERSION).exe

license.blurb: $(top_srcdir)/doc/license-page $(top_srcdir)/doc/GPLv3
	cat $(top_srcdir)/doc/license-page $(top_srcdir)/doc/GPLv3 >$@

g4wihelp.dll: slideshow.cpp desktopshellrun.cpp g4wihelp.c exdll.h
	$(CC) -DUNICODE -static-libgcc -I. -O2 -c \
              -o exdll.o $(srcdir)/exdll.c
	$(CC) -DUNICODE -static-libgcc -I. -O2 -c \
              -o desktopshellrun.o $(srcdir)/desktopshellrun.cpp
	$(CC) -DUNICODE -static-libgcc -I. -O2 -c \
              -o slideshow.o $(srcdir)/slideshow.cpp
	$(CC) -DUNICODE -DENABLE_SLIDE_SHOW -static-libgcc -I. -shared -O2 \
              -o g4wihelp.dll $(srcdir)/g4wihelp.c \
	      desktopshellrun.o slideshow.o exdll.o \
              -lwinmm -lgdi32 -luserenv -lshell32 \
              -lole32 -loleaut32 -lshlwapi -lmsimg32
	$(STRIP) g4wihelp.dll

gpgwrap.exe: gpgwrap.c
	$(CC) -I. -I.. -DHAVE_CONFIG_H -O2 -Wl,-subsystem,windows -o $@ $^
	$(STRIP) $@

sha1sum.exe: sha1sum.c
	$(CC) -O2 -o $@ $^
	$(STRIP) $@

md5sum.exe: sha1sum.c
	$(CC) -DBUILD_MD5SUM -O2 -o $@ $^
	$(STRIP) $@

sha256sum.exe: sha1sum.c
	$(CC) -DBUILD_SHA256SUM -O2 -o $@ $^
	$(STRIP) $@

if BUILD_GPG4WIN
all_full = installers/gpg4win-$(VERSION).exe
endif

all-local: $(all_full)
if BUILD_GPG4WIN
	@echo "###################################################"
	@echo " Gpg4win $(VERSION) successfully build!"
	@echo " Installers can be found under src/installers"
	@echo "###################################################"
endif

clean-local:
	rm -f installers/gpg4win-$(VERSION).exe \
		  installers/GnuPG-VS-Desktop-$(VERSION).msi

distclean-local:
	rm -f *.dll-x*

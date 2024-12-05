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


EXTRA_DIST =  config.site                                      \
              findicons.sh                                     \
              exdll.h exdll.c                                  \
              g4wihelp.c desktopshellrun.cpp                   \
              slideshow.cpp gpgwrap.c gccwrap.sh.in            \
              versioninfo.rc.in.in gpg4win.w32-manifest.in.in  \
              gpg-enable-keyboxd.bat gpg-disable-keyboxd.bat   \
              sha1sum.c                                        \
              potomo                                           \
              index.theme                                      \
              slideshow/slides.dat                             \
              slideshow/slide1-gpgol.png                       \
              slideshow/slide2-gpgex.png                       \
              slideshow/slide3-kleopatra.png                   \
              slideshow/slide4-summary.png                     \
              icons/file-ext.ico                               \
              icons/mail-ext.ico                               \
              icons/shield.ico                                 \
              kdeglobals qtlogging.ini                         \
              make-msi.pl make-msi.guids                       \
              qt.conf                                          \
              WixUI_Gpg4win.wxs included-icons.txt             \
              zlib.pc

if BUILD_APPIMAGE
appimage = appimage
else
appimage =
endif
if BUILD_W64_COND
w64_suffix="-x64"
endif

SUBDIRS = ${appimage} nsis

# This template is used to include standard GNU make files. See below
# for a description.
define INCLUDE_BY_MAKE
include $(1)
endef

# Define macros for the various directories.
#### $(eval $(call INCLUDE_BY_MAKE,setupvars.mk))

# Define macros for the various directories.  These directory names
# must be absolute, as we switch pretty often between them and don't
# want to track relative names.  The directories are created as needed
# by the $(stampdir)/stamp-directories target.
#
# root     :: Our build root.  The make variable PLAYGROUND can be used
#             to override the default.
# stampdir :: The directory to hold stamp files.
# bdir     :: The build dir for the individual packages.
# idir     :: The directory with the installed files from the packages.
# ipdir    :: A subdir of the install directory to hold the installed
#             packages which will be stowed to other subdirs of $(idir).
# ex_idir  :: Same as $(idir) but for packages which are build for the
#             other bit size than the standard.
# ex_ipdir :: Likewise for $(ipdir).
# nat_idir :: Same as $(idir) but for packages which are build for
#             build platform itself.
# nat_ipdir:: Likewise for $(ipdir).
# tsdir    :: The top source directory.
# patdir   :: The source directory with the patches.

tsdir     := $(TOPSRCDIR)
root      := $(PLAYGROUND)
stampdir  := $(root)/stamps
bdir      := $(root)/build
idir      := $(root)/install
ipdir     := $(root)/install/pkgs
ex_idir   := $(root)/install-ex
ex_ipdir  := $(root)/install-ex/pkgs
nat_idir  := $(root)/install-native
nat_ipdir := $(root)/install-native/pkgs
patdir    := $(tsdir)/patches

gpg4win_howto_smime_ll = en de

HOWTO_files = $(addsuffix .txt, \
                $(addprefix HOWTO-SMIME.,$(gpg4win_howto_smime_ll)))

foosum_exe = sha1sum.exe md5sum.exe sha256sum.exe

# Need to clean the dll because we bypassed automake.
CLEANFILES = g4wihelp.dll desktopshellrun.o versioninfo.txt \
			 $(HOWTO_files) NEWS.tmp COMPONENTS-list.tmp \
			 license.blurb cdversioninfo.tmp slideshow.o \
			 $(foosum_exe) gpgwrap.exe

# Supported source packages. (see also ../appimage/Makefile.am)
gpg4win_spkgs = glib libffi gdk-pixbuf gtk+ \
                libgpg-error gpgme gpgol gpgex libpng \
		gpa opencdk jpeg \
		pinentry libassuan ntbtls pcre \
		paperkey regex libiconv gettext scute qrencode

# Source packages following the KDE pattern
gpg4win_kdepkgs = qtbase qttools qtsvg qttranslations qthttpserver \
                  kconfig kwidgetsaddons ki18n extra-cmake-modules \
                  kcompletion kwindowsystem kcoreaddons libkleo kcodecs \
                  kmime kconfigwidgets kxmlgui kguiaddons kitemviews \
                  kiconthemes kleopatra breeze-icons kitemmodels karchive \
                  gpg4win-tools kcrash kio kbookmarks kservice solid \
                  kjobwidgets poppler okular freetype threadweaver \
                  kparts tiff openjpeg sonnet ktextwidgets mimetreeparser \
                  libical kcalendarcore kmbox pcre2 prison gpgpass \
                  knotifications kcolorscheme zstd kstatusnotifieritem \
                  gpgoljs libkdepim syntax-highlighting ktextaddons \
                  kpimtextedit qtkeychain kcontacts qtwebsockets \
                  breeze

# Supported source packages to build in an additional architecture
gpg4win_expkgs = libgpg-error libassuan libiconv gettext gpgex gpgol \
                 gpgme

# The packages that should also be compiled natively
gpg4win_nativepkgs = qtbase breeze-icons kconfig extra-cmake-modules \
                     qttools

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

# CMakeList.txt does not live in the top level
gpg4win_pkg_zstd_conf_subdir = /build/cmake
gpg4win_pkg_zstd_configure = -DZSTD_BUILD_PROGRAMS=OFF

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

gpg4win_pkg_libgpg_error_configure = --enable-static

gpg4win_pkg_libgpg_error_ex_configure = --enable-static

gpg4win_pkg_libgpg_error_extracflags = -D_WIN32_WINNT=0x0600

gpg4win_pkg_libgpg_error_ex_extracflags = -D_WIN32_WINNT=0x0600


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

gpg4win_pkg_libassuan_configure = --enable-static

gpg4win_pkg_libassuan_ex_configure = --enable-static

gpg4win_pkg_libpng_configure = \
      HAVE_SOLARIS_LD_FALSE=yes \
      CPPFLAGS=\"-I$(idir)/include -DPNG_BUILD_DLL\" \
      LDFLAGS=\"-L$(idir)/lib\" \
      LIBPNG_DEFINES=\"-DPNG_BUILD_DLL\"

gpg4win_pkg_pinentry_configure = \
  --enable-pinentry-qt \
  --disable-pinentry-fltk \
  --disable-pinentry-curses \
  --disable-fallback-curses

gpg4win_pkg_gpgme_configure = \
  --enable-static \
  --enable-languages=qt,cpp \
  --disable-gpg-test \
  --disable-gpgsm-test

gpg4win_pkg_gpgme_ex_configure = \
  --enable-static \
  --enable-languages=cpp \
  --disable-gpg-test \
  --disable-gpgsm-test

gpg4win_pkg_openjpeg_configure = -DBUILD_CODEC=OFF

gpg4win_pkg_paperkey_configure = --silent

gpg4win_pkg_sonnet_configure = -DSONNET_USE_QML=OFF

gpg4win_pkg_ki18n_configure = -DBUILD_WITH_QML=OFF

gpg4win_pkg_kconfig_configure = -DKCONFIG_USE_DBUS=OFF -DKCONFIG_USE_QML=OFF

gpg4win_pkg_kconfig_native_configure = -DKCONFIG_USE_DBUS=OFF \
                                       -DKCONFIG_USE_QML=OFF  \
                                       -DKCONFIG_USE_GUI=OFF

gpg4win_pkg_pcre2_configure = \
		-DPCRE2_BUILD_PCRE2_8=OFF -DPCRE2_BUILD_PCRE2_16=ON \
                -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=OFF

gpg4win_pkg_karchive_configure = -DWITH_LIBZSTD=ON -DWITH_LIBLZMA=OFF

gpg4win_pkg_kcoreaddons_configure = -DKCOREADDONS_USE_QML=OFF

gpg4win_pkg_kwindowsystem_configure = -DKWINDOWSYSTEM_QML=OFF

gpg4win_pkg_ktextwidgets_configure = -DWITH_TEXT_TO_SPEECH=OFF

gpg4win_pkg_qtkeychain_configure = -DBUILD_WITH_QT6=ON

gpg4win_pkg_ktextaddons_configure = -DFORCE_DISABLE_MULTIMEDIA=ON

gpg4win_pkg_kcalendarcore_configure = -DUSE_QML=OFF

# Create a minmal build on the build system of the
# same version before cross compiling.
gpg4win_pkg_qtbase_native_configure = \
        -DQT_BUILD_EXAMPLES=OFF \
        -DQT_BUILD_TESTS=OFF \
        -DBUILD_WITH_PCH=OFF \
        -DFEATURE_assistant=ON \
        -DFEATURE_linguist=ON \
        -DFEATURE_eventfd=OFF \
        -DFEATURE_harfbuzz=OFF \
        -DFEATURE_icu=OFF \
        -DFEATURE_zstd=OFF \
        -DFEATURE_glib=OFF \
        -DFEATURE_dynamicgl=OFF \
        -DFEATURE_egl=OFF \
        -DFEATURE_opengl_desktop=OFF \
        -DFEATURE_opengl_dynamic=OFF \
        -DFEATURE_opengles2=OFF \
        -DINPUT_opengl=no \
        -DFEATURE_openssl=OFF \
        -DFEATURE_zstd=OFF \
        -DFEATURE_sql_mysql=OFF \
        -DFEATURE_sql_db2=OFF \
        -DFEATURE_sql_psql=OFF \
        -DFEATURE_sql_oci=OFF \
        -DFEATURE_sql_odbc=OFF \
        -DFEATURE_sql_sqlite=OFF \
        -DFEATURE_sql_ibase=OFF \
        -DCMAKE_VERBOSE_MAKEFILE=ON

define gpg4win_pkg_qtbase_native_post_install
	(set -e ; \
         cd $$$${pkgidir}/bin; \
	 cp qtpaths qtpaths_real; \
	 unlink qtpaths; \
	 echo "#!/bin/sh" > qtpaths; \
	 echo "$$$${pkgidir}/bin/qtpaths_real \"\$$$$@\" | sed 's@/pkgs.*@/@'" \
               >> qtpaths; \
	 chmod u+x qtpaths; \
	 cp qtpaths qtpaths6 )
endef

gpg4win_pkg_qtbase_configure = \
        -DQT_HOST_PATH=$(nat_idir) \
        -DQt6HostInfo_DIR=$(nat_idir)/lib/cmake/Qt6HostInfo \
        -DQT_QMAKE_DEVICE_OPTIONS='CROSS_COMPILE=$(host)-' \
        -DQT_QMAKE_TARGET_MKSPEC=win32-g++ \
        -DQT_BUILD_EXAMPLES=OFF \
        -DQT_BUILD_TESTS=OFF \
        -DBUILD_WITH_PCH=OFF \
        -DFEATURE_accessibility=ON \
        -DFEATURE_dbus=OFF \
        -DFEATURE_fontconfig=OFF \
        -DFEATURE_glib=OFF \
        -DFEATURE_opengl_dynamic=ON \
        -DFEATURE_openssl=OFF \
        -DFEATURE_pkg_config=ON \
        -DFEATURE_sql_mysql=OFF \
        -DFEATURE_sql_odbc=OFF \
        -DFEATURE_sql_psql=OFF \
        -DFEATURE_system_zlib=ON \
        -DFEATURE_system_zstd=ON \
        -DFEATURE_system_pcre=ON \
        -DFEATURE_system_freetype=ON \
        -DFEATURE_system_harfbuzz=OFF \
        -DFEATURE_schannel=ON \
        -DFEATURE_use_gold_linker_alias=OFF \
        -DCMAKE_VERBOSE_MAKEFILE=ON

# copy moc and rcc from the tools into the target tree
# so that pkg-config can find them.
define gpg4win_pkg_qtbase_post_install
	(cp $(nat_idir)/libexec/moc $$$${pkgidir}/bin; \
	 cp $(nat_idir)/libexec/rcc $$$${pkgidir}/bin   )
endef


define gpg4win_pkg_okular_post_install
        (rm $$$${pkgidir}/share/icons/hicolor/icon-theme.cache)
endef

gpg4win_pkg_kleopatra_configure = \
    -DFORCE_DISABLE_KCMUTILS=ON \
    -DDISABLE_KWATCHGNUPG=ON \
    -DRELEASE_SERVICE_VERSION=Gpg4win-$(VERSION) \
    -DKLEOPATRA_DISTRIBUTION_TEXT="$(DISTRIBUTION_TEXT)"

gpg4win_pkg_kxmlgui_configure = \
    -DFORCE_DISABLE_KGLOBALACCEL=ON \
    -DFORCE_DISABLE_DBUS=ON \
    -DXMLGUI_COMPILER_VERSION="$(CC)" \
    -DXMLGUI_DISTRIBUTION_TEXT="$(DISTRIBUTION_TEXT)"

gpg4win_pkg_kio_configure = \
    -DFORCE_DISABLE_DBUS=ON \
    -DFORCE_DISABLE_KCRASH=ON

gpg4win_pkg_knotifications_configure = \
    -DFORCE_DISABLE_CANBERRA=ON

gpg4win_pkg_breeze_icons_native_configure = \
    -DWITH_ICON_GENERATION=OFF \
    -DSKIP_INSTALL_ICONS=ON

define gpg4win_pkg_breeze_icons_native_post_install
 ( mkdir -p $$$${pkgidir}/bin/ && cp $$$${pkgbdir}/bin/* $$$${pkgidir}/bin )
endef

#gpg4win_pkg_breeze_icons_configure = \
#    -DBINARY_ICONS_RESOURCE=ON \
#    -DICON_SUBSET_INCLUDE_FILE=$(abs_srcdir)/included-icons.txt

gpg4win_pkg_breeze_configure = \
    -DBUILD_QT6=ON \
    -DBUILD_QT5=OFF \
    -DWITH_DECORATIONS=OFF

gpg4win_pkg_kbookmarks_configure = \
    -DANDROID=ON

gpg4win_pkg_kservice_configure = \
    -DANDROID=ON

gpg4win_pkg_kjobwidgets_configure = \
    -DANDROID=ON

gpg4win_pkg_kiconthemes_configure = \
    -DKICONTHEMES_USE_QTQUICK=OFF

gpg4win_pkg_okular_configure = \
    -DFORCE_NOT_REQUIRED_DEPENDENCIES="KF6Purpose\;Qt6TextToSpeech\;LibZip\;KF6DocTools\;Phonon4Qt6\;TIFF\;JPEG\;LibSpectre\;KExiv2Qt6\;CHM\;DjVuLibre\;EPub\;QMobipocket\;Discount\;Qt6Qml\;Qt6DBus"

gpg4win_pkg_libical_configure = \
    -DICAL_GLIB=false \
    -DENABLE_GTK_DOC=false

gpg4win_pkg_prison_configure = \
    -DWITH_QUICK=OFF \
    -DWITH_MULTIMEDIA=OFF

gpg4win_pkg_poppler_configure = \
    -DENABLE_NSS3=OFF \
    -DENABLE_GLIB=OFF \
    -DENABLE_GOBJECT_INTROSPECTION=OFF \
    -DENABLE_QT5=OFF \
    -DENABLE_LCMS=OFF \
    -DENABLE_BOOST=OFF \
    -DENABLE_LIBCURL=OFF

gpg4win_pkg_kcontacts_configure = \
    -DKCONTACTS_USE_QML=OFF

gpg4win_pkg_libkdepim_configure = \
    -DFORCE_NOT_REQUIRED_DEPENDENCIES="Qt6DBus"

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

# Zlib needs some special magic to generate a libtool file.
# We also install the pc file here.
define gpg4win_pkg_zlib_post_install
(mkdir $$$${pkgidir}/lib/pkgconfig || true;             \
cp $(abs_srcdir)/zlib.pc $$$${pkgidir}/lib/pkgconfig/;  \
cd $$$${pkgidir};                                      \
echo "# Generated by libtool" > lib/libz.la            \
echo "dlname='../bin/zlib1.dll'" >> lib/libz.la;       \
echo "library_names='libz.dll.a'" >> lib/libz.la;      \
echo "old_library='libz.a'" >> lib/libz.la;            \
echo "dependency_libs=''" >> lib/libz.la;              \
echo "current=1" >> lib/libz.la;                       \
echo "age=2" >> lib/libz.la;                           \
echo "revision=5" >> lib/libz.la;                      \
echo "installed=yes" >> lib/libz.la;                   \
echo "shouldnotlink=no" >> lib/libz.la;                \
echo "dlopen=''" >> lib/libz.la;                       \
echo "dlpreopen=''" >> lib/libz.la;                    \
echo "libdir=\"$$$${pkgidir}/lib\"" >> lib/libz.la)
endef

# Supported binary packages.
gpg4win_bpkgs = pkgconfig gnupg-w32

# Default to same version.
VSD_VERSION=$(VERSION)

# Include installer targets for customized packages
-include gnupg-vsd/custom.mk


# The playground area is our scratch area, where we unpack, build and
# install the packages.
#
# Boost includes are only needed during the build and are linked in the
# playground install tree
$(stampdir)/stamp-directories:
	@echo -------------------------------------------------
	@echo Source .......: $(tsdir)
	@echo Playground ...: $(root)
	@echo Stamps at ....: $(stampdir)
	@echo Building at ..: $(bdir)
	@echo -------------------------------------------------
	$(MKDIR) -p $(root)
	$(MKDIR) -p $(stampdir)
	$(MKDIR) -p installers
	$(MKDIR) -p $(bdir)
	$(MKDIR) -p $(idir)
	$(MKDIR) -p $(idir)/include
	ln -s /usr/include/boost $(idir)/include/boost || true
	$(MKDIR) -p $(ipdir)
	$(if $GPGEX_ADD_HOST, $(MKDIR) -p $(ex_idir))
	$(if $GPGEX_ADD_HOST, $(MKDIR) -p $(ex_ipdir))
	$(MKDIR) -p $(nat_idir)/bin
	ln -s $(abs_srcdir)/gccwrap.sh $(nat_idir)/bin/i686-w64-mingw32-gcc || true
	ln -s $(abs_srcdir)/gccwrap.sh $(nat_idir)/bin/x86_64-w64-mingw32-gcc || true
	ln -s $(abs_srcdir)/gccwrap.sh $(nat_idir)/bin/i686-w64-mingw32-g++ || true
	ln -s $(abs_srcdir)/gccwrap.sh $(nat_idir)/bin/x86_64-w64-mingw32-g++ || true
	$(MKDIR) -p $(nat_ipdir)
	touch $(bdir)/versioninfo.txt
	touch $(stampdir)/stamp-directories


$(stampdir)/stamp-msi-base: icons/shield.ico Makefile.am \
                       $(top_srcdir)/doc/logo/gpg4win-msi*.bmp \
                       $(top_srcdir)/po/gpg4win-de.wxl \
                       $(top_srcdir)/po/gpg4win-en.wxl
	ssh $(WINHOST) "mkdir AppData\\Local\\Temp\\gpg4win-$(VERSION)" || true
	scp $(top_srcdir)/packages/gnupg-msi-$(gpg4win_pkg_gnupg_msi_version)-bin.wixlib \
		$(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION);
	scp $(top_srcdir)/src/icons/shield.ico \
                $(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)
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
	scp $(top_srcdir)/po/gpg4win-en.wxl \
                $(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)
	scp $(top_srcdir)/po/gpg4win-de.wxl \
                $(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)
	scp WixUI_Gpg4win.wxs \
                $(WINHOST):AppData/Local/Temp/gpg4win-$(VERSION)
	touch $(stampdir)/stamp-msi-base

# Now do the bunch of the work.  This is a bunch of dirty magic to
# integrate our special makefile into automake, while not actually
# including it (make should include it).  This is in turn necessary
# because automake can't deal with the elegant magic in the actual
# Makefile.

if BUILD_GPG4WIN
$(eval $(call INCLUDE_BY_MAKE,gpg4win.mk))
gpg4win_clean = clean-gpg4win
endif

clean-local: $(gpg4win_clean)


# Copy the DLL files for NSIS.  We use a stamp because we need only
# some of them.  The dependency on the Makefile is to avoid the need
# for a clean in some situations.
$(stampdir)/stamp-rtlib-files: Makefile
	( \
	 f=libwinpthread-1.dll-ex ; test -f "$$f" && rm -f "$$f" ; \
	 if test "$(gpg4win_rtlib_ex_libwinpthread_1)" != no ; then \
	   cp $(gpg4win_rtlib_ex_libwinpthread_1) "$$f"; $(STRIP_EX) "$$f";\
	 fi; \
	 f=libwinpthread-1.dll-x ; test -f "$$f" && rm -f "$$f" ; \
	 if test "$(gpg4win_rtlib_libwinpthread_1)" != no ; then \
	   cp $(gpg4win_rtlib_libwinpthread_1)    "$$f"; $(STRIP) "$$f";\
	 fi; \
         f=libstdc++-6.dll-x ; test -f "$$f" && rm -f "$$f" ; \
	 if test "$(gpg4win_rtlib_libstdc___6)" != no ; then \
	   cp $(gpg4win_rtlib_libstdc___6)        "$$f"; $(STRIP) "$$f";\
	 fi; \
         f=libgcc_s_sjlj-1.dll-x ; test -f "$$f" && rm -f "$$f" ; \
	 if test "$(gpg4win_rtlib_libgcc_s_sjlj-1)" != no ; then \
	   cp $(gpg4win_rtlib_libgcc_s_sjlj_1)     "$$f"; $(STRIP) "$$f";\
	 fi; \
         f=libgcc_s_dw2-1.dll-x ; test -f "$$f" && rm -f "$$f" ; \
	 if test "$(gpg4win_rtlib_libgcc_s_dw2_1)" != no ; then \
	   cp $(gpg4win_rtlib_libgcc_s_dw2_1)     "$$f"; $(STRIP) "$$f";\
	 fi; \
         f=libgcc_s_seh-1.dll-x ; test -f "$$f" && rm -f "$$f" ; \
	 if test "$(gpg4win_rtlib_libgcc_s_seh_1)" != no ; then \
	   cp $(gpg4win_rtlib_libgcc_s_seh_1)     "$$f"; $(STRIP) "$$f";\
	 fi )
	$(MKDIR) -p $(stampdir)
	touch $(stampdir)/stamp-rtlib-files

common_nsi = $(stampdir)/stamp-rtlib-files \
  nsis/inst-sections.nsi nsis/installer.nsi \
  nsis/installer-finish.nsi nsis/gpg4win.nsi \
  $(addsuffix .nsi,$(addprefix nsis/inst-,$(gpg4win_build_list))) \
  $(addsuffix .nsi,$(addprefix nsis/uninst-,$(gpg4win_build_list)))

# Sign additional files as per signing setup
# Exit in case of error because that usually means that AUTHENTICODE_FILES
# are not up to date.
$(stampdir)/stamp-additional-signedfiles: $(stampdir)/stamp-binaries \
                                          $(foosum_exe)
	(set -e;\
	 $(eval $(call READ_AUTOGEN_template,AUTHENTICODE_KEY)) \
         cd "$(idir)"; \
         for f in $(AUTHENTICODE_FILES); do \
           if [ ! -f "$$f" ]; then \
             echo "ERROR: file '$$f' not available for signing"; \
             exit 1; \
           fi;\
         done; \
         for f in $(AUTHENTICODE_FILES) $(AUTHENTICODE_FILES_OPTIONAL); do \
           if [ ! -f "$$f" ]; then \
             continue; \
           fi; \
           if [ ! -s "$$f" ]; then \
             echo "Codesign: Skipping over empty file '$$f'"; \
             continue; \
           fi; \
           if [ -n "$(AUTHENTICODE_KEY)" \
                -a "$(AUTHENTICODE_KEY)" != "none" ]; then \
             $(call AUTHENTICODE_sign,"$$f","$$f"); \
           fi; \
         done )
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
installers/gpg4win-$(VERSION)$(W64SUFFIX).exe: \
                        $(common_nsi) \
                        $(stampdir)/stamp-final \
                        g4wihelp.dll gpgwrap.exe \
		        $(foosum_exe) \
			$(HOWTO_files) \
	                license.blurb versioninfo.txt
	$(MAKENSIS) -V3 -DBUILD_W64=$(BUILD_W64) -DBUILD_DIR=`pwd` \
                    -DTOP_SRCDIR=$(top_srcdir) \
                    -DSRCDIR=$(srcdir) $(EXTRA_MAKENSIS_FLAGS) \
                    $(srcdir)/nsis/gpg4win.nsi \
	  && mv gpg4win-$(VERSION).exe \
                installers/gpg4win-$(VERSION)$(W64SUFFIX).exe

$(stampdir)/stamp-dist-self: versioninfo.txt
	(set -e; cd ..; make dist-xz)
	touch $(stampdir)/stamp-dist-self

license.blurb: $(top_srcdir)/doc/license-page $(top_srcdir)/doc/GPLv3
	cat $(top_srcdir)/doc/license-page $(top_srcdir)/doc/GPLv3 >$@

g4wihelp.dll: slideshow.cpp desktopshellrun.cpp g4wihelp.c exdll.h
	$(W32CC32) -DUNICODE -static-libgcc -I. -O2 -c \
              -o exdll.o $(srcdir)/exdll.c
	$(W32CC32) -DUNICODE -static-libgcc -I. -O2 -c \
              -o desktopshellrun.o $(srcdir)/desktopshellrun.cpp
	$(W32CC32) -DUNICODE -static-libgcc -I. -O2 -c \
              -o slideshow.o $(srcdir)/slideshow.cpp
	$(W32CC32) -DUNICODE -DENABLE_SLIDE_SHOW -static-libgcc \
              -I. -shared -O2 \
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
all_full = installers/gpg4win-$(VERSION)$(W64SUFFIX).exe
endif

all-local: $(all_full)
if BUILD_GPG4WIN
	@echo "###################################################"
	@echo " Gpg4win $(VERSION) successfully build!"
	@echo " Installers can be found under src/installers"
	@echo "###################################################"
endif

clean-local:
	-rm -f installers/gpg4win-$(VERSION)$(W64SUFFIX).exe \
		  installers/GnuPG-VS-Desktop-$(VERSION).msi \
		  installers/GnuPG-Desktop-$(VERSION).msi

distclean-local:
	rm -f *.dll-x*

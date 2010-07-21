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


EXTRA_DIST = pkg-config gpg4win.nsi gpg4win-src.nsi config.site \
        installer-options.ini.in libiconv.def libintl.def loreley.mid \
        gpg4win-splash.wav gpgwrap.c exdll.h g4wihelp.c g4wihelp.nsi \
        inst-sections.nsi installer.nsi installer-finish.nsi  \
	QtCore.pc QtGui.pc sha1sum.c                          \
        qt.conf kleowrap.c potomo Memento.nsh dirmngr.conf    \
        inst-gpg4win.nsi	   uninst-gpg4win.nsi	      \
        inst-atk.nsi               uninst-atk.nsi	      \
        inst-expat.nsi		   uninst-expat.nsi	      \
        inst-freetype.nsi	   uninst-freetype.nsi	      \
        inst-fontconfig.nsi	   uninst-fontconfig.nsi      \
        inst-cairo.nsi		   uninst-cairo.nsi	      \
        inst-libgsasl.nsi	   uninst-libgsasl.nsi        \
        inst-libtasn1.nsi	   uninst-libtasn1.nsi        \
        inst-gnutls.nsi		   uninst-gnutls.nsi	      \
        inst-curl.nsi		   uninst-curl.nsi	      \
        inst-libxml2.nsi	   uninst-libxml2.nsi	      \
        inst-libetpan.nsi	   uninst-libetpan.nsi        \
        inst-claws-mail.nsi	   uninst-claws-mail.nsi      \
        inst-notification_plugin.nsi uninst-notification_plugin.nsi  \
        inst-gtkhtml2_viewer.nsi   uninst-gtkhtml2_viewer.nsi \
        inst-vcalendar.nsi	   uninst-vcalendar.nsi       \
        inst-rssyl.nsi		   uninst-rssyl.nsi           \
        inst-tnef_parse.nsi	   uninst-tnef_parse.nsi      \
        inst-attachwarner.nsi	   uninst-attachwarner.nsi    \
        inst-bsfilter_plugin.nsi   uninst-bsfilter_plugin.nsi \
        inst-crypt.nsi		   uninst-crypt.nsi	      \
        inst-dirmngr.nsi	   uninst-dirmngr.nsi	      \
        inst-gettext.nsi	   uninst-gettext.nsi	      \
        inst-glib.nsi		   uninst-glib.nsi	      \
        inst-gnupg2.nsi		   uninst-gnupg2.nsi	      \
        inst-gpa.nsi		   uninst-gpa.nsi	      \
        inst-gpgme.nsi		   uninst-gpgme.nsi	      \
        inst-scute.nsi		   uninst-scute.nsi	      \
        inst-paperkey.nsi	   uninst-paperkey.nsi	      \
        inst-gpgol.nsi		   uninst-gpgol.nsi	      \
        inst-gpgex.nsi		   uninst-gpgex.nsi	      \
        inst-gtk+.nsi		   uninst-gtk+.nsi	      \
        inst-libassuan.nsi	   uninst-libassuan.nsi	      \
        inst-libgcrypt.nsi	   uninst-libgcrypt.nsi	      \
        inst-libgpg-error.nsi	   uninst-libgpg-error.nsi    \
        inst-libiconv.nsi	   uninst-libiconv.nsi	      \
        inst-libksba.nsi	   uninst-libksba.nsi	      \
        inst-adns.nsi	           uninst-adns.nsi	      \
        inst-libpng.nsi		   uninst-libpng.nsi	      \
        inst-compendium_de.nsi	   uninst-compendium_de.nsi   \
        inst-man_advanced_de.nsi   uninst-man_advanced_de.nsi \
        inst-man_advanced_en.nsi   uninst-man_advanced_en.nsi \
        inst-man_novice_de.nsi	   uninst-man_novice_de.nsi   \
        inst-man_novice_en.nsi	   uninst-man_novice_en.nsi   \
        inst-pango.nsi		   uninst-pango.nsi	      \
        inst-pinentry.nsi	   uninst-pinentry.nsi	      \
        inst-pkgconfig.nsi	   uninst-pkgconfig.nsi	      \
        inst-pthreads-w32.nsi	   uninst-pthreads-w32.nsi    \
        inst-regex.nsi		   uninst-regex.nsi	      \
        inst-w32pth.nsi		   uninst-w32pth.nsi	      \
        inst-zlib.nsi        	   uninst-zlib.nsi            \
	inst-bsfilter.nsi          uninst-bsfilter.nsi        \
        inst-qt.nsi        	   uninst-qt.nsi              \
        inst-kdesupport.nsi   	   uninst-kdesupport.nsi      \
        inst-oxygen-icons.nsi  	   uninst-oxygen-icons.nsi    \
        inst-kdelibs.nsi  	   uninst-kdelibs.nsi         \
        inst-kleopatra.nsi  	   uninst-kleopatra.nsi       \
	inst-bzip2.nsi             uninst-bzip2.nsi           \
        inst-final.nsi


gpg4win_readme_ll = en de ar es fr ru pt

README_files = $(addsuffix .txt,$(addprefix README.,$(gpg4win_readme_ll)))

foosum_exe = sha1sum.exe md5sum.exe sha256sum.exe

# Need to clean the dll because we bypassed automake.
CLEANFILES = g4wihelp.dll versioninfo.txt $(README_files) \
             installer-options.ini NEWS.tmp versioninfo.tmp \
	     gpgwrap.exe gpgwrap-2.exe kleowrap.exe $(foosum_exe)

# Supported source packages.
gpg4win_spkgs = glib libgpg-error gpgme gpgol gpgex libpng \
		gpa libgsasl libtasn1 opencdk gnutls curl libxml2 \
                libetpan claws-mail notification_plugin gtkhtml2_viewer \
		vcalendar rssyl gnupg2 pinentry libassuan libksba libgcrypt \
		adns dirmngr w32pth scute paperkey tnef_parse attachwarner \
		bsfilter_plugin regex

# Extra options to configure for individual packages.
# We can use $(idir) here for the installation prefix.

gpg4win_pkg_glib_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib CCC=i586-mingw32msvc-g++

# The GnuPG package provides man pages which we have to convert.
# We also create the MO files here.
define gpg4win_pkg_gnupg2_post_install
(for i in gpg2 gpgv2 gpgsm gpg-agent scdaemon gpg-connect-agent gpgconf ; \
  do man -Tlatin1 -l $$$${pkgidir}/share/man/man1/$$$${i}.1 | \
    sed `printf "s/_\b//g;s/\b.//g"` | \
    sed -e 's/$$$$/\r/' > $$$${pkgidir}/share/man/man1/$$$${i}.man ; \
 done ; \
 for i in `$(tsdir)/src/potomo --get-linguas $$$${pkgsdir}/po` ; do \
     $(mkdir_p) $$$${pkgidir}/share/locale/$$$${i}/LC_MESSAGES || true; \
     rm $$$${pkgidir}/share/locale/$$$${i}/LC_MESSAGES/gnupg2.mo 2>/dev/null \
       || true; \
     $(tsdir)/src/potomo $$$${pkgsdir}/po/$$$${i}.po \
              $$$${pkgidir}/share/locale/$$$${i}/LC_MESSAGES/gnupg2.mo; \
 done)
endef

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
( cd $$$${pkgndir}/doc; make pdf )
endef

# We would like to use --with-libiconv-prefix and
# --with-libintl-prefix, but these don't work with the cheesy
# non-"libfoo.la" versions of iconv and gettext that we are using.
#gpg4win_pkg_libgpg_error_configure = \
#  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir)
gpg4win_pkg_libgpg_error_configure = --silent \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib \
  --enable-static

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

gpg4win_pkg_libassuan_configure =  --silent \
  --enable-static

gpg4win_pkg_libksba_configure = --silent \
  --with-gpg-error-prefix=$(idir)

gpg4win_pkg_libgcrypt_configure = --silent \
  --with-gpg-error-prefix=$(idir)

gpg4win_pkg_adns_configure = --silent

gpg4win_pkg_libpng_configure = CPPFLAGS=\"-I$(idir)/include\" LDFLAGS=\"-L$(idir)/lib\"

gpg4win_pkg_dirmngr_configure = \
  --with-gpg-error-prefix=$(idir) \
  --with-ksba-prefix=$(idir) \
  --with-libgcrypt-prefix=$(idir) \
  --with-libassuan-prefix=$(idir) \
  --with-pth-prefix=$(idir)

gpg4win_pkg_gnupg2_configure = \
  --with-gpg-error-prefix=$(idir) \
  --with-ksba-prefix=$(idir) \
  --with-libgcrypt-prefix=$(idir) \
  --with-libassuan-prefix=$(idir) \
  --with-zlib=$(idir) \
  --with-bzip2=$(idir) \
  --with-pth-prefix=$(idir) \
  --with-adns=$(idir) \
  --without-included-gettext \
  --disable-regex

# We would like to use --with-libiconv-prefix and
# --with-libintl-prefix, but these don't work with the cheesy
# non-"libfoo.la" versions of iconv and gettext that we are using.
gpg4win_pkg_pinentry_configure = \
  --disable-pinentry-gtk \
  --enable-pinentry-gtk2 \
  --with-glib-prefix=$(idir) --with-gtk-prefix=$(idir) \
  --disable-pinentry-qt \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib
#  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir)

# The LDFLAGS is needed for -lintl for glib.  The QT4 variables work
# around the lack of cross compilation support in qt-dev.
gpg4win_pkg_gpgme_configure = --silent \
  --with-gpg-error-prefix=$(idir) --enable-static \
  `test -n "@HAVE_PKG_GLIB@" && echo "--enable-w32-glib"` \
  --disable-w32-qt LDFLAGS=-L$(idir)/lib
#  `test -n "@HAVE_PKG_QT@" && echo "--disable-w32-qt"` \
#  QT4_CORE_CFLAGS=\"-DQT_LARGEFILE_SUPPORT -DQT_DLL \
#                   -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_THREAD_SUPPORT \
#                   -I$(idir)/include/QtCore -I$(idir)/include \
#		   -I$(idir)/mkspecs/win32-g++\" \
#  QT4_CORE_LIBS=\"-L$(idir)/lib -lQtCore4\"

gpg4win_pkg_gpa_configure = --silent \
  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir) \
  --with-gpgme-prefix=$(idir) --with-zlib=$(idir) \
  --with-libassuan-prefix=$(idir) --with-gpg-error-prefix=$(idir)

gpg4win_pkg_gpgol_configure = --silent \
  --with-gpgme-prefix=$(idir) --with-gpg-error-prefix=$(idir) \
  --with-libassuan-prefix=$(idir)

gpg4win_pkg_gpgex_configure = --silent \
  --with-gpg-error-prefix=$(idir) \
  --with-libassuan-prefix=$(idir)

gpg4win_pkg_gnutls_configure = \
  --disable-cxx \
  --with-libtasn1-prefix=$(idir) \
  --with-libgcrypt-prefix=$(idir)

gpg4win_pkg_curl_configure = \
  --with-gnutls --without-ca-bundle

gpg4win_pkg_libxml2_configure = \
  --enable-shared --without-python

# The CFLAGS are needed to find pthread-w32.
gpg4win_pkg_libetpan_configure = --with-gnutls \
  CPPFLAGS=\"-I$(idir)/include\" LIBS=\"-L$(idir)/lib\"

# --disable-aspell can be removed from svn917 on and later.
gpg4win_pkg_claws_mail_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  --with-gpg-error-prefix=$(idir) --with-gpgme-prefix=$(idir) \
  --with-config-dir="Claws-mail" --enable-pthread --enable-gnutls \
  --enable-libetpan --disable-aspell --disable-enchant \
  --disable-trayicon-plugin --disable-dbus \
  --disable-openssl --disable-dillo-viewer-plugin --disable-gnomeprint \
  --disable-jpilot --disable-startup-notification --disable-ipv6 \
  --disable-mathml-viewer-plugin --disable-clamav-plugin \
  --disable-spamassassin-plugin --disable-bogofilter-plugin \
  --disable-valgrind --disable-networkmanager-support

gpg4win_pkg_notification_plugin_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  --disable-libnotify --disable-lcdproc --disable-hotkeys

gpg4win_pkg_gtkhtml2_viewer_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) LIBS=\"-L$(idir)/bin\"

gpg4win_pkg_vcalendar_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) LIBS=\"-L$(idir)/bin\"

gpg4win_pkg_rssyl_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) LIBS=\"-L$(idir)/bin\"

gpg4win_pkg_tnef_parse_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) LIBS=\"-L$(idir)/bin\"

gpg4win_pkg_attachwarner_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) LIBS=\"-L$(idir)/bin\"

gpg4win_pkg_bsfilter_plugin_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) LIBS=\"-L$(idir)/bin\"

gpg4win_pkg_scute_configure = --silent \
  --with-gpg-error-prefix=$(idir) --with-libassuan-prefix=$(idir)

gpg4win_pkg_paperkey_configure = --silent

# Supported make-only source packages.
gpg4win_mpkgs = pthreads-w32 bzip2 zlib crypt

# Extra options for the make invocations for individual packages.
# make_flags is used for building, make_args_inst is used for installing.
gpg4win_pkg_pthreads_w32_make_args = \
  prefix=$(idir) CROSS=$(host_alias)- clean GC-inlined

gpg4win_pkg_pthreads_w32_make_args_inst = \
  prefix=$$$${pkgidir} CROSS=$(host_alias)- 

gpg4win_pkg_bzip2_make_args = \
  CC=$(CC) AR=$(AR) RANLIB=$(RANLIB)

gpg4win_pkg_bzip2_make_args_inst = \
  PREFIX=$$$${pkgidir} CC=$(CC) AR=$(AR) RANLIB=$(RANLIB)

gpg4win_pkg_crypt_make = \
  CC=$(CC) AR=$(AR)

gpg4win_pkg_crypt_make_args_inst = \
  prefix=$$$${pkgidir}

gpg4win_pkg_zlib_make_args = -fwin32/Makefile.gcc PREFIX=i586-mingw32msvc- IMPLIB=libz.dll.a

gpg4win_pkg_zlib_make_args_inst = -fwin32/Makefile.gcc install \
	BINARY_PATH=$$$${pkgidir}/bin INCLUDE_PATH=$$$${pkgidir}/include \
	LIBRARY_PATH=$$$${pkgidir}/lib SHARED_MODE=1 IMPLIB=libz.dll.a

# Supported binary packages.
gpg4win_bpkgs = libiconv gettext pkgconfig pango expat freetype fontconfig cairo \
	        atk gtk+ qt kdesupport oxygen-icons kdelibs kleopatra bsfilter

# libiconv needs some special magic to generate a usable import
# library.
define gpg4win_pkg_libiconv_post_install
(cp $(srcdir)/libiconv.def $$$${pkgidir}/lib;		\
cd $$$${pkgidir}/lib;					\
$(DLLTOOL) --output-lib libiconv.dll.a --def libiconv.def)
endef

# libiconv needs some special magic to generate a usable import
# library.  Note that we include some internal symbols that are not
# actually part of the DLL.  They are needed by the AM_GNU_GETTEXT
# configure test, but not used otherwise.
define gpg4win_pkg_gettext_post_install
(cp $(srcdir)/libintl.def $$$${pkgidir}/lib;		\
cd $$$${pkgidir}/lib;					\
$(DLLTOOL) --output-lib libintl.dll.a --def libintl.def)
endef


# Zlib needs some special magic to generate a libtool file.
define gpg4win_pkg_zlib_post_install
(cd $$$${pkgidir};					\
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
echo "libdir=\"$$$${pkgidir}/lib\"" >> lib/libz.la;)
endef

# To make sure that we link against the static versions we need
# remove the import libs from crypt
#define gpg4win_pkg_crypt_post_install
#(cd $$$${pkgidir}/lib && rm libcrypt.dll.a libcrypt.lib)
#endef

# We need to fix the prefix in the various packages using pkgconfig,
# or we can't substitute it properly in our pkg-config wrapper.
define gpg4win_pkg_glib_post_install
 (cd $$$${pkgidir};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef

define gpg4win_pkg_atk_post_install
 (cd $$$${pkgidir_dev};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef

define gpg4win_pkg_freetype_post_install
 (cd $$$${pkgidir_dev};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef

define gpg4win_pkg_fontconfig_post_install
 (cd $$$${pkgidir_dev};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef

define gpg4win_pkg_cairo_post_install
 (cd $$$${pkgidir_dev};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef

define gpg4win_pkg_pango_post_install
 (cd $$$${pkgidir_dev};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef

define gpg4win_pkg_gtk__post_install
 (cd $$$${pkgidir_dev};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef

define gpg4win_pkg_libpng_post_install
 (cd $$$${pkgidir};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef


define gpg4win_pkg_libiconv_post_install
(cp $(srcdir)/libiconv.def $$$${pkgidir}/lib;		\
cd $$$${pkgidir}/lib;					\
$(DLLTOOL) --output-lib libiconv.dll.a --def libiconv.def)
endef

# Qt is missing the pkgconfig files.
define gpg4win_pkg_qt_post_install
(mkdir $$$${pkgidir_dev}/lib/pkgconfig; \
 cp $(srcdir)/QtCore.pc $(srcdir)/QtGui.pc $$$${pkgidir_dev}/lib/pkgconfig/)
endef


# kdesupport ships gettext, which we already have.  Remove a stow
# conflict about that.  Also remove a stow conflict with kdelibs-lib.
define gpg4win_pkg_kdesupport_post_install
(rm -fR "$$$${pkgidir_dev}/share/locale"; \
 rm -fR "$$$${pkgidir_dev}/share/apps/cmake/modules")
endef

# libxml2 ships some binaries, which we already have from kdesupport.  Remove a stow
# conflict about that. 
define gpg4win_pkg_libxml2_post_install
(rm -f "$$$${pkgidir}/bin/xmllint.exe"; \
 rm -f "$$$${pkgidir}/bin/xmlcatalog.exe")
endef

# Supported internal packages.  Internal packages do not require any
# special support.  Thus, this variable is actually unused, and no
# rules are added in gpg4win.mk.
gpg4win_ipkgs = man_novice_de man_advanced_de man_novice_en man_advanced_en \
		compendium_de


# Now do the bunch of the work.  This is a bunch of dirty magic to
# integrate our special makefile into automake, while not actually
# including it (make should include it).  This is in turn necessary
# because automake can't deal with the elegant magic in the actual
# Makefile.

define INCLUDE_BY_MAKE
include $(1)
endef

$(eval $(call INCLUDE_BY_MAKE,gpg4win.mk))

clean-local: clean-gpg4win

common_nsi = inst-sections.nsi installer.nsi installer-finish.nsi	\
  $(addsuffix .nsi,$(addprefix inst-,$(gpg4win_build_list)))		\
  $(addsuffix .nsi,$(addprefix uninst-,$(gpg4win_build_list)))


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
	sed -e '/^#/d' <$(top_srcdir)/NEWS >NEWS.tmp


installer-options.ini : $(top_srcdir)/src/installer-options.ini.in
	cat $(top_srcdir)/src/installer-options.ini.in >installer-options.ini


# For some nut-crazy reason someone thought it would be a great idea
# if makensis changed to the directory of the source file at startup.
# So we have to pull a couple of strings to correct this.
gpg4win-$(VERSION).exe: gpg4win.nsi $(common_nsi) stamps/stamp-final \
                        g4wihelp.dll gpgwrap.exe gpgwrap-2.exe kleowrap.exe \
		        $(foosum_exe) \
			$(README_files) installer-options.ini versioninfo.txt
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
           -DSRCDIR=$(srcdir) $(EXTRA_MAKENSIS_FLAGS) $(srcdir)/gpg4win.nsi

gpg4win-light-$(VERSION).exe: gpg4win.nsi $(common_nsi) stamps/stamp-final \
                        g4wihelp.dll gpgwrap.exe gpgwrap-2.exe kleowrap.exe \
		        $(foosum_exe) \
			$(README_files) installer-options.ini versioninfo.txt
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
           -DSRCDIR=$(srcdir) $(EXTRA_MAKENSIS_FLAGS) \
           -DGPG4WIN_LIGHT=1 $(srcdir)/gpg4win.nsi

gpg4win-$(VERSION).wix: gpg4win.nsi $(common_nsi) stamps/stamp-final \
			gpgwrap.exe gpgwrap-2.exe kleowrap.exe \
		        $(foosum_exe) \
			$(README_files) versioninfo.txt
	perl make-msi.pl --guids $(srcdir)/make-msi.guids \
		--manifest gpg4win-$(VERSION).files \
		-DBUILD_DIR=. -DTOP_SRCDIR=$(top_srcdir) \
		-DSRCDIR=$(srcdir) $(srcdir)/gpg4win.nsi > $@

gpg4win-light-$(VERSION).wix: gpg4win.nsi $(common_nsi) stamps/stamp-final \
			gpgwrap.exe gpgwrap-2.exe kleowrap.exe \
		        $(foosum_exe) \
			$(README_files) versioninfo.txt
	perl make-msi.pl --guids $(srcdir)/make-msi.guids \
		--manifest gpg4win-light-$(VERSION).files \
		-DBUILD_DIR=. -DTOP_SRCDIR=$(top_srcdir) \
		-DSRCDIR=$(srcdir) -DGPG4WIN_LIGHT=1 $(srcdir)/gpg4win.nsi > $@

.PHONY: msi
msi: gpg4win-$(VERSION).wix gpg4win-light-$(VERSION).wix


stamps/stamp-dist-self: versioninfo.txt
	(set -e; cd ..; make dist-bzip2)
	touch stamps/stamp-dist-self

gpg4win-src-$(VERSION).exe: gpg4win-src.nsi $(common_nsi) stamps/stamp-final \
                            stamps/stamp-dist-self installer-options.ini
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
	  -DSRCDIR=$(srcdir) $(EXTRA_MAKENSIS_FLAGS) $(srcdir)/gpg4win-src.nsi

g4wihelp.dll: g4wihelp.c exdll.h
	$(CC) -I. -shared -O2 -o g4wihelp.dll $(srcdir)/g4wihelp.c \
	   -lwinmm -lgdi32
	$(STRIP) g4wihelp.dll

gpgwrap.exe: gpgwrap.c
	$(CC) -I. -I.. -DHAVE_CONFIG_H -O2 -o $@ $^
	$(STRIP) $@

gpgwrap-2.exe: gpgwrap.c
	$(CC) -I. -I.. -DHAVE_CONFIG_H -DGPGWRAP_VARIANT=2 -O2 -o $@ $^
	$(STRIP) $@

kleowrap.exe: kleowrap.c
	$(CC) -I. -I.. -DHAVE_CONFIG_H -O2 -mwindows -o $@ $^
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


if BUILD_SOURCE_INSTALLER
all_src = gpg4win-src-$(VERSION).exe
else
all_src =
endif

if BUILD_LIGHT_INSTALLER
all_light = gpg4win-light-$(VERSION).exe
else
all_light =
endif

all-local: gpg4win-$(VERSION).exe $(all_light) $(all_src)

clean-local:
	rm -f gpg4win-$(VERSION).exe gpg4win-light-$(VERSION).exe \
            gpg4win-src-$(VERSION).exe

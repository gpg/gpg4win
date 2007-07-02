# Makefile.am - Installer for GnuPG 4 Windows Makefile.
# Copyright (C) 2005, 2006, 2007 g10 Code GmbH
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
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA


EXTRA_DIST = pkg-config $(common_nsi) gpg4win.nsi gpg4win-src.nsi \
        inst-gpg4win.nsi uninst-gpg4win.nsi installer-options.ini.in \
	libiconv.def libintl.def  gpg4win-splash.wav gpgwrap.c \
	exdll.h g4wihelp.c g4wihelp.nsi config.site loreley.mid \
	inst-man_novice_en.nsi inst-man_advanced_en.nsi \
	uninst-man_novice_en.nsi uninst-man_advanced_en.nsi

# Need to clean the dll because we bypassed automake.
CLEANFILES = g4wihelp.dll versioninfo.txt README.en.txt README.de.txt \
             installer-options.ini NEWS.tmp gpgwrap.exe

# Supported source packages.
gpg4win_spkgs = glib gnupg libgpg-error gpgme gpgol gpa winpt sylpheed-claws \
	        claws-mail gnupg2 pinentry libassuan libksba \
		libgcrypt dirmngr w32pth

# Extra options to configure for individual packages.
# We can use $(idir) here for the installation prefix.

gpg4win_pkg_glib_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib

# The GnuPG package provides man pages which we have to convert.
# We also create the MO files here.
define gpg4win_pkg_gnupg_post_install	
(man -Tlatin1 -l $$$${pkgidir}/share/man/man1/gpg.1 | \
 sed `printf "s/_\b//g;s/\b.//g"` | \
 sed -e 's/$$$$/\r/' > $$$${pkgidir}/share/man/man1/gpg.man; \
man -Tlatin1 -l $$$${pkgidir}/share/man/man1/gpgv.1 | \
 sed `printf "s/_\b//g;s/\b.//g"` | \
 sed -e 's/$$$$/\r/' > $$$${pkgidir}/share/man/man1/gpgv.man; \
man -Tlatin1 -l $$$${pkgidir}/share/man/man7/gnupg.7 | \
 sed `printf "s/_\b//g;s/\b.//g"` | \
 sed -e 's/$$$$/\r/' > $$$${pkgidir}/share/man/man7/gnupg.man; \
for i in de; do \
 msgfmt --output-file=$$$${pkgidir}/share/gnupg/$$$${i}.mo \
                               $$$${pkgsdir}/po/$$$${i}.po; \
 done)
endef


# The fields FAQ and faq.html conflict with those in GnuPG1.
# For now removes them.
define gpg4win_pkg_gnupg2_post_install	
( rm $$$${pkgidir}/share/gnupg/FAQ; \
  rm $$$${pkgidir}/share/gnupg/faq.html )
endef

# We would like to use --with-libiconv-prefix and
# --with-libintl-prefix, but these don't work with the cheesy
# non-"libfoo.la" versions of iconv and gettext that we are using.
#gpg4win_pkg_libgpg_error_configure = \
#  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir)
gpg4win_pkg_libgpg_error_configure = --silent \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib

gpg4win_pkg_libassuan_configure =  --silent \
  --disable-shared \
  --with-pth-prefix=$(idir)

gpg4win_pkg_libksba_configure = --silent \
  --with-gpg-error-prefix=$(idir)

gpg4win_pkg_libgcrypt_configure = --silent \
  --with-gpg-error-prefix=$(idir)

gpg4win_pkg_dirmngr_configure = \
  --with-gpg-error-prefix=$(idir) \
  --with-ksba-prefix=$(idir) \
  --with-libgcrypt-prefix=$(idir) \
  --with-libassuan-prefix=$(idir)

gpg4win_pkg_gnupg2_configure = \
  --with-gpg-error-prefix=$(idir) \
  --with-ksba-prefix=$(idir) \
  --with-libgcrypt-prefix=$(idir) \
  --with-libassuan-prefix=$(idir) \
  --with-zlib=$(idir) \
  --with-pth-prefix=$(idir) \
  --without-included-gettext \
  --disable-regex

gpg4win_pkg_pinentry_configure = \
  --disable-pinentry-gtk \
  --disable-pinentry-gtk2 \
  --disable-pinentry-qt 

# Glib doesn't add the LDFLAGS automatically.
gpg4win_pkg_gpgme_configure = --silent \
  --with-gpg-error-prefix=$(idir) --without-gpgsm --enable-static \
  --enable-w32-glib LDFLAGS=-L$(idir)/lib

gpg4win_pkg_gpa_configure = --silent \
  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir) \
  --with-gpgme-prefix=$(idir) --with-zlib=$(idir)

gpg4win_pkg_gpgol_configure = --silent \
  --with-gpgme-prefix=$(idir) --with-gpg-error-prefix=$(idir)

gpg4win_pkg_winpt_configure = --silent \
  --with-gpgme-prefix=$(idir) --with-gpg-error-prefix=$(idir)

gpg4win_pkg_sylpheed_claws_configure = --silent \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  --with-gpg-error-prefix=$(idir) --with-gpgme-prefix=$(idir) \
  --with-config-dir="Sylpheed-claws" --disable-pthread \
  --disable-libetpan --disable-aspell --disable-trayicon-plugin \
  --disable-openssl --disable-dillo-viewer-plugin --disable-gnomeprint \
  --disable-jpilot --disable-startup-notification --disable-ipv6 \
  --disable-mathml-viewer-plugin --disable-clamav-plugin \
  --disable-spamassassin-plugin

gpg4win_pkg_claws_mail_configure = --silent \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  --with-gpg-error-prefix=$(idir) --with-gpgme-prefix=$(idir) \
  --with-config-dir="Claws-mail" --disable-pthread \
  --disable-libetpan --disable-aspell --disable-trayicon-plugin \
  --disable-openssl --disable-dillo-viewer-plugin --disable-gnomeprint \
  --disable-jpilot --disable-startup-notification --disable-ipv6 \
  --disable-mathml-viewer-plugin --disable-clamav-plugin \
  --disable-spamassassin-plugin --disable-bogofilter-plugin \
  --disable-valgrind

# Supported make-only source packages.
gpg4win_mpkgs =  pthreads-w32

# Extra options for the make infocations for individual packages.
# make_flags is used fur building make_args_inst is used for installing.
gpg4win_pkg_pthreads_w32_make_args = \
  prefix=$(idir) CROSS=$(host_alias)- clean GC-inlined

gpg4win_pkg_pthreads_w32_make_args_inst = \
  prefix=$$$${pkgidir} CROSS=$(host_alias)- 


# Supported binary packages.
gpg4win_bpkgs =  libiconv gettext pkgconfig zlib libpng jpeg pango cairo \
	          atk gtk+ gpgee crypt regex 

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
(cd $$$${pkgidir_dev};					\
echo "dlname='../bin/zlib1.dll'" > lib/libz.la;	\
echo "library_names='libz.dll.a'" >> lib/libz.la;	\
echo "old_library='libz.a'" >> lib/libz.la;		\
echo "dependency_libs=''" >> lib/libz.la;		\
echo "current=1" >> lib/libz.la;			\
echo "age=2" >> lib/libz.la;				\
echo "revision=3" >> lib/libz.la;			\
echo "installed=yes" >> lib/libz.la;			\
echo "shouldnotlink=no" >> lib/libz.la;			\
echo "dlopen=''" >> lib/libz.la;			\
echo "dlpreopen=''" >> lib/libz.la;			\
echo "libdir=\"$$$${pkgidir}/lib\"" >> lib/libz.la;)
endef

# To make shure that we link against the static versions we need
# remove the import libs from crypt
define gpg4win_pkg_crypt_post_install
(cd $$$${pkgidir}/lib && rm libcrypt.dll.a libcrypt.lib)
endef

# To make shure that we link against the static versions we need
# remove the import libs from regex
define gpg4win_pkg_regex_post_install
(cd $$$${pkgidir}/lib && rm libregex.dll.a libregex.lib)
endef

# We need to fix the prefix in the various packages using pkgconfig,
# or we can't substitute it properly in our pkg-config wrapper.
define gpg4win_pkg_glib_post_install
 (cd $$$${pkgidir_dev};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef

define gpg4win_pkg_atk_post_install
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

# In libpng, the pkg-config files are surprisingly found in the
# runtime package.
define gpg4win_pkg_libpng_post_install
 (cd $$$${pkgidir};							\
 perl -pi -e 's/^prefix=.*$$$$/prefix=\/usr/' `find . -name \*.pc`)
endef


# Supported internal packages.  Internal packages do not require any
# special support.  Thus, this variable is actually unused, and no
# rules are added in gpg4win.mk.
gpg4win_ipkgs = man_novice_de man_advanced_de man_novice_en man_advanced_en


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
versioninfo.txt : playground/build/versioninfo.txt
	set -e; \
	( while read a b; do echo "$$a $$(basename $$b)"; \
            done < playground/build/versioninfo.txt \
          | sort -k2 -sf | tac | uniq -f1 ; \
          echo '=========== SHA-1 checksum ============= == package ==' \
         ) | tac | awk '{printf "%s\r\n", $$0}' > versioninfo.txt

NEWS.tmp : $(top_srcdir)/NEWS
	sed -e '/^#/d' <$(top_srcdir)/NEWS >NEWS.tmp

README.en.txt : versioninfo.txt NEWS.tmp $(top_srcdir)/doc/README.en.txt
	sed -e '/^;.*/d;/!VERSIONINFO!/{r versioninfo.txt' -e 'd;}' \
	-e '/!NEWSFILE!/{r NEWS.tmp' -e 'd;}' \
        -e '/!PKG-COPYRIGHT!/{r $(top_srcdir)/doc/pkg-copyright.txt' -e 'd;}' \
        -e 's,!VERSION!,$(VERSION),g' \
	   < $(top_srcdir)/doc/README.en.txt \
           | awk '{printf "%s\r\n", $$0}' >README.en.txt

installer-options.ini : $(top_srcdir)/src/installer-options.ini.in
	cat $(top_srcdir)/src/installer-options.ini.in >installer-options.ini

README.de.txt : versioninfo.txt NEWS.tmp $(top_srcdir)/doc/README.de.txt
	sed -e '/^;.*/d;/!VERSIONINFO!/{r versioninfo.txt' -e 'd;}' \
	-e '/!NEWSFILE!/{r NEWS.tmp' -e 'd;}' \
        -e '/!PKG-COPYRIGHT!/{r $(top_srcdir)/doc/pkg-copyright.txt' -e 'd;}' \
        -e 's,!VERSION!,$(VERSION),g' \
	   < $(top_srcdir)/doc/README.de.txt \
           | awk '{printf "%s\r\n", $$0}' >README.de.txt

# For some nut-crazy reason someone thought it would be a great idea
# if makensis changed to the directory of the source file at startup.
# So we have to pull a couple of strings to correct this.
gpg4win-$(VERSION).exe: gpg4win.nsi $(common_nsi) stamps/stamp-final \
                        g4wihelp.dll gpgwrap.exe README.en.txt README.de.txt \
			installer-options.ini versioninfo.txt
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
		-DSRCDIR=$(srcdir) $(srcdir)/gpg4win.nsi

gpg4win-light-$(VERSION).exe: gpg4win.nsi $(common_nsi) stamps/stamp-final \
                        g4wihelp.dll gpgwrap.exe README.en.txt README.de.txt \
			installer-options.ini versioninfo.txt
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
		-DSRCDIR=$(srcdir) -DGPG4WIN_LIGHT=1 $(srcdir)/gpg4win.nsi

stamps/stamp-dist-self: versioninfo.txt
	(set -e; cd ..; make dist-bzip2)
	touch stamps/stamp-dist-self

gpg4win-src-$(VERSION).exe: gpg4win-src.nsi $(common_nsi) stamps/stamp-final \
                            stamps/stamp-dist-self installer-options.ini
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
		-DSRCDIR=$(srcdir) $(srcdir)/gpg4win-src.nsi

g4wihelp.dll: g4wihelp.c exdll.h
	$(CC) -I. -shared -O2 -o g4wihelp.dll $(srcdir)/g4wihelp.c \
	   -lwinmm -lgdi32
	$(STRIP) g4wihelp.dll

gpgwrap.exe: gpgwrap.c
	$(CC) -I. -I.. -DHAVE_CONFIG_H -O2 -o gpgwrap.exe $(srcdir)/gpgwrap.c 
	$(STRIP) gpgwrap.exe

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

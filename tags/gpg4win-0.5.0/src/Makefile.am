# Makefile.am - Installer for GnuPG 4 Windows Makefile.
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


EXTRA_DIST = pkg-config $(common_nsi) gpg4win.nsi gpg4win-src.nsi \
	libiconv.def libintl.def  gpg4win-splash.bmp gpg4win-splash.wav \
	exdll.h g4wihelp.c g4wihelp.nsi config.site loreley.mid

# Need to clean the dll because we bypassed automake.
CLEANFILES = g4wihelp.dll 

# Supported source packages.
gpg4win_spkgs := glib gnupg libgpg-error gpgme gpgol gpa winpt sylpheed-claws \
                 eudoragpg man_novice_de man_advanced_de

# Extra options to configure for individual packages.
# We can use $(idir) here for the installation prefix.

gpg4win_pkg_glib_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib

# We would like to use --with-libiconv-prefix and
# --with-libintl-prefix, but these don't work with the cheesy
# non-"libfoo.la" versions of iconv and gettext that we are using.
#gpg4win_pkg_libgpg_error_configure = \
#  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir)
gpg4win_pkg_libgpg_error_configure = \
  CPPFLAGS=-I$(idir)/include LDFLAGS=-L$(idir)/lib

# Glib doesn't add the LDFLAGS automatically.
gpg4win_pkg_gpgme_configure = \
  --with-gpg-error-prefix=$(idir) --without-gpgsm --enable-static \
  --enable-w32-glib LDFLAGS=-L$(idir)/lib

gpg4win_pkg_gpa_configure = \
  --with-libiconv-prefix=$(idir) --with-libintl-prefix=$(idir) \
  --with-gpgme-prefix=$(idir) --with-zlib=$(idir)

gpg4win_pkg_gpgol_configure = \
  --with-gpgme-prefix=$(idir) --with-gpg-error-prefix=$(idir)

gpg4win_pkg_winpt_configure = \
  --with-gpgme-prefix=$(idir) --with-gpg-error-prefix=$(idir)

gpg4win_pkg_sylpheed_claws_configure = \
  --with-lib-prefix=$(idir) --with-libiconv-prefix=$(idir) \
  --with-gpg-error-prefix=$(idir) --with-gpgme-prefix=$(idir) \
  --with-config-dir="Sylpheed-claws" --disable-pthread \
  --disable-libetpan --disable-aspell --disable-trayicon-plugin \
  --disable-openssl --disable-dillo-viewer-plugin --disable-gnomeprint \
  --disable-jpilot --disable-startup-notification --disable-ipv6 \
  --disable-mathml-viewer-plugin --disable-clamav-plugin \
  --disable-spamassassin-plugin

# Supported make-only source packages.
gpg4win_mpkgs :=  pthreads-w32

# Extra options for the make infocations for individual packages.
# make_flags is used fur building make_args_inst is used for installing.
gpg4win_pkg_pthreads_w32_make_args = \
  prefix=$(idir) CROSS=$(host_alias)- clean GC-inlined

gpg4win_pkg_pthreads_w32_make_args_inst = \
  prefix=$$$${pkgidir} CROSS=$(host_alias)- 


# Supported binary packages.
gpg4win_bpkgs :=  libiconv gettext pkgconfig zlib libpng pango atk gtk+ \
		  gpgee crypt regex

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

common_nsi := inst-sections.nsi installer.nsi installer-finish.nsi	\
  $(addsuffix .nsi,$(addprefix inst-,$(gpg4win_build_list)))		\
  $(addsuffix .nsi,$(addprefix uninst-,$(gpg4win_build_list)))

# For some nut-crazy reason someone thought it would be a great idea
# if makensis changed to the directory of the source file at startup.
# So we have to pull a couple of strings to correct this.
gpg4win-$(VERSION).exe: gpg4win.nsi $(common_nsi) stamps/stamp-final \
                        g4wihelp.dll
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
		-DSRCDIR=$(srcdir) $(srcdir)/gpg4win.nsi

gpg4win-src-$(VERSION).exe: gpg4win-src.nsi $(common_nsi) stamps/stamp-final
	$(MAKENSIS) -V3 -DBUILD_DIR=`pwd` -DTOP_SRCDIR=$(top_srcdir) \
		-DSRCDIR=$(srcdir) $(srcdir)/gpg4win-src.nsi

g4wihelp.dll: g4wihelp.c exdll.h
	$(CC) -I. -shared -O2 -o g4wihelp.dll $(srcdir)/g4wihelp.c \
	   -lwinmm -lgdi32

all-local: gpg4win-$(VERSION).exe gpg4win-src-$(VERSION).exe

clean-local:
	rm -f gpg4win-$(VERSION).exe gpg4win-src-$(VERSION).exe

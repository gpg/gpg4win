#! /bin/sh -e

# TODO
# Check source signatures.
# Check source for binary packages.
# Optionally strip after installation.
# User configuration.

. ../include/config.sh

builddir=`pwd`

# Now set up the paths.

root=${builddir}/playground
packages=${builddir}/../packages

# Input variables:
#
# root		Must be set to the build root directory.
# packages	Must be set to the source directory.

# no_run=echo
no_run=

# Derived configuration.

sdir="${packages}"
bdir="${root}/build"
pdir="${builddir}/${top_srcdir}/patches"
idir="${root}/install"
ipdir="${root}/install/pkgs"

export PKG_CONFIG=${builddir}/${top_srcdir}/src/pkg-config
export PKG_CONFIG_PATH="${idir}/lib/pkgconfig"
export SYSROOT="${idir}"


# Clear installation and build directory.

${no_run} ${RM} -fR "${root}"
${no_run} ${MKDIR} "${root}"
${no_run} ${MKDIR} "${idir}"
${no_run} ${MKDIR} "${ipdir}"
${no_run} ${MKDIR} "${bdir}"


# install_binary BINARY SOURCE PREFIXVAR

# Install the binary package BINARY with the corresponding source SOURCE.
# The installation prefix is returned in PREFIXVAR.
function install_binary()
{
    pkg=$1
    spkg=$2
    pkgsdir="${bdir}/${spkg}"
    pkgbdir="${bdir}/${spkg}-build"
    pkgpdir="${pdir}/${spkg}"
    pkgidir="${ipdir}/${pkg}"

    ${no_run} ${MKDIR} "${pkgidir}"
    (cd ${pkgidir}; ${no_run} ${UNZIP} "${sdir}/${pkg}.zip")
    (cd ${ipdir}; ${no_run} ${STOW} "${pkg}")

    eval ${3}_PREFIX="${pkgidir}"
}


# install_source SOURCE CONFIG PREFIXVAR

# Install the source package SOURCE with configure flags CONFIG.
# The installation prefix is returned in PREFIXVAR.
function install_source()
{
    pkg=$1
    spkg=${pkg}
    pkgsdir="${bdir}/${spkg}"
    pkgbdir="${bdir}/${spkg}-build"
    pkgpdir="${pdir}/${spkg}"
    pkgidir="${ipdir}/${pkg}"

    (cd "${bdir}"; ${no_run} ${TAR} xzf "${sdir}/${spkg}.tar.gz")

    for pfile in "${pkgpdir}"/*.patch ; do
	(cd "${pkgsdir}"; ${no_run} "${pfile}")
    done

    ${no_run} mkdir ${pkgbdir}
    (cd "${pkgbdir}"; \
	${no_run} "${pkgsdir}/configure" --prefix="${pkgidir}" \
	--host="${host}" --build="${build}" ${2})

    (cd "${pkgbdir}"; ${no_run} ${MAKE})
    
    (cd "${pkgbdir}"; ${no_run} ${MAKE} install)

    (cd ${ipdir}; ${no_run} ${STOW} "${pkg}")

    eval ${3}_PREFIX="${pkgidir}"
}


# Install iconv runtime and development.

# Required by Gtk.  Provides iconv.dll.
install_binary libiconv-1.9.1.bin.woe32 libiconv-1.9.1 LIBICONV
# FIXME: Conflict iconv.exe

#(cd ${ipdir}; ${no_run} ${RM} libiconv-1.9.1.bin.woe32/bin/iconv.exe)
#(cd ${ipdir}; ${no_run} ${RM} libiconv-1.9.1.bin.woe32/include/iconv.h)
#(cd ${ipdir}; ${no_run} ${RM} libiconv-1.9.1.bin.woe32/include/libcharset.h)
#(cd ${ipdir}; ${no_run} ${RM} -fR libiconv-1.9.1.bin.woe32/share)
#(cd ${ipdir}; ${no_run} ${STOW} libiconv-1.9.1.bin.woe32)

# Provides libiconv-2.dll
#install_binary libiconv-1.8-1-bin libiconv-1.8-1-src
#install_binary libiconv-1.8-1-lib libiconv-1.8-1-src LIBICONV

# Install gettext runtime and development.

# Required by Gtk.  Provides intl.dll.
install_binary gettext-runtime-0.13.1.bin.woe32 gettext-0.13.1 LIBINTL
#(cd ${ipdir}; ${no_run} ${RM} gettext-runtime-0.13.1.bin.woe32/bin/gettext.exe)
#(cd ${ipdir}; ${no_run} ${RM} gettext-runtime-0.13.1.bin.woe32/bin/ngettext.exe)
#(cd ${ipdir}; ${no_run} ${RM} gettext-runtime-0.13.1.bin.woe32/bin/envsubst.exe)
#(cd ${ipdir}; ${no_run} ${RM} gettext-runtime-0.13.1.bin.woe32/bin/gettext.sh)
#(cd ${ipdir}; ${no_run} ${RM} -fR gettext-runtime-0.13.1.bin.woe32/share)
#(cd ${ipdir}; ${no_run} ${RM} -fR gettext-runtime-0.13.1.bin.woe32/include)
#(cd ${ipdir}; ${no_run} ${STOW} gettext-runtime-0.13.1.bin.woe32)

#install_binary gettext-0.14.4-bin gettext-0.14.4
#install_binary gettext-0.14.4-lib gettext-0.14.4 LIBINTL
#install_binary gettext-0.14.4-dep gettext-0.14.4


# Install zlib runtime and development.

install_binary zlib-1.2.3-bin zlib-1.2.3-src
install_binary zlib-1.2.3-lib zlib-1.2.3-src ZLIB

# Now generate the required file for libtool (FIXME: Is this really
# required?).
(cd ${ipdir}; ${no_run} ${STOW} -D zlib-1.2.3-lib)
(cd ${ZLIB_PREFIX}; ${no_run} cat > lib/libz.la <<EOF)
dlname='../bin/zlib1.dll'
library_names='libz.dll.a'
old_library='libz.a'
dependency_libs=''
current=1
age=2
revision=3
installed=yes
shouldnotlink=no
dlopen=''
dlpreopen=''
libdir="${ZLIB_PREFIX}/lib"
EOF
(cd ${ipdir}; ${no_run} ${STOW} zlib-1.2.3-lib)


# Install Glib runtime and development.

# extra-source: dirent.zip
install_binary glib-2.6.6 glib-2.6.6
install_binary glib-dev-2.6.6 glib-2.6.6 GLIB


# Install Gtk+ runtime and development.  Requires glib.

install_binary atk-1.9.0 atk-1.9.0
install_binary atk-dev-1.9.0 atk-1.9.0 ATK

install_binary pango-1.8.2 pango-1.8.2
install_binary pango-dev-1.8.2 pango-1.8.2 PANGO

install_binary gtk+-2.6.9 gtk+-2.6.9
install_binary gtk+-dev-2.6.9 gtk+-2.6.9 GTK2


# Install libpng runtime and development.

install_binary libpng-1.2.8-bin libpng-1.2.8-src
install_binary libpng-1.2.8-lib libpng-1.2.8-src LIBPNG


# Install pkg-config.  Requires Gtk+.  (FIXME: Is this needed?)

install_binary pkgconfig-0.15 pkgconfig-0.15.0


# BINARY FIXUP

# We need to fix the prefix in the various packages, or we can't
# substitute it properly in our pkg-config wrapper.

(cd ${ipdir}; ${no_run} perl -pi -e 's/^prefix=.*$/prefix=\/usr/' `find . -name \*.pc`)


# Install GnuPG.

install_source gnupg-1.4.2


# Install libgpg-error.

install_source libgpg-error-1.2-cvs "" LIBGPG_ERROR


# Install GPGME.  Requires libgpg-error.

install_source gpgme-1.1.0 \
  "--with-gpg-error-prefix=${idir} --without-gpgsm" \
  GPGME


# Install GPA.  Requires zlib, Gtk+, libpng, glib, GPGME.

install_source gpa-0.7.1-cvs \
    "--with-libiconv-prefix=${idir} --with-libintl-prefix=${idir} --with-gpgme-prefix=${idir} --with-zlib=${idir}" \
    GPA

# Install GPGol.  Requires GPGME.

install_source gpgol-0.9.3-cvs "--with-gpgme-prefix=${idir}" GPA

# Install GPGee.  FIXME  (From installable exe ?)

#

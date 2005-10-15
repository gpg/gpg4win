#! /bin/sh

. ../include/config.sh


# GNU

server_gnu=ftp://ftp.cs.tu-berlin.de/pub/gnu

${WGET} -c ${server_gnu}/gettext/gettext-runtime-0.13.1.bin.woe32.zip
${WGET} -c ${server_gnu}/gettext/gettext-runtime-0.13.1.bin.woe32.zip.sig
${WGET} -c ${server_gnu}/gettext/gettext-0.13.1.tar.gz
${WGET} -c ${server_gnu}/gettext/gettext-0.13.1.tar.gz.sig

${WGET} -c ${server_gnu}/libiconv/libiconv-1.9.1.bin.woe32.zip
${WGET} -c ${server_gnu}/libiconv/libiconv-1.9.1.bin.woe32.zip.sig
${WGET} -c ${server_gnu}/libiconv/libiconv-1.9.1.tar.gz
# No signature for the source package.


# http://gnuwin32.sourceforge.net/

server_gnuwin32=http://mesh.dl.sourceforge.net/sourceforge/gnuwin32

${WGET} -c ${server_gnuwin32}/zlib-1.2.3-bin.zip
${WGET} -c ${server_gnuwin32}/zlib-1.2.3-lib.zip
${WGET} -c ${server_gnuwin32}/zlib-1.2.3-src.zip

${WGET} -c ${server_gnuwin32}/libpng-1.2.8-bin.zip
${WGET} -c ${server_gnuwin32}/libpng-1.2.8-lib.zip
${WGET} -c ${server_gnuwin32}/libpng-1.2.8-src.zip


# http://www.gimp.org/~tml/gimp/win32/downloads.html

server_gtk=ftp://ftp.gtk.org/pub/gtk/v2.6
server_gimp=http://www.gimp.org/~tml/gimp/win32

${WGET} -c ${server_gtk}/win32/glib-2.6.6.zip
${WGET} -c ${server_gtk}/win32/glib-dev-2.6.6.zip
${WGET} -c ${server_gtk}/glib-2.6.6.tar.bz2

${WGET} -c ${server_gtk}/win32/atk-1.9.0.zip
${WGET} -c ${server_gtk}/win32/atk-dev-1.9.0.zip
${WGET} -c ${server_gtk}/atk-1.9.0.tar.bz2

${WGET} -c ${server_gtk}/win32/pango-1.8.2.zip
${WGET} -c ${server_gtk}/win32/pango-dev-1.8.2.zip
${WGET} -c ${server_gtk}/pango-1.8.2.tar.bz2

${WGET} -c ${server_gtk}/win32/gtk+-2.6.9.zip
${WGET} -c ${server_gtk}/win32/gtk+-dev-2.6.9.zip
${WGET} -c ${server_gtk}/gtk+-2.6.6.tar.bz2

${WGET} -c ${server_gimp}/pkgconfig-0.15.zip
${WGET} -c ${server_gimp}/pkgconfig-0.15.0.tar.gz


# GnuPG stuff.

server_gnupg=http://ftp.gnupg.org/gcrypt

${WGET} -c ${server_gnupg}/gnupg/gnupg-1.4.2.tar.gz
${WGET} -c ${server_gnupg}/gnupg/gnupg-1.4.2.tar.gz.sig

${WGET} -c ${server_gnupg}/gpgme/gpgme-1.1.0.tar.gz
${WGET} -c ${server_gnupg}/gpgme/gpgme-1.1.0.tar.gz.sig

# libgpg-error, GPA and GPGol currently come from manually crafted
# packages.

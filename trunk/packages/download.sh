#!/bin/sh
# download.sh - Download source and binary packages for GPG4Win.
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

WGET=wget


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
# Note:  Mesh, Duesseldorf does not work reliable anymore.
server_gnuwin32=http://kent.dl.sourceforge.net/sourceforge/gnuwin32

${WGET} -c ${server_gnuwin32}/zlib-1.2.3-bin.zip
${WGET} -c ${server_gnuwin32}/zlib-1.2.3-lib.zip
${WGET} -c ${server_gnuwin32}/zlib-1.2.3-src.zip

${WGET} -c ${server_gnuwin32}/libpng-1.2.8-bin.zip
${WGET} -c ${server_gnuwin32}/libpng-1.2.8-lib.zip
${WGET} -c ${server_gnuwin32}/libpng-1.2.8-src.zip

${WGET} -c ${server_gnuwin32}/crypt-2.2.5-lib.zip
${WGET} -c ${server_gnuwin32}/crypt-2.2.5-src.zip

${WGET} -c ${server_gnuwin32}/regex-0.12-lib.zip
${WGET} -c ${server_gnuwin32}/regex-0.12-src.zip


# RedHat

server_redhat=ftp://sources.redhat.com/pub/

${WGET} -c ${server_redhat}/pthreads-win32/pthreads-w32-2-7-0-release.tar.gz


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

# WinPT

server_winpt="http://wald.intevation.org/frs/download.php"

${WGET} -c ${server_winpt}/47/winpt-0.11.0.tar.bz2
${WGET} -c ${server_winpt}/48/winpt-0.11.0.tar.bz2.sig

# GPGee
# Note: This is a temporary location

server_gpgee="ftp://ftp.g10code.com/g10code/scratch"

${WGET} -c ${server_gpgee}/gpgee-1.2.2-bin.zip
${WGET} -c ${server_gpgee}/gpgee-1.2.2-src.zip


# GnuPG stuff. 

server_gnupg=http://ftp.gnupg.org/gcrypt

# (see below for gnupg - we use the CVS version for now)
#${WGET} -c ${server_gnupg}/gnupg/gnupg-1.4.2.tar.gz
#${WGET} -c ${server_gnupg}/gnupg/gnupg-1.4.2.tar.gz.sig

#${WGET} -c ${server_gnupg}/gpgme/gpgme-1.1.0.tar.gz
#${WGET} -c ${server_gnupg}/gpgme/gpgme-1.1.0.tar.gz.sig

# libgpg-error, GPA and GPGol currently come from manually crafted
# packages.  However, we make them available at a scratch location

server_g10code="ftp://ftp.g10code.com/g10code/scratch"

${WGET} -c ${server_g10code}/gnupg-1.4.3-cvs.tar.bz2
${WGET} -c ${server_g10code}/libgpg-error-1.2-cvs.tar.bz2
${WGET} -c ${server_g10code}/gpgme-1.2.0-cvs.tar.bz2
${WGET} -c ${server_g10code}/gpa-0.7.1-cvs.tar.bz2
${WGET} -c ${server_g10code}/gpgol-0.9.4-cvs.tar.bz2
${WGET} -c ${server_g10code}/sylpheed-claws-1.9.99cvs5-wk1.tar.bz2

# Dummy manual pages
${WGET} -c ${server_g10code}/man_novice_de-0.0.0-cvs.tar.gz
${WGET} -c ${server_g10code}/man_advanced_de-0.0.0-cvs.tar.gz
${WGET} -c ${server_g10code}/eudoragpg-0.0.0-cvs.tar.gz

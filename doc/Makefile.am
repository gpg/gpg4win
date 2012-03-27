# Makefile.am - Documentation for GnuPG 4 Windows Makefile.
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

EXTRA_DIST = nsi-mode.el pkg-copyright.txt beta-warning.txt HACKING\
	     README.ar.txt README.de.txt README.en.txt README.es.txt \
	     README.fr.txt README.ru.txt README.pt.txt

if BUILD_MANUALS
manual = manual
else
manual =
endif

SUBDIRS = logo $(manual) website

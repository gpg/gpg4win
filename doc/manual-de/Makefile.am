# Makefile.am - Building the german manuals
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

eps_files := adele01.eps.gz adele02.eps.gz man-with-signed-key.eps.gz \
             egyptian-stone.eps.gz sealed-envelope.eps.gz \
	     schlapphut-with-key.eps.gz tangled-schlapphut.eps.gz \
	     verleihnix.eps.gz key-with-shadow-bit.eps.gz \
             letter-into-safe.eps.gz letter-out-of-safe.eps.gz \
             secret-key-exchange.eps.gz pk-safe-open.eps.gz \
             pk-safe-opened-with-sk.eps.gz think-passphrase.eps.gz \
             keyserver-world.eps.gz 

eps_files_bb := $(eps_files:.gz=.bb)

EXTRA_DIST = fdl.tex einsteiger.tex durchblicker.tex $(eps_files)

CLEANFILES = $(eps_files_bb)

all-local: $(eps_files_bb)


%.eps.bb : %.eps.gz
	$(ZCAT) `test -f '$<' || echo '$(srcdir)/'`$< \
          | grep '^%%BoundingBox' | head -1 > $@

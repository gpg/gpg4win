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

png_files := \
	sc-winpt-sign-passwd.png \
        sc-gpgee-ctxmenu.png sc-gpgee-signmenu.png \
	sc-gpa-gen-backup.png sc-gpa-gen-backup-warn.png

web_png_files := blank.png next.png previous.png up.png \
                 home.png nonext.png noprevious.png noup.png


eps_files := adele01.eps.gz adele02.eps.gz man-with-signed-key.eps.gz \
             egyptian-stone.eps.gz sealed-envelope.eps.gz \
	     schlapphut-with-key.eps.gz tangled-schlapphut.eps.gz \
	     verleihnix.eps.gz key-with-shadow-bit.eps.gz \
             letter-into-safe.eps.gz letter-out-of-safe.eps.gz \
             secret-key-exchange.eps.gz pk-safe-open.eps.gz \
             pk-safe-opened-with-sk.eps.gz think-passphrase.eps.gz \
             keyserver-world.eps.gz key-with-sigs.eps.gz \
	     clock-face.eps.gz mileage-indicator.eps.gz \
	     table-1.eps.gz table-2.eps.gz table-3.eps.gz \
             sc-inst-components.eps.gz sc-inst-directory.eps.gz \
             sc-inst-finished.eps.gz sc-inst-finished2.eps.gz \
             sc-inst-license.eps.gz sc-inst-ready.eps.gz \
             sc-inst-startmenu.eps.gz sc-inst-welcome.eps.gz \
             sc-gpa-first-key.eps.gz \
             sc-gpa-gen-email.eps.gz sc-gpa-gen-name.eps.gz \
             sc-gpa-gen-passwd.eps.gz sc-gpa-nokey.eps.gz \
             sc-gpa-rungpa.eps.gz sc-gpa-ks-export-p.eps.gz \
             sc-gpa-two-keys.eps.gz \
             sc-ol-send-test-key.eps.gz sc-ol-send-enc-msg1.eps.gz \
             sc-ol-send-enc-msg2.eps.gz \
             sc-gpgol-noword.eps.gz sc-gpgol-set-icon.eps.gz \
             sc-winpt-startmenu.eps.gz sc-winpt-trayicon.eps.gz \
	     sc-winpt-clip-decrypt.eps.gz sc-winpt-good-sig.eps.gz \
             sc-winpt-sel-enc-key.eps.gz sc-winpt-enctoself.eps.gz \
	     sc-misc-mein-key-asc.eps.gz 

eps_files_bb  := $(eps_files:.gz=.bb)
eps_files_png  := $(eps_files:.eps.gz=.png)
#eps_files_pdf := $(eps_files:.eps.gz=.pdf)
png_files_eps := $(png_files:.png=.eps) 

EXTRA_DIST = fdl.tex einsteiger.tex durchblicker.tex $(eps_files) \
             $(png_files) $(web_png_files) \
	     was-ist-gpg4win.tex macros.tex version.tex.in gpg4win-logo.eps

CLEANFILES = $(eps_files_bb) $(png_files_eps) \
             *.pdf *.pdf *.toc *.log *.aux *.out
DISTCLEANFILES = version.tex $(eps_files_png)

pkgdata_DATA = einsteiger.pdf durchblicker.pdf

BUILT_SOURCES = $(eps_files_bb) $(png_files_eps) $(eps_files_png)

all-local: einsteiger.pdf durchblicker.pdf

einsteiger.pdf : $(eps_files_bb) $(png_files_eps) $(eps_files_png)
#$(eps_files_pdf)
durchblicker.pdf : $(eps_files_bb) $(png_files_eps) $(eps_files_png)


webversion: einsteiger.html durchblicker.html


%.eps.bb : %.eps.gz
	$(ZCAT) `test -f '$<' || echo '$(srcdir)/'`$< \
          | grep '^%%BoundingBox' | head -1 > $@

%.eps : %.png
	$(CONVERT) `test -f '$<' || echo '$(srcdir)/'`$< $@

%.png : %.eps.gz
	$(CONVERT) `test -f '$<' || echo '$(srcdir)/'`$< $@

%.dvi : %.tex
	$(TEXI2DVI) `test -f '$<' || echo '$(srcdir)/'`$< 

%.pdf : %.dvi
	TEXPICTS=$(srcdir) $(DVIPDF)  $< $@

#%.pdf : %.eps.gz
#	$(ZCAT) `test -f '$<' || echo '$(srcdir)/'`$< \
#         | epstopdf -f > $@

%.html : %.tex
	hyperlatex $<

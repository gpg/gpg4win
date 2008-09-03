# Makefile.am - Building the manuals
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


png_files = \
		sc-kleopatra-startmenu_de.png\
		sc-kleopatra-mainwindow-empty_de.png\
		sc-kleopatra-ChooseCertificateFormat_de.png\
		sc-kleopatra-openpgp-personalDetails_de.png\
		sc-kleopatra-openpgp-reviewParameters_de.png\
		sc-kleopatra-openpgp-createKey_de.png\
		sc-kleopatra-openpgp-pinentry_de.png\
		sc-kleopatra-openpgp-keyPairCreated_de.png\
		sc-kleopatra-openpgp-exportSecretKey_de.png\
		sc-ol-sendNewOpenpgpCertificate_de.png\
		sc-kleopatra-withOpenpgpTestkey_de.png\
		sc-kleopatra-openpgp-certificateDetails_de.png\
		sc-kleopatra-x509-personalDetails_de.png\
		sc-kleopatra-x509-reviewParameters_de.png\
		sc-kleopatra-x509-createKey_de.png\
		sc-kleopatra-x509-pinentry_de.png\
		sc-kleopatra-x509-keyPairCreated_de.png\
		sc-kleopatra-exportCertificateToServer_de.png\
		sc-kleopatra-certificateSearchOnKeyserver_de.png\
		sc-kleopatra-encryptVerify_de.png \
		sc-kleopatra-certifyCertificate1_de.png \
		sc-kleopatra-certifyCertificate2_de.png \
		sc-kleopatra-certifyCertificate3_de.png \
		sc-kleopatra-openpgp-encryptDialog_de.png \
		sc-ol-sendNewX509Certificate_de.png\
		sc-ol-adele-sendOpenpgpKey-inline_de.png\
		sc-ol-adele-sendOpenpgpKey-attachment_de.png\
		sc-kleopatra-import-certificate_de.png\
		sc-kleopatra-import-openpgp-secret-key_de.png\
		sc-kleopatra-encryption-chooseOpenpgpCertificate_de.png\
		sc-kleopatra-encryption-successful_de.png\
		sc-ol-sendEncryptedMail_de.png\
		sc-ol-sendSignedMail_de.png\
		sc-gpgol-options_de.png\
		sc-gpgol-options-textformat_de.png\
		sc-kleopatra-openpgp-signDialog_de.png\
		sc-kleopatra-sign-chooseOpenpgpCertificate_de.png\
		sc-kleopatra-sign-OpenpgpPinentry_de.png\
		sc-kleopatra-sign-successful_de.png\
		sc-kleopatra-encryptFile1_de.png\
		sc-kleopatra-encryptFile3_de.png\
		sc-kleopatra-encryptFile4_de.png\
		sc-kleopatra-signFile1_de.png\
		sc-kleopatra-signEncryptFile2_de.png\
		sc-kleopatra-signFile3_de.png\
		sc-kleopatra-decryptFile1_de.png\
		sc-kleopatra-decryptFile2_de.png\
		sc-kleopatra-verifyFile1_de.png\
		sc-kleopatra-verifyFile2_de.png\
		sc-gpgex-contextmenu-signEncrypt_de.png\
		sc-gpgex-contextmenu-verifyDecrypt_de.png\
		sc-wordpad-editOpenpgpKey_de.png\
		\
		sc-inst-welcome.png sc-inst-license.png \
		sc-inst-components.png sc-inst-directory.png \
		sc-inst-options.png \
		sc-inst-startmenu.png sc-inst-ready.png \
		sc-inst-finished.png sc-inst-finished2.png \
		sc-winpt-sign-passwd.png \
		sc-gpgee-ctxmenu.png sc-gpgee-signmenu.png \
		sc-gpa-gen-backup.png sc-gpa-gen-backup-warn.png \
		sc-gpgol-options.png sc-gpgol-noword.png \
		sc-en-inst-welcome.png sc-en-inst-license.png \
		sc-en-inst-components.png sc-en-inst-directory.png \
		sc-en-inst-options.png \
		sc-en-inst-startmenu.png sc-en-inst-ready.png \
		sc-en-inst-finished.png \
		sc-en-gpa-gen-backup.png sc-en-gpa-gen-backup-warn.png \
		sc-en-gpa-first-key.png sc-en-gpa-gen-email.png \
		sc-en-gpa-gen-name.png sc-en-gpa-gen-passwd.png \
		sc-en-gpa-ks-export-p.png sc-en-gpa-nokey.png \
		sc-en-gpa-rungpa.png sc-en-gpa-two-keys.png


web_png_files = blank.png next.png previous.png up.png \
                 home.png nonext.png noprevious.png noup.png


eps_files = adele01.eps.gz adele02.eps.gz man-with-signed-key.eps.gz \
            egyptian-stone.eps.gz sealed-envelope.eps.gz \
	    schlapphut-with-key.eps.gz tangled-schlapphut.eps.gz \
	    verleihnix.eps.gz key-with-shadow-bit.eps.gz \
            letter-into-safe.eps.gz letter-out-of-safe.eps.gz \
            secret-key-exchange.eps.gz pk-safe-open.eps.gz \
            pk-safe-opened-with-sk.eps.gz think-passphrase.eps.gz \
            keyserver-world.eps.gz key-with-sigs.eps.gz \
	    clock-face.eps.gz mileage-indicator.eps.gz \
	    table-1.eps.gz table-2.eps.gz table-3.eps.gz \
            sc-gpa-first-key.eps.gz \
            sc-gpa-gen-email.eps.gz sc-gpa-gen-name.eps.gz \
            sc-gpa-gen-passwd.eps.gz sc-gpa-nokey.eps.gz \
            sc-gpa-rungpa.eps.gz sc-gpa-ks-export-p.eps.gz \
            sc-gpa-two-keys.eps.gz \
            sc-ol-send-test-key.eps.gz sc-ol-send-enc-msg1.eps.gz \
            sc-ol-send-enc-msg2.eps.gz \
            sc-gpgol-set-icon.eps.gz \
            sc-winpt-startmenu.eps.gz sc-winpt-trayicon.eps.gz \
	    sc-winpt-clip-decrypt.eps.gz sc-winpt-good-sig.eps.gz \
            sc-winpt-sel-enc-key.eps.gz sc-winpt-enctoself.eps.gz \
	    sc-misc-mein-key-asc.eps.gz \
            openpgp-icon.eps.gz smime-icon.eps.gz

eps_files_bb  = $(eps_files:.gz=.bb)
eps_files_png  = $(eps_files:.eps.gz=.png)
#eps_files_pdf = $(eps_files:.eps.gz=.pdf)
png_files_eps = $(png_files:.png=.eps) 

EXTRA_DIST = fdl.tex fdl-book.tex gpg4win-compendium-de.tex \
	     einsteiger.tex durchblicker.tex novices.tex \
	     $(eps_files) $(png_files) $(web_png_files) \
	     was-ist-gpg4win.tex what-is-gpg4win.tex \
             macros.tex macros-en.tex version.tex.in \
	     gpg4win-logo.eps gpg4win-logo.png
# advanced.tex

CLEANFILES = $(eps_files_bb) $(png_files_eps) \
             *.dvi *.pdf *.pdf *.toc *.log *.aux *.out \
	     gpg4win-compendium-de.html.d/*
DISTCLEANFILES = version.tex $(eps_files_png)

pkgdata_DATA = gpg4win-compendium-de.pdf novices.pdf 
# advanced.pdf

BUILT_SOURCES = $(eps_files_bb) $(png_files_eps) $(eps_files_png)

all-local: gpg4win-compendium-de.pdf novices.pdf \
	   gpg4win-compendium-de.html.d
# advanced.pdf


gpg4win-compendium-de.pdf : $(eps_files_bb) $(png_files_eps) $(eps_files_png)
gpg4win-compendium-de.dvi : version.tex macros.tex $(eps_files_bb)
gpg4win-compendium-de.html : version.tex macros.tex $(eps_files_png)
einsteiger.pdf : $(eps_files_bb) $(png_files_eps) $(eps_files_png)
einsteiger.dvi : version.tex macros.tex $(eps_files_bb)
einsteiger.html : version.tex macros.tex $(eps_files_png)
durchblicker.pdf : $(eps_files_bb) $(png_files_eps) $(eps_files_png)
durchblicker.dvi : version.tex macros.tex $(eps_files_bb)
durchblicker.html : version.tex macros.tex $(eps_files_png)
novices.pdf : $(eps_files_bb) $(png_files_eps) $(eps_files_png)
novices.dvi : version.tex macros-en.tex $(eps_files_bb) $(eps_files_png)
novices.html : version.tex macros-en.tex $(eps_files_png)
#advanced.pdf : $(eps_files_bb) $(png_files_eps) $(eps_files_png)
#advanced.dvi : version.tex macros-en.tex $(eps_files_bb)
#advanced.html : version.tex macros-en.tex $(eps_files_png)

# Note:  This is only used for the old manuals.
htmlversion:  einsteiger.html durchblicker.html novices.html
	rm -rf html
	mkdir html
	cp einsteiger*.html durchblicker*.html novices*.html html/
	cp $(web_png_files) $(png_files) $(eps_files_png) \
	 gpg4win-logo.png html/

online: htmlversion gpg4win-compendium-de.html.d
	set -e; \
	echo "Going to put current manuals online for www.gpg4win.org ..."; \
        user=`svn info | sed -n '/^URL:/ s,.*svn+ssh://\\([^@]*\\).*,\\1,p'`;\
	( cd html ; rsync -v * \
	  $${user}@wald.intevation.org:/gpg4win/htdocs/handbuecher/ )
	( cd gpg4win-compendium-de.html.d ; rsync -v * \
	  $${user}@wald.intevation.org:/gpg4win/htdocs/handbuecher/ )

preview: htmlversion
	set -e; \
	echo "Rsyncing the HTML manuals to the preview host ..."; \
	( cd html ; rsync -v * ${PREVIEWHOST}/ )

%.eps.bb : %.eps.gz
	$(ZCAT) `test -f '$<' || echo '$(srcdir)/'`$< \
          | grep '^%%BoundingBox' | head -1 > $@

%.eps : %.png
	$(CONVERT) `test -f '$<' || echo '$(srcdir)/'`$< $@

%.png : %.eps.gz
	$(CONVERT) -density 100x100 `test -f '$<' || echo '$(srcdir)/'`$< $@

%.dvi : %.tex
	$(TEXI2DVI) `test -f '$<' || echo '$(srcdir)/'`$< 

%.pdf : %.dvi
	TEXPICTS=$(srcdir) $(DVIPDF)  $< $@

#%.pdf : %.eps.gz
#	$(ZCAT) `test -f '$<' || echo '$(srcdir)/'`$< \
#         | epstopdf -f > $@

%.html : %.tex
	hyperlatex $<


# The html.d directories are used to collect all relevant files for
# the NSI scripts.  Fixme: We should better use proper installation
# directories with the internal packages as well.
%.html.d-stamp : %.html
	@rm -f $@.tmp
	@touch $@.tmp
	-rm -rf $@
	mkdir $@
	(src=$$(echo $@ | sed 's/.html.d$$/.tex/'); \
         echo $@ | sed  's/.d$$//'; \
         LC_CTYPE=C sed -n 's/.*\\xname{\([^}]*\).*/\1.html/p' $$src;\
         LC_CTYPE=C sed -n 's/.*\\IncludeImage\[.*\]){\([^}]*\).*/\1.png/p' \
                  $$src;\
         LC_CTYPE=C sed -n 's/.*\\IncludeImage{\([^}]*\).*/\1.png/p' $$src \
	) | sort | uniq | xargs $(INSTALL_DATA) -t $@ 
	@mv -f $@.tmp $@

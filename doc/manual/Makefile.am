# Makefile.am - Building the manuals
# Copyright (C) 2005, 2008 g10 Code GmbH
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

PDFLATEX = pdflatex

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
		sc-kleopatra-withOpenpgpTestkey_de.png\
		sc-kleopatra-withAdeleKey_de.png\
		sc-kleopatra-openpgp-certificateDetails_de.png\
		sc-kleopatra-x509-personalDetails_de.png\
		sc-kleopatra-x509-reviewParameters_de.png\
		sc-kleopatra-x509-createKey_de.png\
		sc-kleopatra-x509-pinentry_de.png\
		sc-kleopatra-x509-keyPairCreated_de.png\
		sc-kleopatra-exportCertificateToServer_de.png\
		sc-kleopatra-certificateSearchOnKeyserver_de.png\
		sc-kleopatra-verifySignedMail_de.png \
		sc-kleopatra-certifyCertificate1_de.png \
		sc-kleopatra-certifyCertificate2_de.png \
		sc-kleopatra-certifyCertificate3_de.png \
		sc-kleopatra-configureKeyserver_de.png\
		sc-ol-adele-sendOpenpgpKey-inline_de.png\
		sc-ol-adele-sendOpenpgpKey-attachment_de.png\
		sc-kleopatra-import-certificate_de.png\
		sc-kleopatra-import-openpgp-secret-key_de.png\
		sc-kleopatra-encryption-chooseOpenpgpCertificate_de.png\
		sc-kleopatra-encryption-successful_de.png\
		sc-kleopatra-format-choice_de.png\
		sc-kleopatra-sign-selectCertificate_de.png\
		sc-kleopatra-encrypt-selectCertificate_de.png\
		sc-ol-sendEncryptedMail_de.png\
		sc-ol-sendSignedMail_de.png\
		sc-gpgol-options_de.png\
		sc-gpgol-options-textformat_de.png\
		sc-kleopatra-sign-OpenpgpPinentry_de.png\
		sc-kleopatra-sign-successful_de.png\
		sc-kleopatra-encryptFile1_de.png\
		sc-kleopatra-encryptFile2_de.png\
		sc-kleopatra-encryptFile3_de.png\
		sc-kleopatra-signFile1_de.png\
		sc-kleopatra-signFile2_de.png\
		sc-kleopatra-signFile3_de.png\
		sc-kleopatra-decryptFile1_de.png\
		sc-kleopatra-decryptFile2_de.png\
		sc-kleopatra-verifyFile1_de.png\
		sc-kleopatra-verifyFile2_de.png\
		sc-kleopatra-verifyFile2a-badSignature_de.png\
		sc-gpgex-contextmenu-signEncrypt_de.png\
		sc-gpgex-contextmenu-verifyDecrypt_de.png\
		sc-wordpad-editOpenpgpKey_de.png\
		sc-pinentry-p12-import-a_de.png\
		sc-pinentry-p12-import-b_de.png\
		sc-inst-language_de.png\
		sc-inst-welcome_de.png\
		sc-inst-license_de.png \
		sc-inst-components_de.png \
		sc-inst-directory_de.png \
		sc-inst-options_de.png \
		sc-inst-startmenu_de.png \
		sc-inst-ready_de.png \
		sc-inst-progress_de.png \
		sc-inst-finished_de.png \
		sc-inst-finished2_de.png \
		openpgp-icon.png \
		smime-icon.png \
		\
		adele01.png \
		adele02.png \
		clock-face.png \
		egyptian-stone.png \
		keyserver-world.png \
		key-with-shadow-bit.png \
		key-with-sigs.png \
		letter-into-safe.png \
		letter-out-of-safe.png \
		man-with-signed-key.png \
		mileage-indicator.png \
		pk-safe-opened-with-sk.png \
		pk-safe-open.png \
		schlapphut-with-key.png \
		sealed-envelope.png \
		secret-key-exchange.png \
		tangled-schlapphut.png \
		think-passphrase.png \
		verleihnix.png \
		\
		table-1.png table-2.png table-3.png \
        sc-gpa-first-key.png \
        sc-gpa-gen-email.png sc-gpa-gen-name.png \
        sc-gpa-gen-passwd.png sc-gpa-nokey.png \
        sc-gpa-rungpa.png sc-gpa-ks-export-p.png \
        sc-gpa-two-keys.png \
        sc-ol-send-test-key.png sc-ol-send-enc-msg1.png \
        sc-ol-send-enc-msg2.png \
        sc-gpgol-set-icon.png \
        sc-winpt-startmenu.png sc-winpt-trayicon.png \
	   	sc-winpt-clip-decrypt.png sc-winpt-good-sig.png \
        sc-winpt-sel-enc-key.png sc-winpt-enctoself.png \
	   	sc-misc-mein-key-asc.png \
		sc-inst-welcome.png \
		sc-inst-finished2.png \
		sc-winpt-sign-passwd.png \
		sc-gpgee-ctxmenu.png \
		sc-gpgee-signmenu.png \
		sc-gpa-gen-backup.png \
	   	sc-gpa-gen-backup-warn.png \
		sc-gpgol-options.png \
		sc-gpgol-noword.png \
		sc-en-inst-welcome.png \
		sc-en-inst-license.png \
		sc-en-inst-components.png \
		sc-en-inst-directory.png \
		sc-en-inst-options.png \
		sc-en-inst-startmenu.png \
		sc-en-inst-ready.png \
		sc-en-inst-finished.png \
		sc-en-gpa-gen-backup.png \
		sc-en-gpa-gen-backup-warn.png \
		sc-en-gpa-first-key.png \
	   	sc-en-gpa-gen-email.png \
		sc-en-gpa-gen-name.png \
		sc-en-gpa-gen-passwd.png \
		sc-en-gpa-ks-export-p.png \
		sc-en-gpa-nokey.png \
		sc-en-gpa-rungpa.png \
	   	sc-en-gpa-two-keys.png

web_png_files = blank.png next.png previous.png up.png \
                home.png nonext.png noprevious.png noup.png

eps_files = $(png_files:.png=.eps)


EXTRA_DIST = gpg4win-compendium-de.tex \
				fdl.tex fdl-book.tex version.tex.in  \
		  		$(eps_files) $(png_files) $(web_png_files) \
				gpg4win-logo.eps gpg4win-logo.png \
				# needed for Englisch novices manual:
	     		novices.tex what-is-gpg4win.tex macros-en.tex \
				# needed for (old) German manuals: \
				# einsteiger.tex durchblicker.tex was-ist-gpg4win.tex macros.tex

CLEANFILES = $(eps_files) \
             *.dvi *.pdf *.pdf *.toc *.log *.aux *.out \
	     	 *.html.d-stamp  *.html.d/*
DISTCLEANFILES = version.tex

pkgdata_DATA = 	gpg4win-compendium-de.pdf \
				novices.pdf 

BUILT_SOURCES = $(png_files) 

all-local: 	gpg4win-compendium-de.pdf \
	   		gpg4win-compendium-de.html.d-stamp \
			novices.pdf

gpg4win-compendium-de.pdf : version.tex
gpg4win-compendium-de.dvi : eps version.tex
gpg4win-compendium-de.html.d-stamp : version.tex 
einsteiger.dvi : version.tex macros.tex $(eps_files)
einsteiger.html.d-stamp : version.tex macros.tex $(eps_files)
durchblicker.dvi : version.tex macros.tex $(eps_files)
durchblicker.html.d-stamp : version.tex macros.tex 
novices.dvi : version.tex macros-en.tex $(eps_files)
novices.html.d-stamp : version.tex macros-en.tex 


%.eps : %.png
	$(CONVERT) $< eps2:$@

eps: $(eps_files)

%.dvi : %.tex 
	$(TEXI2DVI) `test -f '$<' || echo '$(srcdir)/'`$< 

%.pdf : %.tex
	$(PDFLATEX) $<

pdf-de: gpg4win-compendium-de.pdf

dvi-de: gpg4win-compendium-de.dvi

html-de: gpg4win-compendium-de.html.d-stamp

# The html.d directories are used to collect all relevant files for
# the NSI scripts.  This is also required because hyperlatex is not
# able to work in VPATH environment. 
%.html.d-stamp : %.tex
	@rm -f $@.tmp
	@touch $@.tmp
	set -e; LC_CTYPE=C; export LC_CTYPE; \
         src=$$(test -f '$<' || echo '$(srcdir)/')$< ; \
	 wdir=$$(echo $@ | sed  's/.d-stamp$$/.d/') ; \
         rm -rf $$wdir || true;\
         mkdir $$wdir;\
         files=$$( (echo $$src; \
            sed -n 's/.*\\IncludeImage\[.*\]{\([^}]*\).*/\1.png/p' $$src;\
            sed -n 's/.*\\IncludeImage{\([^}]*\).*/\1.png/p' $$src ;\
            sed -n 's/.*\\input{\([^}]*\).*/\1/p' $$src ) \
          | sort | uniq) ;\
	 for f in $$files $(web_png_files); do \
	   if [ -f "$$f" ]; then cp "$$f" $$wdir ;\
	   elif [ -f "$(srcdir)/$$f" ]; then cp "$(srcdir)/$$f" $$wdir ;\
	   fi ;\
         done ;\
         cd $$wdir ;\
	 hyperlatex $$(basename $$src) ;\
	 for f in $$files; do \
	    x=$$(basename "$$f") ;\
	    case $$x in *.png) : ;; *) rm -f $$x ;; esac ;\
	 done
	@mv -f $@.tmp $@

online: gpg4win-compendium-de.html.d-stamp novices.html.d-stamp
	set -e; \
	echo "Going to put current manuals online for www.gpg4win.org ..."; \
        user=`svn info | sed -n '/^URL:/ s,.*svn+ssh://\\([^@]*\\).*,\\1,p'`;\
	for d in $^; do \
          (x=$$(echo $$d | sed  's/.d-stamp$$/.d/') ;\
	   echo "Cding to: $$x";\
           cd $$x ;\
           rsync -v * \
             $${user}@wald.intevation.org:/gpg4win/htdocs/handbuecher/ ); \
	done

preview: gpg4win-compendium-de.html.d-stamp novices.html.d-stamp
	set -e; \
	echo "Rsyncing the HTML manuals to the preview host ..."; \
	for d in $^; do \
          (x=$$(echo $$d | sed  's/.d-stamp$$/.d/') ;\
	   echo "cd to $$x" ;\
           cd $$x ;\
           rsync -v * ${PREVIEWHOST}/ ) ;\
	done

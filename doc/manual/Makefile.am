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

TEXI2PDF = texi2pdf
INDEX = makeindex
HYPERLATEX = hyperlatex
HTML_DIR = compendium-html

png_compendium_files = \
	images-compendium/adele01.png \
	images-compendium/adele02.png \
	images-compendium/clock-face.png \
	images-compendium/egyptian-stone.png \
	images-compendium/gpg4win-logo.png \
	images-compendium/keyserver-world.png \
	images-compendium/key-with-shadow-bit.png \
	images-compendium/key-with-sigs.png \
	images-compendium/letter-into-safe.png \
	images-compendium/letter-out-of-safe.png \
	images-compendium/man-with-signed-key.png \
	images-compendium/mileage-indicator.png \
	images-compendium/openpgp-icon.png \
	images-compendium/pk-safe-opened-with-sk.png \
	images-compendium/pk-safe-open.png \
	images-compendium/sc-gpgex-contextmenu-signEncrypt_de.png \
	images-compendium/sc-gpgex-contextmenu-signEncrypt_en.png \
	images-compendium/sc-gpgex-contextmenu-verifyDecrypt_de.png \
	images-compendium/sc-gpgex-contextmenu-verifyDecrypt_en.png \
	images-compendium/sc-gpgol-options_de.png \
	images-compendium/sc-gpgol-options_en.png \
	images-compendium/sc-gpgol-options-textformat_de.png \
	images-compendium/sc-gpgol-options-textformat_en.png \
	images-compendium/schlapphut-with-key.png \
	images-compendium/sc-inst-components_de.png \
	images-compendium/sc-inst-components_en.png \
	images-compendium/sc-inst-directory_de.png \
	images-compendium/sc-inst-directory_en.png \
	images-compendium/sc-inst-finished2_de.png \
	images-compendium/sc-inst-finished2_en.png \
	images-compendium/sc-inst-finished_de.png \
	images-compendium/sc-inst-finished_en.png \
	images-compendium/sc-inst-language_de.png \
	images-compendium/sc-inst-language_en.png \
	images-compendium/sc-inst-license_de.png \
	images-compendium/sc-inst-license_en.png \
	images-compendium/sc-inst-options_de.png \
	images-compendium/sc-inst-options_en.png \
	images-compendium/sc-inst-progress_de.png \
	images-compendium/sc-inst-progress_en.png \
	images-compendium/sc-inst-ready_de.png \
	images-compendium/sc-inst-startmenu_de.png \
	images-compendium/sc-inst-startmenu_en.png \
	images-compendium/sc-inst-welcome_de.png \
	images-compendium/sc-inst-welcome_en.png \
	images-compendium/sc-kleopatra-certificateSearchOnKeyserver_de.png \
	images-compendium/sc-kleopatra-certificateSearchOnKeyserver_en.png \
	images-compendium/sc-kleopatra-certifyCertificate1_de.png \
	images-compendium/sc-kleopatra-certifyCertificate1_en.png \
	images-compendium/sc-kleopatra-certifyCertificate2_de.png \
	images-compendium/sc-kleopatra-certifyCertificate2_en.png \
	images-compendium/sc-kleopatra-certifyCertificate3_de.png \
	images-compendium/sc-kleopatra-certifyCertificate3_en.png \
	images-compendium/sc-kleopatra-ChooseCertificateFormat_de.png \
	images-compendium/sc-kleopatra-ChooseCertificateFormat_en.png \
	images-compendium/sc-kleopatra-configureKeyserver_de.png \
	images-compendium/sc-kleopatra-configureKeyserver_en.png \
	images-compendium/sc-kleopatra-decryptFile1_de.png \
	images-compendium/sc-kleopatra-decryptFile1_en.png \
	images-compendium/sc-kleopatra-decryptFile2_de.png \
	images-compendium/sc-kleopatra-decryptFile2_en.png \
	images-compendium/sc-kleopatra-encryptFile1_de.png \
	images-compendium/sc-kleopatra-encryptFile1_en.png \
	images-compendium/sc-kleopatra-encryptFile2_de.png \
	images-compendium/sc-kleopatra-encryptFile2_en.png \
	images-compendium/sc-kleopatra-encryptFile3_de.png \
	images-compendium/sc-kleopatra-encryptFile3_en.png \
	images-compendium/sc-kleopatra-encryption-chooseOpenpgpCertificate_de.png \
	images-compendium/sc-kleopatra-encryption-successful_de.png \
	images-compendium/sc-kleopatra-encrypt-selectCertificate_de.png \
	images-compendium/sc-kleopatra-encrypt-selectCertificate_en.png \
	images-compendium/sc-kleopatra-exportCertificateToServer_de.png \
	images-compendium/sc-kleopatra-exportCertificateToServer_en.png \
	images-compendium/sc-kleopatra-format-choice_de.png \
	images-compendium/sc-kleopatra-import-certificate_de.png \
	images-compendium/sc-kleopatra-import-certificate_en.png \
	images-compendium/sc-kleopatra-import-openpgp-secret-key_de.png \
	images-compendium/sc-kleopatra-import-openpgp-secret-key_en.png \
	images-compendium/sc-kleopatra-mainwindow-empty_de.png \
	images-compendium/sc-kleopatra-mainwindow-empty_en.png \
	images-compendium/sc-kleopatra-openpgp-certificateDetails_de.png \
	images-compendium/sc-kleopatra-openpgp-certificateDetails_en.png \
	images-compendium/sc-kleopatra-openpgp-createKey_de.png \
	images-compendium/sc-kleopatra-openpgp-createKey_en.png \
	images-compendium/sc-kleopatra-openpgp-exportSecretKey_de.png \
	images-compendium/sc-kleopatra-openpgp-exportSecretKey_en.png \
	images-compendium/sc-kleopatra-openpgp-keyPairCreated_de.png \
	images-compendium/sc-kleopatra-openpgp-keyPairCreated_en.png \
	images-compendium/sc-kleopatra-openpgp-personalDetails_de.png \
	images-compendium/sc-kleopatra-openpgp-personalDetails_en.png \
	images-compendium/sc-kleopatra-openpgp-pinentry_de.png \
	images-compendium/sc-kleopatra-openpgp-pinentry_en.png \
	images-compendium/sc-kleopatra-openpgp-reviewParameters_de.png \
	images-compendium/sc-kleopatra-openpgp-reviewParameters_en.png \
	images-compendium/sc-kleopatra-signEncryptFile2_de.png \
	images-compendium/sc-kleopatra-signFile1_de.png \
	images-compendium/sc-kleopatra-signFile1_en.png \
	images-compendium/sc-kleopatra-signFile2_de.png \
	images-compendium/sc-kleopatra-signFile2_en.png \
	images-compendium/sc-kleopatra-signFile3_de.png \
	images-compendium/sc-kleopatra-signFile3_en.png \
	images-compendium/sc-kleopatra-sign-OpenpgpPinentry_de.png \
	images-compendium/sc-kleopatra-sign-OpenpgpPinentry_en.png \
	images-compendium/sc-kleopatra-sign-selectCertificate_de.png \
	images-compendium/sc-kleopatra-sign-selectCertificate_en.png \
	images-compendium/sc-kleopatra-sign-successful_de.png \
	images-compendium/sc-kleopatra-startmenu_de.png \
	images-compendium/sc-kleopatra-startmenu_en.png \
	images-compendium/sc-kleopatra-verifyFile1_de.png \
	images-compendium/sc-kleopatra-verifyFile1_en.png \
	images-compendium/sc-kleopatra-verifyFile2a-badSignature_de.png \
	images-compendium/sc-kleopatra-verifyFile2a-badSignature_en.png \
	images-compendium/sc-kleopatra-verifyFile2_de.png \
	images-compendium/sc-kleopatra-verifyFile2_en.png \
	images-compendium/sc-kleopatra-verifySignedMail_de.png \
	images-compendium/sc-kleopatra-verifySignedMail_en.png \
	images-compendium/sc-kleopatra-withAdeleKey_de.png \
	images-compendium/sc-kleopatra-withAdeleKey_en.png \
	images-compendium/sc-kleopatra-withOpenpgpTestkey_de.png \
	images-compendium/sc-kleopatra-withOpenpgpTestkey_en.png \
	images-compendium/sc-kleopatra-x509-createKey_de.png \
	images-compendium/sc-kleopatra-x509-createKey_en.png \
	images-compendium/sc-kleopatra-x509-keyPairCreated_de.png \
	images-compendium/sc-kleopatra-x509-keyPairCreated_en.png \
	images-compendium/sc-kleopatra-x509-personalDetails_de.png \
	images-compendium/sc-kleopatra-x509-personalDetails_en.png \
	images-compendium/sc-kleopatra-x509-pinentry_de.png \
	images-compendium/sc-kleopatra-x509-pinentry_en.png \
	images-compendium/sc-kleopatra-x509-reviewParameters_de.png \
	images-compendium/sc-kleopatra-x509-reviewParameters_en.png \
	images-compendium/sc-ol-adele-sendOpenpgpKey-attachment_de.png \
	images-compendium/sc-ol-adele-sendOpenpgpKey-attachment_en.png \
	images-compendium/sc-ol-adele-sendOpenpgpKey-inline_de.png \
	images-compendium/sc-ol-adele-sendOpenpgpKey-inline_en.png \
	images-compendium/sc-ol-sendEncryptedMail_de.png \
	images-compendium/sc-ol-sendEncryptedMail_en.png \
	images-compendium/sc-ol-sendSignedMail_de.png \
	images-compendium/sc-ol-sendSignedMail_en.png \
	images-compendium/sc-pinentry-p12-import-a_de.png \
	images-compendium/sc-pinentry-p12-import-a_en.png \
	images-compendium/sc-pinentry-p12-import-b_de.png \
	images-compendium/sc-pinentry-p12-import-b_en.png \
	images-compendium/sc-wordpad-editOpenpgpKey_de.png \
	images-compendium/sc-wordpad-editOpenpgpKey_en.png \
	images-compendium/sealed-envelope.png \
	images-compendium/secret-key-exchange.png \
	images-compendium/smime-icon.png \
	images-compendium/tangled-schlapphut.png \
	images-compendium/think-passphrase.png \
	images-compendium/verleihnix.png \
	images-compendium/sc-inst-uat_de.png \
	images-compendium/sc-kleopatra-importKeyQuestion_de.png \
	images-compendium/sc-kleopatra-paperkey1_de.png \
	images-compendium/sc-kleopatra-publishKey1_de.png \
	images-compendium/sc-kleopatra-publishKey_de.png \
	images-compendium/sc-kleopatra-searchKeyEdward_de.png \
	images-compendium/sc-kleopatra-smartCard1_de.png \
	images-compendium/sc-kleopatra-smartCard2_de.png \
	images-compendium/sc-kleopatra-smartCard3_de.png \
	images-compendium/sc-kleopatra-smartCard4_de.png

png_manual_files = \
	images-manual/adele01.png \
	images-manual/adele02.png \
	images-manual/clock-face.png \
	images-manual/egyptian-stone.png \
	images-manual/gpg4win-logo.png \
	images-manual/keyserver-world.png \
	images-manual/key-with-shadow-bit.png \
	images-manual/key-with-sigs.png \
	images-manual/letter-into-safe.png \
	images-manual/letter-out-of-safe.png \
	images-manual/man-with-signed-key.png \
	images-manual/mileage-indicator.png \
	images-manual/openpgp-icon.png \
	images-manual/pk-safe-opened-with-sk.png \
	images-manual/pk-safe-open.png \
	images-manual/sc-en-gpa-first-key.png \
	images-manual/sc-en-gpa-gen-backup.png
	images-manual/sc-en-gpa-gen-backup-warn.png \
	images-manual/sc-en-gpa-gen-email.png \
	images-manual/sc-en-gpa-gen-name.png \
	images-manual/sc-en-gpa-gen-passwd.png \
	images-manual/sc-en-gpa-ks-export-p.png \
	images-manual/sc-en-gpa-nokey.png \
	images-manual/sc-en-gpa-rungpa.png \
	images-manual/sc-en-gpa-two-keys.png \
	images-manual/sc-en-inst-components.png \
	images-manual/sc-en-inst-directory.png \
	images-manual/sc-en-inst-finished.png \
	images-manual/sc-en-inst-license.png \
	images-manual/sc-en-inst-options.png \
	images-manual/sc-en-inst-ready.png \
	images-manual/sc-en-inst-startmenu.png \
	images-manual/sc-en-inst-welcome.png \
	images-manual/sc-gpa-fihrst-key.png \
	images-manual/sc-gpa-genn-backup.png \
	images-manual/sc-gpa-genn-backup-warn.png \
	images-manual/sc-gpa-genn-email.png \
	images-manual/sc-gpa-genn-name.png \
	images-manual/sc-gpa-gepn-passwd.png \
	images-manual/sc-gpa-ksu-export-p.png \
	images-manual/sc-gpa-nokey.png \
	images-manual/sc-gpa-rungpa.png \
	images-manual/sc-gpa-two-keys.png \
	images-manual/sc-gpgee-ctxmenu.png \
	images-manual/sc-gpgee-signmenu.png \
	images-manual/sc-gpgol-icons-es.png \
	images-manual/sc-gpgol-menu-es.png \
	images-manual/sc-gpgol-noword.png \
	images-manual/sc-gpgol-options.png \
	images-manual/sc-gpgol-set-icon.png \
	images-manual/schlapphut-with-key.png \
	images-manual/sc-inst-components.png \
	images-manual/sc-inst-directory.png \
	images-manual/sc-inst-finished2.png \
	images-manual/sc-inst-finished.png \
	images-manual/sc-inst-license.png \
	images-manual/sc-inst-options.png \
	images-manual/sc-inst-ready.png \
	images-manual/sc-inst-startmenu.png \
	images-manual/sc-inst-welcome.png \
	images-manual/sc-misc-mein-key-asc.png \
	images-manual/sc-ol-send-enc-msg1.png \
	images-manual/sc-ol-send-enc-msg2.png \
	images-manual/sc-ol-send-test-key.png \
	images-manual/sc-winpt-clip-decrypt.png \
	images-manual/sc-winpt-enctoself.png \
	images-manual/sc-winpt-good-sig.png \
	images-manual/sc-winpt-sel-enc-key.png \
	images-manual/sc-winpt-sign-passwd.png \
	images-manual/sc-winpt-startmenu.png \
	images-manual/sc-winpt-trayicon.png \
	images-manual/sealed-envelope.png \
	images-manual/secret-key-exchange.png \
	images-manual/smime-icon.png \
	images-manual/table-1.png \
	images-manual/table-2.png \
	images-manual/table-3.png \
	images-manual/tangled-schlapphut.png \
	images-manual/think-passphrase.png \
	images-manual/verleihnix.png

png_hyperlatex_files = \
	images-hyperlatex/blank.png \
	images-hyperlatex/home.png \
	images-hyperlatex/next.png \
	images-hyperlatex/nonext.png \
	images-hyperlatex/noprevious.png \
	images-hyperlatex/noup.png \
	images-hyperlatex/previous.png \
	images-hyperlatex/up.png \
	images-hyperlatex/german.png \
	images-hyperlatex/english.png

eps_compendium_files = $(png_compendium_files:%.png=%.eps)
eps_manual_files = $(png_manual_files:.png=.eps)


EXTRA_DIST = 	gpg4win-compendium-de.tex \
		gpg4win-compendium-en.tex \
		fdl.tex fdl-book.tex version.tex.in indexstyle.ist \
		hyperlatex.sty \
		$(png_compendium_files) $(png_hyperlatex_files)

CLEANFILES = $(eps_compendium_files) $(eps_manual_files) \
             *.dvi *.pdf *.pdf *.toc *.log *.aux *.out *.idx *.ilg *.ind \
	     	 *.html *.html.d-stamp* *.html.d $(HTML_DIR)
DISTCLEANFILES = version.tex

pkgdata_DATA = 	gpg4win-compendium-de.pdf \
				gpg4win-compendium-en.pdf

BUILT_SOURCES = $(png_compendium_files)

all-local: 	gpg4win-compendium-de.pdf \
		gpg4win-compendium-en.pdf

gpg4win-compendium-de.pdf : version.tex
gpg4win-compendium-en.pdf : version.tex
gpg4win-compendium-de.dvi : version.tex $(eps_compendium_files)
gpg4win-compendium-en.dvi : version.tex $(eps_compendium_files)
gpg4win-compendium-de.html.d-stamp : version.tex
gpg4win-compendium-en.html.d-stamp : version.tex

einsteiger.dvi : version.tex macros.tex $(eps_manual_files)
einsteiger.html.d-stamp : version.tex macros.tex $(eps_manual_files)
durchblicker.dvi : version.tex macros.tex $(eps_manual_files)
durchblicker.html.d-stamp : version.tex macros.tex
novices.dvi : version.tex macros-en.tex $(eps_manual_files)
novices.html.d-stamp : version.tex macros-en.tex


%.eps : %.png
	$(CONVERT) $< eps2:$@

%.dvi : %.tex
	export MAKEINDEX='makeindex -g -s indexstyle.ist'; \
	$(TEXI2DVI) `test -f '$<' || echo '$(srcdir)/'`$<

%.pdf : %.tex
	export MAKEINDEX='makeindex -g -s indexstyle.ist'; \
	$(TEXI2PDF) $<

pdf-de: gpg4win-compendium-de.pdf
pdf-en: gpg4win-compendium-en.pdf

dvi-de: gpg4win-compendium-de.dvi
dvi-en: gpg4win-compendium-en.dvi


cleanhtml:
	rm -rf $(HTML_DIR)

html: 	cleanhtml html-de html-en html-images

html-de:
	$(HYPERLATEX) gpg4win-compendium-de

html-en:
	$(HYPERLATEX) gpg4win-compendium-en

html-images:
	mkdir -p $(HTML_DIR)/images-hyperlatex;\
	for f in $(png_hyperlatex_files); do \
		if [ -f "$$f" ]; then cp "$$f" $(HTML_DIR)/images-hyperlatex ;\
		elif [ -f "$(srcdir)/$$f" ]; then cp "$(srcdir)/$$f" $(HTML_DIR)/images-hyperlatex ;\
		fi ;\
	done ;\
	mkdir -p $(HTML_DIR)/images-compendium;\
	for f in $(png_compendium_files); do \
		if [ -f "$$f" ]; then cp "$$f" $(HTML_DIR)/images-compendium ;\
		elif [ -f "$(srcdir)/$$f" ]; then cp "$(srcdir)/$$f" $(HTML_DIR)/images-compendium ;\
		fi ;\
	done


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
	 for f in $$files; do \
	   if [ -f "$$f" ]; then cp "$$f" $$wdir ;\
	   elif [ -f "$(srcdir)/$$f" ]; then cp "$(srcdir)/$$f" $$wdir ;\
	   fi ;\
     done ;\
	 mkdir $$wdir/images-hyperlatex;\
	 for f in $(png_hyperlatex_files); do \
	   if [ -f "$$f" ]; then cp "$$f" $$wdir/images-hyperlatex ;\
	   elif [ -f "$(srcdir)/$$f" ]; then cp "$(srcdir)/$$f" $$wdir/images-hyperlatex ;\
	   fi ;\
     done ;\
	 mkdir $$wdir/images-compendium;\
	 for f in $(png_compendium_files); do \
	   if [ -f "$$f" ]; then cp "$$f" $$wdir/images-compendium ;\
	   elif [ -f "$(srcdir)/$$f" ]; then cp "$(srcdir)/$$f" $$wdir/images-compendium ;\
	   fi ;\
     done ;\
     cd $$wdir ;\
	 hyperlatex $$(basename $$src) ;\
	 for f in $$files; do \
	    x=$$(basename "$$f") ;\
	    case $$x in *.png) : ;; *) rm -f $$x ;; esac ;\
	 done ;\
	 @mv -f $@.tmp $@

online: html
	set -e; \
	echo "Going to put current compendium-html online for www.gpg4win.org ..."; \
	user=`svn info | sed -n '/^URL:/ s,.*svn+ssh://\\([^@]*\\).*,\\1,p'`;\
	echo user;\
	rsync -rvz --delete $(HTML_DIR)/ $${user}@wald.intevation.org:/gpg4win/htdocs/doc/

onlinedryrun: html
	set -e; \
	echo "(DRY RUN) Going to put current compendium-html online for www.gpg4win.org ..."; \
	user=`svn info | sed -n '/^URL:/ s,.*svn+ssh://\\([^@]*\\).*,\\1,p'`;\
	echo user;\
	rsync -rvzn --delete $(HTML_DIR)/ $${user}@wald.intevation.org:/gpg4win/htdocs/doc/


preview: gpg4win-compendium-de.html.d-stamp gpg4win-compendium-en.html.d-stamp
	set -e; \
	echo "Rsyncing the HTML manuals to the preview host ..."; \
	for d in $^; do \
          (x=$$(echo $$d | sed  's/.d-stamp$$/.d/') ;\
	   echo "cd to $$x" ;\
           cd $$x ;\
           rsync -v * ${PREVIEWHOST}/ ) ;\
	done

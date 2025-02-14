# Makefile.am - Simple Makefile for our translations
# Copyright (C) 2025 g10 Code GmbH
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
# along with this program; if not, see <http://www.gnu.org/licenses/>.
#
# NB: We do not use the usual GNU gettext make framework because all
#     we need to do here is to create NSIS files from po file for the
#     translations of the NSIS installer.  Translations for the MSI
#     installer are anyway done in a different way.  We require
#     gettext development packages on the host system and of course
#     GNU make like with all gpg4win Makefiles.

EXTRA_DIST = README.nsis LINGUAS POTFILES \
	     $(POFILES) gpg4win-de.wxl gpg4win-en.wxl \
	     nsis-msgfmt.c nsis-xgettext.awk nsis-xgettext.sh \
	     remove-potcdate.sin

# Note: LINGUAS, POTFILES, NSIFILES and POFILES variables are created
# by configure from the LINGUAS and POTFILES files.

CLEANFILES = nsis-msgfmt $(NSIFILES) catalogs.nsi remove-potcdate.sed


all: catalogs.nsi


SUFFIXES = .nsi .sin .sed .po

XGETTEXT = xgettext
XGETTEXT_OPTIONS = -L c
COPYRIGHT_HOLDER = g10 Code GmbH
MSGMERGE = msgmerge --no-location
MSGMERGE_UPDATE = msgmerge --update --no-location
MSGCONV = msgconv --no-location
MSGFILTER = msgfilter --no-location

.sin.sed:
	sed -e '/^#/d' $< > t-$@
	mv t-$@ $@

.po.nsi:
	(set -e;\
	lang=`echo $* | sed -e 's,.*/,,'`; \
	test "$(srcdir)" = . && dir="" || dir="$(srcdir)/"; \
	echo "rm -f $${dir}$${lang}.nsi && ./nsis-msgfmt $${dir}$${lang}.po > $${dir}$${lang}.nsi"; \
	rm -f $${lang}.nsi ; \
        ./nsis-msgfmt $${dir}$${lang}.po > t-$${lang}.nsi ;\
        mv t-$${lang}.nsi $${lang}.nsi \
	)


# This target rebuilds gpg4win.pot; it is an expensive operation.
# Note that gpg4win.pot is not touched if it doesn't need to be changed.
gpg4win.pot-update: $(POTFILES) remove-potcdate.sed
	(set -e; rm -f gpg4win.po; \
	(for f in $(POTFILES); do \
            $(AWK) -f ${srcdir}/nsis-xgettext.awk \
                   -v "file=$${f##*/}" "$$f";\
        done) | $(XGETTEXT) --default-domain=gpg4win \
		             --add-comments=TRANSLATORS: \
		             $(XGETTEXT_OPTIONS) \
		             --copyright-holder='$(COPYRIGHT_HOLDER)' \
			     --msgid-bugs-address='$(PACKAGE_BUGREPORT)' \
                             - ;\
	if [ -f gpg4win.po ]; then \
	  if test -f $(srcdir)/gpg4win.pot; then \
	    sed -f remove-potcdate.sed < $(srcdir)/gpg4win.pot > gpg4win.1po ;\
	    sed -f remove-potcdate.sed < gpg4win.po > gpg4win.2po ;\
	    if cmp gpg4win.1po gpg4win.2po >/dev/null 2>&1; then \
	        rm -f gpg4win.1po gpg4win.2po gpg4win.po; \
	    else \
	        rm -f gpg4win.1po gpg4win.2po $(srcdir)/gpg4win.pot ;\
	        mv gpg4win.po $(srcdir)/gpg4win.pot; \
	    fi; \
	  else \
	    mv gpg4win.po $(srcdir)/gpg4win.pot; \
	  fi; \
	fi )

# This rule has no dependencies: we don't need to update gpg4win.pot at
# every "make" invocation, only create it when it is missing.
# Only "make gpg4win.pot-update" or "make dist" will force an update.
$(srcdir)/gpg4win.pot:
	$(MAKE) gpg4win.pot-update

# This target rebuilds a PO file if gpg4win.pot has changed.
# Note that a PO file is not touched if it doesn't need to be changed.
$(POFILES): gpg4win.pot
	@lang=`echo $@ | sed -e 's,.*/,,' -e 's/\.po$$//'`; \
	if test -f "$(srcdir)/$${lang}.po"; then \
	  test "$(srcdir)" = . && cdcmd="" || cdcmd="cd $(srcdir) && "; \
	  echo "$${cdcmd}$(MSGMERGE_UPDATE) $${lang}.po $<"; \
	  cd $(srcdir) && $(MSGMERGE_UPDATE) $${lang}.po $<; \
	else \
	  $(MAKE) $${lang}.po-create; \
	fi


# We build this little utility on the BUILD architecture!
nsis-msgfmt: $(srcdir)/nsis-msgfmt.c
	$(BUILD_CC) -o nsis-msgfmt $(srcdir)/nsis-msgfmt.c -lgettextpo


# Collect all NSI files we need to include.
catalogs.nsi: $(NSIFILES)
	set -e;	: > catalogs.nsi; \
	for f in $^; do \
	    echo "!include \"$$f\"" >> catalogs.nsi;\
        done


$(NSIFILES): nsis-msgfmt

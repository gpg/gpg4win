# Build html from m4 macrofiles
# $Id$
#
# (c)2005,2006,2015,2020 by Intevation GmbH
# Author(s): Sascha Wilde, Bernhard Reiter
#
# This is Free Software licensed under the GPL

# Preprocessor configuration
PP = m4
PPFLAGS = --prefix-builtins

# Build configuration
TARGETS = $(patsubst %.htm4,%.html,$(wildcard *.htm4)) change-history.html change-history-de.html
SUBDIRS =

# Installation configuration
INSTALL_DIR = /tmp/gpg4win-www
ADD_INST_TYPES = *.css *.png *.asc
ADD_INST_DIRS = pix img .well-known

USER=intevation

CURDIR=$(shell pwd)

.SUFFIXES: .html .htm4

.htm4.html:
	$(PP) -DNO_LINK_FOR=$@ $(PPFLAGS) $< > $@

all: $(TARGETS) subdirs

$(TARGETS): template.m4 template_header.m4 versions.m4 \
            header.m4 gpg4win.css

subdirs: $(SUBDIRS)
	@for dir in $^ ; do \
	  $(MAKE) -C $$dir SUBDIRS="" ; \
	done

change-history.htm4: build-history.awk NEWS.last
	LC_ALL=de_DE.latin1 awk -f build-history.awk < NEWS.last | \
		   sed 's@\(T[0-9]\+\)@<a href="https://dev.gnupg.org/\1">\1</a>@g' > $@

change-history-de.htm4: build-history.awk NEWS.last
	LC_ALL=de_DE.latin1 awk -f build-history.awk -v lang=de < NEWS.last | \
		   sed 's@\(T[0-9]\+\)@<a href="https://dev.gnupg.org/\1">\1</a>@g' > $@


online: all
	@echo ""
	@echo "Going to put current contents online for www.gpg4win.org ..."
	@echo "(ssh fingerprint may be found via https://ssl.intevation.de/)"
	@echo ""
	rsync -rvPC --perms --chmod=ug+rw,o+r,Dg+s,Da+x,u-s,Fg-s,o-wt --exclude='*.swp' $(ADD_INST_TYPES) $(TARGETS) $(ADD_INST_DIRS) \
	$(USER)@www.gpg4win.org:/srv/gpg4win-www/

install: all
	mkdir -p $(INSTALL_DIR) ;\
	cp -uf $(TARGETS) $(INSTALL_DIR) ;\
	cp -uf $(ADD_INST_TYPES) $(INSTALL_DIR)
	cp -urf *$(ADD_INST_DIRS) $(INSTALL_DIR)
	find $(INSTALL_DIR) -name ".svn" | xargs rm -rf

tar: install
	echo $(CURDIR)
	( cd $(INSTALL_DIR) ; tar -czv -f $(CURDIR)/www.gpg4win.org.tar.gz . )

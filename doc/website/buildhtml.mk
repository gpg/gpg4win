# Build html from m4 macrofiles
# $Id: Makefile,v 1.8 2005/05/11 14:11:02 wilde Exp $
#
# (c)2005,2006 by Intevation GmbH
# Author(s): Sascha Wilde
#
# This is Free Software licensed under the GPL

# Preprocessor configuration
PP = m4
PPFLAGS = --prefix-builtins

# Build configuration
TARGETS = $(patsubst %.htm4,%.html,$(wildcard *.htm4))
SUBDIRS = 

# Installation configuration
INSTALL_DIR = /tmp/kolabkonsortium-www
ADD_INST_TYPES = .css .pdf
ADD_INST_DIRS = pix

.SUFFIXES: .html .htm4

.htm4.html:
	$(PP) $(PPFLAGS) $< > $@

all: $(TARGETS) subdirs

$(TARGETS): template.m4 template_header.m4 versions.m4

subdirs: $(SUBDIRS)
	@for dir in $^ ; do \
	  $(MAKE) -C $$dir SUBDIRS="" ; \
	done

install: all
	mkdir -p $(INSTALL_DIR) ;\
	cp -uf $(TARGETS) $(INSTALL_DIR) ;\
	cp -uf *$(ADD_INST_TYPES) $(INSTALL_DIR)
	cp -urf *$(ADD_INST_DIRS) $(INSTALL_DIR)

tar: all
	rm -f .TAR-FILE-LIST ; \
	for i in $(ADD_INST_DIRS) ; do echo "./$$i" >>.TAR-FILE-LIST ; done ; \
	for i in .html $(ADD_INST_TYPES) ; do \
	  find . -name "*$$i" >>.TAR-FILE-LIST ; \
	done ; \
	tar -czv -f www.kolab-konsortium.tar.gz -T .TAR-FILE-LIST
# the Gpg4win version
VERSION=1.1.2
# the directory where the CD is assembled, needs to be adjusted
CD_DIR=/vol1/projects/gpg4win

all: CD

CD:
	mkdir -p $(CD_DIR)/Gpg4win-CD-$(VERSION)

	make -C ../website -f buildhtml.mk tar
	cp ../website/www.gpg4win.org.tar.gz $(CD_DIR)/Gpg4win-CD-$(VERSION)

	( cd $(CD_DIR)/Gpg4win-CD-$(VERSION) ; 	mkdir -p www.gpg4win.org ; \
	  cd www.gpg4win.org; tar -xzf ../www.gpg4win.org.tar.gz )

	( cd $(CD_DIR)/Gpg4win-CD-$(VERSION) ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-$(VERSION).exe ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-$(VERSION).exe ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-$(VERSION).exe.sig ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-light-$(VERSION).exe ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-light-$(VERSION).exe.sig )

	( cd $(CD_DIR)/Gpg4win-CD-$(VERSION) ; mkdir -p src ; cd src ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-src-$(VERSION).exe ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-src-$(VERSION).exe.sig ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-$(VERSION).tar.bz2 ; \
	  wget -c http://ftp.gpg4win.org/gpg4win-$(VERSION).tar.bz2.sig )

iso: CD
	cd $(CD_DIR)
	mkisofs -hide-rr-moved -l -J -r -o $(CD_DIR)/gpg4win-$(VERSION).iso -A "Gpg4win $(VERSION)" -V "Gpg4win $(VERSION)" $(CD_DIR)/Gpg4win-CD-$(VERSION)

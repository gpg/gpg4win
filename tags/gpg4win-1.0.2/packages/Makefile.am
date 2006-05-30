# Makefile.am - Installer for GnuPG 4 Windows Makefile.
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

EXTRA_DIST = download.sh packages.keys


upload: packages.current packages.current.sig
	set -e; \
	echo "Uploading package list to www.gpg4win.org ..."; \
        user=`svn info | sed -n '/^URL:/ s,.*svn+ssh://\\([^@]*\\).*,\\1,p'`;\
	rsync -v -W packages.current{,.sig} \
	  $${user}@wald.intevation.org:/gpg4win/htdocs/


packages.current.sig : packages.current
	@echo "packages.current.sig is expected to be a detached signature of packages.current"
	@echo "Use \"gpg -sbu YOUR_KEYID packages.current\" to create it"
	@false


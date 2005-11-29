#!/bin/sh
# download.sh - Download source and binary packages for GPG4Win.
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

# Syntax of the packages.current file:
#
# If the first non whitespace character of a line is #, the line is
# considered a comment.  If the first word of a line is "server", the
# rest of the line will be taken as the base URL for following file
# commands.  If the first word of a line is "file" the rest of the
# line will be appended to the current base URL (with a / as
# delimiter).  Example:
#
#    # GnuPG stuff. 
#    server ftp://ftp.gnupg.org/gcrypt
#    
#    file gnupg/gnupg-1.4.2.tar.gz
#    file gnupg/gnupg-1.4.2.tar.gz.sig
#    

WGET=wget

url="ftp://ftp.gpg4win.org/gpg4win/"
echo "downloading packages list from \`$url'."
if ! ${WGET} -N -q $url/packages.current{,.sig} ; then
    echo "download of packages list failed." >&2
    exit 1
fi

if ! gpgv --keyring ./packages.keys packages.current.sig packages.current
  then
    echo "list of packages is not usable." >&2
    exit 1
fi


lnr=0
[ -f '.#download.failed' ] && rm '.#download.failed'
cat packages.current | \
while read key value ; do
    (( lnr++ ))
    [ -z "$key" ] && continue
    case "$key" in
     \#*)    ;;
    server) 
       server="$value" 
       ;;
    file)
       if [ -z "$value" ]; then
           echo "syntax error in file statement" >&2
           exit 1
       fi
       if [ -z "$server" ]; then
           echo "no server location available for file \`$value'" >&2
           exit 1
       fi
       url="$server/$value"
       echo "downloading \`$url'."
       if ! ${WGET} -c -q "$url" ; then
           echo "download of \`$url' failed." >&2
           echo "$url" >> '.#download.failed'
       fi
       ;;
     *)
       echo "syntax error in packages.current, line $lnr." >&2
       exit 1
     esac
done
if [ -f '.#download.failed' ]; then
  echo "some files failed to download" 2>&1
  exit 1
fi

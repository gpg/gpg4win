#!/bin/bash
# download.sh - Download source and binary packages for GPG4Win.
# Copyright (C) 2005, 2007 g10 Code GmbH
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
#    chk  1234567890123456789012345678901234567890
#    


usage()
{
    cat <<EOF
Usage: $0 [OPTIONS]
Options:
	[--force]
	[--keep-list]
	[--no-sig-check]
EOF
    exit $1
}


force=no
keep_list=no
sig_check=yes
while [ $# -gt 0 ]; do
    case "$1" in
	--*=*)
	    optarg=`echo "$1" | sed 's/[-_a-zA-Z0-9]*=//'`
	    ;;
	*)
	    optarg=""
	    ;;
    esac

    case $1 in
	--force)
	    force=yes
	    ;;
        --keep-list)
            keep_list=yes
            ;;
        --no-sig-check)
            sig_check=no
            ;;
	*)
	    usage 1 1>&2
	    ;;
    esac
    shift
done


WGET=wget

url="http://www.gpg4win.org"
if [ "$keep_list" = "no" ]; then
  echo "downloading packages list from \`$url'."
  if ! ${WGET} -N -q $url/packages.current{,.sig} ; then
      echo "download of packages list failed." >&2
      exit 1
  fi
fi

if [ "$sig_ckeck" = yes ]; then
 if ! gpgv --keyring ./packages.keys packages.current.sig packages.current
   then
    echo "list of packages is not usable." >&2
    exit 1
 fi
fi

lnr=0
name=
[ -f '.#download.failed' ] && rm '.#download.failed'
cat packages.current | \
while read key value ; do
    (( lnr++ ))
    [ -z "$key" ] && continue
    case "$key" in
     \#*)    ;;
    server) 
       server="$value" 
       name=
       ;;
    file)
       if [ -z "$value" ]; then
           echo "syntax error in file statement, line $lnr" >&2
           exit 1
       fi
       if [ -z "$server" ]; then
           echo "no server location for file \`$value', line $lnr" >&2
           exit 1
       fi
       url="$server/$value"
       name=`basename "$value"`
       if [ -f "$name" -a "$force" = "no" ]; then
           echo "package     \`$url' ... already exists"
       else
           echo -n "downloading \`$url' ..."
           if ${WGET} -c -q "$url" ; then
               echo " okay"
           else
               echo " FAILED (line $lnr)"
               echo "line $lnr: downloading $url failed" >> '.#download.failed'
           fi
       fi
       ;;
     ren)
       if [ -z "$value" ]; then
           echo "syntax error in ren statement, line $lnr" >&2
           exit 1
       fi
       if [ -z "$name" ]; then
           echo "no file name for ren statement, line $lnr" >&2
           exit 1
       fi
       echo -n "renaming    \`$name' ..."
       if mv -f "$name" "$value" ; then
           echo " okay"
       else
           echo " FAILED (line $lnr)"
           echo "line $lnr: renaming $name failed" >> '.#download.failed'
       fi
       name="$value"
       ;;
     chk)
       if [ -z "$value" ]; then
           echo "syntax error in chk statement, line $lnr" >&2
           exit 1
       fi
       if [ -z "$name" ]; then
           echo "no file name for chk statement, line $lnr" >&2
           exit 1
       fi
       echo -n "checking    \`$name' ..."
       if echo "$value *$name" | sha1sum -c >/dev/null 2>&1 ; then
           echo " okay"
       else
           echo " FAILED (line $lnr)"
           echo "line $lnr: checking $name failed" >> '.#download.failed'
       fi
       name=
       ;;
     *)
       echo "syntax error in \`packages.current', line $lnr." >&2
       exit 1
     esac
done
if [ -f '.#download.failed' ]; then
  cat '.#download.failed' >&2
  rm '.#download.failed'
  echo "some files failed to download or checksums are not matching" >&2
  exit 1
fi

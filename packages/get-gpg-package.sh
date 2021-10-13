#!/bin/bash
# Copyright (C) 2018 Intevation GmbH
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

# Check gpg packages against their distsigkey and print out the lines
# for packages.current
#
# TODO: Update packages.current automatically
set -e
#set -x

GNUPG="libgpg-error libgcrypt libksba libassuan ntbtls npth pinentry gpgme gnupg"
GPG4WIN="gpgex gpgol"

WGET=wget
GPGV=gpgv

srcdir=$(readlink -f `dirname "$0"`)
distsigkey="$srcdir/distsigkey.gpg"

if [ -z "$1" -o -z "$2" ]; then
    echo "Usage $0 <package> <Version> [user]"
    exit 1
fi

if [ -z "$3" ]; then
    CHANGER="ah"
else
    CHANGER="$3"
fi

if ! $GPGV --version >/dev/null 2>/dev/null ; then
    echo "command \"gpgv\" is not installed" >&2
    exit 1
fi

function list_include_item {
  local list="$1"
  local item="$2"
  if [[ $list =~ (^|[[:space:]])"$item"($|[[:space:]]) ]] ; then
    # yes, list include item
    result=0
  else
    result=1
  fi
  return $result
}

if `list_include_item "$GNUPG" "$1"` ; then
    SERVER="https://gnupg.org/ftp/gcrypt"
elif `list_include_item "$GPG4WIN" "$1"` ; then
    SERVER="http://files.gpg4win.org/src"
else
    echo "Unknown package $1";
    exit 1;
fi

FILE="$1-$2.tar.bz2"
FILEPATH="$1/$FILE"
MYTMP=$(mktemp -d)

cd $MYTMP
$WGET $SERVER/$FILEPATH
$WGET $SERVER/$FILEPATH.sig

if ! $GPGV --keyring "$distsigkey" $FILE.sig $FILE; then
    echo "package is not valid!" >&2
    exit 1
fi

SHASUM=$(sha256sum $FILE | cut -d " " -f 1)
DATE=$(date +%Y-%m-%d)

echo "# last changed $DATE"
echo "# by $CHANGER"
echo "# verified: distsigkey.gpg"
echo "server $SERVER"
echo "file $FILEPATH"
echo "chk $SHASUM"
cd -
rm -r $MYTMP

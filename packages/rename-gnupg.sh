#!/bin/sh

if [ -z "$1" ]; then
  echo "usage: rename-gnupg.sh VERSION DATE" >&2
  echo "example:" >&2
  echo " ./rename-gnupg.sh 2.2.37-beta52 20221107" >&2
  exit 1
fi

version=$1
date=$2

die=no
for f in gnupg-${version}.tar.bz2 gnupg-w32-${version}_${date}.tar.xz; do
  if [ ! -f "$f" ]; then
    echo "error: $f missing" >&2
    die=yes
  fi
done
[ $die = yes ] && exit 1

mv gnupg-w32-${version}_${date}.exe     gnupg-w32-${version}_${date}-bin.exe
mv gnupg-w32-${version}_${date}.tar.xz  gnupg-w32-${version}_${date}-src.tar.xz
mv gnupg-w32-${version}_${date}.wixlib  gnupg-w32-${version}_${date}-bin.wixlib
ln -f gnupg-w32-${version}_${date}-bin.wixlib gnupg-msi-${version}_${date}-bin.wixlib
ln -f gnupg-w32-${version}_${date}-src.tar.xz gnupg-msi-${version}_${date}-src.tar.xz

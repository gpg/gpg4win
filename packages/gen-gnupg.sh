#!/bin/sh
# Generate the snippet for the packages file.
# The input is the source name of the GnuPG Windows source tarball

PGM=gen-gnupg.sh

set -e

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS]  WINDOWS_SOURCE_TARBALL
Options:
        [--v4]       Append to packages.4
        [--v3]       Append to packages.3 (default)
        [--snapshot] Create for snapshot folder
EOF
    exit $1
}


forversion=3
bindir="binary"
snapshot=no
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
	--v4)
	    forversion=4
	    ;;
	--v3)
	    forversion=3
	    ;;
	--snapshot|--snapshots)
            snapshot=yes
	    bindir=gnupg
	    ;;
	--help|-h)
	    usage 0
	    ;;
	--*)
	    usage 1 1>&2
	    ;;
	*)
	    break
	    ;;
    esac
    shift
done

if [  $# -ne 1 ]; then
    usage 1 1>&2
fi
w32source="$1"
shift

if [ ! -f "$w32source" ]; then
  echo "$PGM: can't find '$w32source'" >&2
  exit 1
fi
dir=$(dirname "$w32source")
base=$(basename "$w32source" | sed 's/\.tar\.\(bz2\|xz\)$//')
prefix=$(echo "$base"  | sed -n 's/^\(.*\)-w32-.*/\1/p')
version=$(echo "$base" | sed -n 's/.*-w32-\([0-9.]\+[^_]*\).*/\1/p')
date=$(echo "$base"    | sed -n 's/.*-w32-[0-9.]\+[^_]*_\(.*\)/\1/p' | sed -n '/^[0-9]\+$/p')
# echo "base=$base"
# echo "prefix=$prefix"
# echo "version=$version"
# echo "date=$date"
if [ -z "$base" -o -z "$prefix" -o -z "$version" -o -z "$date" ]; then
  echo "$PGM: invalid filename '$w32source'" >&2
  exit 1
fi


cp "$dir/${prefix}-${version}.tar.bz2"            "${prefix}-${version}.tar.bz2"

for suf in tar.xz exe wixlib; do
    cp "$dir/${prefix}-w32-${version}_${date}.$suf" .
done

ln -f "${prefix}-w32-${version}_${date}.tar.xz" "${prefix}-w32-${version}_${date}-src.tar.xz"
ln -f "${prefix}-w32-${version}_${date}.exe" "${prefix}-w32-${version}_${date}-bin.exe"
ln -f "${prefix}-w32-${version}_${date}.wixlib" "${prefix}-msi-${version}_${date}-bin.wixlib"

outfile="packages.$forversion"
echo >>$outfile
echo >>$outfile "# last changed $(date +%Y-%m-%d)"
echo >>$outfile "# by $LOGNAME"
echo >>$outfile "# verified: [taken from buildtree]"

if [ $snapshot = yes ]; then
    echo >>$outfile
    echo >>$outfile "server https://gnupg.org/ftp/gcrypt/snapshots"
    echo >>$outfile
fi

file="${prefix}-${version}.tar.bz2"
echo >>$outfile "name $file"
echo >>$outfile "file gnupg/$file"
echo >>$outfile "chk  $(sha256sum < $file | cut -d ' ' -f1)"
echo >>$outfile

orgfile="${prefix}-w32-${version}_${date}.exe"
file="${prefix}-w32-${version}_${date}-bin.exe"
echo >>$outfile "name $file"
echo >>$outfile "file $bindir/${orgfile}"
echo >>$outfile "chk  $(sha256sum < $orgfile | cut -d ' ' -f1)"
echo >>$outfile

orgfile="${prefix}-w32-${version}_${date}.tar.xz"
file="${prefix}-w32-${version}_${date}-src.tar.xz"
msifile="$(echo $file | sed s/-w32-/-msi-/)"
echo >>$outfile "name $file"
echo >>$outfile "file $bindir/${orgfile}"
echo >>$outfile "link $msifile"
echo >>$outfile "chk  $(sha256sum < $orgfile | cut -d ' ' -f1)"
echo >>$outfile

orgfile="${prefix}-w32-${version}_${date}.wixlib"
file="${prefix}-msi-${version}_${date}-bin.wixlib"
echo >>$outfile "name $file"
echo >>$outfile "file $bindir/${orgfile}"
echo >>$outfile "chk  $(sha256sum < $orgfile | cut -d ' ' -f1)"
echo >>$outfile

echo >>$outfile "# eof"

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
EOF
    exit $1
}


forversion=3
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

cp "$dir/${prefix}-w32-${version}_${date}.tar.xz" "${prefix}-w32-${version}_${date}-src.tar.xz"
cp "$dir/${prefix}-w32-${version}_${date}.exe"    "${prefix}-w32-${version}_${date}-bin.exe"
cp "$dir/${prefix}-w32-${version}_${date}.wixlib" "${prefix}-w32-${version}_${date}-bin.wixlib"

ln -f "${prefix}-w32-${version}_${date}-src.tar.xz" "${prefix}-msi-${version}_${date}-src.tar.xz"
ln -f "${prefix}-w32-${version}_${date}-bin.wixlib" "${prefix}-msi-${version}_${date}-bin.wixlib"

outfile="packages.$forversion"
echo >>$outfile
echo >>$outfile "# last changed $(date +%Y-%m-%d)"
echo >>$outfile "# by $LOGNAME"
echo >>$outfile "# verified: [taken from buildtree]"

file="${prefix}-${version}.tar.bz2"
echo >>$outfile "file $file"
echo >>$outfile "chk  $(sha256sum < $file | cut -d ' ' -f1)"
echo >>$outfile

file="${prefix}-w32-${version}_${date}-bin.exe"
echo >>$outfile "name $file"
echo >>$outfile "file binary/${prefix}-w32-${version}_${date}.exe"
echo >>$outfile "chk  $(sha256sum < $file | cut -d ' ' -f1)"
echo >>$outfile

file="${prefix}-w32-${version}_${date}-src.tar.xz"
msifile="$(echo $file | sed s/-w32-/-msi-/)"
echo >>$outfile "name $file"
echo >>$outfile "file binary/${prefix}-w32-${version}_${date}.tar.xz"
echo >>$outfile "link $msifile"
echo >>$outfile "chk  $(sha256sum < $file | cut -d ' ' -f1)"
echo >>$outfile

file="${prefix}-msi-${version}_${date}-bin.wixlib"
echo >>$outfile "name $file"
echo >>$outfile "file binary/${prefix}-w32-${version}_${date}.wixlib"
echo >>$outfile "chk  $(sha256sum < $file | cut -d ' ' -f1)"
echo >>$outfile

echo >>$outfile "# eof"

#! /bin/bash
# Copyright (C) 2007 g10 Code GmbH
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

# FIXME!
AWK=awk

# We have to wrap xgettext for use with NSIS.

# Limitations: Only supports --files-from for now, no files on the
# command line or STDIN.

srcdir=.
argv=
files_from=
directory=.

i=0
prev=

for opt in "$@"; do
    case "${prev}" in
	-D)
	directory="${opt}"
	prev=
	continue
	;;
	-f)
	files_from="${opt}"
	prev=
	continue
	;;
    esac

    case "$opt" in
	--directory=*)
	directory=`echo "${opt}" | sed 's/^--directory=//'`
	continue
	;;
	--files-from=*)
	files_from=`echo "${opt}" | sed 's/^--files-from=//'`
	continue
	;;
	-D|-f)
	prev="${opt}"
	continue
	;;
	--srcdir=*)
	srcdir=`echo "${opt}" | sed 's/^--srcdir=//'`
	continue
	;;
    esac

    argv[i]="$opt"
    i=$((${i} + 1))	
done

# Now we can create the required input for xgettext.
(for f in `sed -n -e '/^[^#]/p' "${files_from}"`; do ${AWK} -f ${srcdir}/nsis-xgettext.awk -v "file=${f}" "${directory}/${f}"; done) | "${argv[@]}" -

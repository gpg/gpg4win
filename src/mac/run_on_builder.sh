#!/bin/sh
# Helper script to feed a command into a virtual machine via ssh.
#
# Copyright (C) 2026 g10 Code GmbH
#
# Software engineering by: Thomas Friedrichsmeier <thomas.friedrichsmeier@gnupg.com>
#                          Andre Heinecke <aheinecke@gnupg.org>
# This file is part of GnuPG.
#
# GnuPG is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# GnuPG is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-3.0+

set -e
scriptdir=$(dirname "$0")

usage()
{
    cat <<EOF
Usage: $PGM [OPTIONS]
Feed given command to VM via ssh

Options:
        --builddir   Build directory (host path)
        --srcdir     Source directory (host path). The corresponding VM path is set as initial working directory.
        --nosync     Do not sync source directory before this step.
        --           End of options. Everything after this is command to run and args.

EOF
    exit $1
}

# Parse the command line options.
skipshift=
while [ $# -gt 0 ]; do
    case "$1" in
        --*=*) optarg="${1//[-_a-zA-Z0-9]*=/}";;
        *) optarg="";;
    esac

    case "$1" in
        --builddir|--builddir=*) builddir="${optarg}" ;;
        --srcdir|--srcdir=*)     srcdir="${optarg}"   ;;
        --nosync)                sync="no"            ;;
        --)                      shift; break         ;;
        *)                       skipshift=1; break   ;;
    esac
    [ -n "$skipshift" ] || shift
done

if [ ! -f $srcdir/src/mac/run_on_builder.sh ] ; then
    echo "Cannot find myself in sources ($srcdir). Something seems wrong!"
    exit 1
fi

if [ -f "$scriptdir/vmconfig" ] ; then
    source "$scriptdir/vmconfig"

    echo "mkdir -p ${vmsrcdir}" | ssh ${user}@${host}
    if [ "$sync" != "no" ]; then
        echo "Syncing source dir to builder. This could take a while."
        rsync -e ssh ${srcdir}/* -r --delete ${user}@${host}:${vmsrcdir}
    fi
    echo "Running '$@' on builder"
    printf "export TOPSRCDIR='%s'
            export PLAYGROUND='%s'
            export CODESIGN_ID='%s'
            export CODESIGN_TEAMID='%s'
            cd \"\$TOPSRCDIR\"
            %s" "${vmsrcdir}" "${vmbuilddir}" "${codesign_id}" "${codesign_teamid}" "$@" | ssh ${user}@${host}
    echo "Build command '$@' finished successfully"
    rsync -e ssh ${user}@${host}:${vmbuilddir}/artifacts/* ${builddir}
else
    echo "*** $scriptdir/vmconfig is not present. Falling back to build on local system. ***"
    TOPSRCDIR="${srcdir}" PLAYGROUND="${builddir}" $@
    echo "Build command '$@' finished successfully on local machine"
fi

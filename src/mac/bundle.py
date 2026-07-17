#!/usr/bin/python3
# bundle.py - bundle MacOS kleopatra image for distribution
# Copyright (C) 2026 g10 Code GmbH
#
# Software engineering by Thomas Friedrichsmeier <thomas.friedrichsmeier@gnupg.com>
#
# This file is part of Gpg4win.
#
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-2.0+

# This script is meant to handle all steps of creating a complete MAC .dmg bundle, i.e.
# - moving files to the correct layout (see https://doc.qt.io/qt-6/macos-deployment.html)
# - checking all library dependencies
#   - making sure all deps are either system provided or in the bundle
#   - adjusting library paths (install_name_tool)
# (- checking strings for mentions of build path?)
# - signing / notarization
# - creating dmg
#
# Most of that is not yet here. Just some initial experimental bits

from pathlib import Path
import sys
import subprocess

# copied (stripped down) from KDE craft:
def isBinary(fileName: str) -> bool:
    # https://en.wikipedia.org/wiki/List_of_file_signatures
    MACH_O_64_signature = b"\xCF\xFA\xED\xFE"

    fileName = Path(fileName)
    suffix = fileName.suffix.lower()
    if fileName.is_symlink() or fileName.is_dir():
        return False

    if ".dSYM/" in str(fileName):
        return False
    if suffix in {".so", ".dylib"}:
        return True
    with fileName.open("rb") as f:
        return f.read(len(MACH_O_64_signature)) == MACH_O_64_signature

p = Path(sys.argv[1])
files = p.rglob('*')
homebrewdeps = {}
for f in files:
    if isBinary(f):
        # print(f"deps for {f}:\n\n")
        deplines = subprocess.run(["otool", "-L", f], text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout.split('\n')
        for depline in deplines:
            dep = depline.strip().split(' (')[0]  # otool -L gives '     <filename> (<version info>)'
            if 'homebrew' in dep:
                if not dep in homebrewdeps:
                    homebrewdeps[dep] = []
                homebrewdeps[dep].append(str(f))

for dep, files in homebrewdeps.items():
    print(f"\n\nHomebrew dep {dep} is referenced by the following files:")
    print('\n'.join(files))

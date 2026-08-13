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
# - signing / notarization -> TODO
# - creating dmg -> TODO: still very basic
#
# Some pointers to similar tools that do not quite meet our needs:
# macdeployqt - https://doc.qt.io/qt-6/macos-deployment.html#macdeploy
# KDE craft - https://invent.kde.org/packaging/craft/-/blob/master/bin/Packager/MacBasePackager.py?ref_type=heads
#
# Regarding .dmg creation, possibly the most simple script is this:
# https://github.com/remko/fancy-dmg/blob/master/Makefile
# The idea is essentially to create a template dmg, once, then simply
# copy in the new files. The template dmg can be styled, manually, which
# is not too much worse than the osascript used elsewhere.
#
# This script is not yet complete
#
# Note: MacOS 26.05 comes with Python 3.9, so we definitely don't want to
#       target a later Python, for now.

from itertools import chain
from pathlib import Path
import os
import re
import shutil
import subprocess
import sys
import tempfile

def error(message: str):
    print(message)
    exit(1)

def createStagingSkeleton():
    bundleDir.mkdir(parents=True)
    (bundleDir / 'Frameworks').mkdir()
    (bundleDir / 'MacOS').mkdir()
    (bundleDir / 'Resources').mkdir()
    (bundleDir / 'Plugins').mkdir()


def moveFilesToDestination():
    # Some packages (importantly kleopatra, okular) install (some of) their files to DESTDIR/Applications.
    # We need to copy those, but also the files from DESTDIR/pkgs (we go through DESTDIR/pkgs rather than
    # DESTIR/* to allow easier filtering by package -> see destination().
    files = chain((srcPrefix / 'Applications').rglob('*'), (srcPrefix / "pkgs").rglob('*'))
    for f in files:
        dest = destination(f)
        if (dest == None):
            print(f"Skipping {f}")
        else:
            (bundleDir / dest).parent.mkdir(parents=True, exist_ok=True)
            if f.is_symlink():
                target = f.readlink()
                if target.is_absolute():
                    error(f"Cannot handle absolute symlink {f}->{target}")
                print(f"symlink {f} -> {target}")
                (bundleDir / dest).symlink_to(target)
            elif f.is_file():
                print(f"Copying {f} -> {dest}")
                shutil.copy2(f, bundleDir / dest)
                if isBinary(bundleDir / dest):
                    checkAndPatchDependencies(bundleDir / dest, f)


# map source filename to destination
# input and output are relative to prefix
# return value may be None, signaling to drop
def destination(absFilePath: Path) -> str:
    if absFilePath.is_relative_to(srcPrefix / "pkgs"):
        # files from pkgs subdir
        filePath = absFilePath.relative_to(srcPrefix / "pkgs")
        package = filePath.parts[0].split('-')[0]
        fileName = str(filePath.relative_to(filePath.parts[0]))
    else:
        # file from Applications and RPATH values
        filePath = absFilePath.relative_to(srcPrefix)
        package = ""
        fileName = str(filePath)
    if package in ["qttools"]:
        return None
    elif package == "qtbase" and "objects-Release" in fileName:
        return None # unused Qt cruft that makes codesign unhappy
    elif fileName.startswith(tuple(["cmake", "include", "mkspecs", "lib/cmake", "lib/pkgconfig"])):
        return None
    elif fileName.endswith(tuple([".a", ".la"])):
        return None
    elif fileName.startswith("Applications"):
        return re.sub(r'Applications/[^/]*/Contents/', '', fileName) # strip Application/xyz/Contents
    else:
        # moveList essentially as in KDE craft
        moveList = [
            ("lib/plugins", "PlugIns"),
            ("plugins", "PlugIns"),
            ("share", "Resources"),
            ("qml", "Resources/qml"),
            ("translations", "Resources/Translations"),
            ("bin", "MacOS"),
            ("libexec", "MacOS"),
            ("lib/libexec", "MacOS"),
            ("lib", "Frameworks")
        ]
        for (src, dest) in moveList:
            if (fileName.startswith(src + '/')) and fileName != src:
                return fileName.replace(src, dest, 1)
    return None


# isBinary() copied (stripped down) from KDE craft:
def isBinary(fileName: Path) -> bool:
    # https://en.wikipedia.org/wiki/List_of_file_signatures
    MACH_O_64_signature = b"\xCF\xFA\xED\xFE"

    suffix = fileName.suffix.lower()
    if fileName.is_symlink() or fileName.is_dir():
        return False

    if ".dSYM/" in str(fileName):
        return False
    if suffix in {".so", ".dylib"}:
        return True
    if os.access(fileName, os.X_OK):
        with fileName.open("rb") as f:
            return f.read(len(MACH_O_64_signature)) == MACH_O_64_signature
    return False


def getRPaths(file: Path):
    lines = subprocess.run(["otool", "-l", file], text=True, capture_output=True).stdout.split('\n')
    rpaths = []
    for i in range(len(lines)):
        if lines[i].strip() == "cmd LC_RPATH":
            for j in range(i, (i+4)):
                if (lines[j].strip().startswith("path")):
                    rpaths.append(lines[j].strip().split(' ')[1])
                    break
    return rpaths


def checkAndPatchDependencies(file: Path, origin: Path):
    # strip all rpaths, these mostly point to our build dirs, or are plain wrong
    # we'll still be using them to try to look up required dependencies, here
    # (which we'll then reference without resorting to rpath)
    rpaths = getRPaths(origin)
    for rpath in rpaths:
        subprocess.run(["install_name_tool", "-delete_rpath", rpath, file]).check_returncode()
    rpaths.append(srcPrefix / 'lib')

    # If this is a library, fix its library id, otherwise consumers may
    # not be able to load it, even with the correct path
    libid = ""
    lines = subprocess.run(["otool", "-D", str(file)], text=True, capture_output=True).stdout.split('\n')
    if len(lines) > 1:
        libid = lines[1].strip()
        if libid != "":
            print(f"Adjusting libid on {file} from {libid} to {os.path.basename(libid)}")
            subprocess.run(["install_name_tool", "-id", os.path.basename(libid), file]).check_returncode()
            libid = os.path.basename(libid)

    # find and fix all references to libs this binary depends on
    deplines = subprocess.run(["otool", "-L", file], text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout.split('\n')
    for depline in deplines:
        dep = depline.strip().split(' (')[0]  # otool -L gives '     <filename> (<version info>)'
        olddep = dep
        if dep == "" or dep == libid or dep == str(file) + ":":
            continue
        if (dep.startswith('/')):
            if (Path(dep).is_relative_to(srcPrefix)):
                dep = destination(Path(dep))
            else:
                # Absolute external system dep -> leave alone
                if not (dep.startswith('/usr/lib') or dep.startswith('/System/Library')):
                    error(f"{file} depends on external library {dep}")
                continue
        elif (dep.startswith('@executable_path')):
            # Probably we do not have this, anywhere?
            # If you hit this, you probably tried running macdeployqt
            error(f"dep {dep} in {file} is not handled")
        elif (dep.startswith('@rpath')):
            found = False
            for rpath in rpaths:
                candidate = Path(dep.replace('@rpath', str(rpath)))
                if (candidate.exists()):
                    print(f"resolving rpath {dep} to {candidate} to {destination(candidate)}")
                    dep = destination(candidate)
                    found = True
                    break
            if not found:
                error(f"unresolvable rpath {dep} in {file}")
        elif (dep.startswith('@loader_path')):
            dep = dep.replace('@loader_path', '.')
        else:
            error(f"unexpected relative dependency {dep}")

        # For now, we make everything absolute: safest option
        # to cover loading from any binary, and we don't support
        # a movable installation, anyway (so far)
        dep = str((bundleDir / dep).absolute()).replace(str(destPrefix), '')
        print(f"fixing dep {olddep} -> {dep}")
        subprocess.run(["install_name_tool", "-change", olddep, dep, file]).check_returncode()


def createDMG(stagingFolder: Path, imageName: str, outfile: Path):
    print("Creating dmg")
    subprocess.run(["hdiutil", "create", "-srcfolder", str(stagingFolder), "-volname", imageName, str(outfile)]).check_returncode()

# Steps to do:
# - copy the cmake created application bundle skeleton to the real staging destination
# - copy all further files to their destination. We might want to take those from the
#   individual dirs in PREIFX/pkgs, for easier filtering by package. We'll have to special-case
#   those that have cmake support for MacOS bundles (kleopatra, okular).
# - Fix up all library ids
# - Fix up all library references
#   For both we'll be keeping track of the origin location and the target location.
#   After / while moving, we just patch any occurence of the former to point to the latter.
# - remove rpaths (mostly broken)
# - strip
# - codesign
# - package into DMG
# - notarize (for some hints see macdeployqt docs)

srcPrefix = Path(sys.argv[1])
imageName = sys.argv[2]
outFile = Path(sys.argv[3])
if os.path.exists(outFile):
    os.remove(outFile)

stagingDir = tempfile.TemporaryDirectory()
destPrefix = Path(stagingDir.name)
bundleDir = (destPrefix / 'Applications' / (imageName + '.app') / 'Contents')

createStagingSkeleton()
moveFilesToDestination()
# purgeUnusedLibs()
# stripBinaries()
# sanityCheck()
createDMG(destPrefix, imageName, outFile)
stagingDir.cleanup()
print(f"DMG created at {outFile}")
# signAndNotarize()

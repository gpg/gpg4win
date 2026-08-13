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
        if '/Contents/' in fileName:
            return re.sub(r'Applications/[^/]*/Contents/', '', fileName) # strip Application/xyz/Contents
        return None
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
    # To avoid extra dependencies and / or osascript hacks, we use a very simple
    # approach to DMG styling, borrowed from:
    # https://github.com/remko/fancy-dmg/blob/master/Makefile
    # The idea is essentially to create a template dmg, once, then simply
    # copy in the new files. The template dmg can be styled, manually.
    print("Creating dmg")
    sys.stdout.flush()
    dirName = imageName + '.app'
    templateFile = Path(str(outfile) + ".template.dmg")
    if not os.path.exists(templateFile):
        print(f"No DMG template found. For a fancier installer style {templateFile}, manually, and run again.")
        dummy = tempfile.TemporaryDirectory()
        (Path(dummy.name) / dirName).mkdir()
        (Path(dummy.name) / "Applications").symlink_to(Path("/Applications"))
        subprocess.run(["hdiutil", "create", "-fs", "HFSX", "-layout", "SPUD", "-size", "1000000k", templateFile, "-srcfolder", dummy.name, "-format", "UDRW", "-volname", imageName]).check_returncode()
        dummy.cleanup()

    # attach a copy of the template, and copy over files
    wcFile = Path(str(templateFile) + ".wc.dmg")
    shutil.copy2(templateFile, wcFile)
    mountPoint = f"/Volumes/{imageName}.staging"
    print(f"Attaching DMG template at {mountPoint}")
    subprocess.run(["hdiutil", "attach", wcFile, "-noautoopen", "-mountpoint", mountPoint, "-quiet"]).check_returncode()
    print(f"Copying Files")
    subprocess.run(["cp", "-R", str(stagingFolder / 'Applications' / dirName), mountPoint]).check_returncode()
    # umount is not good enough, we need to "hdiutil detach" the working image
    lines = subprocess.run(["hdiutil", "info"], text=True, capture_output=True).stdout.split('\n')
    for line in lines:
        if mountPoint in line:
            dev = line.split('\t')[0]
            subprocess.run(["hdiutil", "detach", dev])

    print(f"Converting to compressed image")
    subprocess.run(["hdiutil", "convert", wcFile, "-format", "UDZO", "-imagekey", "zlib-level=9", "-o", outfile]).check_returncode()
    os.remove(wcFile)

# Steps to do:
# - Copy all files to their final destination (relative to a staging dir)
# - Fix up all library ids
# - remove rpaths (mostly broken)
# - Fix up all library references
# - strip -> TODO
# - codesign -> TODO
# - package into DMG
# - notarize -> TODO (for some hints see macdeployqt docs)

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

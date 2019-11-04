#!/bin/bash
# Copyright (C) 2016 Intevation GmbH
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

# Grab the latest kf5 translations and build a binary/source package for kleo.
# Autogenerates NSIS Files that include translations for frameworks.
#
# This script needs installed packages to determine which frameworks
# localizations exist

set -e
tmpdir=$(mktemp -d -p $(pwd))
VERSION=$(date +%Y%m%d%H%M)

g4widir="$(readlink -f $(dirname $0)/playground/install)"

if [ ! -e "$g4widir" ]; then
    echo "Please build gpg4win first."
    echo "This script needs installed packages to determine which frameworks localizations exist"
    exit 1
fi

# QFrameworks are frameworks that use qt translations
QFRAMEWORKS="kconfig kcompletion kcodecs kcoreaddons kitemviews kwidgetsaddons kwindowsystem"
# KFrameworks are frameworks that use KDE translations
KFRAMEWORKS="kconfigwidgets ki18n kiconthemes kxmlgui"

POFILES="pim/libkleopatra.po \
    pim/kwatchgnupg.po
    pim/kleopatra.po"
# See: https://websvn.kde.org/*checkout*/trunk/l10n-kf5/subdirs
LANGS="af \
ar \
as \
ast \
be \
be@latin \
bg \
bn \
bn_IN \
br \
bs \
ca \
ca@valencia \
crh \
cs \
csb \
cy \
da \
de \
el \
en_GB \
eo \
es \
et \
eu \
fa \
fi \
fr \
fy \
ga \
gd \
gl \
gu \
ha \
he \
hi \
hne \
hr \
hsb \
hu \
hy \
ia \
id \
is \
it \
ja \
ka \
kk \
km \
kn \
ko \
ku \
lb \
lt \
lv \
mai \
mk \
ml \
mr \
ms \
mt \
nb \
nds \
ne \
nl \
nn \
nso \
oc \
or \
pa \
pl \
ps \
pt \
pt_BR \
ro \
ru \
rw \
se \
si \
sk \
sl \
sq \
sr \
sr@ijekavian \
sr@ijekavianlatin \
sr@latin \
sv \
ta \
te \
tg \
th \
tr \
tt \
ug \
uk \
uz \
uz@cyrillic \
vi \
wa \
xh \
x-test \
zh_CN \
zh_HK \
zh_TW"

instfile=$tmpdir/inst-kde-l10n.nsi
uninstfile=$tmpdir/uninst-kde-l10n.nsi

cat > $instfile <<EOF
# THIS FILE IS GENERATED! See kde-l10n.sh
# Copyright (C) 2016 Intevation GmbH
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
!ifdef prefix
!undef prefix
!endif
!define kcfg_prefix \${ipdir}/kconfigwidgets-\${gpg4win_pkg_kconfigwidgets_version}
EOF
for frame in $KFRAMEWORKS $QFRAMEWORKS; do
    echo "!define ${frame}_prefix \${ipdir}/${frame}-\${gpg4win_pkg_${frame}_version}" >> $instfile
done
cat >> $instfile << EOF
!define prefix \${ipdir}/kde-l10n-\${gpg4win_pkg_kde_l10n_version}
!ifdef DEBUG
Section "kde-l10n" SEC_kde_l10n
!else
Section "-kde-l10n" SEC_kde_l10n
!endif
  SetOutPath "\$INSTDIR"
!ifdef SOURCES
  File "\${gpg4win_pkg_kde_l10n_src}"
!else
EOF

cat > $uninstfile <<EOF
# THIS FILE IS GENERATED! See kde-l10n.sh
# Copyright (C) 2016 Intevation GmbH
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
!ifdef prefix
!undef prefix
!endif
!define prefix \${ipdir}/kde-l10n-\${gpg4win_pkg_kde_l10n_version}

; Uninstaller section.
Section "-un.kde-l10n"
!ifdef SOURCES
  Push "\${gpg4win_pkg_kde-l10n}"
  Call un.SourceDelete
!else
EOF

l10ndir=$tmpdir/kde-l10n-$VERSION-src
mkdir -p $l10ndir
cd $l10ndir
for lang in $LANGS; do
    mkdir -p $lang
    cd $lang
    for pofile in $POFILES; do
        svn export svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/$lang/messages/$pofile \
        `basename $pofile` 2>/dev/null || \
        echo "$pofile not found in $lang"
    done
    cd ..
done

l10ndir_bin=$tmpdir/kde-l10n-$VERSION-bin
mkdir -p $l10ndir_bin
cd $l10ndir_bin
for lang in $LANGS; do
    if ! ls $l10ndir/$lang/*.po > /dev/null 2>&1; then
        # No kleo translations. Skip it.
        continue
    fi
    if ! [ -e "$g4widir/share/locale/$lang/kf5_entry.desktop" ]; then
        # No desktop file. Won't show up in ui
        echo "$g4widir/share/locale/$lang/kf5_entry.desktop does not exist"
        continue
    fi
    mkdir -p $l10ndir_bin/share/locale/$lang/LC_MESSAGES
    echo "  SetOutPath \"\$INSTDIR\\share\\locale\\$lang\"" >> $instfile
    echo "  File \${kcfg_prefix}/share/locale/$lang/kf5_entry.desktop" >> $instfile
    echo "  Delete \"\$INSTDIR\\share\\locale\\$lang\\kf5_entry.desktop\"" >> $uninstfile

    echo "  SetOutPath \"\$INSTDIR\\share\\locale\\$lang\\LC_MESSAGES\"" >> $instfile

    for frame in $KFRAMEWORKS; do
        if [ -e "$g4widir/share/locale/$lang/LC_MESSAGES/${frame}5.mo" ]; then
            echo "  File \${${frame}_prefix}/share/locale/$lang/LC_MESSAGES/${frame}5.mo" >> $instfile
            echo "  Delete \"\$INSTDIR\\share\\locale\\$lang\\LC_MESSAGES\\${frame}5.mo\"" >> $uninstfile
        fi
    done
    for frame in $QFRAMEWORKS; do
        if [ -e "$g4widir/share/locale/$lang/LC_MESSAGES/${frame}5_qt.qm" ]; then
            echo "  File \${${frame}_prefix}/share/locale/$lang/LC_MESSAGES/${frame}5_qt.qm" >> $instfile
            echo "  Delete \"\$INSTDIR\\share\\locale\\$lang\\LC_MESSAGES\\${frame}5_qt.qm\"" >> $uninstfile
        fi
    done

    for pofile in $POFILES; do
        moname=$(basename $pofile | sed 's/\.po/\.mo/')
        if msgfmt -o $l10ndir_bin/share/locale/$lang/LC_MESSAGES/$moname $l10ndir/$lang/`basename $pofile` 2>/dev/null; then
            echo "  File \${prefix}/share/locale/$lang/LC_MESSAGES/$moname" >> $instfile
            echo "  Delete \"\$INSTDIR\\share\\locale\\$lang\\LC_MESSAGES\\$moname\"" >> $uninstfile
        fi
    done
    echo "RMDir \"\$INSTDIR\\share\\locale\\$lang\\LC_MESSAGES\"" >> $uninstfile
    echo "RMDir \"\$INSTDIR\\share\\locale\\$lang\\LC_MESSAGES\"" >> $uninstfile
    echo "RMDir \"\$INSTDIR\\share\\locale\\$lang\"" >> $uninstfile
    cd ..
done
echo "RMDir \"\$INSTDIR\\share\\locale\"" >> $uninstfile
echo "RMDir \"\$INSTDIR\\share\"" >> $uninstfile
echo "RMDir \"\$INSTDIR\"" >> $uninstfile
echo "!endif" >> $uninstfile
echo "SectionEnd" >> $uninstfile
echo "!endif" >> $instfile
echo "SectionEnd" >> $instfile

cd $tmpdir
tar -cJf kde-l10n-$VERSION-src.tar.xz kde-l10n-$VERSION-src
cd $l10ndir_bin
tar -cJf ../kde-l10n-$VERSION-bin.tar.xz *
cd ..

echo "Done dir is: $tmpdir"

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
g4widir="$(readlink -f $(dirname $0)/../src/playground/install)"

if [ ! -e "$g4widir" ]; then
    echo "Please build gpg4win first."
    echo "This script needs installed packages to determine which frameworks localizations exist"
    exit 1
fi

# QFrameworks are frameworks that use qt translations
QFRAMEWORKS="kconfig kcompletion kcodecs kcoreaddons kitemviews kwidgetsaddons kwindowsystem sonnet"
# KFrameworks are frameworks that use KDE translations
KFRAMEWORKS="kconfigwidgets ki18n kiconthemes kxmlgui kio kparts kjobwidgets kbookmarks ktextwidgets"

POPREFIXES="kleopatra libkleo okular mimetreeparser"
POFILES="libkleo/libkleopatra.po \
    kleopatra/kleopatra.po \
    okular/okular.po okular/okular_poppler.po \
    mimetreeparser/mimetreeparser.po"
# See: https://websvn.kde.org/*checkout*/trunk/l10n-kf5/subdirs
# and remove x-test
LANGS="
af \
ar \
as \
ast \
az \
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
en \
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
ie \
is \
it \
ja \
ka \
kab \
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
my \
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
tn \
tok \
tr \
tt \
ug \
uk \
uz \
uz@cyrillic \
vi \
wa \
xh \
zh_CN \
zh_HK \
zh_TW"

instfile=$(readlink -f $(dirname $0)/../src/inst-kde-l10n.nsi)
uninstfile=$(readlink -f $(dirname $0)/../src/uninst-kde-l10n.nsi)

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
!define kcfg_prefix \${ipdir}/kconfigwidgets-\${gpg4win_pkg_kconfigwidgets_version}
EOF
for frame in $KFRAMEWORKS $QFRAMEWORKS $POPREFIXES; do
    echo "!define ${frame}_prefix \${ipdir}/${frame}-\${gpg4win_pkg_${frame}_version}" >> $instfile
done
cat >> $instfile << EOF
!ifdef DEBUG
Section "kde-l10n" SEC_kde_l10n
!else
Section "-kde-l10n" SEC_kde_l10n
!endif
  SetOutPath "\$INSTDIR"
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

; Uninstaller section.
Section "-un.kde-l10n"
EOF

for lang in $LANGS; do
    if [ ! -e "$g4widir/share/locale/$lang/LC_MESSAGES/kleopatra.mo" ]; then
        echo No kleo translations. Skip $lang
        continue
    fi
    translated=$(msgfmt --statistics $g4widir/../build/kleopatra-*/po/$lang/kleopatra.po 2>&1 | tail -n 1 | cut -f 1 -d " ")
    if [ -n "$translated" -a "$translated" -lt "500" ]; then
        echo "Only $translated strings translated in $lang - skipping"
        continue
    fi
    if ! [ -e "$g4widir/share/locale/$lang/kf5_entry.desktop" ]; then
        # No desktop file. Won't show up in ui
        echo "$g4widir/share/locale/$lang/kf5_entry.desktop does not exist"
        continue
    fi
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
        poprefix="`dirname $pofile`_prefix"
        if [ -f "$g4widir/share/locale/$lang/LC_MESSAGES/$moname" ]; then
            echo "  File \${$poprefix}/share/locale/$lang/LC_MESSAGES/$moname" >> $instfile
            echo "  Delete \"\$INSTDIR\\share\\locale\\$lang\\LC_MESSAGES\\$moname\"" >> $uninstfile
        else
            echo "$pofile not found installed in $lang skipping"
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
echo "SectionEnd" >> $uninstfile
echo "SectionEnd" >> $instfile


echo "Translations updated. Plase check git diff"

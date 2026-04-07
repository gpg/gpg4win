# Makefile.am - Installer for GnuPG 4 Windows Makefile.
# Copyright (C) 2005, 2008, 2012 g10 Code GmbH
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
# along with this program; if not, see <http://www.gnu.org/licenses/>.

ACLOCAL_AMFLAGS = -I m4
AUTOMAKE_OPTIONS = dist-xz no-dist-gzip
DISTCHECK_CONFIGURE_FLAGS = --host=i686-w64-mingw32

if BUILD_GPG4WIN
po = po
else
po =
endif
if BUILD_GPG4WIN
doc = doc
else
doc =
endif

SUBDIRS = ${po} packages ${doc} src

# Use these commands to update the list of patches; the commands are different because in
# patches-appimage we use symbolic links to folders in patches:
# git ls-files patches | sed 's/$/ \\/' | sed 's/^/             /'
# find -L patches-appimage -name *.patch | sort | sed 's/$/ \\/' | sed 's/^/             /'

EXTRA_DIST = build.sh autogen.rc autogen.sh VERSION README.GIT ONEWS \
             doc/license-page doc/GPLv3 \
             build-aux/git-log-footer build-aux/git-log-fix \
             build-aux/gpg-authcode-sign.sh \
             docker/appimage/Dockerfile \
             docker/gpg4win-trixie/Dockerfile \
             docker/gpg4win-trixie/mingw-pthread-run-reverse-order.patch \
             patches/breeze-icons/0001-Add-folder-edit-sign-encrypt-icon.patch \
             patches/breeze-icons/add-the-nose.patch \
             patches/breeze-icons/azz-Make-all-breeze-icons-available-in-breeze-dark.patch \
             patches/breeze-icons/subset-crossbuild.patch \
             patches/extra-cmake-modules/0001-Use-BIN_INSTALL_DIR-data-for-DATAROOTDIR-on-Windows.patch \
             patches/jpeg/fix-redefine.patch \
             patches/kconfig/0001-Read-defaults-from-Windows-registry.patch \
             patches/kconfig/0002-Fix-reading-of-localized-config-values-on-Windows-an.patch \
             patches/kconfig/0003-Use-QStandardPaths-GenericStateLocation-on-all-platf.patch \
             patches/kconfigwidgets/0001-Fix-crash-on-exit-on-Windows.patch \
             patches/kconfigwidgets/0001-Make-QDbus-optional.patch \
             patches/kcoreaddons/0001-Fix-MINGW-build.patch \
             patches/kguiaddons/0001-DRAFT-There-is-no-dark-mode-on-old-Windows.patch \
             patches/ki18n/0001-Undef-snprintf-for-windows.patch \
             patches/kiconthemes/0001-Make-DBus-optional.patch \
             patches/kiconthemes/dark-mode-detection.patch \
             patches/kio/0001-WIP-Remove-dependency-to-dbus.patch \
             patches/kio/FileManagerWindowJob.patch \
             patches/kleopatra/set-windows-registry.patch \
             patches/kparts/0001-Apply-implicit-android-DBUS-fix-for-Win.patch \
             patches/kparts/disable-jobuidelegate.patch \
             patches/kwidgetsaddons/0001-Set-the-modes-on-the-date-picker.patch \
             patches/kwidgetsaddons/0002-Remove-No-date-option-from-date-picker-popup-used-by.patch \
             patches/kwidgetsaddons/fix-height-of-text-after-update.patch \
             patches/kxmlgui/0001-Store-kxmlgui-rc-file-in-config-location.patch \
             patches/kxmlgui/0001-make-qdbus-optional.patch \
             patches/kxmlgui/0002-stretch-aboutpage.patch \
             patches/kxmlgui/0004-Cruedly-disable-KSendbugmail.patch \
             patches/libical/workaround-weird-mingw-10.0.0-issue.patch \
             patches/okular/0001-Add-GnuPG-specific-manifest-to-okular.patch \
             patches/okular/0001-Add-support-to-customize-about-data.patch \
             patches/okular/lower-cmake-requirement.patch \
             patches/qtbase/0001-Add-StateLocation-GenericStateLocation-to-StandardLo.patch \
             patches/qtbase/0001-Don-t-report-active-windows-as-having-focus-unless-t.patch \
             patches/qtbase/0001-Gpg4win-qstandardpaths-patch.patch \
             patches/qtbase/0002-Gpg4win-theme-names-and-relpaths.patch \
             patches/qtbase/0004-Fix-tree-table-list-accessibility-state.patch \
             patches/qtbase/0005-a11y-Return-correct-string-information-for-item-view.patch \
             patches/qtbase/CVE-2023-32762-qtbase-5.15.patch \
             patches/qtbase/CVE-2023-32763-qtbase-5.15.patch \
             patches/qtbase/CVE-2023-34410-qtbase-5.15.patch \
             patches/qtbase/CVE-2023-37369-qtbase-5.15.patch \
             patches/qtbase/CVE-2023-38197-qtbase-5.15.patch \
             patches/qtbase/CVE-2023-43114-5.15.patch \
             patches/qtbase/CVE-2023-51714-0001-qtbase-5.15.patch \
             patches/qtbase/CVE-2023-51714-0002-qtbase-5.15.patch \
             patches/qtbase/CVE-2024-25580-qtbase-5.15.patch \
             patches/qtbase/CVE-2024-39936-qtbase-5.15.patch \
             patches/qtbase/CVE-2025-30348-qtbase-5.15.patch \
             patches/qtbase/CVE-2025-4211-qtbase-5.15.patch \
             patches/qtbase/CVE-2025-5455-qtbase-5.15.patch \
             patches/qtbase/add-kleopatras-mime-types.patch \
             patches/qtbase/fix-high-contrast-item-view-selection-color.patch \
             patches/qtbase/fix-queryHighContrast.patch \
             patches/qtbase/fix-tooltip-text-color-with-dark-theme.patch \
             patches/qtbase/use-fusion-style-for-high-contrast-mode.patch \
             patches/qtsvg/CVE-2023-32573-qtsvg-5.15.patch \
             patches/qttools/disable-most-tools.patch \
             patches/sonnet/0001-W32-Force-ispellchecker-for-sonnet.patch \
             patches-appimage/kcoreaddons/0001-Fix-MINGW-build.patch \
             patches-appimage/kleopatra-202501221111/0001-Explicitely-require-threads.patch \
             patches-appimage/kwidgetsaddons/0001-Set-the-modes-on-the-date-picker.patch \
             patches-appimage/kwidgetsaddons/0002-Remove-No-date-option-from-date-picker-popup-used-by.patch \
             patches-appimage/kwidgetsaddons/fix-height-of-text-after-update.patch \
             patches-appimage/okular/0001-Add-support-to-customize-about-data.patch \
             patches-appimage/okular/0001-Make-KF5Pty-dependency-optional.patch \
             patches-appimage/okular/lower-cmake-requirement.patch \
             patches-appimage/poppler/fix-gpg-error-include.patch \
             patches-appimage/qtbase/0001-Add-StateLocation-GenericStateLocation-to-StandardLo.patch \
             patches-appimage/qtbase/0001-Don-t-report-active-windows-as-having-focus-unless-t.patch \
             patches-appimage/qtbase/0001-Gpg4win-qstandardpaths-patch.patch \
             patches-appimage/qtbase/0002-Gpg4win-theme-names-and-relpaths.patch \
             patches-appimage/qtbase/0004-Fix-tree-table-list-accessibility-state.patch \
             patches-appimage/qtbase/0005-a11y-Return-correct-string-information-for-item-view.patch \
             patches-appimage/qtbase/add-kleopatras-mime-types.patch \
             patches-appimage/qtbase/CVE-2023-32762-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2023-32763-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2023-34410-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2023-37369-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2023-38197-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2023-43114-5.15.patch \
             patches-appimage/qtbase/CVE-2023-51714-0001-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2023-51714-0002-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2024-25580-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2024-39936-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2025-30348-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2025-4211-qtbase-5.15.patch \
             patches-appimage/qtbase/CVE-2025-5455-qtbase-5.15.patch \
             patches-appimage/qtbase/fix-high-contrast-item-view-selection-color.patch \
             patches-appimage/qtbase/fix-queryHighContrast.patch \
             patches-appimage/qtbase/fix-tooltip-text-color-with-dark-theme.patch \
             patches-appimage/qtbase/use-fusion-style-for-high-contrast-mode.patch \
             patches-appimage/qtsvg/CVE-2023-32573-qtsvg-5.15.patch \
             patches-appimage/qtwayland-5.15.0/00-disable-wayland-server.patch

dist-hook: gen-ChangeLog pack_packages_tarballs

if BUILD_W64_COND
w64_extraargs=" --w64"
endif

distcheck-hook:
	set -e; ( \
	pref="#+macro: gpg4win_" ;\
	reldate="$$(date -u +%Y-%m-%d)" ;\
        echo "$${pref}ver  $(PACKAGE_VERSION)"  ;\
        echo "$${pref}date $${reldate}" ;\
        list='$(DIST_ARCHIVES)'; for i in $$list; do \
	  case "$$i" in *.tar.bz2) \
            echo "$${pref}size $$(wc -c <$$i|awk '{print int($$1/1024)}')k" ;\
	    echo "$${pref}sha1 $$(sha1sum <$$i|cut -d' ' -f1)" ;\
	    echo "$${pref}sha2 $$(sha256sum <$$i|cut -d' ' -f1)" ;;\
	  esac;\
	done ) | tee $(distdir).swdb

# Names of to help the release target.
RELEASE_NAME = $(PACKAGE_TARNAME)-$(PACKAGE_VERSION)

gen_start_date = 2012-03-26T00:00:00
.PHONY: gen-ChangeLog
gen-ChangeLog:
	set -e;                         				\
	if test -d $(top_srcdir)/.git; then				\
	  (cd $(top_srcdir) &&                      			\
	    $(GITLOG_TO_CHANGELOG) --append-dot --tear-off		\
	    --amend=build-aux/git-log-fix                		\
	    --since=$(gen_start_date) ) > $(distdir)/cl-t;		\
          cat $(top_srcdir)/build-aux/git-log-footer >> $(distdir)/cl-t;\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

# We also need to package all tarballs.  Actually it would be better
# to pack only those which are listed in packages.current but for this
# wen need to extend the script and also handle the package list for
# appimages.  Note further that we can't use ln(1) because /src and
# /build are on different partitions inside docker.
.PHONY: pack_packages_tarballs
pack_packages_tarballs:
	(find $(top_srcdir)/packages -type f \
           \( -name '*.tar.gz' -o -name '*.tar.bz2' \
           -o -name '*.tar.xz' -o -name '*.zip' \
           -o -name '*.exe' -o -name '*.wixlib' \
           \) -print | xargs cp -t $(distdir)/packages/ )


download: packages/packages.list
	(cd packages; ./download.sh)

vsd-versions: src/stamps/stamp-versions-all-signed

rebuild:
	./build.sh --update-img --inplace $(w64_extraargs)

clean-local:
	-rm -rf artifacts
	-rm -f $(RELEASE_NAME).tar.xz files-to-commit.lst

distclean-local:
	-rm -f $(RELEASE_NAME).swdb


msi:
	$(MAKE) $(AM_MAKEFLAGS) -C src \
		TOPSRCDIR=/src PLAYGROUND=/build msi

msi-signed:
	$(MAKE) $(AM_MAKEFLAGS) -C src \
		TOPSRCDIR=/src PLAYGROUND=/build msi-signed

msi-upload:
	$(MAKE) $(AM_MAKEFLAGS) -C src \
		TOPSRCDIR=/src PLAYGROUND=/build msi-upload

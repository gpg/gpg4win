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

# Use this command to update the list of patches
# git ls-files patches | sed 's/$/ \\/' | sed 's/^/             /'

EXTRA_DIST = build.sh autogen.rc autogen.sh VERSION README.GIT ONEWS \
             doc/license-page doc/GPLv3 build.sh \
             build-aux/git-log-footer build-aux/git-log-fix \
             build-aux/gpg-authcode-sign.sh \
             docker/appimage/Dockerfile \
             docker/gpg4win-trixie/Dockerfile \
             docker/gpg4win-trixie/mingw-pthread-run-reverse-order.patch \
             patches/breeze-6.5.4-g10/0001-Do-not-alias-QtOpenGL-and-QtNetwork.patch \
             patches/breeze-6.5.4-g10/0001-Do-not-pass-QIcon-Selected-mode-to-icon-painter.patch \
             patches/breeze-6.5.4-g10/0001-kstyle-Draw-hovered-menu-bar-items-like-selected-ite.patch \
             patches/breeze-icons/0001-Add-16x16-variant-of-data-success.patch \
             patches/breeze-icons/0004-Add-symbolic-variants-of-status-icons-for-usage-with.patch \
             patches/breeze-icons/0005-Disable-recoloring-of-status-icons.patch \
             patches/breeze-icons/remove-kleopatra-icons.patch \
             patches/breeze/0000-Remove-references-to-wallpapers-and-cursors.patch \
             patches/breeze/0001-Add-helper-for-checking-if-high-contrast-color-schem.patch \
             patches/breeze/0001-Don-t-use-mixed-colors-for-frames-if-high-contrast-i.patch \
             patches/breeze/0005-For-high-contrast-draw-hovered-menu-items-like-selec.patch \
             patches/extra-cmake-modules/0001-Revert-Use-BIN_INSTALL_DIR-data-for-DATAROOTDIR-on-Windows.patch \
             patches/extra-cmake-modules/0001-Use-preferred-display-language-instead-of-locale-on-.patch \
             patches/gpgol-2.7.2/0001-Require-C-17.patch \
             patches/gpgoljs/0001-Allow-to-compile-on-Mac.patch \
             patches/gpgoljs/0001-Switch-to-KDSingleApplication-for-handling-unique-in.patch \
             patches/gpgoljs/0002-Work-around-failure-to-accept-custom-root-cert-on-Ma.patch \
             patches/jpeg/fix-redefine.patch \
             patches/kconfig-6.31.0/00-kf632-0001-Ensure-locale-name-with-language-code-and-country-co.patch \
             patches/kconfig/0001-g10-Set-organization-name-of-kreadconfig-for-Windows.patch \
             patches/kf5/breeze-icons/subset-crossbuild.patch \
             patches/kf5/kconfig/0001-Read-defaults-from-Windows-registry.patch \
             patches/kf5/kconfigwidgets/0001-Fix-crash-on-exit-on-Windows.patch \
             patches/kf5/kconfigwidgets/0001-Make-QDbus-optional.patch \
             patches/kf5/kcoreaddons/0001-Fix-MINGW-build.patch \
             patches/kf5/kiconthemes/0001-Make-DBus-optional.patch \
             patches/kf5/kiconthemes/dark-mode-detection.patch \
             patches/kf5/kleopatra/set-windows-registry.patch \
             patches/kf5/kwidgetsaddons/0001-Set-the-modes-on-the-date-picker.patch \
             patches/kf5/kwidgetsaddons/0002-Remove-No-date-option-from-date-picker-popup-used-by.patch \
             patches/kf5/kwidgetsaddons/fix-height-of-text-after-update.patch \
             patches/kf5/qtbase/0001-Gpg4win-qstandardpaths-patch.patch \
             patches/kf5/qtbase/CVE-2023-32763-qtbase-5.15.patch \
             patches/kf5/qtbase/CVE-2023-37369-qtbase-5.15.patch \
             patches/kf5/qtbase/CVE-2023-43114-5.15.patch \
             patches/kf5/qtsvg/CVE-2023-32573-qtsvg-5.15.patch \
             patches/kf5/qttools/disable-most-tools.patch \
             patches/kf5/sonnet/0001-W32-Force-ispellchecker-for-sonnet.patch \
             patches/kguiaddons/0002-DRAFT-There-is-no-dark-mode-on-old-Windows.patch \
             patches/ki18n/0001-Undef-snprintf-for-windows.patch \
             patches/ki18n/0001-gpg4win-fix-language-issues.patch \
             patches/kiconthemes/0001-Add-helper-for-checking-if-high-contrast-color-schem.patch \
             patches/kiconthemes/0002-Use-symbolic-icons-if-high-contrast-color-scheme-is-.patch \
             patches/kjobwidgets/0001-Remove-knotification.patch \
             patches/kwidgetsaddons/0002-KMessageWidget-Don-t-draw-background-if-high-contras.patch \
             patches/kxmlgui/0001-Store-kxmlgui-rc-file-in-config-location.patch \
             patches/libayatana-appindicator/downpatch_requirements.patch \
             patches/libayatana-ido/downpatch_requirements.patch \
             patches/libayatana-indicator/downpatch_requirements.patch \
             patches/libical/workaround-weird-mingw-10.0.0-issue.patch \
             patches/libqrencode/0001-fix-cmake-install-paths.patch \
             patches/okular/0001-Add-GnuPG-specific-manifest-to-okular.patch \
             patches/okular/0001-Add-support-to-customize-about-data.sik \
             patches/okular/0002-hide_finish_signing_banner_on_document_reload.patch \
             patches/okular/pgp-default-true.patch \
             patches/pcre2/cross-build-cmake.patch \
             patches/poppler/downgrade-min-boost.patch \
             patches/poppler/downgrade-min-fontconfig.patch \
             patches/qtbase/00-qt6xx-0001-Fix-a11y-window-activation-events.patch \
             patches/qtbase/0001-Don-t-report-tabname-as-name-of-tabbar.patch \
             patches/qtbase/0001-Gpg4win-qstandardpaths-patch.patch \
             patches/qtbase/0002-no-dark-mode-on-old-windows-10.patch \
             patches/qtbase/add-kleopatras-mime-types.patch \
             patches/qtbase/configurable-windowstheme.patch \
             patches/qtbase/fix_macos_26_5_build.patch \
             patches/qtbase/qstandardpaths_macos.patch \
             patches/qtbase/qt_use_share_instead_of_data.patch \
             patches/qthttpserver/originAuthenticationRequired.patch

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

dnl appimage.m4 - macros to configure appimage.
dnl Copyright (C) 2005, 2009 g10 Code GmbH
dnl
dnl This file is part of GPG4Win.
dnl
dnl GPG4Win is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 2 of the License, or
dnl (at your option) any later version.
dnl
dnl GPG4Win is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, see <https://www.gnu.org/licenses/>.


# APPIMAGE_DEFINE SYMBOL
# A poor man's version of AC_DEFINE_UNQUOTED for NSIS.
AC_DEFUN([APPIMAGE_DEFINE],
[
  eval $1=\"\!define $1 1\"
  AC_SUBST($1)
])


# APPIMAGE_BASH
# Gpg4Win needs bash.  This macro checks for it.
AC_DEFUN([APPIMAGE_BASH],
[
  AC_MSG_CHECKING([for Bash])
  _bash=$BASH_VERSION
  if test -z "$_bash"; then
    _bash=no
  fi
  AC_MSG_RESULT($_bash)
  if test $_bash = no; then
    AC_MSG_ERROR("this configure script requires Bash")
  fi
])


# APPIMAGE_PACKAGES
# Determines the path to the source and binary packages.
# Default is the "packages" directory in the source directory.
# The path is stored in the shell variable appimage_packages.
AC_DEFUN([APPIMAGE_PACKAGES],
[
  AC_MSG_CHECKING(for packages directory)
  _appimage_packages_default=packages
  AC_ARG_WITH([packages],
    AS_HELP_STRING([--with-packages=DIR],
                   [source and binary packages [[packages]]]),
    appimage_packages=$withval)
  AS_IF([test -z $appimage_packages],
        [appimage_packages=$_appimage_packages_default])
  AS_IF([test `echo $appimage_packages | head -c 1` != /],
        [appimage_packages=`pwd`/$appimage_packages])
  AC_SUBST(appimage_packages)
  AC_MSG_RESULT($appimage_packages)

  # Set auto-detection.  FIXME: This should accept a comma-separated
  # list of packages that will be autodetected.
  _appimage_auto_detection=yes
  AC_ARG_ENABLE([packages],
    AS_HELP_STRING([--enable-packages], [enable auto-detection [[yes]]]),
    _appimage_auto_detection=$enableval)
])


# Should be called early.
AC_DEFUN([APPIMAGE_INIT],
[
  # We call this here so its options appear before the per-package options.
  AC_REQUIRE([APPIMAGE_PACKAGES])
])


# APPIMAGE_FIND([FILE],[PATTERN],[ZIP|TAR],[DIR],[IF-FOUND],[IF-NOT-FOUND])
# Search for package file FILE in DIR.  If DIR is empty, yes or maybe,
# look in default directory.  If DIR is not maybe, abort if not found.
# The package file name is provided in appimage_val and the version in
# appimage_version.
AC_DEFUN([APPIMAGE_FIND],
[
  AC_REQUIRE([APPIMAGE_BASH])
  AC_REQUIRE([APPIMAGE_PACKAGES])

  appimage_val=
  appimage_version=

  AC_MSG_CHECKING(for package $1)
  _appimage_critical=no
  _appimage_file=
  _appimage_dir=$4

  # If --enable-pkg-foo was specified, make success critical.
  AS_IF([test x$_appimage_dir != xmaybe], [_appimage_critical=yes])

  # Only check if critical or auto detection is requested.
  AS_IF([test $_appimage_auto_detection = yes -o $_appimage_critical = yes],
    [AS_IF([test -z "$_appimage_dir" -o "$_appimage_dir" = yes -o "$_appimage_dir" = maybe],
          [_appimage_dir=$appimage_packages])

    # Install pattern.
    AS_IF([test -z "$2"], [_appimage_pat='$1-\([[0-9]].*\)'],
          [_appimage_pat="$2"])

    # Frob pattern.  Regex party!
    [_appimage_glob=`echo "$_appimage_pat" | sed -e 's/\\\\(\(.*\)\\\\)/\1/'`]
    [_appimage_glob=`echo "$_appimage_glob" | sed -e 's/\\.\\*/*/'`]

    # Make non-matching globs expand to nothing.
    shopt -s nullglob

    _appimage_format=both
    AS_IF([test ! -z "$3"], _appimage_format="$3")

    AS_IF([test -z "$_appimage_file" -a $_appimage_format != zip],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.tar.xz`
           _appimage_suffix=.tar.xz])
    AS_IF([test -z "$_appimage_file" -a $_appimage_format != zip],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.tar.bz2`
           _appimage_suffix=.tar.bz2])
    AS_IF([test -z "$_appimage_file" -a $_appimage_format != zip],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.tbz2`
           _appimage_suffix=.tbz2])
    AS_IF([test -z "$_appimage_file" -a $_appimage_format != zip],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.tbz`
           _appimage_suffix=.tbz])
    AS_IF([test -z "$_appimage_file" -a $_appimage_format != zip],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.tar.gz`
           _appimage_suffix=.tar.gz])
    AS_IF([test -z "$_appimage_file" -a $_appimage_format != zip],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.tgz`
           _appimage_suffix=.tgz])
    AS_IF([test -z "$_appimage_file" -a $_appimage_format != tar],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.zip`
           _appimage_suffix=.zip])
    AS_IF([test -z "$_appimage_file" -a $_appimage_format != tar -a $_appimage_format != zip],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.exe`
           _appimage_suffix=.exe])
    AS_IF([test -z "$_appimage_file" -a $_appimage_format != tar -a $_appimage_format != zip],
          [_appimage_file=`echo ${_appimage_dir}/${_appimage_glob}.wixlib`
           _appimage_suffix=.wixlib])
    shopt -u nullglob])

  AS_IF([test -z "$_appimage_file"],
        AC_MSG_RESULT(no),
        AS_IF([test `echo $_appimage_file | head -c 1` != /],
              [_appimage_file=`pwd`/$_appimage_file])
        AC_MSG_RESULT($_appimage_file))
  AS_IF([test -z "$_appimage_file" -a $_appimage_critical = yes],
        AC_MSG_ERROR(could not find sources for $1 in $_appimage_dir))

  # Test for duplicate.
  _appimage_found=
  for _appimage_f in $_appimage_file; do
      AS_IF([test "$_appimage_found" = yes],
            [AC_MSG_WARN(found more than one sources for $1 in $_appimage_dir)
             appimage_dup_sources="$appimage_dup_sources $1";
             appimage_rm_candidates="$appimage_rm_candidates $_appimage_file"])
      _appimage_found=yes
  done

  AS_IF([test ! -z "$_appimage_file"],
        [appimage_val="$_appimage_file"
        [appimage_version=`echo "$appimage_val" | sed -e "s,^.*/${_appimage_pat}${_appimage_suffix}$,\1,"`]
         [$5]],
        [$6])
])


AC_DEFUN([APPIMAGE_CHECK_DEPS],
[
  AC_MSG_CHECKING(build list)
  appimage_build_list=`echo $_appimage_deps | tsort`
  # Remove newlines.
  appimage_build_list=`echo $appimage_build_list`
  AC_MSG_RESULT($appimage_build_list)
  AC_SUBST(appimage_build_list)

  # Check each dependency.
  _appimage_not_found=
  _appimage_d=
  _appimage_p=
  for _appimage_p in $_appimage_deps; do
    AS_IF([test -z $_appimage_d], [_appimage_d=$_appimage_p],
          [
            _appimage_found=
            for _appimage_i in $_appimage_pkgs; do
              AS_IF([test $_appimage_d = $_appimage_i],
                    _appimage_found=yes
                    break)
            done
            AS_IF([test -z $_appimage_found],
                  AC_MSG_WARN(could not find package $_appimage_d required by package $_appimage_p)
                  _appimage_not_found=yes)
            _appimage_d=
          ])
  done
  AS_IF([test ! -z "$_appimage_not_found"],
        AC_MSG_ERROR([could not find some required packages]))
])


AC_DEFUN([APPIMAGE_FINALIZE],
[
  AC_REQUIRE([APPIMAGE_CHECK_DEPS])

  _appimage_debug=no
  AC_ARG_ENABLE([debug],
    AS_HELP_STRING([--enable-debug], [enable debugging [[no]]]),
    _appimage_debug=$enableval)

  AS_IF([test "${_appimage_debug}" != no],
    APPIMAGE_DEFINE(APPIMAGE_DEBUG))
])


# APPIMAGE_SPKG([PKG],[DEPENDS],[IF-FOUND],[IF-NOT-FOUND])
# Set up the source package PKG.
# It is provided in appimage_val.
AC_DEFUN([APPIMAGE_SPKG],
[
  AC_REQUIRE([APPIMAGE_INIT])
  _appimage_pkg=maybe
  AC_ARG_ENABLE([pkg-$1],
    AS_HELP_STRING([--enable-pkg-$1[=DIR]],
                   [include package $1]),
    _appimage_pkg=$enableval)
  _appimage_spkg=no
  _appimage_version=
  AS_IF([test "$_appimage_pkg" != no],
        [APPIMAGE_FIND($1,,, $_appimage_pkg,
	 _appimage_spkg=$appimage_val
	 _appimage_version=$appimage_version)])

  # At this point, _appimage_spkg is no, or the actual package source file.

  # appimage_pkg_PKGNAME=FILENAME_OF_SOURCE
  appimage_pkg_[]m4_translit([$1],[-+],[__])[]=$_appimage_spkg
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[-+],[__]))

  # appimage_pkg_PKGNAME_version=VERSION
  appimage_pkg_[]m4_translit([$1],[-+],[__])[]_version=$_appimage_version
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[-+],[__])[]_version)

  # appimage_pkg_PKGNAME_deps=DEPS
  appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps="$2"
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps)

  AS_IF([test "$_appimage_spkg" != no],
    _appimage_pkgs="$_appimage_pkgs $1"
    APPIMAGE_DEFINE(HAVE_PKG_[]m4_translit([$1],[a-z+-],[A-Z__]))
    # Record dependencies.  Also enter every package as node.
    _appimage_deps="$_appimage_deps $1 $1"
    AS_IF([test ! -z "$2"],
          for _appimage_i in $2; do
            _appimage_deps="$_appimage_deps $_appimage_i $1"
          done)
      [$3],
      [$4])
])


# APPIMAGE_KDEPKG([PKG],[DEPENDS],[IF-FOUND],[IF-NOT-FOUND])
# Set up the KDE source package PKG.
# It is provided in appimage_val.
AC_DEFUN([APPIMAGE_KDEPKG],
[
  AC_REQUIRE([APPIMAGE_INIT])
  _appimage_pkg=maybe
  AC_ARG_ENABLE([pkg-$1],
    AS_HELP_STRING([--enable-pkg-$1[=DIR]],
                   [include package $1]),
    _appimage_pkg=$enableval)
  _appimage_kdepkg=no
  _appimage_version=
  AS_IF([test "$_appimage_pkg" != no],
        [APPIMAGE_FIND($1,,, $_appimage_pkg,
        _appimage_kdepkg=$appimage_val
        _appimage_version=$appimage_version)])

  # appimage_pkg_PKGNAME=FILENAME_OF_SOURCE
  appimage_pkg_[]m4_translit([$1],[-+],[__])[]=$_appimage_kdepkg
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[-+],[__]))

  # appimage_pkg_PKGNAME_version=VERSION
  appimage_pkg_[]m4_translit([$1],[-+],[__])[]_version=$_appimage_version
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[-+],[__])[]_version)

  # appimage_pkg_PKGNAME_deps=DEPS
  appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps="$2"
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps)

  AS_IF([test "$_appimage_kdepkg" != no],
    _appimage_pkgs="$_appimage_pkgs $1"
    APPIMAGE_DEFINE(HAVE_PKG_[]m4_translit([$1],[a-z+-],[A-Z__]))
    # Record dependencies.  Also enter every package as node.
    _appimage_deps="$_appimage_deps $1 $1"
    AS_IF([test ! -z "$2"],
          for _appimage_i in $2; do
            _appimage_deps="$_appimage_deps $_appimage_i $1"
          done)
      [$3],
      [$4])
])

# APPIMAGE_BPKG_BINSRC([PKG],[DEPENDS],[IF-FOUND],[IF-NOT-FOUND])
# Set up package PKG which is expected to be delivered as two ZIP files
# with a "-(src|source)" and a "-(bin|noinstaller)" suffix.
AC_DEFUN([APPIMAGE_BPKG_BINSRC],
[
  AC_REQUIRE([APPIMAGE_INIT])
  _appimage_pkg=maybe
  AC_ARG_ENABLE([pkg-$1],
    AS_HELP_STRING([--enable-pkg-$1[=DIR]],
                   [include package $1]),
    _appimage_pkg=$enableval)
  _appimage_bpkg=no
  _appimage_version=
  AS_IF([test "$_appimage_pkg" != no],
        [APPIMAGE_FIND($1-bin, [$1-\(.*\)-bin],,
         $_appimage_pkg,
         _appimage_bpkg=$appimage_val
	 _appimage_version=$appimage_version)])
  AS_IF([test "$_appimage_pkg" != no -a "$_appimage_bpkg" = no],
        [APPIMAGE_FIND($1-noinstaller, [$1-\(.*\)-noinstaller],,
         $_appimage_pkg,
         _appimage_bpkg=$appimage_val
	 _appimage_version=$appimage_version)])

  # At this point, _appimage_bpkg is no, or the actual package binary file.

  # appimage_pkg_PKGNAME=FILENAME_OF_BINARY
  appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]=$_appimage_bpkg
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__]))

  # appimage_pkg_PKGNAME_version=VERSION
  appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_version=$_appimage_version
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_version)

  # appimage_pkg_PKGNAME_deps=DEPS
  appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps="$2"
  AC_SUBST(appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps)

  AS_IF([test "$_appimage_bpkg" != no],
    tmp_binsrc=yes
    APPIMAGE_FIND($1-src, [$1-\(.*\)-src],,
                 $_appimage_pkg, _appimage_bpkg=$appimage_val, tmp_binsrc=no)
    if test $tmp_binsrc = no ; then
       APPIMAGE_FIND($1-source, [$1-\(.*\)-source],,
                    $_appimage_pkg, _appimage_bpkg=$appimage_val,
                    AC_MSG_ERROR(can not find sources for package $1))
    fi
    # appimage_pkg_PKGNAME_src=FILENAME_OF_SOURCE
    appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_src=$_appimage_bpkg
    AC_SUBST(appimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_src)

    # FIXME: Add a version consistency check here.  Both packages
    # must match!

    APPIMAGE_DEFINE(HAVE_PKG_[]m4_translit([$1],[a-z+-],[A-Z__]))

    _appimage_pkgs="$_appimage_pkgs []m4_translit([$1],[A-Z],[a-z])"
    # Record dependencies.  Also enter every package as node.
    _appimage_deps="$_appimage_deps []m4_translit([$1],[A-Z],[a-z]) []m4_translit([$1],[A-Z],[a-z])"
    AS_IF([test ! -z "$2"],
          for _appimage_i in $2; do
            _appimage_deps="$_appimage_deps $_appimage_i []m4_translit([$1],[A-Z],[a-z])"
          done)
          [$3],
          [$4])
])

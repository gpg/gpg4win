dnl macimage.m4 - macros to configure MacOS image.
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


# MACIMAGE_DEFINE SYMBOL
# A poor man's version of AC_DEFINE_UNQUOTED for NSIS.
AC_DEFUN([MACIMAGE_DEFINE],
[
  eval $1=\"\!define $1 1\"
  AC_SUBST($1)
])


# MACIMAGE_BASH
# Gpg4Win needs bash.  This macro checks for it.
AC_DEFUN([MACIMAGE_BASH],
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


# MACIMAGE_PACKAGES

# Determines the path to the source and binary packages.
# Default is the "/src/packages" directory.
# The path is stored in the shell variable macimage_packages.
AC_DEFUN([MACIMAGE_PACKAGES],
[
  AC_MSG_CHECKING(for packages directory)
  _macimage_packages_default=/src/packages
  AC_ARG_WITH([packages],
    AS_HELP_STRING([--with-packages=DIR],
                   [source and binary packages [[packages]]]),
    macimage_packages=$withval)
  AS_IF([test -z $macimage_packages],
        [macimage_packages=$_macimage_packages_default])
  AS_IF([test `echo $macimage_packages | head -c 1` != /],
        [macimage_packages=`pwd`/$macimage_packages])
  AC_SUBST(macimage_packages)
  AC_MSG_RESULT($macimage_packages)

  # Set auto-detection.  FIXME: This should accept a comma-separated
  # list of packages that will be autodetected.
  _macimage_auto_detection=yes
  AC_ARG_ENABLE([packages],
    AS_HELP_STRING([--enable-packages], [enable auto-detection [[yes]]]),
    _macimage_auto_detection=$enableval)
])


# Should be called early.
AC_DEFUN([MACIMAGE_INIT],
[
  # We call this here so its options appear before the per-package options.
  AC_REQUIRE([MACIMAGE_PACKAGES])
])


# MACIMAGE_FIND([FILE],[PATTERN],[ZIP|TAR],[DIR],[IF-FOUND],[IF-NOT-FOUND])
# Search for package file FILE in DIR.  If DIR is empty, yes or maybe,
# look in default directory.  If DIR is not maybe, abort if not found.
# The package file name is provided in macimage_val and the version in
# macimage_version.
AC_DEFUN([MACIMAGE_FIND],
[
  AC_REQUIRE([MACIMAGE_BASH])
  AC_REQUIRE([MACIMAGE_PACKAGES])

  macimage_val=
  macimage_version=

  AC_MSG_CHECKING(for package $1)
  _macimage_critical=no
  _macimage_file=
  _macimage_dir=$4

  # If --enable-pkg-foo was specified, make success critical.
  AS_IF([test x$_macimage_dir != xmaybe], [_macimage_critical=yes])

  # Only check if critical or auto detection is requested.
  AS_IF([test $_macimage_auto_detection = yes -o $_macimage_critical = yes],
    [AS_IF([test -z "$_macimage_dir" -o "$_macimage_dir" = yes -o "$_macimage_dir" = maybe],
          [_macimage_dir=$macimage_packages])

    # Install pattern.
    AS_IF([test -z "$2"], [_macimage_pat='$1-\([[0-9]].*\)'],
          [_macimage_pat="$2"])

    # Frob pattern.  Regex party!
    [_macimage_glob=`echo "$_macimage_pat" | sed -e 's/\\\\(\(.*\)\\\\)/\1/'`]
    [_macimage_glob=`echo "$_macimage_glob" | sed -e 's/\\.\\*/*/'`]

    # Make non-matching globs expand to nothing.
    shopt -s nullglob

    _macimage_format=both
    AS_IF([test ! -z "$3"], _macimage_format="$3")

    AS_IF([test -z "$_macimage_file" -a $_macimage_format != zip],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.tar.xz`
           _macimage_suffix=.tar.xz])
    AS_IF([test -z "$_macimage_file" -a $_macimage_format != zip],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.tar.bz2`
           _macimage_suffix=.tar.bz2])
    AS_IF([test -z "$_macimage_file" -a $_macimage_format != zip],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.tbz2`
           _macimage_suffix=.tbz2])
    AS_IF([test -z "$_macimage_file" -a $_macimage_format != zip],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.tbz`
           _macimage_suffix=.tbz])
    AS_IF([test -z "$_macimage_file" -a $_macimage_format != zip],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.tar.gz`
           _macimage_suffix=.tar.gz])
    AS_IF([test -z "$_macimage_file" -a $_macimage_format != zip],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.tgz`
           _macimage_suffix=.tgz])
    AS_IF([test -z "$_macimage_file" -a $_macimage_format != tar],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.zip`
           _macimage_suffix=.zip])
    AS_IF([test -z "$_macimage_file" -a $_macimage_format != tar -a $_macimage_format != zip],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.exe`
           _macimage_suffix=.exe])
    AS_IF([test -z "$_macimage_file" -a $_macimage_format != tar -a $_macimage_format != zip],
          [_macimage_file=`echo ${_macimage_dir}/${_macimage_glob}.wixlib`
           _macimage_suffix=.wixlib])
    shopt -u nullglob])

  AS_IF([test -z "$_macimage_file"],
        AC_MSG_RESULT(no),
        AS_IF([test `echo $_macimage_file | head -c 1` != /],
              [_macimage_file=`pwd`/$_macimage_file])
        AC_MSG_RESULT($_macimage_file))
  AS_IF([test -z "$_macimage_file" -a $_macimage_critical = yes],
        AC_MSG_ERROR(could not find sources for $1 in $_macimage_dir))

  # Test for duplicate.
  _macimage_found=
  for _macimage_f in $_macimage_file; do
      AS_IF([test "$_macimage_found" = yes],
            [AC_MSG_WARN(found more than one sources for $1 in $_macimage_dir)
             macimage_dup_sources="$macimage_dup_sources $1";
             macimage_rm_candidates="$macimage_rm_candidates $_macimage_file"])
      _macimage_found=yes
  done

  AS_IF([test ! -z "$_macimage_file"],
        [macimage_val="$_macimage_file"
        [macimage_version=`echo "$macimage_val" | sed -e "s,^.*/${_macimage_pat}${_macimage_suffix}$,\1,"`]
         [$5]],
        [$6])
])


AC_DEFUN([MACIMAGE_CHECK_DEPS],
[
  AC_MSG_CHECKING(build list)
  macimage_build_list=`echo $_macimage_deps | tsort`
  # Remove newlines.
  macimage_build_list=`echo $macimage_build_list`
  AC_MSG_RESULT($macimage_build_list)
  AC_SUBST(macimage_build_list)

  # Check each dependency.
  _macimage_not_found=
  _macimage_d=
  _macimage_p=
  for _macimage_p in $_macimage_deps; do
    AS_IF([test -z $_macimage_d], [_macimage_d=$_macimage_p],
          [
            _macimage_found=
            for _macimage_i in $_macimage_pkgs; do
              AS_IF([test $_macimage_d = $_macimage_i],
                    _macimage_found=yes
                    break)
            done
            AS_IF([test -z $_macimage_found],
                  AC_MSG_WARN(could not find package $_macimage_d required by package $_macimage_p)
                  _macimage_not_found=yes)
            _macimage_d=
          ])
  done
  AS_IF([test ! -z "$_macimage_not_found"],
        AC_MSG_ERROR([could not find some required packages]))
])


AC_DEFUN([MACIMAGE_FINALIZE],
[
  AC_REQUIRE([MACIMAGE_CHECK_DEPS])

  _macimage_debug=no
  AC_ARG_ENABLE([debug],
    AS_HELP_STRING([--enable-debug], [enable debugging [[no]]]),
    _macimage_debug=$enableval)

  AS_IF([test "${_macimage_debug}" != no],
    MACIMAGE_DEFINE(MACIMAGE_DEBUG))
])


# MACIMAGE_SPKG([PKG],[DEPENDS],[IF-FOUND],[IF-NOT-FOUND])
# Set up the source package PKG.
# It is provided in macimage_val.
AC_DEFUN([MACIMAGE_SPKG],
[
  AC_REQUIRE([MACIMAGE_INIT])
  _macimage_pkg=maybe
  AC_ARG_ENABLE([pkg-$1],
    AS_HELP_STRING([--enable-pkg-$1[=DIR]],
                   [include package $1]),
    _macimage_pkg=$enableval)
  _macimage_spkg=no
  _macimage_version=
  AS_IF([test "$_macimage_pkg" != no],
        [MACIMAGE_FIND($1,,, $_macimage_pkg,
	 _macimage_spkg=$macimage_val
	 _macimage_version=$macimage_version)])

  # At this point, _macimage_spkg is no, or the actual package source file.

  # macimage_pkg_PKGNAME=FILENAME_OF_SOURCE
  macimage_pkg_[]m4_translit([$1],[-+],[__])[]=$_macimage_spkg
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[-+],[__]))

  # macimage_pkg_PKGNAME_version=VERSION
  macimage_pkg_[]m4_translit([$1],[-+],[__])[]_version=$_macimage_version
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[-+],[__])[]_version)

  # macimage_pkg_PKGNAME_deps=DEPS
  macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps="$2"
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps)

  AS_IF([test "$_macimage_spkg" != no],
    _macimage_pkgs="$_macimage_pkgs $1"
    MACIMAGE_DEFINE(HAVE_PKG_[]m4_translit([$1],[a-z+-],[A-Z__]))
    # Record dependencies.  Also enter every package as node.
    _macimage_deps="$_macimage_deps $1 $1"
    AS_IF([test ! -z "$2"],
          for _macimage_i in $2; do
            _macimage_deps="$_macimage_deps $_macimage_i $1"
          done)
      [$3],
      [$4])
])


# MACIMAGE_KDEPKG([PKG],[DEPENDS],[IF-FOUND],[IF-NOT-FOUND])
# Set up the KDE source package PKG.
# It is provided in macimage_val.
AC_DEFUN([MACIMAGE_KDEPKG],
[
  AC_REQUIRE([MACIMAGE_INIT])
  _macimage_pkg=maybe
  AC_ARG_ENABLE([pkg-$1],
    AS_HELP_STRING([--enable-pkg-$1[=DIR]],
                   [include package $1]),
    _macimage_pkg=$enableval)
  _macimage_kdepkg=no
  _macimage_version=
  AS_IF([test "$_macimage_pkg" != no],
        [MACIMAGE_FIND($1,,, $_macimage_pkg,
        _macimage_kdepkg=$macimage_val
        _macimage_version=$macimage_version)])

  # macimage_pkg_PKGNAME=FILENAME_OF_SOURCE
  macimage_pkg_[]m4_translit([$1],[-+],[__])[]=$_macimage_kdepkg
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[-+],[__]))

  # macimage_pkg_PKGNAME_version=VERSION
  macimage_pkg_[]m4_translit([$1],[-+],[__])[]_version=$_macimage_version
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[-+],[__])[]_version)

  # macimage_pkg_PKGNAME_deps=DEPS
  macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps="$2"
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps)

  AS_IF([test "$_macimage_kdepkg" != no],
    _macimage_pkgs="$_macimage_pkgs $1"
    MACIMAGE_DEFINE(HAVE_PKG_[]m4_translit([$1],[a-z+-],[A-Z__]))
    # Record dependencies.  Also enter every package as node.
    _macimage_deps="$_macimage_deps $1 $1"
    AS_IF([test ! -z "$2"],
          for _macimage_i in $2; do
            _macimage_deps="$_macimage_deps $_macimage_i $1"
          done)
      [$3],
      [$4])
])

# MACIMAGE_BPKG_BINSRC([PKG],[DEPENDS],[IF-FOUND],[IF-NOT-FOUND])
# Set up package PKG which is expected to be delivered as two ZIP files
# with a "-(src|source)" and a "-(bin|noinstaller)" suffix.
AC_DEFUN([MACIMAGE_BPKG_BINSRC],
[
  AC_REQUIRE([MACIMAGE_INIT])
  _macimage_pkg=maybe
  AC_ARG_ENABLE([pkg-$1],
    AS_HELP_STRING([--enable-pkg-$1[=DIR]],
                   [include package $1]),
    _macimage_pkg=$enableval)
  _macimage_bpkg=no
  _macimage_version=
  AS_IF([test "$_macimage_pkg" != no],
        [MACIMAGE_FIND($1-bin, [$1-\(.*\)-bin],,
         $_macimage_pkg,
         _macimage_bpkg=$macimage_val
	 _macimage_version=$macimage_version)])
  AS_IF([test "$_macimage_pkg" != no -a "$_macimage_bpkg" = no],
        [MACIMAGE_FIND($1-noinstaller, [$1-\(.*\)-noinstaller],,
         $_macimage_pkg,
         _macimage_bpkg=$macimage_val
	 _macimage_version=$macimage_version)])

  # At this point, _macimage_bpkg is no, or the actual package binary file.

  # macimage_pkg_PKGNAME=FILENAME_OF_BINARY
  macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]=$_macimage_bpkg
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__]))

  # macimage_pkg_PKGNAME_version=VERSION
  macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_version=$_macimage_version
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_version)

  # macimage_pkg_PKGNAME_deps=DEPS
  macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps="$2"
  AC_SUBST(macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_deps)

  AS_IF([test "$_macimage_bpkg" != no],
    tmp_binsrc=yes
    MACIMAGE_FIND($1-src, [$1-\(.*\)-src],,
                 $_macimage_pkg, _macimage_bpkg=$macimage_val, tmp_binsrc=no)
    if test $tmp_binsrc = no ; then
       MACIMAGE_FIND($1-source, [$1-\(.*\)-source],,
                    $_macimage_pkg, _macimage_bpkg=$macimage_val,
                    AC_MSG_ERROR(can not find sources for package $1))
    fi
    # macimage_pkg_PKGNAME_src=FILENAME_OF_SOURCE
    macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_src=$_macimage_bpkg
    AC_SUBST(macimage_pkg_[]m4_translit([$1],[A-Z+-],[a-z__])[]_src)

    # FIXME: Add a version consistency check here.  Both packages
    # must match!

    MACIMAGE_DEFINE(HAVE_PKG_[]m4_translit([$1],[a-z+-],[A-Z__]))

    _macimage_pkgs="$_macimage_pkgs []m4_translit([$1],[A-Z],[a-z])"
    # Record dependencies.  Also enter every package as node.
    _macimage_deps="$_macimage_deps []m4_translit([$1],[A-Z],[a-z]) []m4_translit([$1],[A-Z],[a-z])"
    AS_IF([test ! -z "$2"],
          for _macimage_i in $2; do
            _macimage_deps="$_macimage_deps $_macimage_i []m4_translit([$1],[A-Z],[a-z])"
          done)
          [$3],
          [$4])
])

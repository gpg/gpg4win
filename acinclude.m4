dnl macros to configure Gpg4Win
dnl Copyright (C) 1998, 1999, 2000, 2001, 2003 Free Software Foundation, Inc.
dnl Copyright (C) 2021 g10 Code GmbH
dnl
dnl Software engineering by Ingo Klöcker <dev@ingo-kloecker.de>
dnl
dnl This file is part of Gpg4Win.
dnl
dnl Gpg4Win is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 3 of the License, or
dnl (at your option) any later version.
dnl
dnl Gpg4Win is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, see <https://www.gnu.org/licenses/>.

# GPG4WIN_BUILD_RELEASE(NAME,DEFAULT)
# Add a --enable-NAME option to configure and set the shell variable
# build_NAME either to "yes" or "no".  DEFAULT must either be "yes" or "no"
# and decides on the default value for build_NAME and whether --enable-NAME
# or --disable-NAME is shown with ./configure --help
AC_DEFUN([GPG4WIN_BUILD_RELEASE],
  [m4_define([my_build], [m4_bpatsubst(build_$1, [[^a-zA-Z0-9_]], [_])])
   my_build=$2
   m4_if([$2],[yes],[
      AC_ARG_ENABLE([$1], AS_HELP_STRING([--disable-$1],
                                         [do not build the $1 release]),
                           my_build=$enableval, my_build=$2)
    ],[
      AC_ARG_ENABLE([$1], AS_HELP_STRING([--enable-$1],
                                         [build the $1 release]),
                           my_build=$enableval, my_build=$2)
    ])
   case "$my_build" in
         no|yes)
           ;;
         *)
           AC_MSG_ERROR([only yes or no allowed for feature --enable-$1])
           ;;
   esac
   m4_undefine([my_build])
  ])

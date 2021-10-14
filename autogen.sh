#! /bin/sh
# Run this to generate all the initial makefiles, etc.
#
# Copyright (C) 2003 g10 Code GmbH
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

configure_ac="configure.ac"

cvtver () {
  awk 'NR==1 {split($NF,A,".");X=1000000*A[1]+1000*A[2]+A[3];print X;exit 0}'
}

check_version () {
    if [ `("$1" --version || echo "0") | cvtver` -ge "$2" ]; then
       return 0
    fi
    echo "**Error**: "\`$1\'" not installed or too old." >&2
    echo '           Version '$3' or newer is required.' >&2
    [ -n "$4" ] && echo '           Note that this is part of '\`$4\''.' >&2
    DIE="yes"
    return 1
}

# Allow to override the default tool names
AUTOCONF=${AUTOCONF_PREFIX}${AUTOCONF:-autoconf}${AUTOCONF_SUFFIX}
AUTOHEADER=${AUTOCONF_PREFIX}${AUTOHEADER:-autoheader}${AUTOCONF_SUFFIX}

AUTOMAKE=${AUTOMAKE_PREFIX}${AUTOMAKE:-automake}${AUTOMAKE_SUFFIX}
ACLOCAL=${AUTOMAKE_PREFIX}${ACLOCAL:-aclocal}${AUTOMAKE_SUFFIX}

DIE=no
FORCE=
if test x"$1" = x"--force"; then
  FORCE=" --force"
  shift
fi

# Reject unsafe characters in $HOME, $tsdir and cwd.  We consider spaces
# as unsafe because it is too easy to get scripts wrong in this regard.
am_lf='
'
case `pwd` in
  *[\;\\\"\#\$\&\'\`$am_lf\ \	]*)
    echo "unsafe working directory name"; DIE=yes;;
esac
case $tsdir in
  *[\;\\\"\#\$\&\'\`$am_lf\ \	]*)
    echo "unsafe source directory: \`$tsdir'"; DIE=yes;;
esac
case $HOME in
  *[\;\\\"\#\$\&\'\`$am_lf\ \	]*)
    echo "unsafe home directory: \`$HOME'"; DIE=yes;;
esac
if test "$DIE" = "yes"; then
  exit 1
fi

# Begin list of optional variables sourced from ~/.gnupg-autogen.rc
w32_toolprefixes=
w32_extraoptions=
w64_toolprefixes=

if [ -f "$HOME/.gnupg-autogen.rc" ]; then
    echo "sourcing extra definitions from $HOME/.gnupg-autogen.rc"
    . "$HOME/.gnupg-autogen.rc"
fi


# Convenience option to use certain configure options for some hosts.
myhost=""
myhostsub=""
case "$1" in
    --build-w32)
        myhost="w32"
        myhostsub="w64"
        shift
        ;;
    --build*)
        echo "**Error**: invalid build option $1" >&2
        shift
        exit 1
        ;;
    *)
        ;;
esac


# ***** W32 build script *******
# Used to cross-compile for Windows.
if [ "$myhost" = "w32" ]; then
    tmp=`dirname $0`
    tsdir=`cd "$tmp"; pwd`
    if [ ! -f $tsdir/config.guess ]; then
        echo "$tsdir/config.guess not found" >&2
        exit 1
    fi
    build=`$tsdir/config.guess`

    case $myhostsub in
        w64)
          [ -z "$w32root" ] && w32root="$HOME/w32root"
          toolprefixes="$w32_toolprefixes i686-w64-mingw32 i586-mingw32msvc"
          toolprefixes="$toolprefixes i386-mingw32msvc mingw32"
          extraoptions="$w32_extraoptions"
          extratoolprefixes="$w64_toolprefixes x86_64-w64-mingw32"
          ;;
        *)
          [ -z "$w32root" ] && w32root="$HOME/w32root"
          toolprefixes="$w32_toolprefixes i686-w64-mingw32 i586-mingw32msvc"
          toolprefixes="$toolprefixes i386-mingw32msvc mingw32"
          extraoptions="$w32_extraoptions"
          ;;
    esac
    echo "Using $w32root as standard install directory" >&2

    # Locate the cross compiler
    crossbindir=
    for host in $toolprefixes; do
        if ${host}-gcc --version >/dev/null 2>&1 ; then
            crossbindir=/usr/${host}/bin
            conf_CC="CC=${host}-gcc"
            break;
        fi
    done

    w64_crossbindir=
    for extra_host in $extratoolprefixes; do
        if ${extra_host}-gcc --version >/dev/null 2>&1 ; then
            w64_crossbindir=/usr/${extra_host}/bin
            extraoptions="$extraoptions --with-additional-gpgex-host=${extra_host} "
            break;
        fi
    done

    if [ -z "$crossbindir" ]; then
        echo "Cross compiler kit not installed" >&2
        echo "Under Debian GNU/Linux, you may install it using" >&2
        echo "  apt-get install mingw32 mingw32-runtime mingw32-binutils" >&2
        echo "Stop." >&2
        exit 1
    fi

    if [ "$myhostsub" = "w64" -a -z "$w64_crossbindir" ]; then
        echo "Cross compiler for x64 architecture not installed" >&2
        echo "Under Debian GNU/Linux, you may install it using" >&2
        echo "  apt-get install mingw-w64" >&2
        echo "Stop." >&2
        exit 1
    fi

    if [ -f "$tsdir/config.log" ]; then
        if ! head $tsdir/config.log | grep "$host" >/dev/null; then
            echo "Pease run a 'make distclean' first" >&2
            exit 1
        fi
    fi

    $tsdir/configure --host=${host} --build=${build} --enable-maintainer-mode \
                     --enable-gpg4win \
                     ${extraoptions} "$@"
    rc=$?

    exit $rc
fi
# ***** end W32 build script *******




# Grep the required versions from configure.ac
autoconf_vers=`sed -n '/^AC_PREREQ(/ {
s/^.*(\(.*\))/\1/p
q
}' ${configure_ac}`
autoconf_vers_num=`echo "$autoconf_vers" | cvtver`

automake_vers=`sed -n '/^min_automake_version=/ {
s/^.*="\(.*\)"/\1/p
q
}' ${configure_ac}`
automake_vers_num=`echo "$automake_vers" | cvtver`


if [ -z "$autoconf_vers" -o -z "$automake_vers" ]
then
  echo "**Error**: version information not found in "\`${configure_ac}\'"." >&2
  exit 1
fi


if check_version $AUTOCONF $autoconf_vers_num $autoconf_vers ; then
    check_version $AUTOHEADER $autoconf_vers_num $autoconf_vers autoconf
fi
if check_version $AUTOMAKE $automake_vers_num $automake_vers; then
  check_version $ACLOCAL $automake_vers_num $autoconf_vers automake
fi

if test "$DIE" = "yes"; then
    cat <<EOF

Note that you may use alternative versions of the tools by setting
the corresponding environment variables; see README.GIT for details.

EOF
    exit 1
fi

# Check the git setup.
if [ -d .git ]; then
    if [ -f build-aux/git-hooks/pre-commit -a ! -x .git/hooks/pre-commit ];then
    cat <<EOF >&2
*** Activating trailing whitespace git pre-commit hook. ***
    For more information see this thread:
      http://mail.gnome.org/archives/desktop-devel-list/2009-May/msg00084html
    To deactivate this pre-commit hook again move .git/hooks/pre-commit
    and .git/hooks/pre-commit.sample out of the way.
EOF
      cp -av build-aux/git-hooks/pre-commit .git/hooks/pre-commit
      chmod -c +x  .git/hooks/pre-commit
  fi
  tmp=$(git config --get filter.cleanpo.clean)
  if [ "$tmp" != "awk '/^\"POT-Creation-Date:/&&!s{s=1;next};!/^#: /{print}'" ]
  then
    echo "*** Adding GIT filter.cleanpo.clean configuration." >&2
    git config --add filter.cleanpo.clean \
        "awk '/^\"POT-Creation-Date:/&&!s{s=1;next};!/^#: /{print}'"
  fi
  if [ -f build-aux/git-hooks/commit-msg -a ! -x .git/hooks/commit-msg ];then
    cat <<EOF >&2
*** Activating commit log message check hook. ***
EOF
      cp -av build-aux/git-hooks/commit-msg .git/hooks/commit-msg
      chmod -c +x  .git/hooks/commit-msg
  fi
fi


echo "Running aclocal -I m4 ${ACLOCAL_FLAGS:+$ACLOCAL_FLAGS }..."
$ACLOCAL -I m4 $ACLOCAL_FLAGS
echo "Running autoheader..."
$AUTOHEADER
echo "Running automake --gnu ..."
$AUTOMAKE --gnu -Wno-portability;
echo "Running autoconf${FORCE} ..."
$AUTOCONF${FORCE}

#echo "You may now run \"./configure --host=i586-mingw32msvc && make\"."
echo "For building a Gpg4win installer you may now run \"./autogen.sh --build-w32 && make\"."
echo "For building an AppImage check the README."

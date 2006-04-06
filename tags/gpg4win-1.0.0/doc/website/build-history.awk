# build-history.awk - Build a history HTML         -*- coding: latin1 *-*
#                     page from the NEWS file
# Copyright (C) 2006 g10 Code GmbH
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
# USA.

# We use a slightly modified format of the NEWS file to cope with i18n
# issues.  Here is an example of such a news file:
#
#    Noteworthy changes in version 42.1 (2000-01-01)
#    -----------------------------------------------
#    
#    (en) New: Script to build a HTML version 
#         of the NEWS.
#    (de) Neu: Script zum Erzeugen der HTML Version
#    
#    (en) Blurb
#    (de) Blabla
#    
#    ~~~~~~~~~~~~~~~
#    foo.lisp:  1.17
#    bar.lisp:  7.53.1
#    ~~~~~~~~~~~~~~~
#    
#    Noteworthy changes in version 42.0 (1999-12-31)
#    ------------------------------------------------
#    
# Empty lines as well as lines starting with a hash mark are entirly
# ignored.  Paragraphs are indicated by the language tags.  A new
# revision history starts with the "Noteworthy .." line; the release
# date is expected in parentheses on that line.  If it is not given the
# section won't be rendered.  


BEGIN {
  if ( lang == "" )
    lang = "en";
  in_section = 0;
  in_para = 0;
  in_vers = 0;
  any_para = 0;
  version = "";
  reldate = "";
    
  header_text["en"] = "" \
    "m4_dnl -*-html-*-\n" \
    "m4_include(`template.m4')\n" \
    "m4_define(`EN')\n" \
    "m4_define(`EN_FILE', `change-history.html')\n" \
    "PAGE_START\n" \
    "<h1>Change History of gpg4win</h1>\n";

  header_text["de"] = "" \
    "m4_dnl -*-html-*-\n" \
    "m4_include(`template.m4')\n" \
    "m4_define(`DE')\n" \
    "m4_define(`DE_FILE', `change-history-de.html')\n" \
    "PAGE_START\n" \
    "<h1>Änderungshistorie von gpg4win</h1>\n";

  release_text["en"] = "released ";
  release_text["de"] = "veröffentlicht ";
  noreldate_text["en"] = "[ in progress; not yet released ]";
  noreldate_text["de"] = "[ in Arbeit; bisher noch nicht veröffentlicht ]";

  print header_text[lang];
}

/^#/   { next }
/^---/ { next }

in_section && $0 ~ /^Noteworthy/ {
  if (in_para)
    print "</ul>"
  if (in_vers)
    print "</pre>"
  in_section = 0;
  in_para = 0;
  in_vers = 0;
  any_para = 0;
}


!in_section {
  if ($0 !~ /^Noteworthy/)
    next;
  version = $5;
  reldate = "";
  if (index ($0, "(")) {
    sub (/^.*\(/, "");
    sub (/\).*$/, "");
    reldate = $0;
    print "<h2>Version " version " " release_text[lang] " " reldate "</h2>"
  } else {
    reldate = noreldate_text[lang];
    print "<h2>Version " version " " reldate "</h2>"
  }
  in_section = 1;
  in_para = 0;
  in_vers = 0;
  any_para = 0;

  next;
}

in_section && $0 ~ /^\([a-zA-Z]+\)/ {
  in_para = 0;
  if ( $0 ~ ("^\\(" lang "\\)" ) ) {
    in_para = 1;
    any_para = 1;
    print "<li>"
    print substr ($0, 5);
  }
  next;
}
    
in_section && !in_vers && /^~~~/ {
  if (in_para && any_para)
    print "</ul>"
  in_para = 0; 
  in_vers = 1;
  print ""
  print "<pre>"
  next;
}

in_para {
  print $0;
}

in_vers && /^~~~/ {
  in_vers = 0;
  print "</pre>"
}

in_vers {
  split ( $0, a, ":" );
  printf "%s: %s\n", a[1], a[2];
}


END {
  if (in_para && any_para)
    print "</ul>"
  print "PAGE_BOXES"
}

#! /usr/bin/awk
# Copyright (C) 2007 g10 Code GmbH
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

# Process an NSIS script and output something that xgettext can grok.
# Requires variable "file" to be set at command line.

BEGIN {
  collect = 0;
  context = "";
  line = "";
}

# FIXME: Strictly we should check if we are still collecting or not.
/^LangString/ {
  collect = 1;
  print "# " FNR " \"" file "\"";
  context = $2;
  line = "";
}

collect {
  next_line = $0;
  sub (/\\$/, "", next_line);
  sub (/^ */, "", next_line);
  line = (line next_line);
}

collect && !/\\$/ {
  collect = 0;

  # Snip everything up to the first double-quote.
  sub (/^[^"]*/, "", line);
  # Convert the \r characters that gettext doesn't like.
  gsub (/\\r/, "\\\\r", line);
  # Convert the \n characters as well.
  gsub (/\\n/, "\\\\n", line);
  print "pgettext (\"" context "\", " line ");";
}

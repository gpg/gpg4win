#! /usr/bin/perl -w
# make-msi.pl - MSI Installer for Gpg4win.
# Copyright (C) 2007, 2019 g10 Code GmbH
#
# This file is part of Gpg4win.
#
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA

# FIXME: Here is how to support multiple languages in one MSI package,
# using an undocumented feature: Create one MSI package in each
# language, then create transformations:
# MsiTran.Exe -g foo.en.msi foo.de.msi language.de.mst
# Embed these transformations:
# CScript.exe WiSubStg.vbs foo.en.msi language.de.mst 1031
# Change the summmary informations attribute (with Orca):
# Languages = 1033, 1031
# Primary language must come first!
# http://www.installsite.org/pages/de/artikel/embeddedlang/index.htm
# http://forum.installsite.net/index.php?showtopic=16734

use strict;
use warnings;
use diagnostics;
use File::Basename;
use Cwd;


# Default language.
$::lang = 'en';


sub fail
{
    print STDERR $_[0] . "\n";
    exit 1;
}

# We use a new product and package code for every build (using pseudo
# components), but a single constant upgrade code for all versions.
# Note that Windows installer ignores the build part of the version
# number (only the first three components are used).
#
# FIXME: Build upgrade table.
#
# We take a simplified view: Each file corresponds to exactly one
# component.  This means we need to generate GUIDs for these
# components and remember them from one installer version to the next.
# We do this automatically by means of a support file, make-msi.guids.

%::guid = ();
$::guid_file = 'make-msi.guids';
$::guid_changed = 0;

sub fetch_guids
{
    # FIXME: Check if file exists.
    open (FILE, "<$::guid_file") or return;
    while (<FILE>)
    {
        next if (/^#/);
        if (/(\S+)\s+(.+)\s*\r?\n$/)
        {
            $::guid{$2} = $1;
        }
    }
    close (FILE);
}


sub store_guids
{
    # FIXME: Maybe allow to forget unused GUIDs.

    return if (not $::guid_changed);
    print STDERR "GUID list stored in $::guid_file changed, please commit!\n";
    open (FILE, ">$::guid_file.bak") or die "open failed:$!\n";
    print FILE "# This is an automatically generated file.  DO NOT EDIT.\n";
    foreach my $file (sort keys %::guid)
    {
        print FILE "$::guid{$file} $file\n";
    }
    close FILE;
    rename "$::guid_file.bak", $::guid_file or die "rename failed:$!\n";
}


sub get_guid
{
    my ($file) = @_;
    my $guid;

    if (defined $::guid{$file})
    {
        return $::guid{$file};
    }
    # Need to generate a new GUID.
    $::guid_changed = 1;
    $guid = uc `uuidgen`;
    chomp $guid;
    $::guid{$file} = $guid;
    return $guid;
}

sub get_tmp_guid
{
    my $guid = uc `uuidgen`;
    chomp $guid;
    return $guid;
}


$::files_file = '';

# We store the list of included files for temporary packaging, in case
# WiX needs to be run on a different system.
sub store_files
{
    my ($parser) = @_;

    return if ($::files_file eq '');
    open (FILE, ">$::files_file") or die "open failed:$!\n";
    foreach my $name (@{$parser->{pkg_list}})
    {
        my $pkg = $parser->{pkgs}->{$name};

        next if ($#{$pkg->{files}} == -1);
        print FILE (join ("\n", map { "src/" . ($_->{source}) }
                @{$pkg->{files}})). "\n";
    }
    close FILE;
}


sub lang_to_lcid
{
    my ($lang) = @_;

    if ($lang eq 'en')
    {
        return 1033;
    }
    elsif ($lang eq 'de')
    {
        return 1031;
    }
    elsif ($lang eq 'ar')
    {
        return 1025;
    }
    elsif ($lang eq 'es')
    {
        return 3082;
    }
    elsif ($lang eq 'fr')
    {
        return 1036;
    }
    elsif ($lang eq 'ru')
    {
        return 1049;
    }
    return 0;
}


# NSIS parser

# The parser data structure contains the following members:
#
# pre_depth: The current nesting depth of preprocessor conditionals.
# pre_true:  Depth of the last preprocessor conditional that was true.
# pre_symbols: A hash of defined preprocessor symbols.
# po: A hash of languages, each a hash of translated strings.
# outpath: the current output path.
# includedirs: An array of include directories to search through.

# A couple of variables you can set:
$::nsis_parser_warn = 1;
$::nsis_parser_debug = 0;

$::nsis_level_default = 1;
$::nsis_level_optional = 1000;
$::nsis_level_hidden = 2000;

# Evaluate an expression.
sub nsis_eval
{
    my ($parser, $file, $expr) = @_;
    my $val = $expr;

    # Resolve outer double quotes, if any.
    if ($val =~ m/^"/)
    {
        if (not $val =~ s/^"(.*)"$/$1/)
        {
            fail "$file:$.: unmatched quote in expression: $expr";
        }
    }

    my $iter = 0;
    while ($val =~ m/\$\{([^}]*)\}/)
    {
        my $varname = $1;
        my $varvalue;

        if (exists $parser->{pre_symbols}->{$varname})
        {
            $varvalue = $parser->{pre_symbols}->{$varname};
        }
        else
        {
            fail "$file:$.: undefined variable $varname in expression: $expr";
        }
        $val =~ s/\$\{$varname\}/$varvalue/g;

        $iter++;
        if ($iter > 100)
        {
            fail "$file:$.: too many variable expansions in expression: $expr";
        }
    }

    #    # FIXME: For now.
    #    if ($expr =~ m/\$/ or $expr !~ m/^\"/)
    #    {
    #   return $expr;
    #    }
    #    $val = eval $expr;
    return $val;
}


# Retrieve an evaluated symbol
sub nsis_fetch
{
    my ($parser, $symname) = @_;

    return undef if (not exists $parser->{pre_symbols}->{$symname});

    return nsis_eval ($parser, '', $parser->{pre_symbols}->{$symname});
}


# Evaluate an expression.
sub nsis_translate
{
    my ($parser, $file, $expr) = @_;
    my $val = $expr;
    my $iter = 0;

    while ($val =~ m/\$\((.*)\)/)
    {
        my $var = $1;

        if (exists $parser->{po}->{$::lang}->{$1})
        {
            # This was historic taking nsis translations we now do this
            # through WXL l10n system.
            #my $subst = $parser->{po}->{$::lang}->{$1};
            $val =~ s/\$\($var\)/!\(loc.$var\)/g;
        }
        else
        {
            fail "$file:$.: no translation for $val to language $::lang";
        }
        $iter++;
        if ($iter > 100)
        {
            fail "$file:$.: too deep nesting of translations";
        }
    }

    # Resolve outer double quotes, if any.
    $val =~ s/^"(.*)"$/$1/;
    $val =~ s/\$\r/\r/g;
    $val =~ s/\$\n/\n/g;
    $val =~ s/\$\"/"/g;

    return $val;
}


# Low level line input.
sub nsis_get_line
{
    my ($file) = @_;
    my $line = '';

    while (<$file>)
    {
        $line = $line . $_;

        # Strip leading whitespace.
        $line =~ s/^\s*//;

        # Strip newline and trailing whitespace.
        $line =~ s/\s*\r?\n$//;

        # Combine multiple lines connected with backslashes.
        if ($line =~ m/^(.*)\\$/)
        {
            $line = $1 . ' ';
            next;
        }

        $_ = $line;
        last;
    }

    # Now break up the line into
    return $_;
}


# Tokenize the NSIS line.
sub nsis_tokenize
{
    my ($file, $line) = @_;
    my @tokens;

    my @line = split ('', $line);
    my $idx = 0;

    while ($idx <= $#line)
    {
        # The beginning of the current partial token.
        my $token = $idx;

        if ($line[$idx] eq '"')
        {
            $idx++;
            # Skip until end of string, indicated by double quote that
            # is not part of the $\" string.
            while ($idx <= $#line)
            {
                if (substr ($line, $idx, 3) eq '$\\"')
                {
                    $idx += 3;
                }
                else
                {
                    last if ($line[$idx] eq '"');
                    $idx++;
                }
            }
            fail "$file:$.:$idx: unterminated string from position $token"
            if ($idx > $#line);
            $idx++;
            fail "$file:$.:$idx: strings not separated"
            if ($idx <= $#line and $line[$idx] !~ m/\s/);
        }
        elsif ($line[$idx] eq '\'')
        {
            $idx++;
            # Skip until end of string, indicated by a single quote.
            while ($idx <= $#line)
            {
                last if ($line[$idx] eq '\'');
                $idx++;
            }
            fail "$file:$.:$idx: unterminated string from position $token"
            if ($idx > $#line);
            $idx++;
            fail "$file:$.:$idx: strings not separated"
            if ($idx <= $#line and $line[$idx] !~ m/\s/);
        }
        else
        {
            # Skip until end of token indicated by whitespace.
            while ($idx <= $#line)
            {
                fail "$file:$.:$idx: invalid character"
                if ($line[$idx] eq '"');

                last if ($line[$idx] =~ m/\s/);
                $idx++;
            }
        }

        push @tokens, substr ($line, $token, $idx - $token);

        # Skip white space between arguments.
        while ($idx <= $#line and $line[$idx] =~ m/\s/)
        {
            $idx++;
        }
    }

    return @tokens;
}


# We suppress some warnings after first time.
%::warn = ();

# Parse the NSIS line.
sub nsis_parse_line
{
    my ($parser, $file, $line) = @_;

    # We first tokenize the line.
    my @tokens = nsis_tokenize ($file, $line);

    # We handle preprocessing directives here.

    print STDERR "Tokens: " . join (" AND ", @tokens) . "\n"
    if $::nsis_parser_debug;

    # We have special code dealing with ignored areas.
    if ($parser->{pre_depth} > $parser->{pre_true})
    {
        if ($tokens[0] eq '!ifdef' or $tokens[0] eq '!ifndef')
        {
            fail "$file:$.: syntax error" if $#tokens != 1;
            $parser->{pre_depth}++;
        }
        elsif ($tokens[0] eq '!else')
        {
            fail "$file:$.: stray !else" if $parser->{pre_depth} == 0;

            if ($parser->{pre_depth} == $parser->{pre_true} + 1)
            {
                $parser->{pre_true}++;
            }
        }
        elsif ($tokens[0] eq '!endif')
        {
            fail "$file:$.: syntax error" if $#tokens != 0;

            fail "$file:$.: stray !endif" if $parser->{pre_depth} == 0;

            $parser->{pre_depth}--;
        }
        elsif ($tokens[0] eq '!macro')
        {
            fail "$file:$.: syntax error" if $#tokens < 1;

            # FIXME: We do not support macros at this point, although
            # support would not be too hard to add.  Instead, we just
            # ignore their definition so it does not throw us off.

            print STDERR
            "$file:$.: warning: ignoring macro $tokens[1]\n"
            if $::nsis_parser_warn;

            $parser->{pre_depth}++;
        }
        elsif ($tokens[0] eq '!macroend')
        {
            # FIXME: See !macro.
            fail "$file:$.: stray !macroend" if $parser->{pre_depth} == 0;
            $parser->{pre_depth}--;
        }
    }
    else
    {
        # This is the parser for areas not ignored.
        if ($tokens[0] eq '!define')
        {
            if ($#tokens == 1)
            {
                # FIXME: Maybe define to 1?
                $parser->{pre_symbols}->{$tokens[1]} = '';
            }
            elsif ($#tokens == 2)
            {
                $parser->{pre_symbols}->{$tokens[1]} =
                nsis_eval ($parser, $file, $tokens[2]);
            }
            else
            {
                fail "$file:$.: syntax error";
            }

        }
        elsif ($tokens[0] eq '!undef')
        {
            fail "$file:$.: syntax error" if $#tokens != 1;
            delete $parser->{pre_symbols}->{$tokens[1]};
        }
        elsif ($tokens[0] eq '!ifdef')
        {
            fail "$file:$.: syntax error" if $#tokens != 1;

            if (exists $parser->{pre_symbols}->{$tokens[1]})
            {
                $parser->{pre_true}++;
            }
            $parser->{pre_depth}++;
        }
        elsif ($tokens[0] eq '!ifndef')
        {
            fail "$file:$.: syntax error" if $#tokens != 1;

            if (not exists $parser->{pre_symbols}->{$tokens[1]})
            {
                $parser->{pre_true}++;
            }
            $parser->{pre_depth}++;
        }
        elsif ($tokens[0] eq '!else')
        {
            fail "$file:$.: stray !else" if $parser->{pre_depth} == 0;

            if ($parser->{pre_depth} == $parser->{pre_true})
            {
                $parser->{pre_true}--;
            }
            elsif ($parser->{pre_depth} == $parser->{pre_true} + 1)
            {
                $parser->{pre_true}++;
            }
        }
        elsif ($tokens[0] eq '!endif')
        {
            fail "$file:$.: syntax error" if $#tokens != 0;

            fail "$file:$.: stray !endif" if $parser->{pre_depth} == 0;

            if ($parser->{pre_depth} == $parser->{pre_true})
            {
                $parser->{pre_true}--;
            }
            $parser->{pre_depth}--;
        }
        elsif ($tokens[0] eq '!include')
        {
            fail "$file:$.: syntax error" if $#tokens != 1;

            if ($tokens[1] eq 'Memento.nsh')
            {
                print STDERR "Skipping $tokens[1]\n"
                if $::nsis_parser_debug;
            }
            else
            {       print STDERR "Including $tokens[1]\n"
                if $::nsis_parser_debug;

                my $filename = nsis_eval ($parser, $file, $tokens[1]);

                # Recursion.
                nsis_parse_file ($parser, $filename);
            }
        }
        elsif ($tokens[0] eq '!macro')
        {
            fail "$file:$.: syntax error" if $#tokens < 1;

            # FIXME: We do not support macros at this point, although
            # support would not be too hard to add.  Instead, we just
            # ignore their definition so it does not throw us off.

            print STDERR
            "$file:$.: warning: ignoring macro $tokens[1]\n"
            if $::nsis_parser_warn;

            $parser->{pre_depth}++;
        }
        elsif ($tokens[0] eq '!macroend')
        {
            # FIXME: See !macro.
            fail "$file:$.: stray !macroend" if $parser->{pre_depth} == 0;
            $parser->{pre_depth}--;
        }
        elsif ($tokens[0] eq '!cd' or $tokens[0] eq '!addplugindir')
        {
            if (not exists $::warn{"directive-$tokens[0]"})
            {
                print STDERR
                "$file:$.: warning: ignoring $tokens[0] directive\n"
                if $::nsis_parser_warn;
            }
            $::warn{"directive-$tokens[0]"}++;
        }
        elsif ($tokens[0] eq '!addincludedir')
        {
            fail "$file:$.: syntax error" if $#tokens != 1;

            my $dir = nsis_eval ($parser, $file, $tokens[1]);

            unshift @{$parser->{includedirs}}, $dir;
        }
        elsif ($tokens[0] =~ m/^\!/ and $tokens[0] ne '!insertmacro')
        {
            # Note: It is essential that some !insertmacro invocations are
            # not expanded, namely those of SelectSection and UnselectSection,
            # which are used to track dependencies in Gpg4win.

            fail "$file:$.: compiler directive $tokens[0] not implemented";
        }
        else
        {
            # Main processing routine.  This is specific to the backend
            # and probably package.
            gpg4win_nsis_stubs ($parser, $file, @tokens);
        }
    }
}


# Parse the NSIS file.
sub nsis_parse_file
{
    my ($parser, $file) = @_;
    my $handle;

    if ($file eq '-')
    {
        $. = 0;
        $handle = *STDIN;
    }
    else
    {
        if (not -e $file and 1)
        {
            # Search for include file.  Note: We do not change
            # directories, but that is OK for us.  Also, we want to
            # avoid the system header files, as we don't control what
            # constructs they use, and in fact we want to treat their
            # macros and functions as atoms.

            my @includedirs = @{$parser->{includedirs}};
            my $dir;

            foreach $dir (@includedirs)
            {
                if (-e $dir . '/' . $file)
                {
                    $file = $dir . '/' . $file;
                    last;
                }
            }
        }

        if (not open ($handle, "<$file"))
        {
            print STDERR "$file:$.: warning: "
            . "can not open include file $file: $!\n"
            if $::nsis_parser_warn;
            return;
        }
    }

    my $incomment = 0;
    while (defined nsis_get_line ($handle))
    {
        $.++ if ($file eq '-');

        # Check for our block comment
        if ($_ =~ m/^# BEGIN MSI IGNORE.*/)
        {
            $incomment = 1;
        }
        elsif ($_ =~ m/^# END MSI IGNORE.*/)
        {
            $incomment = 0;
        }
        next if $incomment;

        # Skip comment lines.
        next if $_ =~ m/^#/;

        # Skip empty lines.
        next if $_ =~ m/^$/;


        nsis_parse_line ($parser, $file, $_);
    }

    if ($incomment) {
        fail "$file:$.: error: Missing # END MSI IGNORE marker.\n";
    }


    close $handle if ($file ne '-');
}


# The Gpg4win stubs for the MSI backend to the NSIS converter.

# Gpg4win specific state in $parser:
# pkg: the current package (a hash reference), corresponds to certain sections.
# pkgs: a hash ref of all packages encountered indexed by their frobbed name.
# pkg_list: the order of packages (as frobbed names).
# state: specifies a state for special parsing of certain parts.
# dep_name: the current package for which we list dependencies (- for none)

sub gpg4win_nsis_stubs
{
    my ($parser, $file, $command, @args) = @_;

    $parser->{state} = "" if not defined $parser->{state};

    if ($parser->{state} =~ m/^ignore-until-(.*)$/)
    {
        undef $parser->{state} if ($command eq $1);
    }

    # Section support.
    #
    # We parse SetOutPath and File directives in sections.
    # Everything else is ignored.

    elsif ($parser->{state} eq ''
            and ($command eq 'Section' or $command eq '${MementoSection}'
                or $command eq '${MementoUnselectedSection}'))
    {
        my $idx = 0;
        # Default install level for MSI is 3.
        my $level = $::nsis_level_default;
        my $hidden = 0;

        if ($command eq '${MementoUnselectedSection}')
        {
            # Default install level for MSI is 3.
            $level = $::nsis_level_optional;
        }

        # Check for options first.
        return if ($idx > $#args);
        if ($args[$idx] eq '/o')
        {
            # Default install level for MSI is 3.
            $level = $::nsis_level_optional;
            $idx++;
        }

        return if ($idx > $#args);

        my $title = nsis_eval ($parser, $file, $args[$idx++]);

        # Check for hidden flag.
        if (substr ($title, 0, 1) eq '-')
        {
            # Hidden packages are dependency tracked and never
            # installed by default unless required.
            $level = $::nsis_level_hidden;
            $hidden = 1;
            substr ($title, 0, 1) = '';
        }

        # We only pay attention to special sections and those which
        # have a section index defined.
        if ($title eq 'startmenu')
        {
            # The special startmenu section contains all our shortcuts.\
            $parser->{state} = 'section-startmenu';
            return;
        }
        elsif ($idx > $#args)
        {
            return;
        }

        # Finally we can get the frobbed name of the package.
        my $name = $args[$idx++];
        $name =~ s/^SEC_//;

        my $pkg = \%{$parser->{pkgs}->{$name}};

        # Check for ignored packages
        # Ignored packages:
        foreach my $ignored ("gpa", "gtk_", "glib", "expat", "gdk_pixbuf",
                             "cairo", "fontconfig", "atk", "libpng",
                             "freetype", "libffi", "pango", "pcre",
                             "compendium")
        {
            if ($name eq $ignored)
            {
                print STDERR "Ignoring package: " . $name . "\n"
                if $::nsis_parser_debug;
                return;
            }
        }

        $pkg->{name} = $name;
        # Replace - in names to avoid errors with identifies
        $pkg->{name} =~ s/-/_/g;
        $pkg->{title} = $title;
        $pkg->{level} = $level;
        $pkg->{hidden} = $hidden;
        $pkg->{features} = '';

        # Remember the order of sections included.
        push @{$parser->{pkg_list}}, $name;

        $parser->{pkg} = $pkg;
        $parser->{state} = 'in-section';
    }
    elsif ($parser->{state} eq 'in-section')
    {
        if ($command eq 'SectionEnd' or $command eq '${MementoSectionEnd}')
        {
            delete $parser->{pkg};
            undef $parser->{state};
        }
        elsif ($command eq 'SetOutPath')
        {
            fail "$file:$.: syntax error" if ($#args != 0);

            my $outpath = $args[0];
            #       if (not $outpath =~ s/^"\$INSTDIR\\?(.*)"$/$1/)
            if ($outpath =~ m/^"\$INSTDIR\\?(.*)"$/)
            {
                $parser->{outpath} = $1;
            }
            elsif ($outpath =~ m/^"\$APPDATA\\?(.*)"$/)
            {
                $parser->{outpath} = "%CommonAppDataFolder%\\" . $1;
            }
            elsif ($outpath =~ m/^"\$TEMP\\?(.*)"$/)
            {
                $parser->{outpath} = "%TEMP%\\" . $1;
            }
            elsif ($outpath =~ m/^"\$PLUGINSDIR\\?(.*)"$/)
            {
                $parser->{outpath} = "REMOVE_ME\\" . $1;
            }
            else
            {
                fail "$file:$.: unsupported out path: $args[0]";
            }
        }
        elsif ($command eq 'File')
        {
            my $idx = 0;
            my $target;

            fail "$file:$.: not supported" if ($#args < 0 || $#args > 1);

            if ($#args == 1)
            {
                if ($args[0] eq '/nonfatal')
                {
                    print STDERR "$file:$.: warning: skipping non-fatal file $args[1]\n"
                    if $::nsis_parser_warn;
                    return;
                }

                $target = $args[0];
                if (not $target =~ s,^/oname=(.*)$,$1,)
                {
                    fail "$file:$.: syntax error";
                }

                # Temp files are due to overwrite attempts, which are
                # handled automatically by the Windows Installer.  Ignore
                # them here.
                return if $target =~ m/\.tmp$/;
                $idx++;
            }

            my $source = nsis_eval ($parser, $file, $args[$idx]);
            if (not defined $target)
            {
                $target = $source;
                $target =~ s,^.*/([^/\\]+)$,$1,;
            }

            push @{$parser->{pkg}->{files}}, { source => $source,
                dir => $parser->{outpath},
                target => $target };
        }
        elsif ($command eq 'WriteRegStr' ||
               $command eq 'WriteRegExpandStr' ||
               $command eq 'WriteRegBin')
        {
            fail "$file:$.: not supported" if ($#args != 3);

            my $root = $args[0];

            my $key = $args[1];
            $key =~ s/^"(.*)"$/$1/;

            my $name = $args[2];
            $name =~ s/^"(.*)"$/$1/;

            my $value = $args[3];
            $value =~ s/^"(.*)"$/$1/;
            $value =~ s/\$INSTDIR\\?/\[APPLICATIONFOLDER\]/g;
            $value =~ s/\$\{VERSION\}/1.0.0/g;
            $value =~ s/\$\\"/"/g;

            my $type;
            if ($command eq 'WriteRegExpandStr') {
                $type = 'expandable';
            } elsif ($command eq 'WriteRegBin') {
                $type = 'binary';
            } else {
                $type = 'string';
            }

            push (@{$parser->{pkg}->{registry}},
                { root => $root, key => $key, name => $name,
                    value => $value, type => $type });
        }
    }

    # Start menu shortcuts support.

    elsif ($parser->{state} eq 'section-startmenu')
    {
        if ($command eq 'SectionEnd' or $command eq '${MementoSectionEnd}')
        {
            undef $parser->{state};
        }
        elsif ($command eq 'CreateShortCut')
        {
            fail "$file:$.: not supported" if ($#args != 7);

            # The link may contains a translatable string.
            my $link = $args[0];

            # We filter for startmenu shortcuts, as the others are
            # just more of the same.  Equivalently, we could filter
            # for a block between two labels.
            return if ($link !~ m/STARTMENU_FOLDER/);

            # Take the base name of the link.
            # FIXME: We want the manuals in a subdirectory.
            $link =~ s/^.*\\([^\\]*)\"$/$1/;
            $link =~ s/\.lnk$//;

            my $target = nsis_eval ($parser, $file, $args[1]);
            $target =~ s/^\$INSTDIR\\//;

            my $icon = $args[3];
            $icon =~ s/^"(.*)"$/$1/;
            $icon =~ s/^\$INSTDIR\\/[APPLICATIONFOLDER]/;
            $icon = nsis_eval ($parser, $file, $icon);

            my $icon_idx = nsis_eval ($parser, $file, $args[4]);
            fail "$file:$.: not supported" if ($icon_idx ne '');

            # The description contains a translatable string.
            my $description = $args[7];

            $parser->{shortcuts}->{$target} = { link => $link,
                target => $target,
                icon => $icon,
                description => $description };
        }
    }

    # LangString support.
    #
    # LangString directives must be stated at the top-level of the file.

    elsif ($parser->{state} eq '' and $command eq 'LangString')
    {
        fail "$file:$.: syntax error" if ($#args != 2);

        my $lang = $args[1];
        $lang =~ s/^\$\{LANG_(\w*)\}$/$1/;
        if ($lang eq 'ENGLISH')
        {
            $lang = 'en';
        }
        elsif ($lang eq 'GERMAN')
        {
            $lang = 'de';
        }
        elsif ($lang eq 'ARABIC')
        {
            $lang = 'ar';
        }
        elsif ($lang eq 'SPANISH')
        {
            $lang = 'es';
        }
        elsif ($lang eq 'FRENCH')
        {
            $lang = 'fr';
        }
        elsif ($lang eq 'RUSSIAN')
        {
            $lang = 'ru';
        }
        elsif ($lang eq 'PORTUGUESE')
        {
            $lang = 'pt';
        }
        elsif ($lang eq 'CZECH')
        {
            $lang = 'cz';
        }
        elsif ($lang eq 'ITALIAN')
        {
            $lang = 'it';
        }
        elsif ($lang eq 'SIMPCHINESE')
        {
            $lang = 'zh_CN';
        }
        elsif ($lang eq 'TRADCHINESE')
        {
            $lang = 'zh_TW';
        }
        elsif ($lang eq 'NORWEGIAN')
        {
            $lang = 'no';
        }
        elsif ($lang eq 'DUTCH')
        {
            $lang = 'nl';
        }
        else
        {
            fail "$file:$.: unsupported language ID $args[1]";
        }
        $parser->{po}->{$lang}->{$args[0]} = $args[2];
    }

    # Function support.
    #
    # Most functions are ignored.  Some are of special interest and
    # are parsed separately.

    elsif ($parser->{state} eq '' and $command eq 'Function')
    {
        fail "$file:$.: syntax error" if ($#args != 0);

        if ($args[0] eq 'CalcDepends')
        {
            $parser->{state} = 'function-calc-depends';
        }
        elsif ($args[0] eq 'CalcDefaults')
        {
            $parser->{state} = 'function-calc-defaults';
        }
        else
        {
            # Functions we do not find interesting are skipped.
            print STDERR
            "$file:$.: warning: ignoring function $args[0]\n"
            if $::nsis_parser_warn;
            delete $parser->{dep_name};
            $parser->{state} = 'ignore-until-FunctionEnd';
        }
    }

    # Function calc-depends.
    #
    # This function gathers information about dependencies between
    # features.  Features are identified by their frobbed names.  The
    # format is as such: First, a couple of UnselectSection macros,
    # one for each dependency.  Then SelectSection invocations for all
    # packages which should always be installed (mandatory), followed
    # by one block for each feature, consisting of a label "have_FOO:"
    # where FOO is the frobbed package name (in lowercase, usually),
    # followed by SelectSection invocations, one for each dependency,
    # and finally a "skip_FOO:" label to finish the block.
    #
    # The order of these statements and blocks must be so that a single pass
    # through the list is sufficient to resolve all dependencies, that means
    # in pre-fix order.

    elsif ($parser->{state} eq 'function-calc-depends')
    {
        if ($command eq 'FunctionEnd')
        {
            undef $parser->{state};
        }
        elsif ($command =~ m/^have_(.*):$/)
        {
            $parser->{dep_name} = $1;
            $parser->{pkgs}->{$1}->{deps} = {};
        }
        elsif ($command eq '!insertmacro')
        {
            fail "$file:$.: syntax error" if $#args < 0;
            if ($args[0] eq 'SelectSection')
            {
                fail "$file:$.: syntax error" if $#args != 1;
                my $name = $args[1];
                $name =~ s/^\$\{SEC_(.*)\}$/$1/;

                if (not exists $parser->{dep_name})
                {
                    # A stray SelectSection chooses defaults.
                    $parser->{pkgs}->{$name}->{features} .=
                    " Absent='disallow'";
                }
                else
                {
                    my $dep_name = $parser->{dep_name};
                    print STDERR "DEP: Add " . $name . " as a dependency for " .
                    $dep_name . "\n" if $::nsis_parser_debug;

                    # Add $name as a dependency for $dep_name.
                    $parser->{pkgs}->{$dep_name}->{deps}->{$name} = 1;
                }
            }
        }
        elsif ($command =~ m/^skip_(.*):$/)
        {
            fail "$file:$.: stray skip_FOO label"
            if not exists $parser->{dep_name};

            my $dep_name = $parser->{dep_name};
            my $dep_pkg = $parser->{pkgs}->{$dep_name};

            # We resolve indirect dependencies right now.  This works
            # because dependencies are required to be listed in
            # pre-fix order.

            foreach my $name (keys %{$parser->{pkgs}})
            {
                my $pkg = $parser->{pkgs}->{$name};

                # Check if $dep_name is a dependency for $name.
                if (exists $pkg->{deps}->{$dep_name})
                {
                    # Add all dependencies of $dep_name to $name.
                    foreach my $dep (keys %{$dep_pkg->{deps}})
                    {
                        $pkg->{deps}->{$dep} = $pkg->{deps}->{$dep_name} + 1
                        if (not defined $pkg->{deps}->{$dep});
                    }
                }
            }
            delete $parser->{dep_name};
        }
    }

    # Function calc-depends.
    #
    # Format:
    # g4wihelp::config_fetch_bool "inst_FOO"

    elsif ($parser->{state} eq 'function-calc-defaults')
    {
        if ($command eq 'FunctionEnd')
        {
            undef $parser->{state};
        }
        elsif ($command eq 'g4wihelp::config_fetch_bool')
        {
            fail "$file:$.: syntax error" if $#args != 0;

            if ($args[0] !~ m/^"inst_(.*)"$/)
            {
                fail "$file:$.: syntax error";
            }

            $parser->{pkgs}->{$1}->{ini_inst} = 1;
        }
    }
}


# MSI generator.

# Simple indentation tracking, for pretty printing.
$::level = 0;


sub dump_all
{
    my ($parser) = @_;

    my $pkgname;
    # A running count for files within each feature.
    my $fileidx;
    # A running count for registry settings within each feature.
    my $regidx;
    # A running count for directories throughout the whole file.
    my $diridx = 0;
    # The current directory.
    my $cdir = '';

    foreach $pkgname (@{$parser->{pkg_list}})
    {
        my $pkg = $parser->{pkgs}->{$pkgname};

        $fileidx = 0;
        foreach my $file (@{$pkg->{files}})
        {
            if ($cdir ne $file->{dir})
            {
                # We need to change the directory.  We weed out empty
                # path elements, which also takes care of leading slashes.
                my @cdir = grep (!/^$/, split (/\\/, $cdir));
                my @ndir = grep (!/^$/, split (/\\/, $file->{dir}));
                my $min;
                my $i;
                $min = $#cdir;
                $min = $#ndir if ($#ndir < $min);
                for ($i = 0; $i <= $min; $i++)
                {
                    last if ($cdir[$i] ne $ndir[$i])
                }
                my $j;
                for ($j = $i; $j <= $#cdir; $j++)
                {
                    $::level -= 2;
                    print ' ' x $::level
                    . "</Directory>\n";
                }
                for ($j = $i; $j <= $#ndir; $j++)
                {
                    print ' ' x $::level
                    . "<Directory Id='d_$diridx' Name='$ndir[$j]'>\n";
                    $diridx++;
                    $::level += 2;
                }
                $cdir = $file->{dir};
            }

            my $targetfull;
            if ($file->{dir} ne '')
            {
                $targetfull = $file->{dir} . '\\' . $file->{target};
            }
            else
            {
                $targetfull = $file->{target};
            }


            # 64 bit components
            if ($targetfull eq 'bin_64\\gpgol.dll' or
                $targetfull eq 'bin_64\\gpgex.dll')
            {
                print ' ' x $::level
                . "<Component Win64='yes' Id='c_$pkg->{name}_$fileidx' Guid='"
                . get_guid ($targetfull) . "'>\n";
            }
            else # 32 bit components
            {
                print ' ' x $::level
                . "<Component Win64='no' Id='c_$pkg->{name}_$fileidx' Guid='"
                . get_guid ($targetfull) . "'>\n";
            }

            my $sourcefull;
            $sourcefull = $file->{source};
            $sourcefull =~ s/playground\/install-ex/\$(var.InstDirEx)/;
            $sourcefull =~ s/playground\/install/\$(var.InstDir)/;
            $sourcefull =~ s/\.\//\$(var.SrcDir)\//;
            $sourcefull =~ s/\//\\/g;
            print ' ' x $::level
            . "  <File Id='f_$pkg->{name}_$fileidx' Name='"
            . $file->{target} ."' KeyPath='yes'" . " Source='" .
            $sourcefull . "'";

            if ($targetfull eq 'bin_64\\gpgol.dll' or
                $targetfull eq 'bin_64\\gpgex.dll')
            {
                # we cannot write in the 32 bit MSI package into
                # the 64 bit registry. So either we change our
                # package to be 64bit only or do it with the selfreg here.
                #                print ' ' x $::level
                # . " SelfRegCost='1' ";
            }
            print ">\n";

            # Create shortcuts.
            if ($targetfull eq 'bin\\kleopatra.exe')
            {
                print ' ' x $::level
                . "    <Shortcut Id='sm_$pkg->{name}_$fileidx' "
                . " Directory='ProgramMenuDir' Name='Kleopatra'"
                . " Description='!(loc.DESC_Menu_kleopatra)'/>" . "\n";

            }
            if (defined $parser->{shortcuts}->{$targetfull})
            {
                my $shortcut = $parser->{shortcuts}->{$targetfull};
                my $extra = '';

                if (exists $shortcut->{description})
                {
                    my $desc = nsis_translate ($parser, '',
                        $shortcut->{description});
                    $extra .= " Description='$desc'";
                }
                # FIXME: WiX wants the icon to be known at compile time, so it needs a
                # source file, not a target file name.
                #       if ($shortcut->{icon} ne '')
                #       {
                #           $extra .= " Icon='sm_$pkg->{name}_${fileidx}_icon'";
                #       }

                # FIXME: Note that the link name should better not
                # change, or it is not correctly replaced on updates.
                my $link = nsis_translate ($parser, '', $shortcut->{link});
                print ' ' x $::level
                . "    <Shortcut Id='sm_$pkg->{name}_$fileidx' "
                . "Directory='ProgramMenuDir' Name='$link'"
                . $extra;

                #       if ($shortcut->{icon} eq '')
                #       {
                # print "/>\n";
                #       }
                #       else
                #       {
                #           print ">\n";
                #           print ' ' x $::level
                #           . "      <Icon Id='sm_$pkg->{name}_${fileidx}_icon' "
                #           . "SourceFile='$shortcut->{icon}'/>\n";
                #           print ' ' x $::level
                #           . "    </Shortcut>\n";
                #       }

                # Can't make these optional, so we don't do this.
                #       print ' ' x $::level
                #                   . "    <Shortcut Id='dt_$pkg->{name}_$fileidx' "
                #           . "Directory='DesktopFolder' Name='$file->{target}'/>\n";
            }

            print ' ' x $::level
            . "  </File>\n";

            if (defined $parser->{shortcuts}->{$targetfull})
            {
                # http://www.mail-archive.com/wix-users@lists.sourceforge.net/msg02746.html
                # -sice:ICE64
                print ' ' x $::level
                . "  <RemoveFolder Id='rsm_$pkg->{name}_$fileidx' "
                . "Directory='ProgramMenuDir' On='uninstall'/>\n";
            }

            # EXCEPTIONS:
            if ($targetfull eq 'bin\\gpgol.dll' or
                $targetfull eq 'bin_64\\gpgol.dll')
            {
                # KeyPath=no as the file is the key path and the registry values
                # are only meta information for the files.
              print <<EOF;
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\CLSID\\{42d30988-1a3a-11da-c687-000d6080e735}\\InprocServer32" Value="[#f_$pkg->{name}_$fileidx]" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\CLSID\\{42d30988-1a3a-11da-c687-000d6080e735}\\InprocServer32" Name="ThreadingModel" Value="Both" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\CLSID\\{42d30988-1a3a-11da-c687-000d6080e735}\\ProgID" Value="GNU.GpgOL" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\CLSID\\{42d30988-1a3a-11da-c687-000d6080e735}" Value="GpgOL - The GnuPG Outlook Plugin" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\GNU.GpgOL\\CLSID" Value="{42d30988-1a3a-11da-c687-000d6080e735}" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\GNU.GpgOL" Value="GpgOL - The GnuPG Outlook Plugin" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\GNU\\GpgOL" Value="" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Microsoft\\Office\\Outlook\\Addins\\GNU.GpgOL" Name="CommandLineSafe" Value="0" Type="integer" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Microsoft\\Office\\Outlook\\Addins\\GNU.GpgOL" Name="FriendlyName" Value="GpgOL - The GnuPG Outlook Plugin" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Microsoft\\Office\\Outlook\\Addins\\GNU.GpgOL" Name="Description" Value="Cryptography for Outlook" Type="string" Action="write" />
EOF


            } elsif ($targetfull eq 'bin\\gpgex.dll' or
                     $targetfull eq 'bin_64\\gpgex.dll') {
                print ' ' x $::level
                . "  <ProgId Id='*'/>\n";
                print ' ' x $::level
                . "  <ProgId Id='Directory'/>\n";
                print <<EOF;
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\CLSID\\{CCD955E4-5C16-4A33-AFDA-A8947A94946B}" Value="GpgEX" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\CLSID\\{CCD955E4-5C16-4A33-AFDA-A8947A94946B}\\InprocServer32" Name="ThreadingModel" Value="Apartment" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\CLSID\\{CCD955E4-5C16-4A33-AFDA-A8947A94946B}\\InprocServer32" Value="[#f_$pkg->{name}_$fileidx]" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\*\\ShellEx\\ContextMenuHandlers\\GpgEx" Value="{CCD955E4-5C16-4A33-AFDA-A8947A94946B}" Type="string" Action="write" />
                <RegistryValue Root="HKMU" KeyPath='no' Key="Software\\Classes\\Directory\\ShellEx\\ContextMenuHandlers\\GpgEx" Value="{CCD955E4-5C16-4A33-AFDA-A8947A94946B}" Type="string" Action="write" />
EOF
            }
            # Close the component
            print ' ' x $::level
            . "</Component>\n";
            $fileidx++;
        }
        $regidx = 0;
        foreach my $reg (@{$pkg->{registry}})
        {
            my $target;
            my $root;

            if ($reg->{root} eq 'SHCTX')
            {
                $root = 'HKMU';
            }
            else
            {
                $root = $reg->{root};
            }

            my $localValue;

            # Some values need to be translated, like descriptions.
            if ($reg->{value} =~ m/^\$/)
            {
                $localValue = nsis_translate ($parser, '', $reg->{value});
            }
            else
            {
                $localValue = $reg->{value};
            }

            $target = '/REGISTRY/' . $reg->{root} . '/' . $reg->{key}
            . '/' . $reg->{name};

            my $namepart="";
            if ($reg->{name} ne "")
            {
                $namepart = "Name='$reg->{name}' ";
            }

            print ' ' x $::level
            . "<Component Win64='yes' Id='c_$pkg->{name}_r_$regidx' Guid='"
            . get_guid ($target) . "' KeyPath='yes'>\n";
            print ' ' x $::level
            . "  <RegistryValue Id='r_$pkg->{name}_$regidx' Root='"
            . $root . "' Key='" . $reg->{key} . "' " . $namepart
            . " Action='write' Type='" . $reg->{type}
            . "' Value='" . $localValue . "'/>\n";
            print ' ' x $::level
            . "</Component>\n";
            $regidx++;
        }
    }

    my @cdir = grep (!/^$/, split (/\\/, $cdir));
    my $j;
    for ($j = 0; $j <= $#cdir; $j++)
    {
        $::level -= 2;
        print ' ' x $::level
        . "</Directory>\n";
    }
}


sub dump_meat
{
    my ($pkg) = @_;
    my $fileidx;
    my $regidx;

    $fileidx = 0;
    foreach my $file (@{$pkg->{files}})
    {
        print ' ' x $::level
        . "  <ComponentRef Id='c_$pkg->{name}_$fileidx'/>\n";
        $fileidx++;
    }
    $regidx = 0;
    foreach my $reg (@{$pkg->{registry}})
    {
        print ' ' x $::level
        . "  <ComponentRef Id='c_$pkg->{name}_r_$regidx'/>\n";
        $regidx++;
    }
}

sub store_l10n
{
    my ($parser) = @_;

    return if ($::l10n_file eq '');
    open (FILE, ">$::l10n_file") or die "open failed:$!\n";

    # Dump the localization
    foreach my $lang (keys %{$parser->{po}})
    {
        my $codepage;
        my $langid = lang_to_lcid ($::lang);
        my $culture;
        if ($::lang eq 'ENGLISH')
        {
            $codepage = '1252';
            $culture = 'en-us';
        } elsif ($lang eq 'de')
        {
            $codepage = '1252';
            $culture = 'de-de';
            $langid = '1031';
        } else {
            print STDERR "Ignored Language $lang\n";
            next;
        }

        print FILE "<WixLocalization Culture=\"$culture\" Codepage=\"$codepage\"";
        print FILE "     xmlns=\"http://schemas.microsoft.com/wix/2006/localization\">\n";
        print FILE "  <String Id=\"Language\">$langid</String>\n";

        my $key;
        foreach $key (keys %{$parser->{po}->{$lang}})
        {
            print FILE "     <String Id=\"$key\">$parser->{po}->{$lang}->{$key}</String>\n";
        }
        print FILE "</WixLocalization>\n";
    }
}

sub dump_all2
{
    my ($parser) = @_;

    my $pkgname;

    foreach $pkgname (@{$parser->{pkg_list}})
    {
        my $pkg = $parser->{pkgs}->{$pkgname};
        my $features;

        next if $pkg->{hidden};

        $features = $pkg->{features};
        #   $features .= " Display='hidden'" if $pkg->{hidden};
        $features .= " Description='$pkg->{description}'"
        if $pkg->{description};

        my $title = nsis_translate ($parser, '', $pkg->{title});

        print ' ' x $::level
        . "<Feature Id='p_$pkg->{name}' Level='$pkg->{level}' "
        . "Title='$title'" . $features . ">\n";
        if ($pkg->{ini_inst})
        {
            my $uc_pkgname = uc ($pkgname);

            print ' ' x $::level
            . "<Condition Level='$::nsis_level_default'>"
            . "INST_$uc_pkgname = \"true\"</Condition>\n";
            print ' ' x $::level
            . "<Condition Level='$::nsis_level_optional'>"
            . "INST_$uc_pkgname = \"false\"</Condition>\n";
        }
        if ($pkg->{name} eq "kleopatra")
        {
            print ' ' x $::level
            . " <Feature Id='p_kleo_desktop' Title='p_kleo_desktop' Level='1000'"
            . " Display='hidden' InstallDefault='followParent'>\n"
            . "  <Condition Level='1'>INST_DESKTOP= \"true\"</Condition>\n"
            . "  <Condition Level='1000'>INST_DESKTOP= \"false\"</Condition>\n"
            . "  <ComponentRef Id='ApplicationShortcutDesktop'/>\n"
            . " </Feature>\n";

            # That p12 and der, crt have pfx and cer names respectively is a Windows thing.
            print ' ' x $::level
            . " <Feature Id='p_kleo_smime_types' Title='p_kleo_smime_types' Level='1000'"
            . " Display='hidden' InstallDefault='followParent'>\n"
            . "  <Condition Level='1'>DEFAULT_ALL_SMIME = \"true\"</Condition>\n"
            . "  <Condition Level='1000'>DEFAULT_ALL_SMIME = \"false\"</Condition>\n"
            . "  <Component Win64='yes' Id='DefaultSmimeExt' Guid='9B63C4D2-50F1-4747-8D79-0621130B7318' KeyPath='yes' Directory='APPLICATIONFOLDER'>\n"
            . "      <RegistryValue Id='r_kleopatra_default' Root='HKMU' Key='Software\\Classes\\gpg4win.AssocFile.Kleopatra.X509' Name='AllowSilentDefaultTakeOver' Action='write' Type='binary' Value='1'/>\n"
            . "      <RegistryValue Id='r_kleopatra_cer' Root='HKMU' Key='Software\\Classes\\.cer\\OpenWithProgIDs' Name='gpg4win.AssocFile.Kleopatra.X509'  Action='write' Type='binary' Value='0'/>\n"
            . "      <RegistryValue Id='r_kleopatra_cer_o' Root='HKMU' Key='Software\\Classes\\CERFile\\shell\\open\\command'  Action='write' Type='expandable' Value='\"[APPLICATIONFOLDER]bin\\kleopatra.exe\" -- \"%1\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_cer_i' Root='HKMU' Key='Software\\Classes\\CERFile\\DefaultIcon'  Action='write' Type='string' Value='\"[APPLICATIONFOLDER]share\\gpg4win\\file-ext.ico\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p10' Root='HKMU' Key='Software\\Classes\\.p10\\OpenWithProgIDs' Name='gpg4win.AssocFile.Kleopatra.X509'  Action='write' Type='binary' Value='0'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p10_o' Root='HKMU' Key='Software\\Classes\\P10File\\shell\\open\\command'  Action='write' Type='expandable' Value='\"[APPLICATIONFOLDER]bin\\kleopatra.exe\" -- \"%1\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p10_i' Root='HKMU' Key='Software\\Classes\\P10File\\DefaultIcon'  Action='write' Type='string' Value='\"[APPLICATIONFOLDER]share\\gpg4win\\file-ext.ico\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p12' Root='HKMU' Key='Software\\Classes\\.p12\\OpenWithProgIDs' Name='gpg4win.AssocFile.Kleopatra.X509'  Action='write' Type='binary' Value='0'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p12_o' Root='HKMU' Key='Software\\Classes\\PFXFile\\shell\\open\\command'  Action='write' Type='expandable' Value='\"[APPLICATIONFOLDER]bin\\kleopatra.exe\" -- \"%1\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p12_i' Root='HKMU' Key='Software\\Classes\\PFXFile\\DefaultIcon'  Action='write' Type='string' Value='\"[APPLICATIONFOLDER]share\\gpg4win\\file-ext.ico\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p7c' Root='HKMU' Key='Software\\Classes\\.p7c\\OpenWithProgIDs' Name='gpg4win.AssocFile.Kleopatra.X509'  Action='write' Type='binary' Value='0'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p7c_o' Root='HKMU' Key='Software\\Classes\\certificate_wab_auto_file\\shell\\open\\command'  Action='write' Type='expandable' Value='\"[APPLICATIONFOLDER]bin\\kleopatra.exe\" -- \"%1\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_p7c_i' Root='HKMU' Key='Software\\Classes\\certificate_wab_auto_file\\DefaultIcon'  Action='write' Type='string' Value='\"[APPLICATIONFOLDER]share\\gpg4win\\file-ext.ico\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_pfx' Root='HKMU' Key='Software\\Classes\\.pfx\\OpenWithProgIDs' Name='gpg4win.AssocFile.Kleopatra.X509'  Action='write' Type='binary' Value='0'/>\n"
            . "      <RegistryValue Id='r_kleopatra_pfx_o' Root='HKMU' Key='Software\\Classes\\PFXFile\\shell\\open\\command'  Action='write' Type='expandable' Value='\"[APPLICATIONFOLDER]bin\\kleopatra.exe\" -- \"%1\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_pfx_i' Root='HKMU' Key='Software\\Classes\\PFXFile\\DefaultIcon'  Action='write' Type='string' Value='\"[APPLICATIONFOLDER]share\\gpg4win\\file-ext.ico\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_crt' Root='HKMU' Key='Software\\Classes\\.crt\\OpenWithProgIDs' Name='gpg4win.AssocFile.Kleopatra.X509'  Action='write' Type='binary' Value='0'/>\n"
            . "      <RegistryValue Id='r_kleopatra_crt_o' Root='HKMU' Key='Software\\Classes\\CERFile\\shell\\open\\command'  Action='write' Type='expandable' Value='\"[APPLICATIONFOLDER]bin\\kleopatra.exe\" -- \"%1\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_crt_i' Root='HKMU' Key='Software\\Classes\\CERFile\\DefaultIcon'  Action='write' Type='string' Value='\"[APPLICATIONFOLDER]share\\gpg4win\\file-ext.ico\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_der' Root='HKMU' Key='Software\\Classes\\.der\\OpenWithProgIDs' Name='gpg4win.AssocFile.Kleopatra.X509'  Action='write' Type='binary' Value='0'/>\n"
            . "      <RegistryValue Id='r_kleopatra_der_o' Root='HKMU' Key='Software\\Classes\\CERFile\\shell\\open\\command'  Action='write' Type='expandable' Value='\"[APPLICATIONFOLDER]bin\\kleopatra.exe\" -- \"%1\"'/>\n"
            . "      <RegistryValue Id='r_kleopatra_der_i' Root='HKMU' Key='Software\\Classes\\CERFile\\DefaultIcon'  Action='write' Type='string' Value='\"[APPLICATIONFOLDER]share\\gpg4win\\file-ext.ico\"'/>\n"
            . "  </Component>\n"
            . " </Feature>\n"
            . " <Feature Id='p_kleo_smime_types_no' Title='p_kleo_smime_types_no' Level='1'"
            . " Display='hidden' InstallDefault='followParent'>\n"
            . "  <Condition Level='1000'>DEFAULT_ALL_SMIME = \"true\"</Condition>\n"
            . "  <Condition Level='1'>DEFAULT_ALL_SMIME = \"false\"</Condition>\n"
            . "  <Component Win64='yes' Id='DefaultSmimeExtNo' Guid='9B63C4D2-50F1-4747-8D79-0621130B7319' KeyPath='yes' Directory='APPLICATIONFOLDER'>\n"
            . "      <RegistryValue Id='r_kleopatra_no_default' Root='HKMU' Key='Software\\Classes\\gpg4win.AssocFile.Kleopatra.X509' Name='AllowSilentDefaultTakeOver' Action='write' Type='binary' Value='0'/>\n"
            . "  </Component>\n"
            . " </Feature>\n";

            print ' ' x $::level
            . " <Feature Id='p_kleo_autostart' Title='p_kleo_autostart' Level='1000'"
            . " Display='hidden' InstallDefault='followParent'>\n"
            . "  <Condition Level='1'>AUTOSTART= \"true\"</Condition>\n"
            . "  <Condition Level='1000'>AUTOSTART= \"false\"</Condition>\n"
            . "  <Component Id='KleoAutostartRegKey' Guid='6520AE4C-E588-4CC9-B433-102F35C95B74' Directory='APPLICATIONFOLDER'>\n"
            . "  <RegistryValue Root='HKMU' Key='Software\\Microsoft\\Windows\\CurrentVersion\\Run' Name='Kleopatra'\n"
            . "    Type='string' Value='[APPLICATIONFOLDER]bin\\kleopatra.exe --daemon' KeyPath='yes'/>\n"
            . "  </Component>\n"
            . " </Feature>\n"
        }
        if ($pkg->{name} eq "gpgol")
        {
            # Enable INST_GPGOL=inactive
            print <<EOF;
            <Feature Id='p_gpgol_autoload' Title='p_gpgol_autoload' Level='1' Display='hidden' InstallDefault='followParent'>
              <Condition Level='1000'>INST_GPGOL=\"inactive\"</Condition>
              <Component Id='GpgOLActivateRegKey' Win64='yes' Guid='87765E51-3902-41F8-B624-4CCEBC731A13' Directory='APPLICATIONFOLDER'>
                <RegistryValue Root="HKMU" KeyPath='yes' Key="Software\\Microsoft\\Office\\Outlook\\Addins\\GNU.GpgOL" Name="LoadBehavior" Value="3" Type="integer" Action="write" />
              </Component>
              <Component Id='GpgOLActivateRegKey_32' Win64='no' Guid='87765E51-3902-41F8-B624-4CCEBC731A14' Directory='APPLICATIONFOLDER'>
                <RegistryValue Root="HKMU" KeyPath='yes' Key="Software\\Microsoft\\Office\\Outlook\\Addins\\GNU.GpgOL" Name="LoadBehavior" Value="3" Type="integer" Action="write" />
              </Component>
            </Feature>
EOF
        }

        dump_meat ($pkg);

        foreach my $dep (keys %{$pkg->{deps}})
        {
            $dep =~ s/-/_/g;
            my $deppkg = $parser->{pkgs}->{$dep};

            # We use Level=1 because with InstallDefault followParent
            # the Level seems to specify some sort of minimum install
            # level or something (FIXME: confirm this).
            print ' ' x $::level
            . "  <Feature Id='p_$pkg->{name}_$dep' "
            . "Title='p_$pkg->{name}_$dep' "
            . "Level='1' Display='hidden' "
            . "InstallDefault='followParent'>\n";
            $::level += 2;
            dump_meat ($deppkg);
            $::level -= 2;
            print ' ' x $::level
            . "  </Feature>\n";
        }
        print ' ' x $::level
        . "</Feature>\n";
    }
}

sub scan_dir {
    my ($workdir) = @_;

    my @ret;

    my ($startdir) = &cwd; # keep track of where we began

    chdir($workdir) or die "Unable to enter dir $workdir:$!\n";
    opendir(DIR, ".") or die "Unable to open $workdir:$!\n";
    my @names = readdir(DIR) or die "Unable to read $workdir:$!\n";
    closedir(DIR);

    foreach my $name (@names){
        next if ($name eq ".");
        next if ($name eq "..");

        my $abspath = "$startdir/$workdir/$name";

        if (-d "$abspath") {
            foreach my $subname (&scan_dir($name)) {
                push (@ret, $subname);
            }
            next;
        }
        push (@ret, $abspath);
    }

    chdir($startdir) or
        die "Unable to change to dir $startdir:$!\n";
    return @ret;
}

sub dump_help {
    my ($workdir) = @_;
    my $custom_name = basename($workdir);
    open (FILE, ">$workdir/$custom_name.wxs") or
        die "Can't create $custom_name.wxs:$!\n";
    my $fileidx = 0;

    foreach my $file (&scan_dir($workdir)) {
        my $basename = basename($file);
        my $dirname = "HelpDataFolder";

        if ($basename =~ /^\./) {
            next;
        }

        my $guid = get_tmp_guid ($file);
        my $sourcefull = "\$(var.SrcDir)/" . $file;
        $sourcefull =~ s/.*\/src\//\$(var.SrcDir)\//;
        $sourcefull =~ s/\//\\/g;

        my $custom_name_us=$custom_name;
        $custom_name_us =~ s/-/_/;

        print FILE ' ' x 6 . '<Component Id="c_' . $custom_name_us . "_" . $fileidx
        . '" Directory="' . $dirname . '" Guid="' . $guid . '" KeyPath="yes">' . "\n";

        print FILE ' ' x 8
        . "  <File Id='f_$custom_name_us" . "_$fileidx' Name='"
        . $basename ."' KeyPath='no'" . " Source='" .
        $sourcefull . "'/>\n";

        print FILE ' ' x 6 . '</Component>' . "\n";

        $fileidx += 1;
    }
    close FILE;
}

sub dump_single_custom {
    my ($workdir) = @_;
    my $custom_name = basename($workdir);
    open (FILE, ">$workdir/$custom_name.wxs") or die "open failed:$!\n";
    print FILE <<EOF;
<?xml version="1.0" encoding="utf-8"?>
<Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
  <Fragment>
    <DirectoryRef Id="APPLICATIONFOLDER">
     <Directory Id="CommonAppDataFolder">
        <Directory Id="CommonAppDataManufacturerFolder" Name="GNU">
          <Directory Id="AppDataSubFolder" Name="etc">
            <Directory Id="GnuPGDataFolder" Name="gnupg">
              <Directory Id="GnuPGTrustedCerts" Name="trusted-certs"/>
              <Directory Id="GnuPGExtraCerts" Name="extra-certs"/>
            </Directory>
          </Directory>
        </Directory>
      </Directory>
      </DirectoryRef>
    </Fragment>
   <Fragment>
    <ComponentGroup Id="c_customization">
EOF
   print STDERR "Including: help\n";
   open (INCFILE, "<$workdir/../help/help.wxs") or die "open failed:$!\n";
   while (<INCFILE>)
   {
       print FILE $_;
   }
   close (INCFILE);

    my $fileidx = 0;

    foreach my $file (&scan_dir($workdir)) {
        my $basename = basename($file);
        my $dirname = dirname($file);

        if ($basename eq "$custom_name.wxs") {
            next;
        }
        if ($basename eq "$custom_name.wixlib") {
            next;
        }
        if ($basename eq "customer-enc-key.asc") {
            next;
        }
        if ($basename =~ /^\./) {
            next;
        }

        if ($dirname =~ /Standard\/etc\/gnupg/) {
            # We need to skip the Unix etc directory so that it does
            # not end up as global config on Windows.
            next;
        }
        if ($dirname =~ /[^\/]+\/misc/) {
            # Ignore 2nd level subdirs named "misc"
            next;
        }

        if ($basename =~ /.+\.wxs\.include$/) {
           print STDERR "Including $basename for $custom_name\n";
           open (INCFILE, "<$workdir/$basename") or
               die "open failed:$!\n";
           while (<INCFILE>)
           {
               print FILE $_;
           }
           close (INCFILE);
        }

        my $guid = get_tmp_guid ($file);
        my $sourcefull = "\$(var.SrcDir)/" . $file;
        $sourcefull =~ s/.*\/src\//\$(var.SrcDir)\//;
        $sourcefull =~ s/\//\\/g;
        my $mode = "";

        if ($dirname =~ /trusted-certs$/) {
            $dirname = "GnuPGTrustedCerts";
        } elsif ($dirname =~ /extra-certs$/) {
            $dirname = "GnuPGExtraCerts";
        } elsif ($basename eq "VERSION" ||
                 $basename eq "VERSION.sig" ||
                 $basename eq "license.rtf") {
            # The VERSION file is special and needs to go
            # in the Gpg4win root folder.
            $dirname = "APPLICATIONFOLDER";
        } elsif ($basename =~ /kleopatrarc(.*)/ or
                 $basename =~ /libkleopatrarc(.*)/) {
            $dirname = "KleopatraDataFolder";
            $mode = "$1";
            $mode =~ s/_(.*)/\1/;
            $basename =~ s/_.*//;
        }
        else {
            $dirname = "GnuPGDataFolder";
        }

        my $custom_name_us=$custom_name;
        $custom_name_us =~ s/-/_/;

        print FILE ' ' x 6 . '<Component Id="c_' . $custom_name_us . "_" . $fileidx
        . '" Directory="' . $dirname . '" Guid="' . $guid . '" KeyPath="yes">' . "\n";

        print FILE ' ' x 8
        . "  <File Id='f_$custom_name_us" . "_$fileidx' Name='"
        . $basename ."' KeyPath='no'" . " Source='" .
        $sourcefull . "'/>\n";

        if ($mode ne "") {
            print FILE ' ' x 10 . "<Condition>MODE = \"" . $mode . "\"</Condition>\n";
        }
        if (($basename =~ /kleopatrarc/ or
             $basename =~ /libkleopatrarc/) and
             $mode eq "") {
            print FILE ' ' x 10 . "<Condition>MODE = \"" . "default" . "\"</Condition>\n";
        }

        print FILE ' ' x 6 . '</Component>' . "\n";

        $fileidx += 1;
    }
    print FILE <<EOF;
    </ComponentGroup>
  </Fragment>
</Wix>
EOF
    close FILE;
}

sub dump_customs
{
    my ($startdir) = &cwd;
    my ($workdir) = @_;

    chdir($workdir) or die "Unable to enter dir $workdir:$!\n";
    opendir(DIR, ".") or die "Unable to open $workdir:$!\n";
    my @names = readdir(DIR) or die "Unable to read $workdir:$!\n";
    closedir(DIR);
    dump_help("help");

    foreach my $name (@names) {
        next if ($name eq ".");
        next if ($name eq "..");
        next if ($name eq "vs-desktop-branding");
        next if ($name eq "desktop-branding");
        next if ($name eq "custom.mk");
        next if ($name eq "sign.mk");
        next if ($name eq ".git");
        next if ($name eq ".gitignore");
        next if ($name eq "announcement.de.in");
        next if ($name eq "announcement.en.in");
        next if ($name eq "gnupg.com-info-key.asc");
        next if ($name eq "general-enc-key.asc");
        next if ($name eq "help");
        next if ($name eq "README");
        next if ($name =~ /~$/);

        if (-d $name) {
            dump_single_custom($name);
            next;
        }
        print STDERR "Unknown file in vsd-custom directory. '$name' \n";
    }
    chdir($startdir) or die "Unable to dir $startdir!\n";
}

dump_customs("gnupg-vsd");


# Just so that it is defined.
$. = 0;

my %parser = ( pre_depth => 0, pre_true => 0 );
my $parser = \%parser;

fetch_guids ();

$::build_version = '';
$::product_name = '';

while ($#ARGV >= 0 and $ARGV[0] =~ m/^-/)
{
    my $opt = shift @ARGV;
    if ($opt =~ m/^--guids$/)
    {
        $::guid_file = shift @ARGV;
    }
    elsif ($opt =~ m/^--manifest$/)
    {
        $::files_file = shift @ARGV;
    }
    elsif ($opt =~ m/^--version$/)
    {
        $::build_version = shift @ARGV;
    }
    elsif ($opt =~ m/^--name$/)
    {
        $::product_name = shift @ARGV;
    }
    elsif ($opt =~ m/^-D([^=]*)=(.*)$/)
    {
        $parser->{pre_symbols}->{$1} = $2;
    }
    elsif ($opt =~ m/^-L(.*)$/)
    {
        $::lang = $1;
        # Test if it is supported.
        if (!lang_to_lcid ($::lang))
        {
            print STDERR "language: $::lang is not supported.";
            exit 1;
        }
    }
    elsif ($opt eq '--usage')
    {
        print STDERR "Usage: $0 [-DNAME=VALUE...] NSIFILE\n";
        print STDERR "Use --help or -h for more information.\n";
        exit 1;
    }
    elsif ($opt eq '-h' or $opt eq '--help')
    {
        print STDERR "Usage: $0 [-DNAME=VALUE...] NSIFILE\n";
        print STDERR "Convert the .nsi file NSIFILE to a WiX source file.\n";
        print STDERR "Options:\n";
        print STDERR "       --guids NAME     Save GUIDs into file NAME (default: $::guid_file)\n";
        print STDERR "       --manifest NAME  Save included files into file NAME (default: $::files_file)\n";
        print STDERR "       -DNAME=VALUE     Define preprocessor symbol NAME to VALUE\n";
        print STDERR "       -LLANG           Build installer for language LANG (default: $::lang)\n";
        print STDERR "       --version        VERSION of the installer.\n";
        print STDERR "       --name           Product name to use in the installer.\n";
        print STDERR "\n";
        print STDERR "       -h|--help        Print this help and exit\n";
        exit 0;
    }
    else
    {
        print STDERR "$0: unknown option $opt\n";
        print STDERR "Usage: $0 [-DNAME=VALUE...] NSIFILE\n";
        print STDERR "Use --help or -h for more information.\n";
        exit 1;
    }
}


if ($#ARGV < 0)
{
    nsis_parse_file ($parser, '-');
}
else
{
    nsis_parse_file ($parser, $ARGV[0]);
}

# Add exceptions.
# ===============

$parser->{pkgs}->{gnupg}->{deps}->{gpg4win} = 1;

# For debugging:
# use Data::Dumper;
# print Dumper ($parser);
# exit;

# Dump the gathered information.
# ==============================
$::l10n_file = "gpg4win-all.wxl";

my $BUILD_FILEVERSION = nsis_fetch ($parser, '_BUILD_FILEVERSION');

if ($::build_version eq '')
{
    $::build_version = $BUILD_FILEVERSION;
}

if ($::product_name eq '')
{
    $::product_name = nsis_fetch ($parser, '_PACKAGE');
}

my $product_id = get_guid ("/PRODUCT/$::build_version");
my $upgrade_code = get_guid ("/UPGRADE/1");

if ($::product_name eq 'GnuPG VS-Desktop')
{
        my $prod_underscored = $::product_name;
        $prod_underscored =~ s/ /_/g;
        $product_id = get_guid ("/PRODUCT/$prod_underscored/$::build_version");
#       The upgrade code should be the same across all versions to avoid
#       that two versions are installed at the same time.
#       $upgrade_code = get_guid ("/UPGRADE/$prod_underscored/1");
}

my $INSTALL_DIR = nsis_fetch ($parser, 'INSTALL_DIR');

my $lcid = lang_to_lcid ($::lang);

# Replacement regex for components:
# :'<,'>s/.*Component: \(.*\) does not.*/      <ComponentRef Id=\1 \/>/

print <<EOF;
<?xml version='1.0'?>
<Wix xmlns='http://schemas.microsoft.com/wix/2006/wi'>
  <!-- The general product setup -->
  <Product Name='$::product_name'
           Id='$product_id'
           UpgradeCode='$upgrade_code'
           Language='$lcid'
           Codepage='1252'
           Version='$::build_version'
           Manufacturer='GnuPG.com'>
    <Package Description='$::product_name'
             Comments='http://www.gnupg.com/'
             Compressed='yes'
             InstallerVersion='200'
             Manufacturer='GnuPG.com'
             Languages='1033'
             SummaryCodepage='1252'/>

    <Condition Message="At least Windows 7 or Server 2008 R2 required.">
        <![CDATA[Installed OR (VersionNT >= 601)]]>
    </Condition>

    <Upgrade Id='$upgrade_code'>
      <UpgradeVersion Property='UPGRADEPROP'
                      IncludeMaximum='no'
                      Maximum='$::build_version'/>
    </Upgrade>

    <!-- Set up Properties -->
    <MediaTemplate EmbedCab="yes" />
    <!-- 2 is like highest available in msi -->
    <!-- 1 forces highest available -->
    <Property Id="ALLUSERS" Value="1" />

    <Property Id="ApplicationFolderName" Value="$::product_name" />
    <Property Id="WixAppFolder" Value="WixPerMachineFolder" />

    <Property Id="APPLICATIONFOLDER">
      <RegistrySearch Id='gpg4win_instdir_registry' Type='raw'
       Root='HKLM' Key='Software\\Gpg4win' Name='Install Directory'/>
      <IniFileSearch Id='gpg4win_instdir_ini' Type='raw'
       Name='gpg4win.ini' Section='gpg4win' Key='instdir'/>
    </Property>

    <Property Id="GPG4WININSTALLED">
      <RegistrySearch Id='gpg4win_instdir_registry2' Type='raw'
       Root='HKLM' Key='Software\\Gpg4win' Name='Install Directory'
       Win64='no'/>
    </Property>

    <Property Id="VSDINSTALLED">
      <RegistrySearch Id='vsdinstalled' Type='raw'
       Root='HKLM' Key='Software\\Gpg4win' Name='VS-Desktop-Version'
       Win64='no'/>
    </Property>

    <Condition Message="!(loc.gpg4winInstalled)">
        <![CDATA[VSDINSTALLED OR (NOT GPG4WININSTALLED)]]>
    </Condition>

    <!-- Turn on logging
        <Property Id="MsiLogging" Value="gnupg-desktop"/>
    -->
    <Icon Id="shield.ico" SourceFile="shield.ico"/>
    <Property Id="ARPPRODUCTICON" Value="shield.ico"/>

    <WixVariable Id="WixUIBannerBmp" Value="header.bmp" />
    <WixVariable Id="WixUIDialogBmp" Value="dialog.bmp" />
    <WixVariable Id="WixUIExclamationIcon" Value="exclamation.bmp" />
    <WixVariable Id="WixUIInfoBmp" Value="info.bmp" />

    <Property Id="ARPHELPLINK" Value="https://gnupg.com" />
    <!-- We leave repair Property Id="ARPNOREPAIR" Value="yes" Secure="yes" /> -->
    <!-- We leave modify <Property Id="ARPNOMODIFY" Value="yes" Secure="yes" /> -->

    <!-- We allow Downgrades
    <MajorUpgrade DowngradeErrorMessage="!(loc.T_FoundExistingVersion)" AllowDowngrades="yes" AllowSameVersionUpgrades="yes" />
    -->
    <MajorUpgrade AllowDowngrades="yes"/>

    <WixVariable Id="WixUILicenseRtf" Value="license.rtf" />

    <!-- This is the main installer sequence run when the product is actually installed -->
    <InstallExecuteSequence>

       <!-- Determine the install location after the install path has been validated by the installer -->
       <Custom Action="SetARPINSTALLLOCATION" After="InstallValidate"></Custom>

    </InstallExecuteSequence>

    <!-- Set up ARPINSTALLLOCATION property (http://blogs.technet.com/b/alexshev/archive/2008/02/09/from-msi-to-wix-part-2.aspx) -->
    <CustomAction Id="SetARPINSTALLLOCATION" Property="ARPINSTALLLOCATION" Value="[APPLICATIONFOLDER]" />

    <!-- Save the command line value INSTALLDIR and restore it later in the sequence or it will be overwritten by the value saved to the registry during an upgrade -->
    <!-- http://robmensching.com/blog/posts/2010/5/2/the-wix-toolsets-remember-property-pattern/ -->
    <CustomAction Id='SaveCmdLineValueINSTALLDIR' Property='CMDLINE_INSTALLDIR' Value='[APPLICATIONFOLDER]' Execute='firstSequence' />
    <CustomAction Id='SetFromCmdLineValueINSTALLDIR' Property='INSTALLDIR' Value='[CMDLINE_INSTALLDIR]' Execute='firstSequence' />
    <InstallUISequence>
       <Custom Action='SaveCmdLineValueINSTALLDIR' Before='AppSearch' />
       <Custom Action='SetFromCmdLineValueINSTALLDIR' After='AppSearch'>
          CMDLINE_INSTALLDIR
       </Custom>
    </InstallUISequence>
    <InstallExecuteSequence>
       <Custom Action='SaveCmdLineValueINSTALLDIR' Before='AppSearch' />
       <Custom Action='SetFromCmdLineValueINSTALLDIR' After='AppSearch'>
          CMDLINE_INSTALLDIR
       </Custom>
    </InstallExecuteSequence>

    <Property Id="INSTALLDIR">
      <RegistrySearch Win64='no' Id="DetermineInstallLocation" Type="raw" Root="HKLM" Key="Software\\Gpg4win" Name="Install Directory" />
    </Property>

    <Property Id="INST_DESKTOP">
      <IniFileSearch Id='gpg4win_ini_inst_desktop' Type='raw'
       Name='gpg4win.ini' Section='gpg4win' Key='inst_desktop'/>
    </Property>

    <Property Id="DEFAULT_ALL_SMIME">
      <IniFileSearch Id='gpg4win_ini_all_smime' Type='raw'
       Name='gpg4win.ini' Section='gpg4win' Key='default_all_smime'/>
    </Property>

    <Property Id="AUTOSTART">
      <IniFileSearch Id='gpg4win_ini_autostart' Type='raw'
       Name='gpg4win.ini' Section='gpg4win' Key='autostart'/>
    </Property>

    <Property Id="HOMEDIR">
      <IniFileSearch Id='gpg4win_ini_homedir' Type='raw'
       Name='gpg4win.ini' Section='gpg4win' Key='homedir'/>
    </Property>

    <Property Id="MODE">default</Property>

    <!-- Launch Kleopatra after setup exits
    <CustomAction Id            = "StartAppOnExit"
                  FileKey       = "kleopatra.exe"
                  ExeCommand    = ""
                  Execute       = "immediate"
                  Impersonate   = "yes"
                  Return        = "asyncNoWait" />
    <Property Id="WIXUI_EXITDIALOGOPTIONALCHECKBOXTEXT"
      Value="Launch Kleopatra" />
    <Property Id="WIXUI_EXITDIALOGOPTIONALCHECKBOX" Value="1" />
 -->

    <Feature Id="Feature_GnuPG"
         Title="GnuPG"
         Level="1"
         Absent='disallow'>
      <ComponentGroupRef Id="CMP_GnuPG" />
      <Component Win64='no' Id="gpg4win_reg_cmp" Guid="7F122F29-DB6A-4DE5-9DD2-0DAF1A24B62F" Directory="APPLICATIONFOLDER">
        <RegistryValue Id="r_gpg4win_01" Root="HKMU" Key="Software\\Gpg4win" Name="Install Directory" Action="write"
                       Type="string" Value="[APPLICATIONFOLDER]" KeyPath="yes"/>
        <RegistryValue Id="r_gpg4win_02" Root="HKMU" Key="Software\\Gpg4win" Name="VS-Desktop-Version" Action="write"
                       Type="string" Value="$::build_version" KeyPath="no"/>
      </Component>
      <Feature Id='p_homedir' Title='p_homedir' Level='1000'
        Display='hidden' InstallDefault='followParent'>
        <Condition Level='1'>HOMEDIR</Condition>
        <Component Win64='no' Id='homedir_non_default_cmp' Guid='2C11476C-747D-4CA9-9A53-A64445761A4C' Directory='APPLICATIONFOLDER'>
        <RegistryValue Root='HKMU' Key='Software\\GNU\\GnuPG' Name='HomeDir'
         Type='expandable' Value='[HOMEDIR]' KeyPath='yes'/>
        </Component>
      </Feature>
      <!-- Hardcode some components that always should be installed -->

      <!-- List comes from ICE21 and was transformed by see: comment above -->
      <ComponentRef Id='c_gpg4win_0' />
      <ComponentRef Id='c_gpg4win_1' />
      <ComponentRef Id='c_gpg4win_2' />
      <ComponentRef Id='c_gpg4win_3' />
      <ComponentRef Id='c_gpg4win_4' />
      <ComponentRef Id='c_gpg4win_5' />
      <ComponentRef Id='c_gpg4win_6' />
      <ComponentRef Id='c_gpg4win_7' />
      <ComponentRef Id='c_pinentry_0' />
      <ComponentRef Id='c_pinentry_1' />
      <ComponentRef Id='c_scute_0' />
      <ComponentRef Id='c_paperkey_0' />
      <ComponentRef Id='c_paperkey_1' />
      <ComponentGroupRef Id='c_customization' />

    </Feature>
EOF

foreach my $pkgname (@{$parser->{pkg_list}})
{
    if (exists $parser->{pkgs}->{$pkgname}->{ini_inst})
    {
        my $uc_pkgname = uc ($pkgname);

        print <<EOF;
    <Property Id="INST_$uc_pkgname">
      <IniFileSearch Id='gpg4win_ini_inst_$pkgname' Type='raw'
       Name='gpg4win.ini' Section='gpg4win' Key='inst_$pkgname'/>
    </Property>

EOF
    }
}

print <<EOF;
    <Directory Id='TARGETDIR' Name='SourceDir'>
      <Directory Id='ProgramFilesFolder' Name='PFiles'>
        <!-- DIR_GnuPG is used be the GnuPG wxlib -->
        <Directory Id='APPLICATIONFOLDER' Name='$::product_name'>
          <Directory Id="KleopatraDataFolder" Name="share">
            <Directory Id="ShareDocFolder" Name="doc">
              <Directory Id="HelpDataFolder" Name="gnupg-vsd"/>
            </Directory>
          </Directory>
          <Directory Id='DIR_GnuPG' Name='GnuPG'/>
EOF

$::level = 12;
dump_all ($parser);


print <<EOF;
        </Directory>
      </Directory>
EOF

print <<EOF;
  <Directory Id='ProgramMenuFolder' Name='PMenu'>
    <Directory Id='ProgramMenuDir' Name='$::product_name'/>
  </Directory>
  <Directory Id='DesktopFolder' Name='Desktop' >
    <Component Id='ApplicationShortcutDesktop' Guid='8FCEA457-D3AD-41CC-BD0B-3E071D6E70BE'>
      <Shortcut Id='ApplicationDesktopShortcut'
       Name='Kleopatra'
       Description='!(loc.DESC_Menu_kleopatra)'
       Target='[APPLICATIONFOLDER]bin\\kleopatra.exe'/>
      <RemoveFolder Id="DesktopFolder" On="uninstall"/>
      <RegistryValue
          Root="HKMU"
          Key="Software\\Gpg4win"
          Name="desktop_icon"
          Type="integer"
          Value="1"
          KeyPath="yes"/>
   </Component>
  </Directory>
EOF

#print <<EOF;
#      <Directory Id="DesktopFolder" Name="Desktop"/>
#EOF


print <<EOF;
    </Directory>

    <Feature Id='Complete' Title='$::product_name' Description='All components.'
             Display='expand' Level='1' ConfigurableDirectory='APPLICATIONFOLDER'>
EOF

$::level = 6;
dump_all2 ($parser);

# Removed this, because it is not localized:
#    <UIRef Id='WixUI_ErrorProgressText' />

print <<EOF;
    </Feature>

    <!-- Set up the UI -->
    <UI>
      <UIRef Id="WixUI_Advanced"/>
    </UI>

  </Product>
</Wix>
EOF

# Post-processing: We need to remember the GUIDs for later reuse, and
# we remember the files we need in case we want to transfer them to a
# different machine for invocation of WiX.

store_guids ();
store_l10n ($parser);
store_files ($parser);

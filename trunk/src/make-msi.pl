#! /usr/bin/perl -w
# make-msi.pl - MSI Installer for GnuPG 4 Windows.
# Copyright (C) 2007 g10 Code GmbH
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

use strict;
use warnings;
use diagnostics;


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
    open (FILE, ">$::guid_file.bak") or die;
    print FILE "# This is an automatically generated file.  DO NOT EDIT.\n";
    foreach my $file (sort keys %::guid)
    {
	print FILE "$::guid{$file} $file\n";
    }
    close FILE;
    rename "$::guid_file.bak", $::guid_file or die;
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
    $guid = `uuidgen`;
    chomp $guid;
    $::guid{$file} = $guid;
    return $guid;
}


$::files_file = '';

# We store the list of included files for temporary packaging, in case
# WiX needs to be run on a different system.
sub store_files
{
    my ($parser) = @_;

    return if ($::files_file eq '');
    open (FILE, ">$::files_file") or die;
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
    else
    {
	fail "language $lang not supported";
    }
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
$::nsis_parser_warn = 0;
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
    while ($val =~ m/\${([^}]*)}/)
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
	$val =~ s/\${$varname}/$varvalue/g;

	$iter++;
	if ($iter > 100)
	{
	    fail "$file:$.: too many variable expansions in expression: $expr";
	}
    }
    
#    # FIXME: For now.
#    if ($expr =~ m/\$/ or $expr !~ m/^\"/)
#    {
#	return $expr;
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
	    my $subst = $parser->{po}->{$::lang}->{$1};
	    $val =~ s/\$\($var\)/$subst/g;
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
	    {	    print STDERR "Including $tokens[1]\n"
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

    while (defined nsis_get_line ($handle))
    {
	$.++ if ($file eq '-');

	# Skip comment lines.
	next if $_ =~ m/^#/;

	# Skip empty lines.
	next if $_ =~ m/^$/;

	nsis_parse_line ($parser, $file, $_);
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

	$pkg->{name} = $name;
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
	    if (not $outpath =~ s/^"\$INSTDIR\\?(.*)"$/$1/)
	    {
		fail "$file:$.: unsupported out path: $args[0]";
	    }
	    $parser->{outpath} = $outpath;
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
	elsif ($command eq 'WriteRegStr')
	{
	    fail "$file:$.: not supported" if ($#args != 3);

	    my $root = $args[0];

	    my $key = $args[1];
	    $key =~ s/^"(.*)"$/$1/;

	    my $name = $args[2];
	    $name =~ s/^"(.*)"$/$1/;

	    my $value = $args[3];
	    $value =~ s/^"(.*)"$/$1/;
	    $value =~ s/\$INSTDIR\\?/\[INSTDIR\]/g;

	    push (@{$parser->{pkg}->{registry}},
		  { root => $root, key => $key, name => $name,
		    value => $value, type => 'string' });
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
	    $icon =~ s/^\$INSTDIR\\/[INSTDIR]/;
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

	    print ' ' x $::level
		. "<Component Id='c_$pkg->{name}_$fileidx' Guid='"
		. get_guid ($targetfull) . "'>\n";
	    print ' ' x $::level
		. "  <File Id='f_$pkg->{name}_$fileidx' Name='"
		. $file->{target} . "' Source='" . $file->{source} . "'>\n";
	    # Does not help to avoid the warnings: DefaultLanguage='1033'.

	    # EXCEPTIONS:
	    if ($targetfull eq 'gpgol.dll')
	    {
		print ' ' x $::level
		    . "    <Class Id='{42D30988-1A3A-11DA-C687-000D6080E735}' "
		    . "Context='InprocServer32' Description='GpgOL - The "
		    . "GnuPG Outlook Plugin' ThreadingModel='neutral'/>\n";
	    }
	    if ($targetfull eq 'gpgex.dll')
	    {
		print ' ' x $::level
		    . "    <Class Id='{CCD955E4-5C16-4A33-AFDA-A8947A94946B}' "
		    . "Context='InprocServer32' Description='GpgEX' "
		    . "ThreadingModel='apartment'/>\n";
	    }
	    elsif ($targetfull eq 'gpgee.dll')
	    {
		print STDERR "ERR: run heat.exe on gpgee.dll and add info\n";
		exit 1;
	    }

	    # Create shortcuts.
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
#		if ($shortcut->{icon} ne '')
#		{
#		    $extra .= " Icon='sm_$pkg->{name}_${fileidx}_icon'";
#		}

		# FIXME: Note that the link name should better not
		# change, or it is not correctly replaced on updates.
		my $link = nsis_translate ($parser, '', $shortcut->{link});
		print ' ' x $::level
		    . "    <Shortcut Id='sm_$pkg->{name}_$fileidx' "
		    . "Directory='ProgramMenuDir' Name='$link'"
		    . $extra;

#		if ($shortcut->{icon} eq '')
#		{
		    print "/>\n";
#		}
#		else
#		{
#		    print ">\n";
#		    print ' ' x $::level
#			. "      <Icon Id='sm_$pkg->{name}_${fileidx}_icon' "
#			. "SourceFile='$shortcut->{icon}'/>\n";
#		    print ' ' x $::level
#			. "    </Shortcut>\n";
#		}

# Can't make these optional, so we don't do this.
#		print ' ' x $::level
#                   . "    <Shortcut Id='dt_$pkg->{name}_$fileidx' "
#		    . "Directory='DesktopFolder' Name='$file->{target}'/>\n";
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
	    # We use $targetfull because there is also a gpg.exe in pub\.
	    if ($targetfull eq 'gpg.exe')
	    {
		print ' ' x $::level
		    . "  <Environment Id='env_path' Name='PATH' Action='set' "
		    . "System='yes' Part='last' Value='[INSTDIR]pub'/>\n";
	    }
	    elsif ($targetfull eq 'gpgol.dll')
	    {
		print ' ' x $::level
		    . "  <RegistryValue Root='HKLM' Key='Software\\"
		    . "Microsoft\\Exchange\\Client\\Extensions' "
		    . "Name='GpgOL' "
		    . "Value='4.0;[!gpgol.dll];1;11000111111100;11111101' "
		    . "Type='string' Action='write'/>\n";
		print ' ' x $::level
		    . "  <RegistryValue Root='HKLM' Key='Software\\"
		    . "Microsoft\\Exchange\\Client\\Extensions' "
		    . "Name='Outlook Setup Extension' "
		    . "Value='4.0;Outxxx.dll;7;000000000000000;0000000000;OutXXX' "
		    . "Type='string' Action='write'/>\n";
	    }
	    elsif ($targetfull eq 'gpgex.dll')
	    {
		print ' ' x $::level
		    . "  <ProgId Id='*'/>\n";
		print ' ' x $::level
		    . "  <ProgId Id='Directory'/>\n";
		print ' ' x $::level
		    . "  <RegistryValue Root='HKCR' "
		    . "Key='*\\ShellEx\\ContextMenuHandlers\\GpgEX' "
		    . "Value='{CCD955E4-5C16-4A33-AFDA-A8947A94946B}' "
		    . "Type='string' Action='write'/>\n";
		print ' ' x $::level
		    . "  <RegistryValue Root='HKCR' "
		    . "Key='Directory\\ShellEx\\ContextMenuHandlers\\GpgEX' "
		    . "Value='{CCD955E4-5C16-4A33-AFDA-A8947A94946B}' "
		    . "Type='string' Action='write'/>\n";
	    }
	    elsif ($targetfull eq 'gpgee.dll')
	    {
		print STDERR "ERR: run heat.exe on gpgee.dll and add info\n";
		exit 1;
	    }
	    elsif ($targetfull eq 'dirmngr.exe')
	    {
		print ' ' x $::level
		    . "  <ServiceInstall Id='s_dirmngr' "
		    . "DisplayName='Directory Manager' "
		    . "Name='DirMngr' ErrorControl='normal' Start='auto' "
		    . "Arguments='--service' "
		    . "Type='ownProcess' Vital='yes'/>\n";
		print ' ' x $::level
		    . "  <ServiceControl Id='s_dirmngr_ctrl' "
		    . "Name='DirMngr' Start='install' Stop='uninstall' "
		    . "Remove='uninstall'/>\n";
	    }

	    print ' ' x $::level
		. "</Component>\n";
	    $fileidx++;
	}

	$regidx = 0;
	foreach my $reg (@{$pkg->{registry}})
	{
	    my $target;

	    $target = '/REGISTRY/' . $reg->{root} . '/' . $reg->{key}
	    . '/' . $reg->{name};

	    print ' ' x $::level
		. "<Component Id='c_$pkg->{name}_r_$regidx' Guid='"
		. get_guid ($target) . "'>\n";
	    print ' ' x $::level
		. "  <RegistryValue Id='r_$pkg->{name}_$regidx' Root='"
		. $reg->{root} . "' Key='" . $reg->{key} . "' Name='"
		. $reg->{name} . "' Action='write' Type='" . $reg->{type}
		. "' Value='" . $reg->{value} . "'/>\n";
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
#	$features .= " Display='hidden'" if $pkg->{hidden};
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

	dump_meat ($pkg);

	foreach my $dep (keys %{$pkg->{deps}})
	{
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


# Just so that it is defined.
$. = 0;

my %parser = ( pre_depth => 0, pre_true => 0 );
my $parser = \%parser;

fetch_guids ();

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
    elsif ($opt =~ m/^-D([^=]*)=(.*)$/)
    {
	$parser->{pre_symbols}->{$1} = $2;
    }
    elsif ($opt =~ m/^-L(.*)$/)
    {
	$::lang = $1;
	# Test if it is supported.
	lang_to_lcid ($::lang);	
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

my $BUILD_FILEVERSION = nsis_fetch ($parser, '_BUILD_FILEVERSION');

my $product_id = get_guid ("/PRODUCT/$BUILD_FILEVERSION");
my $upgrade_code = get_guid ("/UPGRADE/1");

my $INSTALL_DIR = nsis_fetch ($parser, 'INSTALL_DIR');

my $lcid = lang_to_lcid ($::lang);

print <<EOF;
<?xml version='1.0'?>
<Wix xmlns='http://schemas.microsoft.com/wix/2006/wi'>
  <Product Name='Gpg4win'
           Id='$product_id'
           UpgradeCode='$upgrade_code'
           Language='$lcid'
           Version='$BUILD_FILEVERSION'
           Manufacturer='g10 Code GmbH'>
    <Package Description='Gpg4win Installer'
             Comments='http://www.gpg4win.org/'
             Compressed='yes' 
             InstallerVersion='200'
             InstallPrivileges='elevated'
             Manufacturer='g10 Code GmbH'/>

    <Upgrade Id='$upgrade_code'>
      <UpgradeVersion Property='UPGRADEPROP'
                      IncludeMaximum='no'
                      Maximum='$BUILD_FILEVERSION'/>
    </Upgrade>

    <InstallExecuteSequence>
      <RemoveExistingProducts After='InstallFinalize' />
    </InstallExecuteSequence>

    <Condition
     Message="You need to be an administrator to install this product.">
      Privileged
    </Condition>

    <Media Id='1' Cabinet='gpg4win.cab' EmbedCab='yes'/>

    <Property Id="INSTDIR">
      <RegistrySearch Id='gpg4win_instdir_registry' Type='raw'
       Root='HKLM' Key='Software\\GNU\\GnuPG' Name='Install Directory'/>
      <IniFileSearch Id='gpg4win_instdir_ini' Type='raw'
       Name='gpg4win.ini' Section='gpg4win' Key='instdir'/>
    </Property>

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
        <Directory Id='GNU' Name='GNU'>
          <Directory Id='INSTDIR' Name='$INSTALL_DIR'>
EOF

$::level = 12;
dump_all ($parser);


print <<EOF;
          </Directory>
        </Directory>
      </Directory>
EOF

if (scalar keys %{$parser->{shortcuts}})
{
    my $name = nsis_fetch ($parser, 'PRETTY_PACKAGE');

    print <<EOF;
      <Directory Id='ProgramMenuFolder' Name='PMenu'>
        <Directory Id='ProgramMenuDir' Name='$name'/>
      </Directory>
EOF
}

#print <<EOF;
#      <Directory Id="DesktopFolder" Name="Desktop"/>
#EOF


print <<EOF;
    </Directory>

    <Feature Id='Complete' Title='Gpg4win' Description='All components.'
             Display='expand' Level='1' ConfigurableDirectory='INSTDIR'>
EOF

$::level = 6;
dump_all2 ($parser);
    
#    <Icon Id="Foobar10.exe" SourceFile="FoobarAppl10.exe"/>

# Removed this, because it is not localized:
#    <UIRef Id='WixUI_ErrorProgressText' />

print <<EOF;
    </Feature>

    <WixVariable Id='WixUILicenseRtf' Value='gpl.rtf'/>
    <UIRef Id='WixUI_Mondo' />

  </Product>
</Wix>
EOF

# Post-processing: We need to remember the GUIDs for later reuse, and
# we remember the files we need in case we want to transfer them to a
# different machine for invocation of WiX.

store_guids ();
store_files ($parser);

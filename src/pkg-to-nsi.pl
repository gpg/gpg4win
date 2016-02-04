#! /usr/bin/perl -w
# pkg-to-nsi.pl - Helper script to create NSI snippets from archive files.
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

# This is a small script to convert the list of files in a binary
# package to an NSI install or uninstall snippet.
#
# Usage: ./pkg-to-nsi.pl [--filter FILTER1,FILTER2,...]... \
#                        --inst|--uninst PACKAGE
#
# For example:
#
#  perl pkg-to-nsi.pl --filter crystal,22x22,32x32,48x48,64x64,128x128 \
#                     --inst ../packages/oxygen-icons-20071220-bin.zip
#
# The result can be used as the basis for a NSI file.  Do NOT cut and paste
# this without thinking.  Some merging needs to be done.  For example, some
# files will be installed in different locations (bin,lib to root), and
# files only included in previous installations may need to be removed from
# future installations, etc.

# Operation.
$::op = '--inst';

# Filter expressions.
@::filter = ();

while ($ARGV[0] =~ m,^-,)
{
    my $opt;
    $opt = shift @ARGV;
    if ($opt eq '--inst' or $opt eq '--uninst')
    {
        $::op = $opt;
    }
    elsif ($opt eq '--filter')
    {
	die "--filter needs argument" if ($#ARGV < 0);
	push @::filter, split (',', shift @ARGV);
    }
    else
    {
	die "unknown option $opt";
    }
}

if ($::op ne '--inst' and $::op ne '--uninst')
{
    die "unknown operation $::op";
}

$_ = shift @ARGV;
@::files = ();

if ($_ =~ m/\.zip$/)
{
    @::files = `unzip -l -qq $_ | colrm 1 28`;
}
elsif ($_ =~ m/\.tar\.gz$/)
{
    @::files = `tar tzf $_`;
}
elsif ($_ =~ m/\.tar\.bz2$/)
{
    @::files = `tar tjf $_`;
}
elsif ($_ =~ m/\.tar\.xz$/)
{
    @::files = `tar tJf $_`;
}
else
{
    die "unknown file type $_";
}


@::files = sort @::files;


if ($::op eq '--inst')
{
    my $cdir = "";

    foreach my $file (@::files)
    {
	chomp $file;
	
	next if ($file =~ m,/$,);
	my $matches = 0;
	foreach my $filter (@::filter)
	{
	    if ($file =~ m,$filter,)
	    {
		$matches = 1;
		last;
	    }
	}
	next if $matches;

	$file =~ m,(?:(.*)/)?([^/]+),;
	my $dir = $1;
	my $base = $2;
	if ($dir ne $cdir)
	{
	    $cdir = $dir;
	    $dir =~ s,/,\\,g;
	    
	    print "\n" . '  SetOutPath "$INSTDIR\\' . $dir . '"' . "\n\n";
	}
	print '  File ${prefix}/' . $file . "\n";
    }
}
elsif ($::op eq '--uninst')
{
    my $in_rmdir = 0;
    # All directories we have seen.
    my %dir_seen;
    # All directories that occur.
    my %dirs;

    @::files = reverse @::files;

    foreach my $file (@::files)
    {
	chomp $file;

        # We handle all dirs at the end.
	next if ($file =~ m,/$,);

	my $matches = 0;

	# Apply filters.
	foreach my $filter (@::filter)
	{
	    if ($file =~ m,$filter,)
	    {
		$matches = 1;
		last;
	    }
	}
	next if $matches;

	# Remember directories.
	my $dir = $file;
	
	chomp $dir;
	while ($dir =~ m,/,)
	{
	    $dir =~ s,/[^/]+$,/,;
	    $dirs{$dir}++;
		$dir =~ s,/$,,;
	}
	
	# Delete file.
	$file =~ m,(?:(.*)/)?([^/]+),;
	$dir = $1;
	$dir_seen{$dir}++;
	do
	{
	    $dir =~ s,/[^/]+$,,;
	    $dir_seen{$dir}++;
	}
	while ($dir =~ m,/,);
	
	if ($in_rmdir)
	{
	    print "\n";
	    $in_rmdir = 0;
	    }
	
	$file =~ s,/,\\,g;
	print '  Delete "$INSTDIR\\' . $file . '"' . "\n";
    }

    # Delete all dirs not yet deleted.
    foreach my $file (reverse sort keys %dirs)
    {
	chomp $file;

	if ($file =~ m,/$,)
	{
	    chop $file;

	    next if not defined $dir_seen{$file};

	    $file =~ s,/,\\,g;

	    if (not $in_rmdir)
	    {
		print "\n";
		$in_rmdir = 1;
	    }

	    print '  RMDir "$INSTDIR\\' . $file . '"' . "\n";
	}
    }
    print '  RMDir "$INSTDIR"'. "\n";
}

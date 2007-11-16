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

# Invoke like this:
#
# perl make-msi.pl < ../include/config.nsi
#
# Note that this needs to be called from the gpg4win src/ directory, because
# a number of files (inst-*.nsi for example) are accessed in that directory.
#
# This program parses the NSIS source files and creates a .wix file,
# which needs to be compiled with candle and linked with light, see
# make-msi.bat.
#
# The file make-msi.guids is read and updated.  It contains GUIDs for all
# components used by the installer, which are kept from version to version.
#
# Also, the output file make-msi.files contains a list of all files
# that will be accessed by the linker when creating the package.

use strict;

# TODO:
#
# DirMngr config files/cache directory?  service start fails!!!
# desktop and quick launch entries, but optional (also startmenu optional)

# The list of all enabled packages.
@::pkgs = ();
# All definitions from config.nsi (the input file)
%::config = ();
# A description of the components.  We have one component per package.
# Creating the data for these components is most of the work.
@::components = ();
# A list of all source files included in the package.
@::sources = ();
# A hash which maps frobbed package names to a hash of frobbed package
# names on which they depend.
%::deps = ();
# A hash which contains one key for each file that wants a shortcut in the
# canonical places (start menu, desktop, quick launch).
%::shortcuts = ();

$::INSTDIR = 'GnuPG';
$::name = 'GnuPG for Windows';

# Simple indentation tracking, for pretty printing.
$::level = 0;



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


$::files_file = 'make-msi.files';

# We store the list of included files for temporary packaging, in case
# WiX needs to be run on a different system.
sub store_files
{
    open (FILE, ">$::files_file") or die;
    foreach my $pkg (@::components)
    {
	next if ($#{$pkg->{files}} == -1);
	print FILE (join ("\n", map { $_->{source} } @{$pkg->{files}})). "\n";
    }
    close FILE;
}


sub get_deps
{
    my $name = '';
    my %deps = ();

    # FIXME: Check if file exists.
    open (FILE, "<inst-sections.nsi") or return;
    while (<FILE>)
    {
	my $line = $_;

	if ($name eq '')
	{
	    if ($line =~ m/^\s*have_(\S+):\s*\r?\n$/)
	    {
		$name = $1;
	    }
	}
	else
	{
	    if ($line =~ m/^\s*!insertmacro\s+SelectSection\s+\$\{SEC_(\S+)\}\s*\r?\n$/)
	    {
		$deps{$1} = 1;
	    }
	    elsif ($line =~ m/^\s*skip_$name:\s*\r?\n$/)
	    {
		# We resolve indirect dependencies right now.
		foreach my $pkg (keys %::deps)
		{
		    if (defined $::deps{$pkg}->{$name})
		    {
			foreach my $dep (keys %deps)
			{
			    $::deps{$pkg}->{$dep} = $::deps{$pkg}->{$name} + 1
				if (not defined $::deps{$pkg}->{$dep})
			}
		    }
		}
		$::deps{$name} = { %deps };
		$name = '';
		%deps = ();
	    }
	}
    }
    close (FILE);
}


sub get_shortcuts
{
    my %shortcuts = ();

    # Pending line.
    my $line;

    # FIXME: Check if file exists.
    open (FILE, "<inst-sections.nsi") or return;
    while (<FILE>)
    {
	# Combine multiple lines connected with backslashes.
	$line = $line . $_;
	if ($line =~ m/^(.*)\\\s*\r?\n$/)
	{
	    $line = $1 . ' ';
	    next;
	}
	$_ = $line;
	$line = '';

	if (m,^\s*CreateShortCut\s+\"\$SMPROGRAMS\\\$STARTMENU_FOLDER\\[^.]+\.lnk\"\s+\"\$INSTDIR\\([^"]+)\",)
	{
	    $shortcuts{$1} = 1;
	}
    }
    close (FILE);
    %::shortcuts = %shortcuts;
}


sub collect_all
{
  # Input file is $(top_srcdir)/include/config.nsi

  while (<>)
  {
      if (/^!define\s+(\w+)\s+(\S.*\S)\s*\r?\n$/)
      {
	  $::config{$1} = $2;
      }
  }
  # gpg4win_build_list is a C-like string, so strip the quotes first.
  my $pkg_list;
  eval '$pkg_list = ' . $::config{gpg4win_build_list};
  @::pkgs = split (' ', $pkg_list);

  # Now we have a list of packages to process.  For each package,
  # create a nice data structure that captures all the information we
  # collect.

  foreach my $pkg (@::pkgs)
  {
      my %pkg;
      $pkg{name} = $pkg;
      $pkg =~ tr/-+/__/;
      $pkg{frobbed_name} = $pkg;
      $pkg{version} = $::config{"gpg4win_pkg_${pkg}_version"};
      $pkg{source} = $::config{"gpg4win_pkg_${pkg}"};
      $pkg{features} = '';
      $pkg{hidden} = 0;

      # We parse the inst-package file to figure out what to do.  This
      # is not a full-featured NSIS to MSI converter, but it does the
      # job for us.

      # FIXME: Manuals!
      next if not defined $pkg{version};
      my $prefix = "playground/install/pkgs/$pkg{name}-$pkg{version}";

      # The list of all files encountered and included in the package.
      my @files;
      # The list of all registry settings to write.
      my @registry;

      # The current directory.
      my $dir = '';

      # The pending line.
      my $line = '';

      open (FILE, "<inst-$pkg{name}.nsi") or die;
      while (<FILE>)
      {
	  # Combine multiple lines connected with backslashes.
	  $line = $line . $_;
	  if ($line =~ m/^(.*)\\\s*\r?\n$/)
	  {
	      $line = $1 . ' ';
	      next;
	  }
	  $_ = $line;
	  $line = '';

	  # FIXME: Handle hidden packages "-foo".
	  if (m,^\s*Section\s+"-([^"]+)",)
	  {
	      # Hidden packages are dependency-tracked.
	      $pkg{title} = $1;
	      $pkg{level} = 2000;  # Superfluous.
	      $pkg{hidden} = 1;
	  }
	  elsif (m,^\s*Section\s+"([^"]+)",)
	  {
	      $pkg{title} = $1;
	      $pkg{level} = 1;
	  }
	  elsif (m,^\s*Section\s+/o\s+"([^"]+)",)
	  {
	      # Default install level is 3.
	      $pkg{title} = $1;
	      $pkg{level} = 1000;
	  }
	  elsif (m,^\s*LangString\s+DESC_SEC_\S+\s+\$\{LANG_ENGLISH\}\s+\"([^"]+)\"\s*\r?\n,)
	  {
	      $pkg{description} = $1;
	  }
	  # Special hack for kdesupport.nsi.  FIXME: Could do real
	  # variable substitution here.
	  elsif (m,^\s*\!define prefix \${ipdir}/([^\$]+)-\$.*\r?\n$,)
	  {
	      $prefix = "playground/install/pkgs/$1-$pkg{version}";
	  }
	  elsif (m,^\s*SetOutPath\s+"?\$INSTDIR\\?([^"]*)"?\s*\r?\n$,)
	  {
	      $dir = $1;
	  }
	  elsif (m,^\s*File\s+"?\$\{(prefix|BUILD_DIR|SRCDIR)\}(?:/(\S*))?/([^/"\s]+)"?\s*\r?\n$,)
	  {
	      my $source = $3;

	      $source = "$2/$source" if defined $2;
	      $source = "${prefix}/$source" if $1 eq 'prefix';
	      # FIXME: We assume that srcdir == build_dir here.

	      push @files, { source => $source, dir => $dir, target => $3 };
	      push @::sources, $source;
	  }
	  elsif (m,^\s*File\s+/oname=(\S+)\s+"?\$\{(prefix|BUILD_DIR)\}/([^"\s]+)"?\s*\r?\n$,)
	  {
	      my $target = $1;
	      my $source = $3;

	      $source = "${prefix}/$source" if $2 eq 'prefix';

	      # Temp files are due to overwrite attempts, which are
	      # handled automatically by the Windows Installer.
	      # Ignore them here.
	      next if $target =~ m/\.tmp$/;

	      push @files, { source => $source,
			     dir => $dir, target => $target };
	      push @::sources, $source;
	  }
	  elsif (m,^\s*WriteRegStr\s+(\S+)\s+"([^"]+)"\s+"([^"]+)"\s+"?([^"]+)"?\s*\r?\n$,)
	  {
	      my ($root, $key, $name, $value) = ($1, $2, $3, $4);
	      $value =~ s/\$INSTDIR/\[INSTDIR\]/g;
	      push (@registry,
		    { root => $root, key => $key, name => $name,
		      value => $value, type => 'string' });
	  }
      }
      close (FILE);
      $pkg{files} = \@files;
      $pkg{registry} = \@registry;

      # Some things we can not easily parse from the NSI files.  For
      # these, we do manual overrides here.
      if ($pkg{name} eq 'gnupg')
      {
	  $pkg{features} .= " Absent='disallow'";
      }
      elsif ($pkg{name} eq 'gnupg2')
      {
	  $pkg{features} .= " Absent='disallow'";
      }

      push @::components, \%pkg;
  }
}


sub dump_all
{
    my $pkg;
    # A running count for files within each feature.
    my $fileidx;
    # A running count for registry settings within each feature.
    my $regidx;
    # A running count for directories throughout the whole file.
    my $diridx = 0;
    # The current directory.
    my $cdir = '';

    foreach $pkg (@::components)
    {
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
		. "<Component Id='c_$pkg->{frobbed_name}_$fileidx' Guid='"
		. get_guid ($targetfull) . "'>\n";
	    print ' ' x $::level
		. "  <File Id='f_$pkg->{frobbed_name}_$fileidx' Name='"
		. $file->{target} . "' Source='" . $file->{source} . "'"
		. " DefaultLanguage='1033'>\n";

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
	    if (defined $::shortcuts{$targetfull})
	    {
		print ' ' x $::level
		    . "    <Shortcut Id='sm_$pkg->{frobbed_name}_$fileidx' "
		    . "Directory='ProgramMenuDir' Name='$file->{target}'/>\n";

#		print ' ' x $::level
#                   . "    <Shortcut Id='sm_$pkg->{frobbed_name}_$fileidx' "
#		    . "Directory='DesktopFolder' Name='$file->{target}'/>\n";
	    }

	    print ' ' x $::level
		. "  </File>\n";

	    if (defined $::shortcuts{$targetfull})
	    {
		# http://www.mail-archive.com/wix-users@lists.sourceforge.net/msg02746.html
		# -sice:ICE64
		print ' ' x $::level
		    . "    <RemoveFolder Id='rsm_$pkg->{frobbed_name}_$fileidx' "
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
# FIXME: Start service (currently broken).
#		print ' ' x $::level
#		    . "  <ServiceControl Id='s_dirmngr_ctrl' "
#		    . "Name='DirMngr' Start='install' Stop='uninstall' "
#		    . "Remove='uninstall'/>\n";
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
		. "<Component Id='c_$pkg->{frobbed_name}_r_$regidx' Guid='"
		. get_guid ($target) . "'>\n";
	    print ' ' x $::level
		. "  <RegistryValue Id='r_$pkg->{frobbed_name}_$regidx' Root='"
		. $reg->{root} . "' Key='" . $reg->{key} . "' Name='"
		. $reg->{name} . "' Action='write' Type='" . $reg->{type}
		. "' Value='" . $reg->{value} . "'/>\n";
	    print ' ' x $::level
		. "</Component>\n";
	    $regidx++;
	}
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
	    . "  <ComponentRef Id='c_$pkg->{frobbed_name}_$fileidx'/>\n";
	$fileidx++;
    }
    $regidx = 0;
    foreach my $reg (@{$pkg->{registry}})
    {
	print ' ' x $::level
	    . "  <ComponentRef Id='c_$pkg->{frobbed_name}_r_$regidx'/>\n";
	$regidx++;
    }
}


sub dump_all2
{
    my $pkg;

    foreach $pkg (@::components)
    {
	my $features;

	next if not defined $pkg->{version};
	next if $pkg->{hidden};

	$features = $pkg->{features};
#	$features .= " Display='hidden'" if $pkg->{hidden};
	$features .= " Description='$pkg->{description}'"
	    if $pkg->{description};
	
	print ' ' x $::level
	    . "<Feature Id='p_$pkg->{frobbed_name}' Level='$pkg->{level}' "
	    . "Title='$pkg->{title}'" . $features . ">\n";
	dump_meat ($pkg);

	foreach my $dep (keys %{$::deps{$pkg->{frobbed_name}}})
	{
	    my $deppkg;

	    foreach my $_pkg (@::components)
	    {
		$deppkg = $_pkg;
 		last if ($_pkg->{frobbed_name} eq $dep);
	    }
	    
	    print ' ' x $::level
		. "  <Feature Id='p_$pkg->{frobbed_name}_$dep' "
		. "Title='p_$pkg->{frobbed_name}_$dep' "
		. "Level='$pkg->{level}' Display='hidden' "
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


# WiX is the Windows Installer XML toolset.  It contains a compiler
# (candle.exe) and a linker (light.exe) which can assemble an XML file
# and data files to a Windows installer package (MSI).
#
# The following code creates an appropriate XML file for Gpg4win.

# We use a single media element, which is also the default for all
# components and directory elements.

# FIXME: Use Vital for all file attributes?
fetch_guids ();
collect_all ();
get_deps ();
get_shortcuts ();

$::product_id = get_guid ("/PRODUCT/$::config{_BUILD_FILEVERSION}");
$::upgrade_code = get_guid ("/UPGRADE/1");

print <<EOF;
<?xml version='1.0'?>
<Wix xmlns='http://schemas.microsoft.com/wix/2006/wi'>
  <Product Name='Gpg4win'
           Id='$::product_id'
           UpgradeCode='$::upgrade_code'
           Language='1033'
           Version='$::config{_BUILD_FILEVERSION}'
           Manufacturer='g10 Code GmbH'>
    <Package Description='Gpg4win Installer'
             Comments='http://www.gpg4win.org/'
             Compressed='yes' 
             InstallerVersion='200'
             InstallPrivileges='elevated'
             Manufacturer='g10 Code GmbH'/>

    <Upgrade Id='$::upgrade_code'>
      <UpgradeVersion Property='UPGRADEPROP'
                      IncludeMaximum='no'
                      Maximum='$::config{_BUILD_FILEVERSION}'/>
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
      <RegistrySearch Id='gpg4win_registry' Type='raw'
      Root='HKLM' Key='Software\\GNU\\GnuPG' Name='Install Directory' />
    </Property>

    <Directory Id='TARGETDIR' Name='SourceDir'>
      <Directory Id='ProgramFilesFolder' Name='PFiles'>
        <Directory Id='GNU' Name='GNU'>
          <Directory Id='INSTDIR' Name='$::INSTDIR'>
EOF

$::level = 12;
dump_all ();


print <<EOF;
          </Directory>
        </Directory>
      </Directory>
EOF

if (scalar keys %::shortcuts)
{
    print <<EOF;
      <Directory Id='ProgramMenuFolder' Name='PMenu'>
        <Directory Id='ProgramMenuDir' Name='$::name'/>
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
dump_all2 ();
    
#    <Icon Id="Foobar10.exe" SourceFile="FoobarAppl10.exe"/>

print <<EOF;
    </Feature>

    <WixVariable Id='WixUILicenseRtf' Value='gpl.rtf'/>
    <UIRef Id='WixUI_Mondo' />
    <UIRef Id='WixUI_ErrorProgressText' />

  </Product>
</Wix>
EOF

# Post-processing: We need to remember the GUIDs for later reuse, and
# we remember the files we need in case we want to transfer them to a
# different machine for invocation of WiX.

store_guids ();
store_files ();


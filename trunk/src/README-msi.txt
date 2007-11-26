Prerequisites
=============

* A complete build-tree of Gpg4win (NSIS) for the version you want to
  package.  Please see http://www.gpg4win.org/build-installer.html for
  more information on how to create a Gpg4win NSIS installer.

* Perl 5

* Windows XP, for example running in a virtual machine, with the
  following software installed:

  Windows Installer XML (WiX) toolset, from http://wix.sourceforge.net/
  Version 3.0 is required.

  WiX requires the .NET framework, for example .NET 2.0 from
  http://www.microsoft.com/downloads/details.aspx?FamilyID=0856EACB-4362-4B0D-8EDD-AAB15C5E04F5

* A way to access files in the build-tree from the Windows machine,
  for example using a network connection and SMB, or a data medium to
  transfer several hundred MB of data


Instructions
============

1) Change to the src/ directory of the Gpg4win installer build-tree.

$ cd gpg4win/src

2) Create the required WiX source file:

$ make msi

Maintainer note: The program might output the message "GUID list
stored in make-msi.guids changed, please commit!".  In this case, the
modified source file make-msi.guids should be committed to the repository.

3) Now switch to the same directory on the Windows machine, and run
the script make-msi.bat to create the MSI package:

> make-msi.bat gpg4win-VERSION.wix
> make-msi.bat gpg4win-light-VERSION.wix

where VERSION is the full version number of the build (for example,
1.9.0-svn595).

The batch file assumes that WiX is installed in the canonical
location.  If that is not the case, you might need to adjust the PATH
in the file.

4) That's it!  The final installer package gpg4win.msi can be installed with

> msiexec /i gpg4win.msi

and uninstalled with 

> msiexec /x gpg4win.msi


How to access the package files
===============================

The WiX tools need to access all files from the build-tree included in
the package.  There are many solutions to that.  Here are two suggestions:

1) Ubuntu + VirtualBox + Samba

You can run Windows XP in a Virtual Machine under VirtualBox, and
access the files using the SMB protocol by running the Samba server on
the Linux Host.  The build-tree folder should be shared (right-mouse
click on the folder in Nautilus), and can then be bound to a drive
letter in Windows by the command:

> net use H: \\10.0.2.2\gpg4win

where H: is the drive letter to be used and gpg4win is the name of the
shared folder.

2) tar

A list of all files required is stored by make-msi.pl in the file
make-msi.files.  This list can be used to transfer all needed files
and to the Windows computer by any media or network.  For example,
they can be grouped in an archive using tar:

$ cd gpg4win
$ tar -T src/gpg4win-VERSION.files cjf gpg4win-msi.tar.bz2

Beside the files in gpg4win-msi.tar.bz, you also need src/gpg4win-VERSION.wix
and src/make-msi.bat on the Windows computer, which should be put into
the src/ subdirectory of the archive.

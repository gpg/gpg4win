;; README.en.txt                               -*- coding: latin-1; -*-
;; This is the README installed with Gpg4win. Lines with a ; in the first
;; column are considered a comment and not included in the actually
;; installed version.  Certain keywords are replaced by the Makefile;
;; those words are enclosed by exclamation marks.

                   English README file for Gpg4win
                   ===============================

This is GnuPG for Windows, vesion !VERSION!.

Content:

     1. Important notes
     2. Changes
     3. Version numbers 
     4. Installer options
     5. Legal notices 




1. Important Notes
==================

Manuals describing the installation of Gpg4win are currently only
available in German.  Check out http://www/gpg4win.org for latest
news.




2. Record of Changes (NEWS file)
================================

An up-to-date list of changes is also available at
http://www.gpg4win.de/change-history.html .  Below you find the raw
NEWS file:

!NEWSFILE!




3. Version Numbers of Included Software
=======================================

!VERSIONINFO!




4. Installer Options
====================

The default installation path can be speficied with the /D=PATH
option, which must be last on the command line.  The installer
supports the options /S for unattended installation, and the option
/C=INIFILE to specify an .ini file which should contain exactly one
section "[gpg4win]".  This section contains various installer settings
and absolute file paths to configuration files that should be
preinstalled.  Most options just set a different default value.
Excetions are documented below.  Here is an example file which shows
all possible keys:

[gpg4win]
  ; Installer settings.  Do not define or leave empty for defaults.
  inst_gnupg2 = false
  inst_gpgol = true
  inst_gpgex = true
  inst_gpa = true
  inst_winpt = true
  inst_gpgee = true
  inst_claws_mail = false
  inst_novice_manual_en = true
  inst_novice_manual_de = true
  inst_advanced_manual_de = true

  ; Where to install short-cuts.
  inst_start_menu = true
  inst_desktop = false
  inst_quick_launch_bar = false

  ; Contrary to other settings in this file, the start menu folder
  ; setting here will override the user selection at installation
  ; time.
  inst_start_menu_folder = GnuPG for Windows

  ; Additional configuration files to install.
  gpg.conf = D:\config\gpg-site.conf
  gpg-agent.conf = D:\config\gpg-agent-site.conf
  trustlist.txt = D:\config\trustlist-site.txt
  dirmngr.conf = D:\config\dirmngr-site.conf
  dirmngr_ldapserver.conf = D:\config\dirmngr_ldapserver-site.conf
  scdaemon.conf = D:\config\scdaemon-site.txt
  gpa.conf = D:\config\gpa-site.conf

An example command for unattended installation could look like this:

gpg4win.exe /S /C=C:\TEMP\gpg4win.ini /D=D:\Programme\Gpg4win

For the MSI installer, the above also holds, with the following
changes: Unattended installation is achieved as usual with the /qb-
option to msiexec.  The control file must be called gpg4win.ini and
reside in the system directory (C:\WINDOWS).  It is found
automatically by the installer.  The installation directory can be
specified with an entry for "instdir".  Also, each entry can be given
in uppercase at the command line through INSTDIR=... and
INST_GPA=FALSE etc. (the control file takes precedence, though).  The
default config files as well as start menu directory and optional
installation of short cuts are currently not supported through the MSI
installer.


5. Legal notices pertaining to the individual packets
=====================================================

Gpg4win consist of several independent developed packages, available
under different license conditions.  Most of these packages however
are available under the GNU General Public License (GNU GPL).  Common
to all is that they are free to use without restrictions, may be
modified and that modifications may be distributed.  If the source
files (i.e. gpg4win-src-x.y.z.exe) are distributed along with the
binaries and the use of the GNU GPL has been pointed out, distribution
is in in all cases possible.

What follows is a list of copyright statements.

!PKG-COPYRIGHT!




Happy GiPiGing,

  Your Gpg4win Team

***end of file ***

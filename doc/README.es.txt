;; README.en.txt                               -*- coding: latin-1; -*-
;; This is the README installed with Gpg4win. Lines with a ; in the first
;; column are considered a comment and not included in the actually
;; installed version.  Certain keywords are replaced by the Makefile;
;; those words are enclosed by exclamation marks.

                   English README file for Gpg4win
                   ===============================

+++ You are welcome to translate this file into Spanish!
Please contact the Gpg4win developer mailing list for contributing
and look at http://gpg4win.de/localize-gpg4win.html +++


This is Gpg4win, version !VERSION!.

Content:

     1. Important Notes
     2. Changes
     3. Known Bugs (and Workarounds)
     4. Version History
     5. Version Numbers of Included Software
     6. Installer Options
     7. Legal Notices


1. Important Notes
==================

Manuals describing the installation of Gpg4win are currently only
available in German.  Check out http://www/gpg4win.org for latest
news.

If you used an older version of Gpg4win in the past, please check
out the migration hints in the Gpg4win Compendium's appendix.

Please read the "Known bugs" section before you start working with
Gpg4win.


2. Changes
==========

Gpg4win2 has major changes compared to Gpg4win 1.x.  Below is a list
of the most important ones:

- Kleopatra is the new certificate manager.  Kleopatra is the S/MIME
  certificate manager of KDE (a desktop environment used on many
  GNU/Linux systems).  For use in Gpg4win it has been extended to
  support OpenPGP and to act as a graphical user interface for all
  cryptographic operations.  It is automatically started if another
  component requests its services and then runs permanently in your
  system tray.  WinPT has been dropped.

- GpgEX is the new plugin for the Microsoft Explorer and replaces GpgEE.

- The mail program Claws Mail has been updated to a modern version.
  It now supports SSL, NNTP and IMAP.

- GpgOL, the plugin for Outlook 2003 and 2007 has been comprehensively
  updated.  It now supports PGP/MIME and thus makes the use of
  encrypted or signed attachments much easier and standard conform.
  Support for S/MIME has been added.  Most dialogs are now provided by
  Kleopatra for graphical user dialogs.

- The German "Gpg4win-Kompendium" is the new documentation for Gpg4win.
  This combines the previous "Einsteiger" and "Durchblicker" manuals.
  All chapters were reworked and extended to describe the new Gpg4win
  Version 2.0. Among other things, this means adaption to Kleopatra,
  GpgEX and PGP/MIME and new texts for S/MIME and X.509.

- Support of these platforms:
  Operating System: Windows 2000, XP (32/64), Vista (32/64)
  Outlook: 2003, 2007

Short overview on changes compared to version 2.0.2:
----------------------------------------------------
- Pinentry:
  * Change default: switch back from QT4 to GTK
    (reason: 2.0.2 has a critical problem with pinentry-qt4; 
    see https://issues.kolab.org/issue4378)

- GnuPG-Backend:
  * "is-socket-patch" agains gpgme 1.2.0 
    (see https://issues.kolab.org/issue4302)

- Gpg4win Compendium (German):
  * Final version 3.0.0 added.

- Included components are:
    GnuPG:        2.0.14
    Kleopatra:    2.0.14-svn1098530 (20100303)
    GPA:          0.9.0
    GpgOL:        1.1.1
    GpgEX:        0.9.5
    Claws-Mail:   3.7.4cvs1
    Kompendium:   3.0.0

Short overview on changes compared to version 2.0.1:
----------------------------------------------------
- Kleopatra:
  * New certificate wizard for OpenPGP and X.509 improved
  * Certificate selection dialog for sign/encrypt comes up in case of  
    conflict only
  * Result dialog for sign/encrypt combined in one window
  * File crypto operations with GpgEX stabilized
  * SmartCard support for X.509 NetKey cards improved
  * Rekursive sign/encrypt of files/directory now possible; condition:  
    external archive tool required (see README file for configuration)
  * new oxygen icons
  * Several minor and medium issues and errors were fixed

- GpgOL:
  * Symbol load mechanism improved to add new icons
    (now with crypto icons for the message list)

- Pinentry:
  * Change default: switch from GTK to QT4
    (GTK still enabled for gpg4win-light installer)
  * new icons for pinentry-qt4
  * Pinentry-qt4 dialog always comes up in foreground

- GnuPG-Backend:
  * Generate new certificate for OpenPGP/X.509: default key length
    updated (new Default: RSA, 2048 bit); 
    furthermore select list of key length in Kleopatra updated

- Installer:
  * new images for NSIS installer

- Included components are:
    GnuPG:        2.0.14
    Kleopatra:    2.0.14-svn1098530 (20100303)
    GPA:          0.9.0
    GpgOL:        1.1.1
    GpgEX:        0.9.5
    Claws-Mail:   3.7.4cvs1
    Kompendium:   3.0.0-rc1


3. Known Bugs (and Workarounds)
===============================

- Using smart card with Kleopatra

   The initial setting of smart cards with Kleopatra is currently not
   yet possible. Please run the following steps one-time to use your
   smart card with Kleopatra.

   * OpenPGP card
     Use the gpg command line tool to create a new OpenPGP certificate
     on your card (a) or to activate your existing certificate of
     your card (b):

     (a) Create new certificate
       - Insert card.
       - Run "gpg --card-edit".
       - Switch to admin modus by enter: "admin".
       - Enter "generate" to create a new certificate.

     (b) Activate existing certificate of your card
       - Import associated (public) certificate of your card (e.g.
         from certificate server or from a exported certificate file).
       - Insert card.
       - Run "gpg --card-status".

   * X.509 Telesec Netkey 3 card
     Use Kleopatra to initializing your card:
     - Insert card.
     - Click at the Kleopatra systemtray icon (or use the context menu of
       the systemtray icon and run the learn card command).

   After finishing these steps your OpenPGP / X.509 certificate
   from your smart card is shown in Kleopatra under the tab
   "My certificates" (marked with a smart card icon).

   A good (graphical) alternative for setting up your smart
   card and changing PIN is GPA. A better smart card support for
   Kleopatra is in process.

- Using the Outlook Plugin "GpgOL":

  * You defintely should create copies of your old encrypted/signed
    emails, e.g. in the form of PST files.

  * Encrypted E-Mails occuring un-encrypted on the email server: It
    can happen that parts of encrypted emails are copied to your email
    server (IMAP or MAPI) in un-encrypted/decrypted form when creating
    or viewing them.  Affected is the content of the email view
    window, thus usually the so-called email body.  Attachments are
    not affected.  Switching off the Outlook preview will lower the
    probability of this to happen, but not eliminate the issue.
    A solution is being worked on.

  * Sending signed or encrypted messages via an Exchange based account
    does not yet work.

- Using GpgEX with Windows x64:

   * In some cases sign/encrypt or decrypt/verify via GpgEX doesn't work 
     correctly (Kleopatra freezed). Then you should kill Kleopatra via 
     task manager and run the file crypto operation directly in Kleopatra
     (see file menu).

   * Problems with Windows x64:
     GpgEX is a (32bit) plugin for the (32bit) Windows
     Explorer and it does _not_ run in a 64bit Explorer
     (= default for a Windows 64bit system).

     Workaround: Run the 32bit Explorer to use GpgEX.
     Click "Start" -> "Run", type the following in the box, and then
     click OK:
         C:\windows\syswow64\explorer.exe /separate
     Note: Adjust the path to your x64-based version of Windows if
     necessary. 
     This separate command seems to be currently broken in Win7/64bit.

- sign/encrypt files with archive function:

   * The new Kleopatra function to sign/encrypt files as archive
     is currently not full implemented. It's for testing for 
     expert users only. An extra archive application is required.
     Configure the pack command in the config file of Kleopatra:
       C:\Programme\GNU\GnuPG\share\config\libkleopatrarc
     Here an exemple for the tool "7-ZIP" (http://www.7-zip.org):
        [Archive Definition #0]
        Name=TAR (via 7-ZIP)
        id=7zip
        extensions=tar
        pack-command=7z a dummy -ttar -so


4. Version History
==================

Find below the changes as recorded in the source distribution's NEWS
file.  An up-to-date list of changes is also available at
http://www.gpg4win.de/change-history.html .

!NEWSFILE!


5. Version Numbers of Included Software
=======================================

!VERSIONINFO!



6. Installer Options
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
  inst_gpgol = true
  inst_gpgex = true
  inst_kleopatra = true
  inst_gpa = true
  inst_claws_mail = false
  inst_compendium_de = true
  inst_man_novice_en = true

  ; Where to install short-cuts.
  inst_start_menu = true
  inst_desktop = false
  inst_quick_launch_bar = false

  ; Contrary to other settings in this file, the start menu folder
  ; setting here will override the user selection at installation
  ; time.
  inst_start_menu_folder = Gpg4win

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


7. Legal notices pertaining to the individual packets
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

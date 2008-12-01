Important Hints for Using Gpg4win 1.9-BETA
##########################################

  Attention: This is a BETA version of Gpg4win.
  This means, some functionalities might be
  missing or not working correctly.

  Beta versions are intended for testing by
  experienced users or administrators to learn
  about the upcoming version and suggest changes.

Status: Gpg4win-1.9.13 (20081202)

This text covers information that are
intended to help judging whether Gpg4win 1.9
is already sufficient for your individual needs
or you better wait for a first beta-test.

Furthermore, this text lays out the new functionality
of Gpg4win 2.0. The 1.9.X releases represent the
beta-cycle. Once this cycle is finished, version
2.0 will be released.

For changes compared to previous beta release see
bottom of this document.

Read the Gpg4win compendium to get help for using
Gpg4win. Note: It's currently in German only!
A translation in English is scheduled.
You can find the compendium (after the installation
of Gpg4win-1.9.x) in the Gpg4win start 
menu -> 'Dokumentation' or directly online:

  http://gpg4win.de/handbuecher/gpg4win-compendium-de.html


Feedback welcome!
  Please let us know whether your tests of Gpg4win 1.9
  were successful or whether (and which) problems
  occured.
  We encourage you to subscribe to the english
  users mailing list. Submit your reports there
  or read the reports of other users:

  http://lists.wald.intevation.org/mailman/listinfo/gpg4win-users-en


Contents of this document:

* Important hints for present version
* Migration
* Most important changes in Gpg4win 1.9 compared to 1.1
* Most important changes in Gpg4win 1.9.13 compared to 1.9.12


Important hints for present version
===================================

- Installation package ca. 32 MByte:
  The installer isn't optimzed concerning package size.
  It is aspired to shrink the size in the next time.

- Using the Outlook Plugin "GpgOL":

  * You defintely should create copies of your old
    encrypted/signed emails, e.g. in the form of PST files.

  * Encrypted E-Mails occuring un-encrypted on the email server:
    It can happens that parts of encrypted emails are copied
    to your email server (IMAP or MAPI) in un-encrypted/decrypted
    form when creating or viewing them.
    Affected is the content of the email view windows, thus usually
    the so-called email body. Attachments are not affected.
    Switching off the Outlook preview will lower
    the probability of this to happen, but not eliminate the issue.
    A solution is being worked on.


Migration
=========

* From an older Gpg4win 1.9 Version:

  Please uninstall the older Gpg4win-1.9.x version
  before you installed the new version.

  If there was an older 1.9 version installed, then
  it is mandadory to reboot the system in case the
  installation routine demands (via preselection) so.
  Else you will run into major errors during cryptographic
  operations.

* From a Gpg4win 1.X or other GnuPG Version:

  It's very important to uninstall the older Gpg4win 1.x
  version before you start the installation of Gpg4win 1.9.x.

  Reboot the system in case the installation routine
  demands so. Else you will run into major errors during 
  cryptographic operations.

Note the migration hints in the Gpg4win Compendium (see appendix).


Most important changes in Gpg4win 1.9 compared to 1.1
=====================================================


Removed:
--------

- GpgEE: This module is replaced by GpgEX (see below)

- WinPT: It's functionality is now provided via Kleopatra (see below)

- German manuals "Einsteiger" and "Durchblicker": Superceeded
  by the german Gpg4win Kompendium (see below)

Updated:
--------

- Claws Mail: Version 3.6.1cvs47
  Main new features: Support of SSL, NNTP and IMAP in the
  Windows-Version of Claws Mail.

- GpgOL: This component has been comprehensively updated.

  * Main new features are:

    - Support of OpenPGP/MIME:
      So far, only the so-called "inline-PGP" was supported.
      Now, it is even possible to handle attachments directly.

    - Support of S/MIME
      GpgOL now supports the X.509 based email encryption method
      S/MIME.

    - Use of Kleopatra for graphical user dialogs:
      Instead of implementing dialogs of its own, GpgOL
      uses the unified dialogs of Kleopatra (see below).

    - Support of these platforms:
      Operating System: Windows 2000, XP (32/64), Vista (32/64)
      Outlook: 2003, 2007

New:
----

- GpgEX: The new plugin for Microsoft Explorer.

- Kleopatra: The new certifacte manager

  * Kleoaptra is the current S/MIME certificate manager of KDE.
    On the one hand it has been extended for support of OpenPGP.
    On the other hand, Kleopatra now acts as graphical user
    interface for cryptographic operations and thus unifies the
    user interaction.

  * Kleopatra usually runs permanently as a service (see your system tray)
    from the time one when its service has been requested in your session.

  * Kleopatra is still in development:
    Some functionalities for OpenPGP are still missing.
    You can use GPA for the missing functionality.

- German Gpg4win Kompendium: The new documentation for Gpg4win.
  This combines the previous "Einsteiger" and "Durchblicker" manuals.
  All chapters were reworked and extended to descibe the new Gpg4win Version 2.0.
  Among other things, this means adaption to Kelopatra GpgEX
  and PGP/MIME and new texts for S/MIME and X.509.


Most important changes in Gpg4win 1.9.13 compared to 1.9.12
===========================================================

 - Kleopatra:
     * load certifications of OpenPGP certificates on keyserver
       disabled (not allowed)
     * Menu entry "Change passphrase" enabled for own certificates 
       only
     * Own S/MIME certificate (width trusted root) is shown under
       the tab "Trusted Certificates"
     * translations added
     * several minor and medium improvements

 - GpgOL:
     * After a GpgOL update the check options dialog comes up one-time only
     * translations added

 - Gpg4win Compendium 3.0.0-beta1 reworked

 - Backend and Installer: 
     * critical error (which cleared pupring.gpg) resolved
     * Installer full name changed to "Gpg4win", German about text
       of wellcome page changed
     * Gpg4win version number added under "Control Panel -> Software"
     * Several minor and medium issues and errors were fixed.

Important Hints for Using Gpg4win 1.9-BETA
##########################################

  Attention: This is a BETA version of Gpg4win.
  This means, some functionalities might be
  missing or not working correctly.

  Beta versions are intended for testing by
  experienced users or administrators to learn
  about the upcoming version and suggest changes.

Status: Gpg4win-1.9.1 (20080514)

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
* Important hints for using S/MIME
* Migration
* Most important changes in Gpg4win 1.9 compared to 1.1
* Most important changes in Gpg4win 1.9.1 compared to 1.9.0


Important hints for present version
===================================

- Installation package almost 40 MByte:
  The tools curently contain comprehensive debug information.
  This helps to analyse problems as they occur.
  For version 2.0 this debug information will be skipped
  and the installation package is expected to shrink
  to 10 MByte or even less.

- Manuals not updated:
  The manuals "Gpg4win for Novices" and "Gpg4win für Durchblicker"
  are not updated to the new tools yet.
  However, the manuals that are installed with the 1.9 version
  are more advanced than the downloadable version 2.0.2 of the manuals.

- Encrypt to self:
  It is highly recommended to configure your certificates for
  OpenPGP and S/MIME so that emails are always also encrypted
  for yourself.
  For this, enter the GnuPG configuration dialog of Kleopatra
  and insert the fingerprints of your certificates for
  "GPG for S/MIME: encrypt to user ID NAME as well" and
  "GPG for OpenPGP: encrypt to user ID NAME as well".

- Using the Outlook Plugin "GpgOL":

  * You defintely should create copies of your old
    encrypted/signed emails, e.g. in the form of PST files.

  * Encrypted E-Mails occuring un-encrypted on the email server:
    It can happend that parts of encrypted emails are copied
    to your email server (IMAP or MAPI) in un-encrypted/decrypted
    form when creating or viewing them.
    Affected is the content of the email view windows, thus usually
    the so-called email body. Attachments are not affected.
    Switching off the Outlook Preview will lower
    the probability of this to happen, but not eliminate the problem.
    A solution is being worked on.

  * Emails will be stored on the server in Microsoft specific
    format and thus not be readable via other email programs.
    A migration solution is being worked on.


Important hints for using S/MIME
================================

The email encryption method S/MIME is added for
Gpg4win 2.0.

It is recommended to make yourself familiar with
the concept of S/MIME before using it.

Configuration of S/MIME:
For making S/MIME ready to work, you need to follow
these steps.

- Enable S/MIME for GpgOL:
  In Outlook menu Extras->Options, tab "GpgOL"
  you have to explicitely enable S/MIME support.
  Please consider the warning dialog seriously.

- Create new S/MIME key:
  The creation of a *new* S/MIME key is
  not yet fully implemented Kleopatra.

- Import S/MIME certificate chain for personal key:
  The certificate chain the belongs to your secret key
  is to be imported as P7C file (other suffixes for
  such files do occur as well).
  See menu File->Import certificates.
  Typically the chain consists of a root certificate,
  a CA certificate and your personal certificate.

- Import secret S/MIME key:
  The personal secret key can be imported as P12 file
  via Kleopatra (menu File->Import certificates).
  Important: P12 import will only work
  if you did the previous step first!

- Import S/MIME certificate of email recipient:
  Now import the certificates of your email recipients
  in the same way, ideally also always including the
  complete chain.

- Mark root certifactes as trusted:
  If you activate "Gpg Agent: allow clients
  to mark keys as trusted" in the GnuPG Backend configuration
  reachable via Kleopatra menu, then you will be asked
  whether you want to trust a root certificate at the moment
  of use.
  Please note that you need to restart gpg-agent to
  get the configuration change into effect.
  This is done e.g. by logging out an in again.

- Mark root certificates as trusted for DirMngr:
  Place the respective root certificates as DER files
  (with filename suffix ".crt" into the directory
  %INSTALL_DIR%\etc\dirmngr\trusted-certs\

- Problems with certificate revocation lists (CRLs):
  The S/MIME concept considers the use of revocation lists
  to check validity of a certificate.

  This check may fail due to various problems which do not
  all result in a helpful error message yet.

  In case that a S/MIME operation does not work as expected,
  you may switch of CRL checks temporarily and try again whether the
  operation works now.
  If so, please report your obervation to the Gpg4win development
  team or the users mailing list.

  CRL checks are switched this way:
  Activate "GPG for S/MIME: never consult a CRL" in
  "Configure GnuPG Backend" dialog of Kleopatra.
  Then log out and in again to activate your change.

- LDAP Server and DirMngr configuration dialogs have no effect:
  Currently configuration dialogs for LDAP server and
  DirMngr (CRL options) are avaiable via Kleopatra.
  Changing the values has no effect.
  The configirations need to be done by system administrator
  in the global configuration text files.


Migration
=========

* From an older Gpg4win 1.9 Version:

  If there was an older 1.9 version installed, then
  it is mandadory to reboot the system in case the
  installation routine demands (via preselection) so.
  Else you will run into major errors during cryptographic
  operations.

* From a Gpg4win 1.X or other GnuPG Version:

  In case you have installed Gpg4win 1.x or any other
  GnuPG Installation on your system, then you might need to
  remove this registry entry:
  HKCU\Software\GNU\GnuPG\gpgProgramm

Most important changes in Gpg4win 1.9 compared to 1.1
=====================================================


Removed:
--------

- GpgEE: This module is replaced by GpgEX (see below)


Updated:
--------

- Claws Mail: Version 3.4.0
  NNTP- and IMAP-Support has been further worked on
  by Gg4win but is not yet available.
  On the Claws Mail side, work has continued on the SSL support,
  but there are still problems with the Windows version.
  During 2008 it is expected to finalize the integration of SSL, NNTP and
  IMAP for the Windows-Version of Claws Mail.

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

Neu:
----

- GpgEX: The new plugin for Microsoft Explorer.

- Kleopatra: The new certifacte manager

  * Kleoaptra is the current S/MIME certificate manager of KDE.
    On the one hand it has been extended for support of OpenPGP.
    On the other hand, Kleopatra now acts as graphical user
    interface for cryptographic operations and thus unifies the
    user interaction.

  * WinPT and GPA will eventually removed from Gpg4win as soon
    as their functionality is fully replaced by Kleopatra.

  * Kleopatra usually runs permanently as a service (see your system tray)
    from the time one when its service has been requested in your session.

  * Kleopatra is still in development:
    Some functionalities for OpenPGP are still missing.
    You can use GPA or WinPT for the missing functionality.


Most important changes in Gpg4win 1.9.1 compared to 1.9.0
=========================================================

 * Claws Mail: Update from 3.1.0cvs370 to 3.4.0

 * GpgOL: Now uses Icons (toolbar etc).

 * Kleopatra:
  * Integrated test for potential execution problems
  * Verfification results now in a special dialog; applies
    similar appearance as KMail does
  * Sign/Encrypt: Dialog sequence has been reworked.
  * Audit-Log support
  * Progress bar when handling files
  * Clipboard support

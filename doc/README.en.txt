;; README.en.txt                               -*- coding: latin-1; -*-
;; This is the README installed with Gpg4win. Lines with a ; in the first
;; column are considered a comment and not included in the actually
;; installed version.  Certain keywords are replaced by the Makefile;
;; those words are enclosed by exclamation marks.

                   English README file for Gpg4win
                   ===============================

This is Gpg4win, version !VERSION! (!BUILD_ISODATE!).

Content:

     1. Important notes
     2. Changes
     3. Additional notes
     4. Version history
     5. Version numbers of included software
     6. Legal notices


1. Important notes
==================

At release date, the English version of the ebook `Gpg4win Compendium`
has not been updated for Gpg4win 3, but still is useful as documentation of
some general background how to use the product. You will find it
on your system (depending on the version of Windows) or online at

    https://www.gpg4win.org/doc/en/gpg4win-compendium.html

Note that the German version 4.0.0 is up-to-date and only available as pdf.

Please read the section `3. Additional notes` of this
README before you start working with Gpg4win.

The Compendium has more hints for manual or automated installation.


System requirements
-------------------

Gpg4win runs on Windows versions 7 or newer (up to Windows 10).
Both 32 and 64bit systems are supported. If you have at least Windows XP,
some parts of Gpg4win can be used, but are not officially supported.

The Outlook plugin GpgOL is compatible with Microsoft Outlook 2010,
2013 and 2016 (both 32 and 64bit) and supports transporting emails
via SMTP/IMAP and MS Exchange Server (version 2010 or newer).
For elder Outlook versions 2003 and 2007 less functionality is offered.

(See https://www.gpg4win.org/system-requirements.html for updates.)


2. Changes
==========

Included Gpg4win components in version !VERSION! are:

!COMPONENTS!


New in Gpg4win version !VERSION! (!BUILD_ISODATE!)
-----------------------------------------

- GnuPG: A library used by GnuPG has been updated to fix a
  problem that could block the GnuPG system. (T3378)

- GpgOL: More possible "random" crashes caused by
  GpgOL have been fixed. (T3484)

- GpgOL: Outlook is no longer blocked when selecting many mails.
  (T3433)

- GpgOL: G Suite Sync plugin accounts are now detected. Only sending
  No-MIME PGP/Messages (without attachments) and unsigned
  messages are supported. Reading crypto mail is fully supported.
  (T3545)

- GpgOL: The option to send "No-MIME" (inline) PGP encrypted,
  unsigned text messages without attachments works again. (T3514)

- GpgOL: Die Option "No-MIME" verschlüsselte,
  unsignierte Textnachrichten, ohne Anhänge zu versenden funktioniert
  wieder (T3514)

- GpgOL: Improved error handling for signed, unencrypted mails.
  (T3538)

- GpgOL: Several performance improvements.

- GpgOL: Improved detection of large PGP/MIME messages and
  MS-TNEF crypto messages. (T3419 , T3542)

- Kleopatra: Passphrase entry is no longer opened behind Kleopatra
  windows. (T3460)

- Kleopatra: Decrypting archives across partitions has been fixed.
  (T3547)

- Kleopatra: Fixed possible crash in GpgOL certificate selection.
  (T3544)

- Kleopatra: Preselection of encrypt / sign file actions from GpgEX
  works again. (T3543)

- Kleopatra: Added Web Key Directory lookup support in file
  encryption dialog. (T3548)

- Kleopatra: Fixed crash when searching in LDAP. (T3550)


3. Additional notes
===================

- GpgOL

  * It is not possible to modify mails (e.g. moving / flagging the mail)
    while they are shown decrypted.
    To workaround this: unselect the crypto mail and then make changes
    through the right click context menu or move it with drag and drop.

  * Crypto mails forwarded as attachment are not properly handled.

  * The certificate selection dialog sometimes opens in the background and
    need an overhaul.

  * Localization is only there for German and Portuguese.

- General

  * For 3.1 we plan to offer a quick switch to a more automatic mode that
    will set the GnuPG options:

        auto-key-locate wkd
        auto-key-retrieve
        trust-model tofu+pgp

    As this is not properly handled everywhere (especially Kleopatra's
    file verification dialog) this is not yet default or easily accessible.

    You can add it manually to your gpg.conf. The trust-model is fully
    supported by GpgOL.

- Kleopatra

  * Netkey cards are not yet supported by the new Manage Smartcard view.

- GpgOL for Outlook 2003 and 2007 (deprecated):

  Outlook 2003 and 2007 support is deprecated and may be removed in a
  future version.

  * For Outlook 2003/2007 only:
    You definitely should create copies of your old encrypted/signed
    emails before installing GpgOL, e.g. in the form of PST files.

  * For Outlook 2003/2007 only:
    Sending signed or encrypted messages via an Exchange based account
    does not work. (Please note, using SMTP with GpgOL and Exchange
    seems to be work. Or use GpgOL with Outlook 2010 or newer.)

  * For Outlook 2003/2007 only:
    Encrypted E-Mails occurring un-encrypted on the email server: It
    can happen that parts of encrypted emails are copied to your email
    server (IMAP or MAPI) in un-encrypted/decrypted form when creating
    or viewing them.  Affected is the content of the email view
    window, thus usually the so-called email body.  Attachments are
    not affected.  Switching off the Outlook preview will lower the
    probability of this to happen, but not eliminate the issue.
    (If this is an issue for you: use GpgOL with Outlook 2010 or newer.)


4. Version history
==================

Listed below are the changes as recorded in the source distribution's
NEWS file. An up-to-date list of changes is also available at:
https://www.gpg4win.org/change-history.html

!NEWSFILE!


5. Version numbers of included software
=======================================

!VERSIONINFO!


6. Legal notices pertaining to the individual packets
=====================================================

Gpg4win consist of several independently developed packages, available
under different licensing conditions.  Most of these packages however
are available under or compatible to the GNU General Public License (GNU GPL).
Common to all is that they are Free Software, which means they can be used
without restrictions, may be studied, modified and that modifications may be
distributed. If the source files (i.e. gpg4win-src-x.y.z.exe) are distributed
along with the binaries and the use of the GNU GPL has been pointed out,
distribution is possible under many circumstances.

What follows is a list of copyright statements.

!PKG-COPYRIGHT!


***end of file ***

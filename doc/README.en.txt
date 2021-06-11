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

Gpg4win runs on Windows versions 7 or newer including Windows Server 2008
and later. Both 32 and 64bit systems are supported.
If you have at least Windows XP, some parts of Gpg4win can be used,
but are not officially supported.

The Outlook plugin GpgOL is compatible with Microsoft Outlook 2010 and
later and supports transporting emails via SMTP/IMAP and MS Exchange Server
(version 2010 or newer).

With Gpg4win version 3.1.2 Outlook 2003 and 2007 support was removed for
security reasons.

(See https://www.gpg4win.org/system-requirements.html for updates.)


2. Changes
==========

Included Gpg4win components in version !VERSION! are:

!COMPONENTS!


New in Gpg4win version !VERSION! (!BUILD_ISODATE!)
-----------------------------------------

- GpgOL: Added support for encrypting Outlook elements such
  as forwarded mails or contacts and events. (T4184)

- GpgOL: Encryption no longer blocks the Outlook window. (T5022)

- GpgOL: The "conflicting crypto preferences" warning
  now ignores more undocumented states. (T5335)

- Kleopatra: Added a "Groups" feature where you can define
  recipient groups that can then be selected as a whole when
  doing operations. (T5175 T5241)

- Kleopatra: Encryption works again with Windows shared file
  system paths. (T5216)

- Kleopatra: The check for elevated execution is now
  only a warning and no longer a hard error. (T5248)

- Kleopatra: The combined export of S/MIME and OpenPGP certificates
  has been improved. (T5002)

- Kleopatra: Search no longer shows all results as uncertified.
  (T5388)

- Kleopatra: Added support for additional CardOS Smartcards.
  (T4876)

- Kleopatra: Automatically imports public keys for the inserted
  Smartcard from an Active Directory / LDAP Server. (T4876)

- Kleopatra: The certify dialog now allows to certify a key
  as the certification authority for a specific domain. This
  enables Public Key Infrastructures where the certification
  is delegated. (T5245)

- Kleopatra: The Smartcard view has been improved for better
  usability. (T4876)

- Kleopatra: Complex LDAP Keyserver entries can now be entered
  without corruption. (T5404)

- Kleopatra: Very large Archives no longer lead to crashes on
  decryption. (T5475)

- Kleopatra: The performance when decrypting archives has
  been improved. (T5478)

- Kleopatra: Encrypting folders with files larger then 4GB no
  longer leads to truncated archives. (T5475)

- Kleopatra: Searching on LDAP / Active Directory for OpenPGP
  keys can now show multiple keys and shows details. (T5441)

- GnuPG: Importing OpenPGP keys from LDAP no longer strips third
  party signatures. (T5387)

- GnuPG: Files encrypted with S/MIME (CMS) but only with
  a password can now be decrypted.

- GnuPG: Special characters (non 7bit) are now handled again.
  (T4398)

- GnuPG: Updated to 2.2.28 See:
  https://lists.gnupg.org/pipermail/gnupg-announce/2021q2/000460.html


3. Additional notes
===================

- GpgOL

  * Crypto mails forwarded as attachment are not properly handled.

  * Integrated Microsoft only OLE Objects are not supported.

  * Localization is only complete for Dutch, German and Portugese.

- General

  * For a future Version we plan to, optionally, further automate GpgOL.
    This would set the GnuPG-Option:

        trust-model tofu+pgp

    As this is not properly handled everywhere (especially Kleopatra's
    file verification dialog) this is not default.

    You can add it manually to your gpg.conf. The trust-model is already
    supported by GpgOL.


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

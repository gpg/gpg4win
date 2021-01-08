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

With Gpg4win version 3.1.2 Outlook 2003 and 2007 support was removed for
security reasons.

(See https://www.gpg4win.org/system-requirements.html for updates.)


2. Changes
==========

Included Gpg4win components in version !VERSION! are:

!COMPONENTS!


New in Gpg4win version !VERSION! (!BUILD_ISODATE!)
-----------------------------------------

- GpgOL: Fixed a critical issue since Gpg4win-3.1.12 where
  the selection of "No Key" for a recipient could lead to arbitrary
  keys selected instead. (T5223)

- GpgOL: auto-key-retrieve in the GnuPG config now no longer
  leads to "No Data" errors when viewing signed mails. (T5164)

- GpgOL: The error "No Data" now leads to more useful output in
  the mail view. (T5164)

- GpgOL: The name for VS-NfD compliance is now configurable through
  libkleopatrarc.

- Kleopatra: The dialog to create new keys has been simplified and
  makes it easier to create keys without protection. This can
  be disabled by setting "enforce-passphrase-constraints" in the
  gpg-agent configuration. (T5181)

- Kleopatra: Name and e-mail for new keys are now obtained through
  active directory if they are available. (T5181)

- Kleopatra: Creating S/MIME CSRs for OpenPGP Smartcards has been
  further improved. (T5127)

- Kleopatra: Tag support for certifications has been greatly improved
  and is now also available when adding keys in the file encrypt
  dialog. (T5174)

- Kleopatra: Elevated execution of Kleopatra (run as Administrator)
  is now prevented to avoid accidental permission problems in the
  GnuPG data folder. (T5212)

- Kleopatra: Setting the initial SigG PIN for NetKey cards now also
  works if the generic PIN is not set. (T5220)

- GnuPG: Now supports system wide configuration files in
  "%ProgramData%\GNU\etc\gnupg" so Administrators can both set defaults
  and enforce a specific configuration. The Format is the same as
  the user configuration under "%AppData%\gnupg" with additional syntax
  to enforce some options and ignore other options. (T4788)

- GnuPG: OpenPGP certificates can no be obtained automatically
  over Active Directory.

- GnuPG: The scheme for LDAP access has been improved.

- GnuPG: Updated to 2.2.26 See:
  https://lists.gnupg.org/pipermail/gnupg-announce/2020q4/000451.html

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

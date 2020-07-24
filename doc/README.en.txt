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

- GpgOL: Improved handling of mails with encrypted
  subjects. (T4796)

- GpgOL: Improved integration with Web Key Services to
  automatically provide public keys. (T4839)

- GpgOL: The addressbook integration is now more visible. (T4874)

- GpgOL: Group accounts are now properly considered when
  preselecting the signing key. (T4090)

- GpgOL: During signature verification a preview of the
  content is now displayed. (T4944)

- GpgOL: Printing of encrypted mails now works correctly
  after changing the printer. (T4890)

- GpgOL: Security level of keys obtained from a Web Key
  Directory is now properly shown as Level 2.

- GpgOL: Permanently decrypt now works more reliably and
  should no longer lead to "No Data" errors. (T4718)

- GpgOL: Long lines in plaintext mails should no longer
  be displayed as multiple lines after decryption. (T4987)

- GpgOL: Attachments with filenames that are not allowed
  on Windows can now be handled. (T4835)

- GpgOL: Mails with exactly one attachment and no body
  are now displayed correctly.

- GnuPG: Symmetric encryption now uses only one
  password dialog. (T4971)

- GnuPG: Improved certificate import for S/MIME
  certificates. (T4847)

- GnuPG: Added support for CardOS 5 Smartcards
  based on the D-Trust 3.1 card.

- GnuPG: Support for rsaPSS signatures has been added. (T4538)

- GnuPG: The "Quality" of a new passphrase is
  no longer incorrectly displayed. (T2103)

- Kleopatra: Overwriting secret key exports now works
  correctly. (T4709)

- Kleopatra: Fixed a case where file sign & encrypt dialogs
  would not be shown on high DPI systems. (T4819)

- Kleopatra: The sorting of multiple tabs has been
  fixed.

- Kleopatra: The minimal lenght of the Name has been
  reduced to better support non latin names. (T4745)

- Kleopatra: The filename suggestion for key exports
  has been improved to avoid confusion between
  public and private key exports. (T4995)

- Kleopatra: Authentication subkeys can now be exported
  in the OpenSSH format.

- Kleopatra: Markup is now automatically removed when
  pasting into the notepad. (T4969)

- Kleopatra: "updating..." as key validity is no
  longer displayed incorrectly when doing a keyserver
  search. (T4948)

- Gpg4win: The file and URL connections with Kleopatra now properly
  split arguments and potential external data like filenames and
  the search query.
  This prevents a security issue where Kleopatra could be triggered
  to load a library from a filename provided through an unescaped
  URL.


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

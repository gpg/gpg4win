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

- GpgOL: It is now possible to move crypto mails while they
  are open. (T3459)

- GpgOL: Messages are automatically secured if valid Keys / Certificates
  can be found for each recipient.
  This can be turned off with the option "Automatically secure messages".
  (T3999)

- GpgOL: Support for distribution lists has been added. (T4065)

- GpgOL: S/MIME can now be preferred when automatically resolving
  recipients. (T3961)

- GpgOL: Encryption should no longer cause Outlook to freeze.
  (T3838)

- GpgOL: Mails moved by Outlook folder rules are now handled by
  GpgOL. (T4070)

- GpgOL: The config dialog was changed to improve future extensibility.
  (T3961)

- GpgOL: Fixed various memory errors and stability problems.

- GpgOL: Crashes related to filenames of attachments have been fixed.
  (T4062 T4032)

- GpgOL: An error has been fixed which could lead to attachments not
  beeing displayed.

- Kleopatra: Now offers diagnostic information in case of file
  decryption errors.

- Kleopatra: Support for NetKey v3 Smartcards has been improved.

- Kleopatra: Decryption errors caused by missing integrity protection
  (MDC) are now handled properly. (T4038)

- Kleopatra: Update check can now be disabled more easily. (T4043)

- Kleopatra: Special characters in GnuPG output should be displayed
  correctly. (T2983)

- Kleopatra: p7m and p7s files are now also registered to be
  opened with Kleopatra. (T3890)

- Kleopatra: Various minor improvements. (T3238 T4078 T3229 T4041)

- Installer: Silent install now correctly closes running Gpg4win
  applications. (T4051)

- GnuPG: The dirmngr process no longer requests Windows firewall
  access. (T3610)

- GnuPG: S/MIME data is now handled faster. (T4069)

- GnuPG: Updated to 2.2.9.
  (See: https://lists.gnupg.org/pipermail/gnupg-announce/2018q3/000427.html )


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

  * For 3.2 we plan to, optionally, further automate GpgOL. This would
    set the GnuPG-Option:

        trust-model tofu+pgp

    As this is not properly handled everywhere (especially Kleopatra's
    file verification dialog) this is not default.

    You can add it manually to your gpg.conf. The trust-model is already
    supported by GpgOL.

- Kleopatra

  * Netkey cards are not yet supported by the new Manage Smartcard view.


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

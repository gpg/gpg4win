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

--- Accessibility ---

- Kleopatra: OpenPGP and S/MIME key generation are now optimized
  for accessibility. (T5832)

- Kleopatra: The tab bar for different certificate views is
  now always shown. (T5841)

- Kleopatra: The certificate view can now be navigated by arrow
  keys to make it more accessible by keyboard. (T5841)

- Kleopatra: Empty cells in the certificate view now have screen reader
  specific annotations to make them readable. e.g.: "no name" or
  "no email". (T5841)

- Kleopatra: Key-IDs and Fingerprints are now read by screen readers
  in groups of four characters. (T5841)

- Kleopatra: The file encryption dialog has been optimized
  for accessibility. (T5845)

- Kleopatra: The certificate selection dialog, which can be
  accessed through the file encryption dialog, has been
  optimized for accessibility. (T5876)

- Kleopatra: The dialog for adding a User-ID has been
  rewritten for full accessibility. (T5916)

--- Features ---

- Kleopatra: The GnuPG backend can now be restarted
  through an action in the Extras menu. (T5775)

- Kleopatra: A tooltip highlights why subkeys are needed
  in the advanced key generation dialog. (T5781)

- Kleopatra: There is now a button in certificate details
  to copy the fingerprint via clipboard without spaces.
  (T5776)

- Kleopatra: The smartcard reader settings are now on their
  own configuration page. (T5857)

- Kleopatra: It is now possible to revoke your own
  key. (T5859)

- Kleopatra: The dialog for adding a User-ID has been
  rewritten and now also accepts names starting with
  numbers. (T5916)

- Kleopatra: It is now possible to configure a minimal
  and maximal validity period for new keys. (T5864)

- Kleopatra: A wrong passphrase for symmetric decryption
  now shows as wrong passphrase error. (T5406)

- Kleopatra: Support for using S/MIME certificate from PKCS#15 Smartcards.

- GpgEX: It is now possible to configure the default
  command through the Windows registry. (T5915)

- GnuPG: Threefold decryption speedup for large files.
         (T5820)
    For full use of this improvements use GnuPG on the command line.

- GnuPG: New Option "--require-compliance" to create an error if
  an Operation did not comply to the compliance setting.

- GnuPG: Tar archives now support longer filenames larger then MAX_PATH.
  (T5754)

- GnuPG: Support for GeNUA Smartcards.

- GnuPG: WKD lookups now also work for resolvers not handling SRV records.
  (T4729)

- GnuPG: Updated to 2.2.35.

--- Bug fixes ---

- Kleopatra: Several places where the application name
  was written in lowercase have been fixed. (T5833)

- Kleopatra: A crash has been fixed that occurred
  when revoking a certification without a selected
  key. (T5858)

- Kleopatra: The keylist filter for not certified certificates
  now only shows not certified keys and not all invalid
  certificates. (T5850)

- Kleopatra: Forcing the key type through configuration
  now also forces correct usage flags. (T5856)

- GpgOL: Fixed a double free error which could lead
  to random crashes. This double free was not
  exploitable as a security issue.

- GnuPG: Config values from the windows registry are now properly
  shown with gpgconf --show-configs. (T5724)

- GnuPG: Additional non compliant ciphers can now be decrypted
  in compliance mode.


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

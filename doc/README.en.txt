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

- GPA: So long, and thanks for all the fish.  To reduce maintenance
  and overall quality of Gpg4win we have decided to retire
  GPA. Over the last decade Kleopatra has made large improvements
  in quality and is very well maintained and the focus of our
  development.  [rW3f7ed3834f]

--- Features ---

- GnuPG: Improve signature verification speed by a factor of more
  than four.  Double detached signing speed.  [T5826]

- GnuPG: Import stray revocation certificates to improve WKD
  usability.

- GnuPG: New option --add-revocs for gpg-wks-client.  [rG2f4492f3be]

- GnuPG: Ignore expired user-ids in gpg-wks-client.  [T6292]

- GnuPG: Support the Telesec Signature Card v2.0 in OpenPGP.
  [T6252]

- GnuPG: For the new AEAD Format we now only allow the fast OCB
  mode.  The EAX mode may still be used for decryption.
  [rG5a2cef801d]

- Kleopatra: Support the import of non-standard conforming UTF-16
  encoded text files with certificates.  [T6298]

- Kleopatra: New Option to delete the locally stored secret key
  after a transfer to a smart card.  [T5836]

- Kleopatra: Improve the display of keys in the group edit
  dialog. [T6295]

- Kleopatra: Simplify changing the owner trust of keys.  [T6148]

- Kleopatra: Allow selecting ECC with supported curves when
  generating new keys for smart cards.  [T4429]

--- Bug fixes ---

- GnuPG: Update the X.509/CMS library Libksba to version 1.6.3 to
  fix a security problem in the CRL signature parser.  [T6230]

- GnuPG: Fix trusted introducer for mbox only user-ids.  [T6238]

- GpgOL: IMAP access to encrypted mails works again.  [T6203]

- Kleopatra: Don't report success if the key signing job was
  canceled.  [T6305]

- Kleopatra: Report failed imports immediately when receiving the result.
  [T6302]

- Kleopatra: Do not offer invalid S/MIME certificates for signing
  or encryption.  [T6216]

- Kleopatra: Don't ask user to certify an imported expired or
  revoked OpenPGP key.  [T6155]

- Kleopatra: Do not crash when closing details widget while
  certificate dump is shown.  [T6180]

- Kleopatra: Improve usability and accessibility of the notepad
  operations.  [T6188]

3. Additional notes
===================

- GpgOL

  * Crypto mails forwarded as attachment are not properly handled.

  * Integrated Microsoft only OLE Objects are not supported.

  * Localization is only complete for Dutch, German and Portugese.


4. Version history
==================

Listed below are the changes as recorded in the source distribution's
NEWS file. An up-to-date list of changes is also available at:
https://www.gpg4win.org/change-history.html


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

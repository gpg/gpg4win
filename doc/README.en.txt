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

--- General ---

- Okular (GnuPG Edition): Gpg4win has been extended with the popular
  Okular PDF Viewer.  Although our Okular version is currently considered
  experimental and therefore not installed by default, this provides the
  ability to legally sign and verify documents with the S/MIME certificates
  and smart cards GnuPG supports.
  The GnuPG Edition of Okular is optimized to be lightweight and to provide
  as little attack surface as possible. It does not support any active
  content like JavaScript or media files in PDF documents. It should
  therefore be more suitable in high security environments than other
  PDF readers.

  See: TODO: Link auf Neuigkeiten.

- GnuPG: The new component "keyboxd" is now enabled by default for new users
  of Gpg4win. keyboxd stores certificates (public keys) in an sqlite
  database and keeps it in memory.  The resulting performance improvement
  can be quite large especially for users with large keyrings.

  Adventuresome users can enable it manually:
  Select all certificates in Kleopatra and export them with a right click.
  Add a file %APPDATA%\gnupg\common.conf with the contents
  "use-keyboxd" (without the quote marks), then restart Kleopatra and
  import your certificates again.

  As usual we caution to make a backup of the %APPDATA%\gnupg directory
  before modifying files in there.

  To switch back to the old behavior, add a "#" character in front of
  the "use-keyboxd" and restart Kleopatra. Where applicable you have to
  export the certificate before and import them again after the restart.

- mkportable has been removed. Please see:
  https://wiki.gnupg.org/Gpg4win/PortableVersion
  on how to create a portable version of Gpg4win.

--- Features ---

- Kleopatra: Folder encryption and decryption (gpgtar) has been completely
  reworked so that it now has roughly the same performance as on the
  command line. The new architecture also allows for further performance
  improvements in the future and is much more robust.  And solves several
  issues.  [T5478 T6488 T6499 et.al.]

- Kleopatra: The progress indicator now also works for very large data
  files. [T6534]

- Kleopatra: It is now possible to rename the output file, if a file
  with the same name already exists, instead of just overwriting or
  canceling. [T6372]

- Kleopatra: It is now offered to delete the secret key on the computer
  after it was successfully transferred to a smart card. [T5836]

- Kleopatra: Added warnings when your certificate or other certificates
  in your keyring are about to expire.  The warnings are configurable
  and should allow a smoother switch to a new or extended certificate.
  [T6452]

- Kleopatra: The Notepad now also uses the last chosen certificates for
  signing and self-encryption as default.
  The values are shared with file encryption.[T6415]

- Kleopatra: The startup time of Kleopatra has been slightly improved.
  [T6259]

- Kleopatra: The certificate selection input and dropdown fields are now
  alphabetically sorted. [T6492, T6514]

- Kleopatra: Backed up subkeys can now be restored through the UI even when
  they were used from a smart card in between. [T3456, T3391]

- Kleopatra: For certifications of public keys it is now possible to
  configure a default validity period. [T6452]

- Kleopatra: When extending the validity period of a certificate,
  the default for new ones is now preset. [T6479]

- Kleopatra: The default validity of new certificates is now three years
  instead of two. This can be changed through configuration. [T2701]

- GpgOL: Now offers to create a OpenPGP certificate, if none with
  signing capability exists and only signing is requested. [T5869]

- GnuPG: The PKCS#12 (.p12 files) parser has been rewritten to increase
  compatibility with other PKCS#12 implementations. [T6536]

- GnuPG: S/MIME certificate listings have been sped up on Windows.
  [rG08ff55bd44]

- GnuPG: A new option "ADSK" has been added to signal the intention that
  messages should be encrypted to multiple subkeys.
  [T6395, https://gnupg.org/blog/20230321-adsk.html]

- GnuPG: There are now more compressed formats detected for which GnuPG then
  automatically disables its builtin compression. This can result in
  significant speed ups. [T6332]

--- Bug fixes ---

- Kleopatra: An accidental timeout when creating checksum files has been
  removed. This could result in empty or incomplete checksum files. [T6573]

- Kleopatra: The validity period of all subkeys is now extended
  even if the primary key was already expired.
  This fixes the case where seemingly extended keys were no
  longer usable for encryption. [T6473]

- Kleopatra: A rare occurrence, where encryption only keys would be offered
  as signing keys, has been fixed. [T6456]

- Kleopatra: Some obsolete configuration options have been removed.
  [T6326 T6327]

- Kleopatra: The button "What's this" in the right upper corner has
  been removed, since it was only used in very few places. [T6318]

- Kleopatra: Canceling file operations now reliably cancels the underlying
  backend operations, too. [T6524]

- Kleopatra: A number of encoding problems when displaying output from the
  backend have been solved. [T5960]

- Kleopatra: A cause for longer loading time of the certificate list at
  startup was fixed. [T6261]

- Kleopatra: Selecting cancel when exporting a secret subkey now properly
  cancels instead of creating a file without the secret part. [T5755]

- Kleopatra: When importing secret keys you do not want to mark as your own,
  it is no longer asked multiple times if it is your own key. [T6474]

- GnuPG/Kleopatra: Error handling for permission and write errors has
  been improved across the board. [T6528]

- GpgOL: An issue has been fixed where crypto mails would show up empty
  if text/plain display was preferred. [T6357]

- GpgOL: Fixed a crash that occurred when encrypting a mail with an
  attachment without a file name. [T6546]

- GpgOL: Category and flag changes now work again if the mail is
  not displayed in a decrypted state when they are made. [T4127]

- GpgOL: Added safeguards against a plain text leak back to the server
  in a specific unusual configuration. (dd3ff839)

- GnuPG: For a full list of the backend changes between GnuPG 2.4.0 in
  Gpg4win-4.1.0 and GnuPG 2.4.3 in Gpg4win-4.2.0 please see:

  2.4.1: https://lists.gnupg.org/pipermail/gnupg-announce/2023q2/000478.html
  2.4.2: https://lists.gnupg.org/pipermail/gnupg-announce/2023q2/000479.html
  2.4.3: https://lists.gnupg.org/pipermail/gnupg-announce/2023q3/000480.html

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

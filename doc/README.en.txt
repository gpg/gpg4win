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

--- Features ---

- GnuPG: Avoids "invalid hash method" errors by using SHA-256
  for certificates with implicit SHA-1 preferences in de-vs mode.
  (T6043)

- GnuPG: It is now possible to forbid users to trust additional
  root certificates. The option for this is "no-user-trustlist".
  (T5990)

- GnuPG: It is now possible to change the default filename
  (trustlist.txt) for the list of S/MIME root certificates.
  The option for this is "sys-trustlist-name" or on Windows
  it can be configured in the registry.
  This allows admins to change the S/MIME root certificates
  from the packaged default without having it overwritten with
  each update. (T5990)

- GnuPG: The "display serial number" is now used for card insert
  prompts.  This should match the serial number printed on
  smart cards. (T6135)

- GpgOL: Groups configured in Kleopatra can now be used for mail
  encryption. Groups must contain only keys of one protocol
  (either S/MIME or OpenPGP) and be named like the mail address.
  (T5967)

- GpgOL: An exclamation mark at the end of the GpgOL config registry
  values under "Local machine" now disallows the user to change that
  setting. (T5827)

- Kleopatra: Any configuration settings in kleopatrarc are now
  configurable through the Windows Registry / Group Policies, too.
  (T5707)

- Kleopatra: Automatic extraction of tar archives can now be disabled
  in the Kleopatra settings. (T6057)

- Kleopatra: The original filename is now embedded in encrypted
  files. (T6056)

- Kleopatra: In case the embedded filename does not match the
  filename of the encrypted file, the user is asked after decryption
  if the file should be renamed to the embedded name.
  This only works for files encrypted with GnuPG VS-Desktop 3.1.24
  or later. (T6056)

- Kleopatra: The user is now asked which file should be verified
  if the signed data for a detached signature (.sig) could not be found
  automatically. (T6062)

- Kleopatra: Queries containing just a single character are now allowed
  when searching in remote directories.  This should make it easier
  to list all certificates in a directory. (T6064)

- Kleopatra: When a user specific trustlist.txt is created by Kleopatra
  it now adds the "include-default" keyword, so that the system wide
  trustlist.txt is still included. (T6096)

- Kleopatra: The storage location is now displayed per subkey to
  better support offline keys and multiple smart cards. (T6108)

- Kleopatra: The certificate details now have an explicit update button
  to refresh a key from the configured directory services. (T5903)

- Kleopatra: The fingerprint with the suffix .rev is now used
  as suggested filename for revocation certificates. (T6121)

- Kleopatra: Several more file dialogs now save the last used
  directory. (T6121)

- Kleopatra: When withdrawing certifications, the own certifications
  on the certificate are now automatically determined. (T6115)

--- Bug fixes ---

- GnuPG: YubiKeys with firmware versions 5.4 and above are correctly
  detected again. (T6070)

- GnuPG: Combined symmetric and asymmetric encryption / decryption
  is now displayed as VS-NfD compliant, if appropriate. (T6119)

- GnuPG: A misleading error message when transferring keys to a
  smart card was changed. (T6122)

- GnuPG: The options "auto-key-import" and "include-key-block" are
  changeable through Kleopatra, again. (T6138)

- GnuPG: A possible path traversal security issue regarding
  "gpg-wks-server" has been fixed. This only affects
  users of "gpg-wks-server" in a WKS deployment. (T6098)

- GpgOL: Fixed some encoding issues.

- GpgOL: Issue with sender resolution for draft mails fixed.

- GpgOL: A hang and performance problem when displaying unencrypted
  mails with a specific structure has been fixed. (#8917)

- GpgOL: Stale temporary files created by GpgOL are now deleted to avoid
  clutter on systems that do not clean the temporary files. (T5926)

- Kleopatra: No longer reports success when adding an empty userid.
  (T5997)

- Kleopatra: The maximum expiration date is now 2106-02-05. (T5991)

- Kleopatra: S/MIME certificate trees are no longer collapsed when
  details are opened by double click. (T6055)

- Kleopatra: Minor improvements to the encrypt / sign recipient
  selection dialog. (T6080)

- Kleopatra: Canceling the password entry when exporting a secret
  key now correctly aborts the operation. (T6090)

- Kleopatra: A family of startup crashes has been fixed.  The
  crashes would show up in the event log as crashes in
  libstdc++6.dll. (T6131)

- Kleopatra: Fixed a very rare hang when archiving files.  This
  caused Kleopatra never to finish an archiving operation. (T6139)

- Kleopatra: When only a single OpenPGP certificate is imported,
  the question about weather to certify it has been restored.
  (T6144)

- Kleopatra: Problems of "Failed to move directory" when decrypting
  archives on systems where the users TEMP directory was placed
  on Microsoft virtual hard disks have been resolved. (T6147)

--- Accessibility ---

- Kleopatra: The following dialogs have been changed so that they are
  usable:
  * with keyboard only
  * with a screenreader (tested NVDA and ORCA)
  * with 400% magnification
  * with high contrast color scheme (T6073)
  * with inverted color scheme (T6073)

  - OpenPGP certificate creation (T5969, T5832)
  - The main window toolbar (T6026)
  - Certificate Details (T5843)
  - Certificate certification (T6046)
  - Expiration date change (T6080)
  - Group configuration (T6095)
  - DN Attribute Order configuration (T6089)
  - Subkey details (T6104)
  - Certifications view (T6102)
  - Self Test (T6101)

- Kleopatra: Generating a new OpenPGP certificate is reduced to
  a single dialog. (T5832)

- Kleopatra: Creating an S/MIME Certificate Signing Request (CSR)
  is now a standalone action in Kleopatras file menu. (T5832)

- Kleopatra: Links used in Kleopatra texts are now accessible for
  screenreaders. (T6034)

- Kleopatra: Text parts (labels) are now selectable and the
  selection is highlighted.  This is easier to control with
  a Screenreader. (T6036)

- Kleopatra: Tooltip pop-ups are now read out by screenreaders.
  (T6044)

- Kleopatra: All icon-only buttons should now have a description
  which can be read by Screenreaders. (T6088)

- Kleopatra: Navigating the certificate list with the keyboard
  is improved. (T5841)

- Kleopatra: Validity period labels have been unified to
  "Valid from" and "Valid until" respectively. (T6120)

- Kleopatra: Compliance display has been simplified by
  removing the "communication is possible" part.
  (T5855)


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

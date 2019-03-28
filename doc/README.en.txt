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

- Gpg4win-3.1.7 is a minor update over 3.1.6 to fix
  regressions introduced in 3.1.6. The changes
  for 3.1.6 are:

- Kleopatra: An issue has been fixed that could cause
  Kleopatra to generate broken TAR archives. (T4332)
  If you are affected see:
  https://wiki.gnupg.org/TroubleShooting#Restoring_corrupted_Archives_created_by_Kleopatra

- Kleopatra: When importing from X509 directory services
  trusted-certs from dirmngr are also used. (T4269)

- Kleopatra: Secret key backup has been simplified.
  (T4089)

- Kleopatra: It is now possible to generate keys
  without signing capability. (T4373)

- Kleopatra: Startup time has been slightly
  improved.

- Kleopatra: Generating keys on OpenPGP Smartcards
  works again. (T4428)

- Kleopatra: Shows the embedded, encrypted, file name if it
  differs from the actual file name. (T4390)

- Kleopatra, GnuPG: Can now directly import secret keys exported
  from Symantec PGP Desktop. (T4392)

- Pinentry: A problem preventing pinentry from starting
  in some minimal installations has been fixed. (T4347)

- GPA: An error when generating new keys has been fixed.
  (T4265)

- GpgOL: The context menu of a crypto mail now offers to
  permanently decrypt a message. (T3895)

- GpgOL: Forwarding sent crypto mails works now. (T4321)

- GpgOL: S/MIME Mail detection has been improved. Especially
  when sending from exchange to exchange. (T4262 T3935)

- GpgOL: Now shows diagnostics in case sign/encrypt failed
  (T4435)

- GpgOL: A crash when memory debugging was enabled
  has been fixed. (T4262)

- GpgOL: With the new option "Import any keys included in mails"
  GpgOL can now automatically import keys from mail headers
  and attachments. (T4432)

- GpgOL: The option to automatically toggle secure can now
  be modified to do this even if the keys are untrusted.
  (T4432)

- GpgOL: An encrypted subject (e.g. from Enigmail) is now
  shown after decryption. (T4433)

- GpgOL: Now uses descriptive names for OpenPGP MIME parts.
  (T4258)

- GpgOL: Now provides a minimal API for other
  Addins or Programs to work with
  crypto mails which GpgOL would otherwise lock.
  (T4241)

- GpgOL: There is now a warning in case GpgOL can't
  represent an Outlook internal attachment format, like
  for an Event. (T4184)

- GnuPG: An issue that could cause dirmngr not to launch
  on some systems has been fixed. (T3381)

- GnuPG: Updated to Version 2.2.15.
  (See: https://gnupg.org for News.)

3. Additional notes
===================

- GpgOL

  * Crypto mails forwarded as attachment are not properly handled.

  * Integrated Microsoft only OLE Objects are not supported.

  * Localization is only complete for Dutch, German and Portugese.

- General

  * For 3.2 we plan to, optionally, further automate GpgOL. This would
    set the GnuPG-Option:

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

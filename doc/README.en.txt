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

- Kleopatra: The group configuration has been extended so that groups
  can now be exported and imported. (T5638)

- Kleopatra: Now shows the used GnuPG version in the about dialog.
  (T5652)

- Kleopatra: Added an option under crypto operations to only
  use symmetric encryption. (T5661)

- Kleopatra: Available Smartcard readers can now be listed under
  settings. (T5662)

- Kleopatra: The update notification has been fixed. (T5663)

- Kleopatra: Checks for RESTRICTED / VS-NfD compliance
  now take underlying library configurations into account. (T5362)

- Kleopatra: Added error handling for operations which are not
  allowed in the configured compliance mode. (T5653)

- Kleopatra: Configuration of Keyservers is now shown correctly
  even when done through dirmngr.conf. (T5672)

- Kleopatra: Smartcard reader can now be selected through a menu
  which shows all available readers. This is found under the GnuPG System
  Smartcard configuration. (T5666)

- Kleopatra: When searching for certificates in the available list, a
  following "Search on Server" is now prefilled with the search string.
  (T5624)

- Kleopatra: Both S/MIME and OpenPGP certificates can now be imported
  from a single file. (T5638)

- Kleopatra: Configuration pages can now be hidden. (T5689)

- Kleopatra: The key creation wizard can now be customized with
  custom placeholders and expiry times. (T5690 T5708)

- Kleopatra: It is now possible to hide S/MIME (CMS) actions for
  an OpenPGP only mode. (T5688)

- Kleopatra: The GnuPG-System configuration has received minor
  cleanups. (T5677)

- Kleopatra: A crash related to circular certificate chains
  has been fixed. (T5697)

- GpgOL: Contents are no longer hidden if plain text
  only is configured through group policies. (T5681)

- GnuPG: A new, optional, configuration syntax has been implemented
  which allows conditional configuration based on variables. Variables
  can be read from the Windows registry and controlled by Group Policies.

- GnuPG: The configured "trusted-key" options can now be
  properly changed. (T5685)

- GnuPG: The default selection for smartcard reader now tries
  to ignore virtual smartcard readers. (T5644)

- GnuPG: With "gpgconf --show-configs" the configuration of the
  system can now be listed.

- GnuPG: Updated to 2.2.33.  For details see:
  https://lists.gnupg.org/pipermail/gnupg-announce/2021q4/000466.html


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

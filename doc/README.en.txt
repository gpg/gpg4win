;; README.en.txt                               -*- coding: latin-1; -*-
;; This is the README installed with Gpg4win. Lines with a ; in the first
;; column are considered a comment and not included in the actually
;; installed version.  Certain keywords are replaced by the Makefile;
;; those words are enclosed by exclamation marks.

                   English README file for Gpg4win
                   ===============================

This is Gpg4win, version !VERSION! (!BUILD_ISODATE!).

Content:

     1. Important Notes
     2. Changes
     3. Known Bugs (and Workarounds)
     4. Installation
     5. Version History
     6. Version Numbers of Included Software
     7. Legal Notices


1. Important Notes
==================

The Gpg4win Compendium describes the installation and use of Gpg4win.
After installation it is available in the Gpg4win start menu or online:
http://www.gpg4win.org/doc/en/gpg4win-compendium.html

Please read the section "3. Known Bugs (and Workarounds)" of this
README before you start working with Gpg4win.

Gpg4win supports these platforms:

  * Operating System: Windows XP and later Versions (for all: 32/64 bit)

  * MS Outlook: 2003, 2007, 2010, 2013, 2016 (2010 and later also in 64bit)


2. Changes
==========

Included Gpg4win components in Version !VERSION! are:

!COMPONENTS!


New in Gpg4win Version !VERSION! (!BUILD_ISODATE!)
-----------------------------------------

- GpgOL: A cause for seemingly random crashes in GpgOL has been
  fixed.

- GpgOL: A crash when pasting recipients has been fixed.

- GpgOL: Various problems regarding S/MIME mails have been fixed.

- GpgOL: A user interface error for Outlook 2010 has been fixed.

- Kleopatra: Fehler bei S/MIME Dateioperationen wurden behoben.

- Kleopatra: Verschiedene Probleme im Umgang mit Dateiordnern
  und Archiven wurden behoben.

- GnuPG: Has been updated to version 2.2.2.

- Some small bugfixes and improvements.

- The mkportable process can be used again to create a portable
  Gpg4win variant.

3. Additional Notes
===================
- General

  * For 3.0 we plan to offer a quick switch to a more automatic mode that
    will set the gnupg options:

        auto-key-locate wkd
        auto-key-retrieve
        trust-model tofu+pgp

    As this is not properly handled everywhere (especially Kleopatra's
    file verification dialog) this is not yet default or easily accessible.

    You can add it manually to your gpg.conf. The trust-model is fully
    supported by GpgOL.

- Kleopatra

  * Netkey cards are not yet supported by the new Manage Smartcard view.

- GpgOL

  * It is not possible to modify mails (e.g. moving / flagging the mail)
    while they are shown decrypted.
    To workaround this unselect the crypto mail and then make changes
    through the right click context menu or move it with drag and drop.

  * Crypto mails forwarded as attachment are not properly handled.

  * The certificate selection dialog sometimes opens in the background and
http://www.gpg4win.de/doc/de/gpg4win-compendium_35.html
    needs an overhaul.

  * Localization is incomplete


- GpgOL for Outlook 2003 and 2007 (deprecated):

  Outlook 2003 and 2007 support is deprecated and may be removed in a
  future version.

  * You defintely should create copies of your old encrypted/signed
    emails before installing GpgOL, e.g. in the form of PST files.

  * For Outlook 2003/2007 only:
    Sending signed or encrypted messages via an Exchange based account
    does not yet work.
    [see https://bugs.g10code.com/gnupg/issue1102]
    (Please note, using SMTP with GpgOL and Exchange seems to be work.
    Or use GpgOL with Outlook 2010 or later.)

  * For Outlook 2003/2007 only:
    Encrypted E-Mails occuring un-encrypted on the email server: It
    can happen that parts of encrypted emails are copied to your email
    server (IMAP or MAPI) in un-encrypted/decrypted form when creating
    or viewing them.  Affected is the content of the email view
    window, thus usually the so-called email body.  Attachments are
    not affected.  Switching off the Outlook preview will lower the
    probability of this to happen, but not eliminate the issue.
    Or use GpgOL with Outlook 2010/2013.


4. Installation
===============

For installation instructions please read the new Gpg4win Compendium:
https://files.gpg4win.org/doc/gpg4win-compendium-en.pdf

Hints for automated installations (without user dialogs):
https://files.gpg4win.org/doc/gpg4win-compendium-en.pdf


5. Version History
==================

Listed below are the changes as recorded in the source distribution's
NEWS file. An up-to-date list of changes is also available at:
http://www.gpg4win.org/change-history.html

!NEWSFILE!


6. Version Numbers of Included Software
=======================================

!VERSIONINFO!


7. Legal notices pertaining to the individual packets
=====================================================

Gpg4win consist of several independent developed packages, available
under different license conditions.  Most of these packages however
are available under the GNU General Public License (GNU GPL).  Common
to all is that they are free to use without restrictions, may be
modified and that modifications may be distributed.  If the source
files (i.e. gpg4win-src-x.y.z.exe) are distributed along with the
binaries and the use of the GNU GPL has been pointed out, distribution
is in in all cases possible.

What follows is a list of copyright statements.

!PKG-COPYRIGHT!




Happy GiPiGing,

  Your Gpg4win Team


***end of file ***

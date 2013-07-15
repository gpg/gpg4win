;; README.en.txt                               -*- coding: latin-1; -*-
;; This is the README installed with Gpg4win. Lines with a ; in the first
;; column are considered a comment and not included in the actually
;; installed version.  Certain keywords are replaced by the Makefile;
;; those words are enclosed by exclamation marks.

                   English README file for Gpg4win
                   ===============================
!BETA-WARNING!
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

If you used Gpg4win 1.x or another program in the past, please check
out the migration hints in the Gpg4win Compendium's appendix.
http://www.gpg4win.org/doc/en/gpg4win-compendium_36.html

Please read the section "3. Known Bugs (and Workarounds)" before you
start working with Gpg4win.

Gpg4win supports these platforms:

  * Operating System: Windows XP (32/64), Vista (32/64), 7 (32/64)

  * MS Outlook: 2003, 2007, 2010


2. Changes
==========

Included Gpg4win components in Version !VERSION! are:

!COMPONENTS!


New in Gpg4win Version !VERSION! (!BUILD_ISODATE!)
-------------------------------------------------
- GpgEx:
  * Now with Windows 64 bit support!

- GpgOL:
  * starts supporting Outlook 2010. There are some Context Menu / UI
    actions available in Outlook 2010. Due to the extensive compatiblity break
    with earlier extensions the support for Outlook 2010 is still minimal and
    does not include any MIME parsing.

- Kleopatra:
  * Kleopatra no longer crashes when started as User on Windows Server
    Systems.

- Pinentry:
  * Pinentry now allows you to paste in the passphrase.

- GnuPG-Backend:
  * Gpg-agent may now be used as Pageant (PuTTY authentication agent) 
    replacement with additional smartcard support.

- Installer:
  * Updated License page
  * Removed S/MIME HOWTO page (available via program menu of 
    Gpg4win)


3. Known Bugs (and Workarounds)
===============================

- Using smart card with Kleopatra

   The initial setting of smart cards with Kleopatra is currently not
   yet possible. Please run the following steps one-time to use your
   smart card with Kleopatra.

   * OpenPGP card
     Use the gpg command line tool to create a new OpenPGP certificate
     on your card (a) or to activate your existing certificate of
     your card (b):

     (a) Create new certificate
       - Insert card.
       - Run "gpg --card-edit".
       - Switch to admin modus by enter: "admin".
       - Enter "generate" to create a new certificate.

     (b) Activate existing certificate of your card
       - Import associated (public) certificate of your card (e.g.
         from certificate server or from a exported certificate file).
       - Insert card.
       - Run "gpg --card-status".

   * X.509 Telesec Netkey 3 card
     Use Kleopatra to initializing your card:
     - Insert card.
     - Click at the Kleopatra systemtray icon (or use the context menu of
       the systemtray icon and run the learn card command).

   After finishing these steps your OpenPGP / X.509 certificate
   from your smart card is shown in Kleopatra under the tab
   "My certificates" (marked with a smart card icon).

- Using the Outlook Plugin "GpgOL":

  * You defintely should create copies of your old encrypted/signed
    emails, e.g. in the form of PST files.

  * Sending signed or encrypted messages via an Exchange based account
    does not yet work.
    [see https://bugs.g10code.com/gnupg/issue1102]
    (Please note: Using SMTP with GpgOL and Exchange seems to be work.)

  * Encrypted E-Mails occuring un-encrypted on the email server: It
    can happen that parts of encrypted emails are copied to your email
    server (IMAP or MAPI) in un-encrypted/decrypted form when creating
    or viewing them.  Affected is the content of the email view
    window, thus usually the so-called email body.  Attachments are
    not affected.  Switching off the Outlook preview will lower the
    probability of this to happen, but not eliminate the issue.
    A solution is being worked on.


4. Installation
===============

For installation instructions please read the new Gpg4win Compendium:
http://www.gpg4win.org/doc/en/gpg4win-compendium_11.html

Hints for automated installations (without user dialogs):
http://www.gpg4win.org/doc/en/gpg4win-compendium_35.html


5. Version History
==================

Find below the changes as recorded in the source distribution's NEWS
file.  An up-to-date list of changes is also available at
http://www.gpg4win.org/change-history.html .

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

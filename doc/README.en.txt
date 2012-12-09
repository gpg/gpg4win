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

  * MS Outlook: 2003, 2007

Note: Currently, there is no 64-bit support for GpgEX
      (see section 3, "Using GpgEX with Windows x64", for details)


2. Changes
==========

Included Gpg4win components in Version !VERSION! are:

!COMPONENTS!


Detailed list of changes in version 2.1.0 (2011-03-15)
------------------------------------------------------
  [The bug numbers reference either http://bugs.gnupg.org or
   https://issues.kolab.org/.]

- Kleopatra:
  * recursive sign/encrypt of files and folders possible (see
    GnuPG Backend)
  * Checksums
    - Create/verify checksum by sha1sum, sha256sum, md5sum possible
      (see GnuPG Backend)
    - create checksums for more than one files
      [kolab/issue4540]
    - Create/verify checksum entry to file menu of Kleopatra added
      [kolab/issue4464]
    - Create and verify dialogs of Kleopatra extended
      [kolab/issue4487]
  * Conflict dialog
    - Certificate selection dialog now works context-sensitive
      (dependent on selecting sign, encrypt or sign/encrypt)
      [kolab/issue4492]
    - Conflicts redefined and implemented, fixed errors
      [kolab/issue4197,4234]
    - New configuration option for "quick mode" (Power-User-Mode) to
      sign and encrypt
      [kolab/issue4136])
    - No protocol (OpenPGP or S/MIME) pre-selection dialog required -
      replaced by new certificate selection dialog.
      [kolab/issue4213,4235]
  * Certificate lookup on certificate server
    - Search for fingerprint or key-id shows new information dialog
      (some server requires 0x-Präfix in search string)
      [kolab/issue4453]
  * Certify OpenPGP certificates
    - Fingerprint and key-id in step 1 added
      [kolab/issue4468,4458]
    - Key-id in step 2 added
      [kolab/issue4460]
  * Several minor and medium (GUI) improvements:
    - Kleopatra's main window: column 'fingerprint' with 'key-id' replaced
      [kolab/issue4542]
    - Show key-id always in 8-digit format
      [kolab/issue4659]
    - Decrypt/verify files dialog layout improved
      [kolab/issue4662]
    - Export of secret X.509 certificats use new default (utf8) for
      passphrase charset
      [kolab/issue4454]
    - Import certificate without file type improved (content checker)
      [kolab/issue4457]
    - Fix certificate list in delete confirm dialog
      [kolab/issue4459]
    - New context menu entry for deleting certificate added
      [kolab/issue4450]
    - OwnerTrust added to tooltips and certificate details
      [kolab/issue4198]
    - Unit (Bits) to the key strength fields in NewCertificateWizard's
      overview page added
      [kolab/issue4183]
    - E-Mail-Validator allows to delete '@' Zeichen
      [kolab/issue4189]
    - Trust/distrust root certificates via context menu
      (write directly $GNUPGHOME\trustlist.txt)
      [kolab/issue4190]
    - For developer: KDebugDialog available (installed with Kleopatra,
      run $INSTDIR\kdebugdialog.exe)
      [kolab/issue4318]
    - Hierarchical certificate list: toggling (regression)
      [kolab/issue4327]
    - Fixed exception for decrypt/verify special S/MIME e-mail
      [kolab/issue4179]
  * Kleopatra Settings - S/MIME dialog:
    - Option 'allow-mark-trusted' removed if gnupg provides
      'no-allow-mark-trusted'
  * SmartCard
    - Improve initialize smart card process with Kleopatra
      [kolab/issue4519]
    - Detecting smartcard: Kleopatra's systemtray icon blinks after
      inserting X.509 card. Click starts learn card command or opens
      Null-PIN dialog.
      [kolab/issue4191]
    - Learn card commands suppress gpgsm error dialogs.
      [kolab/issue4126]
  * Miscellaneous
    - Gpg4win credits added (see 'About Gpg4win' dialog)
    - German translations fixed
    - Several minor and medium issues and errors were fixed

- GnuPG Backend:
  * Update to gnupg 2.0.17
  * Option 'allow-mark-trusted' enabled by default (no-allow-mark-trusted
    added)
  * gpgme and libassuan updated (fixed increase of open handles in
    Kleopatra, see [kolab/issue4705])
  * fixed: gpgconf doesn't restart gpg-agent automatically
    [kolab/issue4563]
  * bzip2 updated (from 1.0.4 to 1.0.6)
  * Add better error code for missing certificates
  * (recursive) sign/encrypt of files and folders possible
    [kolab/issue4298,4299,4300]
  * Create/verify checksum by sha1sum, sha256sum, md5sum
    possible via GpgEX
    [kolab/issue41634,294,4295,4296,4297,4321]
  * Updated to new libassuan v2 interface
  * Several minor and medium improvements of stability
    [u.a.: kolab/issue4212]

- GpgEX
  * (recursive) sign/encrypt of files and folders possible (see
    GnuPG Backend)
  * Create/verify checksum by sha1sum, sha256sum, md5sum possible
    (see GnuPG-Backend)
  * Portuguese translation added
  * Updated to libgpg-error 1.9

- GpgOL:
  * Portuguese translation added
  * updated to new libassuan2 interface and libgpg-error 1.9

- Pinentry:
  * Pinentry-qt4 hanger while signing e-mail fixed
    (update from 0.8.0 to 0.8.1)
    [kolab/issue4302]
  * Change default: switch to QT4
    (GTK still enabled for gpg4win-light installer)
    [kolab/issue4378]
  * Fixed German translation for 'Cancel' cancel
    [kolab/issue4132]

- Installer:
  * Installation of dektop shortcuts using non-German installer language fixed
  * Windows7 support for Gpg4win
  * S/MIME configuration instruction added
  * English language version of the Gpg4win Compendium
    (v3.0.0-beta1) added. Old novices manual removed.
  * Installer was signed with a CodeSigning certificate of GlobalSign
    (Publisher: "Intevation GmbH")
  * Portuguese translation added

- Claws-Mail:
  See http://www.claws-mail.org


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

  * Outlook2007 crashes after opening attachments of an encrypted message
    [see https://bugs.g10code.com/gnupg/issue1110]

  * Encrypted E-Mails occuring un-encrypted on the email server: It
    can happen that parts of encrypted emails are copied to your email
    server (IMAP or MAPI) in un-encrypted/decrypted form when creating
    or viewing them.  Affected is the content of the email view
    window, thus usually the so-called email body.  Attachments are
    not affected.  Switching off the Outlook preview will lower the
    probability of this to happen, but not eliminate the issue.
    A solution is being worked on.

- Using GpgEX with 64 bit versions Windows:

   * In some cases sign/encrypt or decrypt/verify via GpgEX doesn't work
     correctly (Kleopatra freezed). Then you should kill Kleopatra via
     task manager and run the file crypto operation directly in Kleopatra
     (see file menu).

   * Problems with Windows x64:
     GpgEX is a (32bit) plugin for the (32bit) Windows
     Explorer and it does _not_ run in a 64bit Explorer
     (= default for a Windows 64bit system).

     Workaround: Run the 32bit Explorer to use GpgEX.
     Click "Start" -> "Run", type the following in the box, and then
     click OK:
         C:\windows\syswow64\explorer.exe /separate
     Note: Adjust the path to your x64-based version of Windows if
     necessary.
     This 'separate' command seems to be currently broken in Windows7/64bit.
     Alternatively you can use the file crypto operations of GpgEX
     directly via the file menu of Kleopatra.


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

;; README.de.txt                             -*- coding: latin-1; -*-
;; This is the README installed with Gpg4win (German version).  Lines
;; with a ; in the first column are considered a comment and not
;; included in the actually installed version.  Certain keywords are
;; replaced by the Makefile; those words are enclosed by exclamation
;; marks.

                  Deutsche README Datei für Gpg4win
                  =================================

Dies ist Gpg4win, Version !VERSION! (!BUILD_ISODATE!).

Inhalt:

     1. Wichtige Hinweise
     2. Änderungen
     3. Anmerkungen
     4. Versionsgeschichte
     5. Versionsnummern der einzelnen Programmteile
     6. Rechtliche Hinweise


1. Wichtige Hinweise
====================

Hilfe bei der Installation und Benutzung von Gpg4win bietet Ihnen das
Gpg4win-Kompendium. Sie finden es nach der Installation
auf Ihrem System (wo genau, ist abhängig von Ihrer Windows-Version)
oder online auf
    https://www.gpg4win.de/documentation-de.html

Bitte lesen Sie den Abschnitt "3. Anmerkungen" dieses READMEs,
bevor Sie Gpg4win nutzen.

Im Kompendium finden Sie weitere Hinweise zur manuellen oder automatischen
Installation.


Systemvoraussetzungen
---------------------

Gpg4win läuft auf Windows Versionen 7 oder neuer (bis Windows 10).
32- und 64bit-Systeme werden unterstützt. Wird mindestens Windows XP verwendet,
können einige Komponenten von Gpg4win verwendet werden, sie sind allerdings
nicht offiziell unterstützt.

Das Outlook-Plugin GpgOL ist kompatibel mit Microsoft Outlook 2010, 2013 und
2016 (sowohl 32 als auch 64bit) und unterstützt E-Mail Transport per SMTP/IMAP
und MS Exchange Server (ab Version 2010).

Mit Gpg4win Version 3.1.2 wurde die Unterstützung für Outlook 2003 und 2007
aus sicherheitsgründen entfernt.

(Aktuellste Angaben auf https://www.gpg4win.de/system-requirements-de.html .)



2. Änderungen
=============

Die integrierten Gpg4win-Komponenten in Version !VERSION! sind:

!COMPONENTS!


Neu in Gpg4win Version !VERSION! (!BUILD_ISODATE!)
-----------------------------------------

- GpgOL: Verbesserte Kompatibilität mit anderen Klienten
  für S/MIME Mails. Zum Beispiel mit dem Outlook Web
  Interface. (T4543 T4525)

- GpgOL: Mails die zu groß sind um auf einem Server, mit Limits
  für die Mail-Größe, verarbeitet werden zu können, werden
  nun mit einer eigenen Fehlermeldung behandelt. (T4731)

- GpgOL / Kleopatra: Die GnuPG-System Konfiguration kann nun
  versteckt werden.

- GpgOL: Es gibt nun eine weitere Konfigurationsoption um
  den Dialog zur Zertifikats-Bestätigung auch bei voller
  Automatisierung anzuzeigen.

- GpgOL: Mails werden nun nicht immer als HTML klassifiziert.

- GpgOL: Es funktioniert nun auch Mails als Dateien abzuspeichern
  wenn diese in einem eigenen Fenster geöffnet sind.

- GpgOL: Ein seltener Absturz wurde behoben der beim öffnen
  von Mails aus dem Dateisystem passieren konnte.

- GpgOL: Der Dialog zur Zertifikats-Bestätigung hat nun
  Info Knöpfe um Details anzuzeigen.

- Kleopatra: Der Dialog zum beglaubigen von Benutzerkennungen
  wurde überarbeitet um die Benutzerfreundlichkeit zu verbessern.
  (T4649)

- Kleopatra: Neues Feature "Tags": Beim beglaubigen einer
  Benutzerkennung kann man nun zusätzliche Tags angeben.
  Diese Tags können verwendet werden um Schlüssel zu
  gruppieren oder danach zu suchen. Es werden alle Tags
  angezeigt die von Schlüsseln mit vollem Beglaubigungs-Vertrauen
  angelegt wurden. (T4734)

- Kleopatra: Es erscheint nun eine Fehlermeldung wenn bei der
  Datei-Verschlüsselung ein Schlüssel nicht gefunden werden
  konnte.

- Kleopatra: Die Smartcard-Verwaltung unterstützt nun
  auch OpenPGP 3 Karten. Zum Beispiel neuere Yubikeys.

- GnuPG: Netzwerk-Operationen sind nun deutlich
  schneller wenn IPv6 nicht verfügbar ist. (T4165)

- GnuPG: Vorbereitung auf "chosen-prefix" SHA-1 Kollisionen in
  Schlüssel-Signaturen (Beglaubigungen).
  Diese Änderung ignoriert alle SHA-1 basierten Beglaubigungen,
  welche nach dem 19.1.2019 erstellt wurden.
  Dies betrifft alle DSA-1024 Schlüssel.
  Die neue Option --allow-weak-key-signatures kann verwendet
  werden um das alte, unsicherere, verhalten wiederherzustellen.
  (T4755, CVE-2019-14855)

- GnuPG: Auf Version 2.2.19 aktualisiert.
  (Siehe: https://gnupg.org für weitere Neuigkeiten.)


==============

- GpgOL

  * Crypto E-Mails, die als Anhang weitergeleitet wurden,
    werden nicht verarbeitet.

  * Integrierte Microsoft spezifische OLE Objekte sind nicht
    unterstützt.

  * Als weitere Sprachen sind nur Englisch, Niederländisch
    und Portugiesisch verfügbar.

- Allgemein

  * Für Version 3.2 planen wir mit GpgOL, optional, in einen stärker
    automatisierten Modus zu wechseln. Dies würde die GnuPG-Option
    setzen:

        trust-model tofu+pgp

    Da das neue Vertrauensmodell noch nicht vollständig in Kleopatra behandelt
    wird (insbesondere bezüglich Dateisignaturen), ist diese Option
    nicht voreingestellt.

    Sie können sie jedoch manuell in der gpg.conf setzen. Das neue
    Vertrauensmodell wird von GpgOL bereits unterstützt.


4. Versionsgeschichte
=====================

Eine aktuelle, deutschsprachige Übersicht der Änderungen finden Sie online
unter: https://www.gpg4win.de/change-history-de.html
Im Weiteren finden Sie die Einträge aus der englischen NEWS-Datei:

!NEWSFILE!


5. Versionsnummern der einzelnen Programmteile
==============================================

Zur Übersicht sind hier die Prüfsummen, sowie die Namen der einzelnen
Bestandteile, aufgelistet.

!VERSIONINFO!


6. Rechtliche Hinweise zu den einzelnen Bestandteilen der Software
==================================================================

Gpg4win besteht aus einer ganzen Reihe von unabhängig entwickelten
Paketen, die teilweise unterschiedliche Lizenzen haben. Der Großteil
dieser Software ist, wie Gpg4win selbst, kompatibel mit der GNU General
Public License (GNU GPL). Allen gemeinsam ist, dass es Freie Software ist,
welche ohne Restriktionen benutzt werden kann, studiert und verändert werden
darf, sowie, dass Änderungen weitergeben dürfen. Wenn die Quelltexte (also
gpg4win-x.y.z.tar.bz2) mit weitergegeben werden und auf die die GNU
GPL hingewiesen wird, ist die Weitergabe fast immer möglich.

Zur Übersicht folgt eine Liste der Copyright Erklärungen.


!PKG-COPYRIGHT!


*** Ende der Datei ***

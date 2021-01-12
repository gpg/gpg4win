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

- GpgOL: Ein kritischer Fehler der seit Gpg4win-3.1.12 existierte
  wurde behoben bei der Auswahl von "Kein Schlüssel" für einen
  Empfänger konnte es dazu kommen das an beliebige Schlüssel
  verschlüsselt wurde. (T5223)

- GpgOL: auto-key-retrieve in der GnuPG Konfiguration führt nun
  nicht mehr zu "Keine Daten" Fehlern beim betrachten signierter
  Mails. (T5164)

- GpgOL: Der Fehler "Keine Daten" wird nun besser behandelt und
  zeigt hilfreiche Informationen in der Mail-Ansicht. (T5164)

- GpgOL: Der Name für VS-NfD Konformität ist nun in der libkleopatrarc
  konfigurierbar.

- Kleopatra: Der Dialog um neue Schlüssel zu erstellen wurde
  vereinfacht und macht es nun leichter Schlüssel ohne zusätzlichen
  Passphrase Schutz zu erstellen. Dies kann mit der Option
  "enforce-passphrase-constraints" in der gpg-agent Konfiguration
  deaktiviert werden. (T5181)

- Kleopatra: Name und Mailaddresse für neue Schlüssel werden nun über
  Active Directory befüllt wenn diese Information verfügbar ist.
  (T5181)

- Kleopatra: Das erstellen von S/MIME CSRs zu OpenPGP Smartcards
  wurde weiter verbessert. (T5127)

- Kleopatra: Die Unterstützung für Tags in Beglaubigungen wurde
  deutlich verbessert und tags werden nun auch berücksichtigt wenn
  man Schlüssel zur Datei-Verschlüsselung auswählt. (T5174)

- Kleopatra: Das ausführen mit erhöhten Rechten (als Administrator starten)
  wird nun verhindert um zu vermeiden das die Dateirechte im GnuPG
  Datenordner fehlerhaft gesetzt werden. (T5212)

- Klepoatra: Das setzen der initialen SigG PIN für NetKey Karten funktioniert
  nun auch wenn die generelle PIN nicht gesetzt ist. (T5220)

- GnuPG: Es gibt nun eine systemweite Konfigurationsmöglichkeit
  Konfigurationsdateien unter "%ProgramData%\GNU\etc\gnupg" werden
  nun berücksichtigt. Das Format entspricht der Nutzerkonfiguration
  unter "%AppData%\gnupg" mit zusätzlicher Syntax um Optionen zu
  erzwingen und andere zu ignorieren. (T4788)

- GnuPG: OpenPGP Zertifikate können nun automatisch
  über Active Directory bezogen werden.

- GnuPG: Für LDAP Schlüsselserver wird nun ein verbessertes
  Schema verwendet.

- GnuPG: Auf Version 2.2.27 aktualisiert:
  https://lists.gnupg.org/pipermail/gnupg-announce/2021q1/000452.html

  Ankündigung von Version 2.2.26:
  https://lists.gnupg.org/pipermail/gnupg-announce/2020q4/000451.html

3. Hinweise
===========

- GpgOL

  * Crypto E-Mails, die als Anhang weitergeleitet wurden,
    werden nicht verarbeitet.

  * Integrierte Microsoft spezifische OLE Objekte sind nicht
    unterstützt.

  * Als weitere Sprachen sind nur Englisch, Niederländisch
    und Portugiesisch verfügbar.

- Allgemein

  * Für Version planen wir mit GpgOL, optional, in einen stärker
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

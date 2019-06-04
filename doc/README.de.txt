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

- Kleopatra: Die Zertifikats-Ansicht hat nun konfigurierbare Spalten
  und verliert bei einer Aktualisierung nicht länger den Zustand.
  (T4557 T3888 T3604)

- Kleopatra: Der Dialog um Benutzerkennungen hinzuzufügen wurde
  überarbeitet und vereinfacht. (T4139)

- Kleopatra: Die Warnung bei der Suche nach einem Fingerprint
  wurde entfernt und das vorgeschlagene verhalten automatisiert.
  (T4164)

- Kleopatra: Der Dialog um Beglaubigungen anzuzeigen wurde
  verbessert um den Zustand der Beglaubigungen besser anzuzeigen.
  (T4458)

- GpgOL: S/MIME Zertifikate können nun ähnlich wie OpenPGP Keys
  im Adressbuch hinterlegt werden. (T4479)

- GpgOL: Ein möglicher Verlust von Anhängen beim weiterleiten
  von verschlüsselten und unverschlüsselten Mails wurde behoben.
  (T4526)

- GpgOL: Es kann nicht länger passieren das Anhänge mit
  einer Content-ID unsichtbar sind auch wenn diese nicht
  in der Nachricht referenziert werden. (T4203)

- GpgOL: Die Verschlüsselung von Entwürfen als optionales und
  aktuell experimentelles Feature, wurde hinzugefügt. (T4388)

- GpgOL: S/MIME Mails verwenden nun die gleichen Icons wie
  Outlook S/MIME Mails um Verwirrung zu vermeiden. (T4558)

- GpgOL: Das interne Format für S/MIME Nachrichten wurde
  geändert um die Kompatibilität mit anderen Mail-Klienten
  zu verbessern. (T4278 T4553)

- GpgOL: Automatische Verschlüsselung wird nicht mehr ausgelöst
  für Nutzer ohne S/MIME Zertifikate, wenn S/MIME bevorzugt wird.
  (T4483)

- GpgOL: Eine Möglichkeit das S/MIME Mails weiterhin von GpgOL
  behandelt wurden auch wenn S/MIME ausgeschaltet war existiert
  nicht länger. (T3935)

- GpgOL: Der Dialog zur Sicherheits-Bestätigung wurde verbessert
  und behandelt nun Situationen mit mehreren Schlüsseln besser.
  (T4559)

- GpgOL: Mehrere seltene Abstürze die nur auftraten wenn die
  Speicherfehler-Analyse in der Fehlersuche aktiviert war wurden
  behoben.

- GpgOL: Es werden nun einige weitere, fehlerhaft konstruierte,
  Mails von anderen Klienten akzeptiert. (T4552)

- GpgOL, Kleopatra: Eine Timing-Situation die dazu führen
  konnte das das komplette GnuPG-System einfriert wurde
  behoben.

- GnuPG: Auf Version 2.2.16 aktualisiert.
  (Siehe: https://gnupg.org für die Neuigkeiten.)

3. Anmerkungen
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

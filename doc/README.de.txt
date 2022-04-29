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

Gpg4win läuft auf Windows Versionen 7 oder neuer. Inklusive Windows
Server ab Version 2008. Es werden sowohl 32- und 64bit-Systeme unterstützt.
Wird mindestens Windows XP verwendet, können einige Komponenten von
Gpg4win verwendet werden, sie sind allerdings nicht offiziell unterstützt.

Das Outlook-Plugin GpgOL ist kompatibel mit Microsoft Outlook 2010 und späteren
Versionen (sowohl 32 als auch 64bit) und unterstützt E-Mail Transport per SMTP/IMAP
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

--- Accessibility ---

- Kleopatra: OpenPGP und S/MIME Schlüsselerstellung sind nun für
  Barrierefreiheit optimiert. (T5832)

- Kleopatra: Die Tab Leiste für verschiedene Zertifikatsansichten
  ist nun immer sichtbar. (T5841)

- Kleopatra: Die Zertifikatsliste kann nun mit den Pfeiltasten
  navigiert werden, um sie zugänglicher für Tastatureingabe zu machen.
  (T5841)

- Kleopatra: Leere Zellen in der Zertifikatsliste haben nun
  Screenreader spezifische Anmerkungen, damit sie z.B. als: "kein Name"
  oder "keine E-Mail" gelesen werden. (T5841)

- Kleopatra: Schlüsselkennungen und Fingerabdrücke werden nun von
  Screenreadern in Gruppen von vier Zeichen gelesen. (T5841)

- Kleopatra: Der Dateiverschlüsselungsdialog wurde hinsichtlich
  Barrierefreiheit optimiert. (T5845)

- Kleopatra: Der Zertifikatsauswahl-Dialog, welcher aus dem
  Dateiverschlüsseln Dialog aufgerufen werden kann, wurde
  hinsichtlich der Barrierefreiheit optimiert. (T5876)

- Kleopatra: Der Dialog zum Hinzufügen von Benutzerkennungen
  wurde vollständig auf Barrierefreiheit hin überarbeitet.
  (T5916)

--- Features ---

- Kleopatra: Das GnuPG Backend kann jetzt über eine
  Menüoption unter Extras neu gestartet Werden. (T5775)

- Kleopatra: In der erweiterten Schlüsselerstellung weist
  nun ein Tooltip auf den Zweck von Unterschlüsseln hin. (T5781)

- Kleopatra: In den Zertifikatsdetails kann der Fingerprint
  nun einfach ohne Leerzeichen in die Zwischenablage kopiert
  werden. (T5776)

- Kleopatra: Die Smartcard Leser Einstellungen sind nun
  auf einer eigenen Konfigurationsseite. (T5857)

- Kleopatra: Es ist nun möglich den eigenen Schlüssel
  zurückzurufen. (T5859)

- Kleopatra: Der Dialog zum Hinzufügen von Benutzerkennungen
  wurde überarbeitet und akzeptiert nun auch Namen,
  die mit einer Zahl beginnen. (T5916)

- Kleopatra: Es ist nun möglich eine minimale und maximale
  Gültigkeitsdauer für Schlüssel zu konfigurieren. (T5864)

- Kleopatra: Eine falsche Passphrase bei der symmetrischen
  Entschlüsselung zeigt nun false Passphrase an und nicht
  nur fehlerhafter Sitzungsschlüssel. (T5406)

- Kleopatra: Unterstützung für S/MIME Zertifikate auf PKCS#15 Smartcards.

- GpgEX: Es ist nun möglich das Standardkommando über
  die Windows registry zu konfigurieren. (T5915)

- GnuPG: Dreifache Geschwindigkeit beim entschlüsseln großer Dateien.
         (T5820)
    Um diese Verbesserungen voll auszunutzen sollte die Kommandozeile
    verwendet werden.

- GnuPG: Neue Option "--require-compliance" um einen Fehler zu erzeugen
  wenn eine Operation nicht der compliance Einstellung entsprach.

- GnuPG: Tar Archive unterstützen nun längere Dateinamen als MAX_PATH.
  (T5754)

- GnuPG: Unterstützung für GeNUA Smartcards.

- GnuPG: WKD Suche funktioniert nun auch mit DNS Servern welche keine
  SRV Einträge verarbeiten. (T4729)

- GnuPG: Auf Version 2.2.35 aktualisiert.

--- Bug fixes ---

- Kleopatra: Mehrere Stellen, an denen der Name der
  Anwendung klein geschrieben wurde, sind angepasst
  worden. (T5833)

- Kleopatra: Ein Absturz wurde behoben, der auftrat,
  wenn man eine Beglaubigung zurückzurufen versuchte
  ohne einen Schlüssel gewählt zu haben. (T5858)

- Kleopatra: Der Zertifikatsfilter für nicht beglaubigte
  Zertifikate zeigt nun nicht mehr alle invaliden
  Zertifikate an, sondern nur die nicht beglaubigten.
  (T5850)

- Kleopatra: Erzwingen des Schlüsseltyps über die
  Konfiguration erzwingt nun auch korrekte
  Schlüsselverwendungs-Einstellungen. (T5856)

- GpgOL: Eine doppelte Speicherfreigabe wurde behoben,
  die zu Abstürzen hätte führen können. Diese Speicherfreigabe
  war nicht als Sicherheitsproblem ausnutzbar.

- GnuPG: Konfigurationswerte aus der Windows Registry werden nun
  korrekt bei gpgconf --show-configs angezeigt. (T5724)

- GnuPG: Weitere nicht konforme Verschlüsselungsalgorithmen können
  nun im Konformitätsmodus entschlüsselt werden.

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

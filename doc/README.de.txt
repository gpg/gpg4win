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

- Kleopatra: Die Konfiguration von "default-new-key-algo" ist nun
  für ECC Kurven vereinfacht einzutragen. (T5717)

- Kleopatra: Der Assistent für neue Schlüsselpaare kann nun
  konfiguriert werden um erweiterte Einstellungen auszublenden.
  (T5690)

- Kleopatra: Bei der Suche auf Server wird nun auch ein möglicherweise
  vorhandenes Web-Key-Directory (WKD) berücksichtigt. (T5334)

- Kleopatra: Eine neue Einstellung in der Gruppe [Smartcard] mit Name
  "AlwaysSearchCardOnKeyserver" sorgt dafür das Kleopatra beliebige
  Schlüsselserver bei der Suche Zertifikaten für eine Smartcard
  abfragt. (T5735)

- Kleopatra: Weitere Dialoge haben entsprechende Datei-Endungen
  vorausgewählt wenn Dateien gespeichert werden sollen. (T5736)

- Kleopatra: Die Fehlerbehandlung für PKCS#12 Imports wurde
  verbessert. (T5713)

- Kleopatra: Es wird nun eine Information angezeigt wenn Schlüsselserver
  ungültige Antworten liefern. (T5725)

- Kleopatra: Unter Hilfe können nun in GnuPG VS-Desktop weitere
  Dokumente hinterlegt werden.

- Kleopatra: Geheime Unterschlüssel können nun exportiert und importiert
  werden. (T5755)

- Kleopatra: Konfigurations-Elemente die in der globalen Konfiguration
  erzwungen werden sind nun korrekt ausgegraut. (T5791)

- Kleopatra: Die automatische Erkennung neuer Smartcards wurde verbessert.
  (T5782)

- Kleopatra: Die gleichzeitige Konfiguration von OpenPGP und X.509
  Schlüsselservern wurde verbessert. (T5801)

- Kleopatra: Das öffnen von externen links kann nun administrativ
  deaktiviert werden. (T5777)

- Kleopatra: Beim öffnen von Outlook anhängen wird nun der Dokumente
  Ordner des Nutzers vorausgewählt. (T5774)

- Kleopatra: In den Zertifikatsdetails ist es nun unter Beglaubigungen
  möglich alle Zertifikate der Beglaubiger abzurufen. (T5805)

- Kleopatra: Es ist nun möglich die Zertifikate von Beglaubigern automatisch
  bei einem Import abzurufen. Dies wird mit der Einstellung
  "RetrieveSignerKeysAfterImport" in der "Import" Gruppe aktiviert. (T5805)

- GpgEX: Es ist nun möglich das Standardkommando über
  die Windows registry zu konfigurieren. (T5915)

- GnuPG: Große performance Verbesserungen:
         - Verdoppelte Geschwindigkeit beim erstellen von
           detached Signaturen (.sig Dateien).
         - Bis zu fünf mal schnellere Überprüfung von detached
           Signaturen (.sig Dateien).
         - Dreifache Geschwindigkeit beim entschlüsseln großer Dateien.
         - Nahezu doppelte Geschwindigkeit bei AES256.OCB Verschlüsselung.
    Um diese Verbesserungen voll auszunutzen sollte die Kommandozeile
    verwendet werden.

- GnuPG: Neue Option "--require-compliance" um einen Fehler zu erzeugen
  wenn eine Operation nicht der compliance Einstellung entsprach.

- GnuPG: Tar Archive unterstützen nun längere Dateinamen als MAX_PATH.
  (T5754)

- GnuPG: ECDSA wird nun für CRLs und OCSP unterstützt.

- GnuPG: WKD Suche funktioniert nun auch mit DNS Servern welche keine
  SRV Einträge verarbeiten. (T4729)

- GnuPG: Auf Version 2.3.5 aktualisiert. Für all Details siehe:
  https://lists.gnupg.org/pipermail/gnupg-announce/2022q2/000472.html

--- Bug fixes ---

- Kleopatra: Keyserver Konfiguration wird nun automatisch auf den
  Standardwert gesetzt wenn ein leerer Wert eingetragen wrid.
  (T5711)

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

- GpgOL: Es wurde ein Problem behoben das dazu führen konnte das bei
  der erneuten Bearbeitung eines Entwurfs der Entwurf nicht korrekt
  verschlüsselt wurde. Dadurch wurde Klartext zum Exchange
  Server übertragen. (T5564)

- GpgOL: Die Entwurfsverschlüsselung kann nun über die Registry aktiviert
  werden wenn man den Wert "auto" als "draftKey" hinterlegt. (T5564).


- GpgOL: Eine doppelte Speicherfreigabe wurde behoben,
  die zu Abstürzen hätte führen können. Diese Speicherfreigabe
  war nicht als Sicherheitsproblem ausnutzbar.

- GnuPG: Windows Benutzerkonten mit Sonderzeichen im Namen funktionieren
  nun wieder.

- GnuPG: Konfigurationswerte aus der Windows Registry werden nun
  korrekt bei gpgconf --show-configs angezeigt. (T5724)

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

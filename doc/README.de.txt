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

- GpgOL: Verbesserte Behandlung von Mails mit verschlüsseltem
  Betreff. (T4796)

- GpgOL: Die Integration mit Web Key Diensten um öffentl.
  Schlüssel zu veröffentlichen wurde verbessert. (T4839)

- GpgOL: Die Addressbuch Integration ist nun stärker sichtbar.
  (T4874)

- GpgOL: Die Vorauswahl des Signaturschlüssels berücksichtigt
  nun auch Gruppenpostfächer. (T4090)

- GpgOL: Während der Signaturprüfung wird nun eine
  Vorschau angezeigt. (T4944)

- GpgOL: Das Drucken von verschlüsselten Mails funktioniert
  nun auch nach dem Ändern des Druckers. (T4890)

- GpgOL: Die Sicherheitsstufe von Schlüsseln aus einem
  Web Key Directory ist nun korrekterweise Stufe 2.

- GpgOL: Dauerhaftes Entschlüsseln funktioniert nun
  zuverlässiger und sollte nicht mehr zu "No Data" Fehlern
  führen. (T4718)

- GpgOL: Lange Zeilen in "Nur Text" Mails werden nicht
  mehr auf mehrere Zeilen nach dem Entschlüsseln umgebrochen.
  (T4987)

- GpgOL: Anhänge mit Sonderzeichen im Dateinamen die das
  Windows Dateisystem verbietet, können nun verarbeitet
  werden. (T4835)

- GpgOL: Mails mit exakt einem Anhang, ohne Nachricht,
  werden nun korrekt dargestellt.

- GnuPG: Symmetrische Verschlüsselung fragt nun in
  nur einem Dialog nach dem Passwort. (T4971)

- GnuPG: Verbesserter Import von einigen S/MIME
  Zertifikaten. (T4847)

- GnuPG: Basierend auf der D-Trust 3.1 Karte werden
  nun CardOS 5 Karten unterstützt.

- GnuPG: Unterstützung für rsaPSS Signaturen wurde hinzugefügt.
  (T4538)

- GnuPG: Die "Qualität" einer neuen Passphrase wird nun
  nicht mehr falsch dargestellt. (T2103)

- Kleopatra: Das überschreiben von Exports des privaten
  Schlüssels funktioniert nun korrekt. (T4709)

- Kleopatra: Ein Fehler wurde behoben durch den der
  Dateiverschlüsselungsdialog auf Systemen mit hoher
  Auflösung nicht korrekt angezeigt wurde. (T4819)

- Kleopatra: Die Sortierung mehrerer Tabs wurde korrigiert.

- Kleopatra: Die minimale Länge des Namens wurde
  reduziert um besser die nicht lateinische Sprache zu
  unterstützen. (T4745)

- Kleopatra: Der vorgeschlagene Dateiname beim
  Export wurde verbessert um eine Verwechslung zwischen
  privaten und öffentlichen Schlüsseln zu vermeiden.
  (T4995)

- Kleopatra: Authentifizierungs-Schlüssel können nun im
  OpenSSH Format exportiert werden.

- Kleopatra: Markup wird nun automatisch entfernt wenn
  man Daten in den Notizblock kopiert. (T4969)

- Kleopatra: Es wird nun nicht länger "aktualisiere..." als
  Gültigkeit angezeigt wenn man eine Suche auf dem Schlüsselserver
  durchführt. (T4948)

- Gpg4win: Die Datei und URL verknüpfungen mit Kleopatra spalten nun
  korrekt Argumente und potentiell externe Daten wie Dateinamen und
  Such-Parameter.
  Dies verhindert ein Sicherheits-Problem mit dem Kleopatra dazu
  gebracht werden konnte eine Bibliothek von einem Pfad zu laden
  der durch eine nicht escapte URL übergeben wurde.

==============

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

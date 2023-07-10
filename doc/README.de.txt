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

--- General ---

- Okular (GnuPG Edition): Gpg4win wurde um den beliebten Okular PDF Reader
  erweitert.  Diese erste Version gilt zwar noch als experimentell und wird
  noch nicht per default installiert, ermöglicht es aber, Dokumente
  rechtsverbindlich mit den in GnuPG unterstützten S/MIME Zertifikaten und
  Smartcards zu unterschreiben bzw. zu prüfen.
  Die GnuPG Edition von Okular ist zudem darauf optimiert, leichtgewichtig
  zu sein und eine möglichst geringe Angriffsfläche zu bieten. So werden
  beispielsweise keine aktiven Inhalte wie Mediendateien oder JavaScript
  unterstützt. Sie sollte daher in Umgebungen mit hohen
  Sicherheitsanforderungen geeigneter sein als andere PDF Reader.

  Siehe: TODO: Link auf Neuigkeiten.

- GnuPG: Die neue Komponente "keyboxd" wird nun für neue Gpg4win
  Nutzer per Default verwendet.  Keyboxd speichert Zertifikate
  (Public Keys) in einer sqlite Datenbank und hält sie im Speicher.  Der
  daraus resultierende Geschwindigkeitsgewinn kann insbesondere bei
  großen Schlüsselringen hoch sein.

  Experimentierfreudige können auch auf den keyboxd umsteigen, dafür:
  Alle Zertifikate in Kleopatra auswählen und per Rechtsklick exportieren.
  Dann die Datei %APPDATA%\gnupg\common.conf mit dem
  Inhalt "use-keyboxd" (ohne Anführungszeichen) anlegen und Kleopatra neu
  starten. Jetzt die gerade exportierten Zertifikate importieren, um von
  nun an keyboxd zu verwenden.

  Wie immer empfehlen wir natürlich eine Sicherungskopie des %APPDATA%\gnupg
  Verzeichnisses anzulegen, bevor darin Dateien verändert werden.

  Man kann den keyboxd wieder ausschalten, indem man ein "#" dem
  "use-keyboxd" voranstellt und Kleopatra neu startet. Gegebenenfalls
  muss man auch hier vorher die Zertifikate exportieren und nach dem
  Neustart wieder importieren.

- mkportable wurde endgültig entfernt. Unter:
  https://wiki.gnupg.org/Gpg4win/PortableVersion
  ist beschrieben, wie man eine portable Version von Gpg4win erstellt.

--- Features ---

- Kleopatra: Das Ver- und Entschlüsseln von Dateiordnern wurde komplett
  überarbeitet, so dass es nun in Kleopatra etwa genau so schnell ist
  wie auf der Kommandozeile.  Die neue Architektur ist zudem deutlich
  robuster und ermöglicht auch zukünftige Leistungsverbesserungen.
  Auch wurden dadurch mehrere Probleme behoben.  [T5478 T6488 T6499 et.al.]

- Kleopatra: Die Fortschrittsanzeige funktioniert nun auch für sehr große
  Dateien. [T6534]

- Kleopatra: Es ist nun möglich, die Ausgabedateien von Kleopatra
  umzubenennen, wenn eine Datei mit dem gleichen Namen bereits existiert,
  statt nur überschreiben oder abbrechen zu können. [T6372]

- Kleopatra: Es wird nun angeboten, den geheimen Schlüssel auf dem Computer
  zu löschen, wenn er erfolgreich auf eine Smartcard verschoben wurde.
  [T5836]

- Kleopatra: Es wird nun gemeldet, wenn das eigene Zertifikat oder
  Zertifikate von Kommunikationspartnern bald ablaufen.
  Dies ist konfigurierbar und soll helfen, einen Austausch von neuen
  bzw. verlängerten Zertifikaten frühzeitig durchzuführen. [T6452]

- Kleopatra: Der Notizblock verwendet nun auch das letztgewählte
  Signatur- sowie eigene Verschlüsselungs-Zertifikat als Standard.
  Die Werte werden mit der Dateiverschlüsselung geteilt. [T6415]

- Kleopatra: Die Startzeit von Kleopatra wurde etwas verbessert. [T6259]

- Kleopatra: Die vorgeschlagenen Zertifikate in den Eingabefeldern und in
  der Dropdown Auswahl werden nun alphabetisch sortiert. [T6492, T6514]

- Kleopatra: Gesicherte Unterschlüssel können nun über die
  Benutzeroberfläche wiederhergestellt werden, auch wenn sie
  zwischenzeitlich über eine Smartcard genutzt wurden. [T3456, T3391]

- Kleopatra: Für Beglaubigungen von Zertifikaten kann nun eine Standard
  Gültigkeitsdauer konfiguriert werden. [T6452]

- Kleopatra: Beim Verlängern der Gültigkeitsdauer von Zertifikaten
  wird nun der gleiche Zeitraum vorbelegt wie beim Erstellen von Neuen.
  [T6479]

- Kleopatra: Die Standard Gültigkeitsdauer für neue Zertifikate wurde
  von zwei auf drei Jahre erhöht. Dies kann in den Einstellungen geändert
  werden. [T2701]

- GpgOL: Es wird nun auch angeboten, ein OpenPGP Zertifikat zu erstellen,
  falls keins mit dieser Eigenschaft vorhanden und nur Signieren
  ausgewählt ist.[T5869]

- GnuPG: Der PKCS#12 (.p12 Dateien) code wurde umgeschrieben, um die
  Kompatibilität mit anderen PKCS#12 Implementationen zu verbessern.
  [T6536]

- GnuPG: S/MIME Zertifikatsabfragen wurden unter Windows beschleunigt.
  [rG08ff55bd44]

- GnuPG: Die neue Option "ADSK" wurde hinzugefügt, um zu signalisieren,
  dass an mehrere Unterschlüssel gleichzeitig verschlüsselt werden sollte.
  [T6395, https://gnupg.org/blog/20230321-adsk.html]

- GnuPG: Es werden nun mehr Daten als bereits komprimiert erkannt, für welche
  GnuPG dann die interne Kompression automatisch ausschaltet. Dies kann zu
  signifikanten Leistungsverbesserungen führen. [T6332]

--- Bug fixes ---

- Kleopatra: Ein unbeabsichtigter Timeout bei der Erstellung von
  Prüfsummendateien wurde entfernt. Dieser konnte zu unvollständigen
  oder leeren Prüfsummendateien führen. [T6573]

- Kleopatra: Die Gültigkeitsdauer von Unterschlüsseln wird nun auch
  mit verlängert, wenn der Primärschlüssel bereits abgelaufen ist.  Dies
  behebt das Problem, dass augenscheinlich verlängerte Schlüssel nicht mehr
  zum Verschlüsseln verwendet werden konnten. [T6473]

- Kleopatra: Ein seltener Fall, bei dem Schlüssel ohne Signaturfunktion
  zum Signieren angeboten wurden, wurde behoben. [T6456]

- Kleopatra: Einige überflüssige Konfigurationsoptionen wurden entfernt.
  [T6326 T6327]

- Kleopatra: Der Knopf für kontextbasierte Hilfe in der oberen rechten
  Fensterecke wurde entfernt, da er nahezu keine Funktion hatte. [T6318]

- Kleopatra: Das Abbrechen von Dateioperationen sorgt nun zuverlässig dafür,
  dass auch die entsprechenden Hintergrund Operationen abgebrochen werden.
  [T6524]

- Kleopatra: Eine Reihe von Zeichensatzproblemen bei der Anzeige wurde
  behoben, z.B. bei Umlauten aus der GnuPG Ausgabe. [T5960]

- Kleopatra: Eine Ursache für längere Ladedauer der Zertifikatsliste
  beim Start wurde behoben. [T6261]

- Kleopatra: Beim Exportieren eines geheimen Unterschlüssels wird nun bei
  einem Abbruch korrekt abgebrochen und keine Datei ohne den geheimen
  Anteil erstellt. [T5755]

- Kleopatra: Beim Importieren geheimer Schlüssel, die nicht als eigene
  markiert werden sollen, wird nun nicht mehr mehrfach nachgefragt, ob
  es der eigene Schlüssel ist. [T6474]

- GnuPG/Kleopatra: Die Fehlerbehandlung von Dateiberechtigungs- und
  Schreibfehlern wurde grundsätzlich verbessert. [T6528]

- GpgOL: Ein Fehler wurde behoben bei dem Krypto Mails als leer angezeigt
  wurden, wenn Textdarstellung als bevorzugt eingestellt war. [T6357]

- GpgOL: Ein Absturz wurde behoben der auftrat, wenn eine Mail mit einem
  Anhang ohne Dateinamen verschlüsselt werden sollte. [T6546]

- GpgOL: Änderungen an Kategorien und Flaggen werden nun korrekt übernommen,
  wenn diese durchgeführt werden ohne dass die Mail dabei entschlüsselt
  angezeigt wird. [T4127]

- GpgOL: Es wurden zusätzliche Schutzmaßnahmen eingefügt, um zu verhindern,
  das Klartext in einer ganz bestimmten ungewöhnlichen Konfiguration zurück
  zum Server übertragen wird (dd3ff839).

- GnuPG: Die vollständige Liste der Änderungen zwischen GnuPG 2.4.0 in
  Gpg4win-4.1.0 und GnuPG 2.4.3 in Gpg4win-4.2.0 findet sich hier (Englisch):

  2.4.1: https://lists.gnupg.org/pipermail/gnupg-announce/2023q2/000478.html
  2.4.2: https://lists.gnupg.org/pipermail/gnupg-announce/2023q2/000479.html
  2.4.3: https://lists.gnupg.org/pipermail/gnupg-announce/2023q3/000480.html


4. Versionsgeschichte
=====================

Eine aktuelle, deutschsprachige Übersicht der Änderungen finden Sie online
unter: https://www.gpg4win.de/change-history-de.html


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

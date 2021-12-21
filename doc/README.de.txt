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

- Kleopatra: Die Gruppen Konfiguration wurde erweitert so das nun
  Gruppen nun exportiert und importiert werden können. (T5638)

- Kleopatra: Es wird nun die verwendete GnuPG Version im
  "Über Kleopatra" Dialog angezeigt. (T5652)

- Kleopatra: Eine Option wurde hinzugefügt durch die rein
  symmetrische Ve erzwungen werden kann. (T5661)

- Kleopatra: Verwendbare Smartcard-Leser können nun unter Einstellungen
  angezeigt werden. (T5662)

- Kleopatra: Der Hinweis auf aktualisierte Versionen funktioniert nun
  wieder. (T5663)

- Kleopatra: Die Prüfung auf RESTRICTED / VS-NfD Konformität berücksichtigt
  nun die Konfiguration der zugrundeliegenden Bibliotheken. (T5362)

- Kleopatra: Es wurde eine Fehlerbehandlung für Aktionen eingeführt
  die nicht der konfigurierten Konformität entsprechen. (T5653)

- Kleopatra: Die Konfiguration von Schlüsselservern wird nun
  auch angezeigt wenn Sie in dirmngr.conf vorgenommen wird. (T5672)

- Kleopatra: Smartcard-Leser können nun über ein Menü in der GnuPG-System
  Smartcard Konfiguration ausgewählt werden. Dabei werden verfügbare Leser
  angezeigt. (T5666)

- Kleopatra: Bei der Suche nach Zertifikaten über die Zertifikatsliste
  wird nun bei einer folgenden Suche auf einem Server der Suchstring
  schon vorausgefüllt. (T5624)

- Kleopatra: Es können nun sowohl S/MIME als auch OpenPGP Zertifikate
  aus einer einzelnen Datei importiert werden. (T5638)

- Kleopatra: Konfigurations-Seiten können nun individuell versteckt
  werden. (T5689)

- Kleopatra: Der Assistent für neue Schlüsselpaare kann nun
  mit individuellen Platzhaltern und Ablaufdaten vorkonfiguriert
  werden. (T5690 T5708)

- Kleopatra: Es ist nun möglich einen OpenPGP Modus zu konfigurieren
  in dem die meisten Aktionen für S/MIME (CMS) versteckt werden.
  (T5688)

- Kleopatra: Die GnuPG-System Konfiguration wurde leicht
  aufgeräumt. (T5677)

- Kleopatra: Ein Absturz im Zusammenhang mit rekursiven
  Zertifikatsketten wurde behoben. (T5697)

- Kleopatra: Es wird nun der korrekte Pfad für den UIServer Socket
  verwendet

- Kleopatra: Fenster erscheinen nicht mehr im Hintergrund
  wenn Kleopatra nicht das aktive Vordergrund Fenster war.
  (T5533)

- Kleopatra: Die Konfiguration von LDAP Verzeichnisdiensten
  wurde verbessert. (T5465)

- Kleopatra: Es ist nun möglich ein Ablaufdatum für eine
  beglaubigung zu setzen. (T5336)

- Kleopatra: Es ist nun möglich auch das Ablaufdatum von
  unterschlüsseln zu ändern. (T4717)

- Kleopatra: Der standard Schlüsselserver wird nun von GnuPG
  abgefragt. (T5514)

- Kleopatra: Es wird nun aufgefordert das Beglaubigungsvertrauen
  zu setzen wenn man mit einem nicht vertrautem Schlüssel
  eine Beglaubigung durchführt. (T5511)

- Kleopatra: Symmetrische Verschlüsselung ist nun vorausgewählt
  wenn keine Schlüssel vorhanden sind. (T5545)

- Kleopatra: Jede Aktion im Verschlüsselungs-Dialog hat nun
  einen Keyboard-Shortcut. (T5544)

- Kleopatra: Die Barrierefreiheit, besonders für Verschlüsselung
  wurde stark verbessert. (T5535)

- GpgOL: Inhalte werden nun angezeigt wenn die Präferenz
  von reinen Text Mails über Gruppen-Richtlinien gesetzt wird.
  (T5681)

- Pinentry: Symmetrische Passwörter werden nun formatiert
  angezeigt wenn die entsprechende Option
  "pinentry-formatted-passphrase" im gpg-agent
  gesetzt wurde. (T5517)

- Pinentry: Es ist nun möglich sichere Passwörter für
  die symmetrische Verschlüsselung über den gpg-agent
  zu generieren. (T5517)

- Pinentry: Es ist jetzt möglich angepasste Hilfe Texte
  zu hinterlegen um Passwort-Regeln anzuzeigen. (T5517)

- Pinentry: Passwort Regeln können nun besser geprüft
  werden und ein nicht entsprechendes Passwort wird
  nicht mehr aus der Eingabe gelöscht. (T5532)

- Pinentry: Es wird nun eine Warnung angezeigt wenn
  die Hochstelltaste aktiv ist. (T4950)

- Pinentry: Die Barrierefreiheit des Dialogs wurde
  verbessert so das alle Warnungen und Aktionen gut
  von Screenreadern verarbeitet werden.

- GnuPG: Die Unterstützung für Passwort-Regeln wurde
  verbessert und erlaubt nun auch Sonder-Regeln für
  symmetrische Passwörter.
  (T5517)

- GnuPG: Die Socket Dateien liegen nun unter
  Appdata/Local. (T5537)

- GnuPG: Eine neue, optionale, Konfigurations-Syntax wurde implementiert
  mit der das System dynamisch konfiguriert werden kann. Dabei können
  Variablen aus der Windows Registry gelesen und über Gruppenrichtlinen
  konfiguriert werden.

- GnuPG: Der "PIN-Cache" wird nun korrekter als "Passwort-Cache"
  bezeichnet.

- GnuPG: Die konfigurierten "trusted-key" Optionen können nun
  korrekt geändert werden. (T5685)

- GnuPG: Die Auswahl des Standard Smartcard-Lesers versucht nun
  virtuelle Smartcard-Leser zu ignorieren. (T5644)

- GnuPG: Mit dem Kommando "gpgconf --show-configs" kann nun die
  vollständige Konfiguration des Systems aufgelistet werden.

- GnuPG: Ein neuer, experimenteller Datenbank-Dienst für Zertifikate wurde
    implementiert.  Um diesen zu verwenden kann "use-keyboxd" in die gpg.conf
    und gpgsm.conf hinzugefügt werden. Mit der vewendeten SQlite Datenbank
    werden alle Schlüsseloperationen viel schneller.

- GnuPG: Ein großes Update auf Version 2.3.4.

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

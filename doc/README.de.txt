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

- GpgOL: Krypto-Mails können nun auch verschoben werden wenn
  diese geöffnet sind.

- GpgOL: Nachrichten werden automatisch abgesichert wenn beglaubigte
  Schlüssel / Zertifikate für alle Empfänger gefunden werden konnten.
  Dies kann mit der Option "Nachrichten automatisch absichern"
  abgewählt werden. (T3999)

- GpgOL: Unterstützung für Verteilerlisten wurde hinzugefügt. (T4065)

- GpgOL: S/MIME kann nun bei der automatischen Schlüssel-Auflösung
  bevorzugt werden. (T3961)

- GpgOL: Verschlüsselung sollte Outlook nicht länger einfrieren.
  (T3838)

- GpgOL: Mails welche durch Outlook Ordner Regeln verschoben wurden
  werden nun von GpgOL verarbeitet. (T4070)

- GpgOL: Der Konfigurations-Dialog wurde erneuert um zukünftig besser
  erweitert werden zu können. (T3944)

- GpgOL: Eine Reihe von Speicherfehlern und Stabilitäts-Problemen wurde
  behoben.

- GpgOL: Das erneute verifzieren einer Mail ist nun deutlich schneller.

- GpgOL: Abstürze im Zusammenhang mit den Dateienamen von Anhängen
  wurden behoben. (T4062 T4032)

- GpgOL: Ein Fehler wurde behoben der dazu führen konnte das Anhänge
  nicht korrekt angezeigt wurden.

- GpgOL: Bei der Signaturprüfung wird nun auch "im Auftrag von"
  berücksichtig. (T4110)

- Kleopatra: Diagnoseausgaben werden nun bei Entschlüsselungs-Fehlern
  angeboten.

- Kleopatra: Unterstützung für NetKey v3 Smartcards wurde verbessert.
  (T4080)

- Kleopatra: Es wird nun mit Entschlüsselungs-Fehlern durch fehlenden
  Integritätsschuz sauber umgegangen. (T4038)

- Kleopatra: Die Update-Prüfung kann nun einfacher deaktiviert werden.
  (T4043)

- Kleopatra: Sonderzeichen in der Ausgabe von GnuPG sollten nun
  korrekt dargestellt werden. (T2983)

- Kleopatra: p7m und p7s Dateien werden nun auch mit Kleopatra
  verknüpft. (T3890)

- Kleopatra: Verschiedene kleinere Verbesserungen.
  (T3238 T4078 T3229 T4041)

- Installer: Der Installer schließt nun Anwendungen auch bei der
  stillen Installation. (T4051)

- Installer: Neues, optionales, Modul "Browser Integration" um GnuPG
  als backend für Mailvelope 3.0 zu registrieren.

- GnuPG: Der dirmngr Dienst fragt nun nicht mehr nach einer
  Windows Firewall Regel. (T3610)

- GnuPG: Die Verarbeitung von S/MIME Daten wurde beschleunigt.
  (T4069)

- GnuPG: Aktualisiert auf Version 2.2.10.
  (Siehe: https://lists.gnupg.org/pipermail/gnupg-announce/2018q3/000428.html )


3. Anmerkungen
==============

- GpgOL

  * Crypto E-Mails, die als Anhang weitergeleitet wurden,
    werden nicht verarbeitet.

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

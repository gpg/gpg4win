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
und MS Exchange Server (ab Version 2010). Für die alten Outlook-Versionen
2003 und 2007 wird eine reduzierte Menge an Funktionen angeboten.

(Aktuellste Angaben auf https://www.gpg4win.de/system-requirements-de.html .)



2. Änderungen
=============

Die integrierten Gpg4win-Komponenten in Version !VERSION! sind:

!COMPONENTS!


Neu in Gpg4win Version !VERSION! (!BUILD_ISODATE!)
-----------------------------------------

- GnuPG: Eine von GnuPG verwendete Softwarebibliothek wurde
  aktualisiert um ein Problem zu beheben das zu einer
  Blockade des GnuPG Systems führen konnte. (T3378)

- GpgOL: Weitere augenscheinlich zufällige Abstürze von Outlook
  wurden beseitigt. (T3484)

- GpgOL: Outlook wird nicht mehr blockiert wenn viele Mails
  gleichzeitig ausgewählt werden. (T3433)

- GpgOL: Konten die mit dem G Suite Sync Plugin eingerichtet wurden
  werden nun erkannt. Mit diesen Konten werden bisher nur
  reine ("No-MIME") verschlüsselte PGP Textnachrichten, ohne
  Anhänge, unterstützt.
  Das senden von signierten Nachrichten wird nicht unterstützt.
  Lesen von Krypto Mails ist vollständig unterstützt. (T3545)

- GpgOL: Die Verarbeitung und Fehlerbehandlung von signierten,
  unverschlüsselten Mails wurde verbessert.

- GpgOL: Verschiedene Geschwindigkeits- und
  Leistungs-Verbesserungen.

- GpgOL: Verbesserte Erkennung von großen PGP/MIME Nachrichten und
  MS-TNEF Nachrichten. (T3419 , T3542)

- Kleopatra: Das Passwort Eingabefeld öffnet sich nicht mehr
  teilweise im Hintergrund. (T3460)

- Kleopatra: Das entschlüsseln von Archiven über Partitionsgrenzen
  hinweg funktioniert nun. (T3547)

- Kleopatra: Ein möglicher Absturz in der GpgOL Zertifikatsauswahl
  wurde behoben. (T3544)

- Kleopatra: Die Vorauswahl von verschlüsseln / signieren mit GpgEX
  funktioniert erneut. (T3543)

- Kleopatra: Web Key Directories werden nun bei der
  Dateiverschlüsselung unterstützt. (T3548)

- Kleopatra: Ein Absturz bei der Schlüsselsuche auf einem LDAP
  Schlüsselserver wurde behoben. (T3550)


3. Anmerkungen
==============

- GpgOL

  * Es ist nicht möglich E-Mails zu verändern (z.B. sie zu verschieben oder
    Flaggen zu setzen) während diese entschlüsselt betrachtet werden.
    Um dies zu umgehen schließen Sie die entsprechende Mail oder wählen
    Sie ab und modifzieren / verschieben diese dann über Rechtsklick oder
    Drag & Drop.

  * Crypto E-Mails, die als Anhang weitergeleitet wurden,
    werden nicht verarbeitet.

  * Der Zertifikatsauswahldialog öffnet sich teilweise im Hintergrund
    und bedarf insgesamt einer Überarbeitung.

  * Als weitere Sprachen sind nur Englisch und Portugisisch verfügbar.

- Allgemein

  * Für Version 3.1 planen wir eine einfache Möglichkeit, in einen
    automatisierten Modus zu wechseln. Dies würde die folgenden GnuPG-Optionen
    setzen:

        auto-key-locate wkd
        auto-key-retrieve
        trust-model tofu+pgp

    Da das neue Vertrauensmodell noch nicht vollständig in Kleopatra behandelt
    wird (insbesondere bezüglich Dateisignaturen), sind diese Optionen noch
    nicht voreingestellt.

    Sie können sie jedoch manuell in der gpg.conf setzen. Das neue
    Vertrauensmodell wird von GpgOL bereits unterstützt.

- GpgOL für Outlook 2003 und 2007

  Die Unterstützung von Outlook 2003 und 2007 ist veraltet
  und wird in einer zukünftigen Version vollständig entfernt werden.

  * Nur für Outlook 2003/2007:
    Sie sollten unbedingt vor der Installation von GpgOL
    Sicherheitskopien Ihrer alten verschlüsselten/signierten E-Mails
    erstellen, z.B. in PST-Dateien!

  * Nur für Outlook 2003/2007:
    Senden von signierten oder verschlüsselten Nachrichten über ein
    Exchange-basiertes Konto funktioniert nicht.
    (Hinweis: Beim Verwenden von SMTP sollte das Senden
     mit GpgOL funktionieren. Oder Sie nutzen GpgOL mit Outlook
    2010 oder neuer.)

  * Nur für Outlook 2003/2007:
    Verschlüsselte E-Mails unverschlüsselt auf E-Mail-Server:
    Es kann vorkommen, dass Teile von verschlüsselten E-Mails
    in entschlüsselter/unverschlüsselter Form auf dem E-Mail-Server
    (IMAP oder MAPI) zu liegen kommen, wenn man sie erstellt/liest.
    Betroffen sind nur der Inhalt des Anzeigefensters von Outlook,
    also der "E-Mail-Body". Anhänge sind nicht betroffen.
    Schaltet man die Voransicht von Outlook ab, so
    verringert sich die Wahrscheinlichkeit dafür deutlich,
    aber es kann trotzdem noch passieren. (Wenn Ihnen das Sorge bereitet:
    nutzen Sie GpgOl mit Outlook 2010 oder neuer.)


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

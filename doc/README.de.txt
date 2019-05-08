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

- Gpg4win-3.1.7 ist eine kleine Aktualisierung von 3.1.6 um
  neu eingeführten Fehler in Kleopatra und GPA zu beheben. Im
  folgenden die Änderungen aus 3.1.6:

- Kleopatra: Ein Fehler wurde behoben der dazu führen
  konnte das Kleopatra fehlerhafte TAR Archive erstellte. (T4332)
  Mehr Informationen für betroffene:
  https://wiki.gnupg.org/TroubleShooting#Restoring_corrupted_Archives_created_by_Kleopatra

- Kleopatra: Beim Import aus X509 Verzeichnis-Diensten
  werden nun auch trusted-certs berücksichtigt. (T4269)

- Kleopatra: Das sichern geheimer Schlüssel wurde
  vereinfacht. (T4089)

- Kleopatra: Es ist nun möglich Schlüssel ohne
  Signaturfunktion zu erstellen. (T4373)

- Kleopatra: Startet nun etwas schneller.

- Kleopatra: Schlüssel können nun wieder auf OpenPGP
  Smartcards erstellt werden. (T4428)

- Kleopatra: Zeigt nun den verschlüsselten, eingebetteten,
  Dateinamen an falls dieser vom richtigen Namen abweicht.

- Kleopatra, GnuPG: Geheime Schlüssel die von Symantec PGP Desktop
  exportiert wurden können nun direkt importiert werden. (T4392)

- Pinentry: Ein Problem das dazu führen konnte das Pinentry
  in manchen, minimalen, Installationen nicht startete
  wurde behoben. (T4347)

- GPA: Ein Fehler beim erstellen neuer Schlüssel wurde behoben.
  (T4265)

- GpgOL: Das Kontextmenü von Krypto-Mails erlaubt es nun
  Nachrichten dauerhaft zu entschlüsseln. (T3895)

- GpgOL: Das weiterleiten von selbst versendeten Krypto-Mails
  funktioniert nun. (T4321)

- GpgOL: Das erkennen von S/MIME Mails wurde verbessert.
  Insbesondere beim Versand von Exchange zu Exchange.
  (T4262 T3935)

- GpgOL: Es werden nun Diagnose-Ausgaben angezeigt falls
  das signieren / verschlüsseln fehlschlägt. (T4435)

- GpgOL: Ein Absturz der mit aktivierter Speicheranalyse
  auftreten konnte wurde beseitigt. (T4262)

- GpgOL: Mit der neuen Option "Alle in Mails enthaltene Schlüssel
  importieren" importiert GpgOL Schlüssel aus Mail Headern und
  anhängen. (T4432)

- GpgOL: Die Option um Mails automatisch abzusichern kann
  nun modifiziert werden das auch nicht vertrauenswürdige
  Schlüssel berücksichtigt werden. (T4432)

- GpgOL: Ein verschlüsselter Betreff (z.B. von Enigmail) wird
  nun nach dem entschlüsseln angezeigt. (T4433)

- GpgOL: Es werden nun beschreibende Namen für die OpenPGP
  MIME-Teile verwendet. (T4258)

- GpgOL: Es existiert nun eine Programmierschnittstelle
  um GpgOL von anderen Addins oder Programmen heraus
  anzusprechen damit diese mit Krypto-Mails arbeiten
  können die GpgOL sonst blockieren würde.
  (T4241)

- GpgOL: Es wird nun eine Warnung angezeigt wenn GpgOL
  einen Anhang in einem Outlook internen Format, etwa
  einen Termin, nicht abbilden kann. (T4184)

- GnuPG: Ein Problem das "dirmngr" auf manchen Systemen
  nicht gestartet werden konnte ist behoben. (T3381)

- GnuPG: Auf Version 2.2.15 aktualisiert.
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

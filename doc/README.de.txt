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

- GpgOL: Es werden nun auch Outlook Elemente, wie etwa weitergeleitete
  Mails oder Kontakte und Termine in Krypo Mails unterstützt. (T4184)

- GpgOL: Die Warnung zu "Widersprüchlichen Krypto Einstellungen"
  ignoriert nun undokumentierte Werte von Outlook. (T5335)

- Kleopatra: Das neue Feature "Gruppen" erlaubt es, Gruppen zu
  definieren, die dann bei der Empfänger-Auswahl als Ganzes
  ausgewählt werden können. (T5175 T5241)

- Kleopatra: Verschlüsseln funktioniert nun auch wieder mit
  Windows Netzwerkpfaden. (T5216)

- Kleopatra: Die Prüfung ob Kleopatra mit erhöhten Rechten
  ausgeführt wird, führt nur noch zu einer Warnung und nicht
  mehr zu einem Fehler. (T5248)

- Kleopatra: Das gleichzeitige Exportieren von S/MIME und
  OpenPGP Zertifikaten wurde vereinfacht. (T5002)

- Kleopatra: Die Suche zeigt nicht länger alle Ergebnisse als
  "nicht beglaubigt" an. (T5388)

- Kleopatra: Neue Unterstützung für weitere CardOS Smartcards.
  (T4876)

- Kleopatra: Zertifikate werden nun passend zur eingesteckten
  Smartcard von einem konfigurieren Active Directory bzw. LDAP
  Server geladen. (T4876)

- Kleopatra: Bei der Beglaubigung kann man nun festlegen, dass
  ein Zertifikat vertrauenswürdige Beglaubigungen für eine bestimmte
  Domäne ausstellen darf. So kann man eine Infrastruktur etablieren,
  bei denen die Verantwortlichkeit für eine Domäne delegiert wird.
  (T5245)

- Kleopatra: Die Benutzbarkeit der Smartcard Ansicht wurde
  weiter verbessert. (T4876)

- Kleopatra: Komplexe LDAP Schlüsselserver Einträge können nun
  eingegeben werden ohne das es zu Syntax Fehlern kommt. (T5404)

- Kleopatra: Sehr große Archive führen nun nicht länger zu einem
  Absturz von Kleopatra. (T5475)

- Kleopatra: Das Entschlüsseln von Archiven wurde beschleunigt.
  (T5478)

- Kleopatra: Verschlüsseln von Ordnern mit Dateien, die größer
  als 4GB sind, führt nun nicht mehr zu fehlerhaften Archiven.
  (T5478)

- Kleopatra: Die Suche in LDAP / Active Directory kann nun mehr
  als einen Schlüssel anzeigen und zeigt die korrekten Details.
  (T5441)

- GnuPG: OpenPGP Schlüssel aus dem LDAP werden nun mit
  Beglaubigungen importiert. (T5387)

- GnuPG: Dateien die mit S/MIME (CMS) aber nur mit Passwort
  verschlüsselt wurden, können nun entschlüsselt werden.

- GnuPG: Sonderzeichen auf der Kommandozeile werden nun erneut
  gehandhabt. (T4398)

- GnuPG: Auf Version 2.2.28 aktualisiert:
  https://lists.gnupg.org/pipermail/gnupg-announce/2021q2/000460.html


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

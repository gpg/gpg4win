;; README.de.txt                             -*- coding: latin-1; -*-
;; This is the README installed with Gpg4win (German version).  Lines
;; with a ; in the first column are considered a comment and not
;; included in the actually installed version.  Certain keywords are
;; replaced by the Makefile; those words are enclosed by exclamation
;; marks.

                  Deutsche README Datei für Gpg4win
                  =================================
!BETA-WARNING!
Dies ist Gpg4win, Version !VERSION! (!BUILD_ISODATE!).

Inhalt:

     1. Wichtige Hinweise
     2. Änderungen
     3. Bekannte Probleme (und Abhilfen)
     4. Installation
     5. Versionshistorie
     6. Versionsnummern der einzelnen Programmteile
     7. Rechtliche Hinweise


1. Wichtige Hinweise
====================

Hilfe bei der Installation und Benutzung von Gpg4win bietet Ihnen das
Gpg4win-Kompendium. Sie finden es nach der Installation im
Gpg4win-Startmenü unter 'Dokumentation' oder direkt online unter:
http://www.gpg4win.de/doc/de/gpg4win-compendium.html

Bitte lesen Sie den Abschnitt "3. Bekannte Probleme (und Abhilfen)"
dieses READMEs, bevor Sie beginnen Gpg4win zu nutzen.

Gpg4win unterstützt folgende Plattformen:

  * Betriebssystem: Windows XP und neuere Versionen (für alle: 32/64 bit)

  * MS Outlook: 2003, 2007, 2010, 2013, 2016 (2010 und spätere auch in 64bit)


2. Änderungen
=============

Die integrierten Gpg4win-Komponenten in Version !VERSION! sind:

!COMPONENTS!


Neu in Gpg4win Version !VERSION! (!BUILD_ISODATE!)
-----------------------------------------

- Die Kryptographie Bibliothek libgcrypt wurde auf Version 1.7.8
  aktualisiert um einen möglichen Seitenkanalangriff zu beheben.
  [CVE-2017-7526] Details (englisch):
  https://lists.gnupg.org/pipermail/gnupg-announce/2017q2/000408.html

- Verwendete Software Bibliotheken wurden aktualisiert.

- GPA wurde auf die Version 0.9.10 aktualisiert. Dies beinhaltet
  eine Fehlerkorrektur für den Umgang mit Dateinamen die besondere
  Zeichen enthalten.

3. Bekannte Probleme (und Abhilfen)
===================================

- Smartcard-Nutzung mit Kleopatra

   Die Einrichtung von Smartcards unter Kleopatra ist derzeit noch
   nicht vollständig möglich. Bitte führen Sie folgende Schritte
   einmalig durch, um Ihre Smartcard anschließend unter Kleopatra
   nutzen zu können.

   * OpenPGP Karte
     Verwenden Sie das gpg-Kommandozeilen-Werkzeug, um ein neues
     OpenPGP-Zertifikat auf Ihrer Karte zu erzeugen (a) oder Ihr
     vohandenes Zertifikat von Ihrer Karte zu aktivieren (b):

     (a) Neues Zertifikat erzeugen
       - Karte einlegen.
       - Führen Sie "gpg --card-edit" auf der Kommandozeile aus.
       - Wechseln Sie in den Admin-Modus mit "admin".
       - Geben Sie "generate" ein und folgen Sie den Anweisungen, um
         ein neues Zertifiakt zu erzeugen.

     (b) Vorhandenes Zertifikat von der Karte aktivieren
       - Das (zu der Karte) zugehörige öffentliche Zertifikat
         importieren (z.B. von einem Zertifikatsserver oder von einer
         vorher exportierten Zertifikatsdatei).
       - Karte einlegen.
       - Führen Sie "gpg --card-status" auf der Kommandozeile aus.

   * X.509 Telesec Netkey 3 Karte
     Verwenden Sie Kleopatra, um Ihre Karte (einmalig) zu initialisieren:
     - Karte einlegen.
     - Auf das blinkende Kleopatra-Smartcard-Systemtray-Icon klicken
       (oder direkt das Systemtray-Kontextmenü "Smartcard" und dort
       den "LearnCard"-Eintrag aufrufen).

   Anschließend wird Ihr OpenPGP- bzw. X.509-Smartcard-Zertifikat in
   Kleopatra unter dem Reiter "Meine Zertifikate" angezeigt (markiert
   mit einem Smartcard-Icon).

- Verwendung der Outlook-Programmerweiterung "GpgOL":

  * Sie sollten unbedingt vor der Installation von GpgOL
    Sicherheitskopien Ihrer alten verschlüsselten/signierten E-Mails
    erstellen, z.B. in PST-Dateien!

  * Nur für Outlook 2003/2007:
    Senden von signierten oder verschlüsselten Nachrichten über ein
    Exchange-basiertes Konto funktioniert nicht.
    [siehe https://bugs.g10code.com/gnupg/issue1102]
    (Hinweis: Beim Verwenden von SMTP sollte das Senden
     mit GpgOL funktionieren. Oder Sie nutzen GpgOL mit Outlook
    2010/2013.)

  * Nur für Outlook 2003/2007:
    Verschlüsselte E-Mails unverschlüsselt auf E-Mail-Server:
    Es kann vorkommen, dass Teile von verschlüsselten E-Mails
    in entschlüsselter/unverschlüsselter Form auf dem E-Mail-Server
    (IMAP oder MAPI) zu liegen kommen, wenn man sie erstellt/liest.
    Betroffen sind nur der Inhalt des Anzeigefensters von Outlook,
    also der "E-Mail-Body".  Anhänge sind nicht betroffen.
    Schaltet man die Voransicht von Outlook ab, so
    verringert sich die Wahrscheinlichkeit dafür deutlich,
    aber es kann trotzdem noch passieren. Oder Sie nutzen GpgOl mit
    Outlook 2010/2013.


4. Installation
===============

Eine Anleitung zur Installation von Gpg4win finden Sie im Gpg4win-Kompendium:
http://www.gpg4win.de/doc/de/gpg4win-compendium_11.html

Hinweise zur automatisierten Installation (ohne Benutzerdialoge)
finden Sie im Anhang des Gpg4win-Komendiums:
http://www.gpg4win.de/doc/de/gpg4win-compendium_35.html


5. Versionsgeschichte
=====================

Eine aktuelle deutschsprachige Übersicht der Änderungen finden Sie online
unter: http://www.gpg4win.de/change-history-de.html
Im weiteren finden Sie die Einträge aus der englischen NEWS-Datei:

!NEWSFILE!


6. Versionsnummern der einzelnen Programmteile
==============================================

Zur Übersicht sind hier die Prüfsummen sowie die Namen der einzelnen
Bestandteile aufgelistet.

!VERSIONINFO!


7. Rechtliche Hinweise zu den einzelnen Bestandteilen der Software
==================================================================

Gpg4win besteht aus einer ganzen Reihe von unabhängig entwickelten
Packeten, die teilweise unterschiedliche Lizenzen haben.  Der Großteil
dieser Software ist, wie Gpg4win selbst, steht unter der GNU General
Public License (GNU GPL).  Gemeinsam ist, dass die Software ohne
Restriktionen benutzt werden kann, verändert werden darf und
Änderungen weitergeben dürfen.  Wenn die Quelltexte (also
gpg4win-x.y.z.tar.bz2) mit weitergegeben werden und auf die die GNU
GPL hingewiesen wird, ist die Weitergabe in jedem Fall möglich.

Zur Übersicht folgt eine Liste der Copyright Erklärungen.


!PKG-COPYRIGHT!




Viel Erfolg,

  Ihr Gpg4win Team


*** Ende der Datei ***

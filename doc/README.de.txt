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

- Es wird nun die moderne 2.2 Variante von GnuPG verwendet. Unter:
  https://www.gnupg.org/faq/whats-new-in-2.1.html (englisch)
  finden sich mehr details dazu.

- Die 64bit variante von Outlook wird nun von GpgOL unterstützt.

- GpgOL für Outlook 2010 und spätere Versionen verwendet nun
  schaltknöpfe zur Auswahl ob eine Mail verschlüsselt und oder
  signiert sein soll. Die operation erfolgt während des versendens,
  dabei werden auch alle Anhänge mitverschlüsselt und ein
  standartisiertes Format (MIME) verwendet.

- GpgOL für Outlook 2010 und spätere Versionen entschlüsselt nun
  wieder automatisch Mails.

- Alle 68 KDE übersetzungen von Kleopatra werden nun mit Gpg4win
  installiert.

- Kleopatra verwendet ein aktualisertes Icon Set.

- Kleopatra zeigt nun die verwendete Kurve für ECC Schlüssel in den
  Technischen Details an.

- Die von Kleopatra verwendeten Programmbibliotheken wurden aktualisiert.

- Ausführbare Anwendungen werden nun im bin unterordner abgelegt. Die
  hilfsanwendungen DBus und kbuildsycoca werden nicht mehr benötigt.
  Dies löst eine Reihe von Kleopatra startproblemen die bei Manchen
  Anwendern aufgetreten sind.

- Nach dem import eines geheimen Schlüssels bietet Kleopatra nun gleich
  an diesen einen eignen Schlüssel zu markieren. (Inhabervertrauen)

- Kleopatra bietet nun in den Erweiterten Optionen bei der
  Schlüsselerstellung an ECC Schlüssel zu erstellen.

- Kleopatra bietet nun die Option einen Privaten Schlüssel mit Paperkey zu drucken.

- Es ist nun auch möglich über Kleopatras Dateimenü Ordner zu verschlüsseln.

- GPA und Kleopatra werden nun als Anwendungen für OpenPGP und S/MIME Dateiendungen in
  Windows registriert.

- Der Dateiverschlüsselungsdialog von Kleopatra wurde neu Entworfen um weniger
  Schritte zu enthalten und die Nutzererfahrung zu verbessern.

- Kleopatra erkennt nun automatisch um welche Dateiart es sich handelt und startet
  die entsprechende Aktion (z.B. entschlüsseln) automatisch.

- Symmetrische (nur mit Passwort) verschlüsselung kann nun auch über Kleopatra
  durchgeführt werden und mit Public-Key-Verschlüsselung kombiniert werden.

- Pinentry erlaubt es nun die eingegebene Passprhase anzuzeigen.

- Kleopatra unterstützt nun OpenPGP Smartcards.

- GpgOL für Outlook 2010 und spätere Versionen hat ein neues
  Benutzerinterface um den Crypostatus direkt im Mailfenster
  anzuzeigen.

- GnuPG unterstützt nun https und verwendet standardmässig den
  https sks-keyserver pool.

- GpgOL unterstützt nun das senden und empfangen von HTML Mails

- Kleopatra hat nun verbesserte Nachrichten beim überprüfen von
  Dateien.

- Kleopatra erlaubt es einem nun direkt fehlendene Zertifikate
  beim Dateiüberprüfen zu importieren.

- Viele Fehlerbehebungen und kleinere verbesserungen.

3. Anmerkungen
==============

- Allgemein

  * Für Version 3.0 planen wir eine einfache möglichkeit zu bieten in einen
    automatisierten Modus zu wechseln. Dies wird die folgenden GnuPG Optionen
    setzen:

        auto-key-locate wkd
        auto-key-retrieve
        trust-model tofu+pgp

    Da das neue Vertrauensmodell noch nicht so wie wir uns das wünschen in
    Kleopatra behandelt wird (insbesondere bezüglich Dateisignaturen) wird
    dies noch nicht angeboten.

    Sie können die Optionen manuell in der gpg.conf setzen. Das neue
    vertrauensmodell wird von GpgOL bereits unterstützt.

- Kleopatra

  * Netkey Smartcards werden noch nicht von der neuen Smartcard ansicht
  unterstützt.

- GpgOL

  * Es ist nicht möglich mails zu verändern (z.B. sie zu verschieben oder
    Flaggen zu setzen) während diese entschlüsselt betrachtet werden.
    Um dies zu umgehen schließen Sie die entsprechende Mail oder wählen
    Sie ab und modifzieren / verschieben diese dann über Rechtsklick oder
    Drag & Drop.

  * Crypto mails die als Anhang weitergeleitet wurden werden nicht verarbeitet.

  * Der Zertifikatsauswahldialog öffnet sich teilweise im Hintergrund und bedarf
    insgesamt einer Überarbeitung.

  * Outlook 2003 und 2007 support is abgekündigt und wird in einer Zukunftigen
    Version vollständig entfernt werden.

- GpgOL für Outlook 2003 und 2007

  Outlook 2003 und 2007 support is abgekündigt und wird in einer Zukunftige
  Version vollständig entfernt werden.

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

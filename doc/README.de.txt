;; README.de.txt                             -*- coding: latin-1; -*-
;; This is the README installed with Gpg4win (German version).  Lines
;; with a ; in the first column are considered a comment and not
;; included in the actually installed version.  Certain keywords are
;; replaced by the Makefile; those words are enclosed by exclamation
;; marks.

                  Deutsche README Datei für Gpg4win
                  =================================

Dies ist Gpg4win, Version !VERSION!.

Inhalt:

     1. Wichtige Hinweise
     2. Änderungen
     3. Bekannte Probleme (und Abhilfe)
     4. Versionshistorie
     5. Versionsnummern der einzelnen Programmteile
     6. Installer Optionen
     7. Rechtliche Hinweise


1. Wichtige Hinweise
====================

Hilfe bei der Benutzung von Gpg4win bietet Ihnen das
Gpg4win-Kompendium. Sie finden es nach der Installation von
Gpg4win2 im Gpg4win-Startmenü unter 'Dokumentation' oder
(in aktueller Fassung) direkt online unter http://www.gpg4win.de.

Falls Sie eine ältere Version von Gpg4win benutzt haben, beachten Sie
bitte die Migrationshinweise im Anhang des Gpg4win-Kompendiums.

Bitte lesen Sie den Abschnitt "Bekannte Probleme", bevor Sie damit
beginnen Gpg4win zu nutzen.


2. Änderungen
=============

Gpg4win2 bringt große Änderungen im Vergleich zu Gpg4win 1.x mit
sich. Nachstehend die wichtigsten Änderungen:

- Kleopatra ist der neue Zertifikatsmanager.  Kleopatra ist der
  bisherige S/MIME Zertifikatsmanager von KDE (eine auf vielen
  GNU/Linux-Systemen benutzte Arbeitsumgebung).  Für die Verwendung
  in Gpg4win ist Kleopatra um die Unterstützung von OpenPGP und eine
  vereinheitlichte grafische Oberfläche für alle kryptografischen 
  Operationen erweitert worden.  Kleopatra läuft in der Regel
  permanent als Dienst (siehe Icon im System-Tray), sobald dessen
  Dienste einmal im Verlauf der Sitzung abgefragt wurden.
  Die Funktionalitäten von WinPT werden nun durch Kleopatra
  abgedeckt. WinPT wurde aus Gpg4win2 entfernt.

- GpgEX ist die neue Programmerweiterung für den Microsoft Explorer
  und ersetzt GpgEE.

- Das E-Mail-Programm Claws Mail wurde auf eine modernere Version
  aktualisiert und unterstützt nun SSL, NNTP und IMAP.

- GpgOL, die Programmerweiterung für Outlook 2003 und 2007, wurde
  umfassend überarbeitet.  Es unterstützt nun PGP/MIME und macht
  damit die Verwendung von verschlüsselten und signierten Anhängen
  viel einfacher und standardkonformer.  Die Unterstützung von S/MIME
  wurde ergänzt.  Für die grafischen Benutzerdialoge aller Krypto-
  Operationen wird nun Kleopatra verwendet.

- Das "Gpg4win-Kompendium" ist die neue deutschsprachige Dokumentation
  zu Gpg4win. Es vereinigt die alten Handbücher "Einsteiger" und
  "Durchblicker".  Desweiteren wurden sämtliche Kapitel für Gpg4win
  Version 2.0 aktualisiert, also unter anderem angepasst auf
  Kleopatra, GpgEX und PGP/MIME sowie ergänzt um S/MIME bzw. X.509.

- Unterstützung folgender Plattformen:
  Betriebssystem: Windows 2000, XP (32/64), Vista (32/64)
  MS Outlook: 2003, 2007


Kurzübersicht zu Änderungen gegenüber Version 2.0.2:
----------------------------------------------------
- Pinentry:
  * Voreinstellung umgestellt: zurück von QT4 auf GTK 
    (Grund: 2.0.2 hat Probleme mit pinentry-qt4;
    siehe https://issues.kolab.org/issue4378)

- GnuPG-Backend:
  * "is-socket-patch" gegen gpgme 1.2.0 
    (siehe https://issues.kolab.org/issue4302)

- Gpg4win-Kompendium:
  * Die finale 3.0.0 Version des Kompendiums ist integriert.

- Die integrierten Gpg4win-Komponenten sind:
    GnuPG:        2.0.14
    Kleopatra:    2.0.14-svn1098530 (20100303)
    GPA:          0.9.0
    GpgOL:        1.1.1
    GpgEX:        0.9.5
    Claws-Mail:   3.7.4cvs1
    Kompendium:   3.0.0


Kurzübersicht zu Änderungen gegenüber Version 2.0.1:
----------------------------------------------------
- Kleopatra:
  * Zertifikatserzeugungsdialog für OpenPGP und X.509 verbessert
  * Zertifikatsauswahldialog beim Signieren/Verschlüsseln wird nur noch im 
    Konfliktfall angezeigt ("Viel-Benutzer-Modus")
  * Ergebnisdialog für Signieren/Verschlüsseln in einem Dialog zusammengefasst
  * Datei-Krypto-Operationen mit GpgEX stabilisiert
  * SmartCard-Unterstützung für NetKey-Karten verbessert
  * Rekursives signieren/verschlüsseln von Dateien/Ordnern grundsätzlich 
    möglich; Bedingung: externes Archiv-Werkzeug nötig (Konfiguration siehe 
    Punkt 3 dieser README)
  * neues deutschsprachiges Handbuch für Kleopatra
  * neue Oxygen-Icons
  * diverse kleinere Stabilitäts- und GUI-Verbesserungen

- GpgOL:
  * verbesserter Symbol-Lademechanismus
  * neue Icons (nun auch für Nachrichtenliste)

- Pinentry:
  * Voreinstellung umgestellt: von GTK auf QT4
    (für gpg4win-light-Installer weiterhin GTK aktiv)
  * neue Icons für pinentry-qt4
  * Pinentry-qt4-Dialog erscheint nun immer im Vordergrund

- GnuPG-Backend:
  * Zertifikatserzeugung für OpenPGP/X.509: voreingestellte Schlüssellängen  
    nach Algorithmenkatalogs des BSI angepasst (Default: RSA, 2048 bit);
    außerdem Auswahlliste der Schlüssellängen in Kleopatra aktualisiert

- Installer:
  * neue NSIS-Installer-Grafiken

- Die integrierten Gpg4win-Komponenten sind:
    GnuPG:        2.0.14
    Kleopatra:    2.0.14-svn1098530 (20100303)
    GPA:          0.9.0
    GpgOL:        1.1.1
    GpgEX:        0.9.5
    Claws-Mail:   3.7.4cvs1
    Kompendium:   3.0.0-rc1



3. Bekannte Probleme (und Abhilfe)
==================================

- Smartcard-Nutzung mit Kleopatra

   Die Einrichtung von Smartcards unter Kleopatra ist derzeit noch
   nicht vollständig möglich. Bitte führen Sie folgende Schritte
   einmalig durch, um Ihre Smartcard anschließend unter Kleopatra
   nutzen zu können.

   * OpenPGP Karte
     Verwenden Sie das gpg-Kommandozeilen-Werkzeug, um ein neues
     OpenPGP-Zertifikat auf Ihrer Karte zu erzeugen (a) oder Ihr
     vohandenes Zertifikat von Ihrer Karte zu aktivieren (b):

     (a) Neue Zertifikat erzeugen
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
       (oder direkt das Systemtray-Kontextmenü "Smartcard" aufrufen und dort
        den "LearnCard"-Eintrag aufrufen).

   Anschließend wird Ihr OpenPGP- bzw. X.509-Smartcard-Zertifikat in
   Kleopatra unter dem Reiter "Meine Zertifikate" angezeigt (markiert mit
   einem Smartcard Icon).

   Eine gute (grafische) Alternative ist GPA, um Ihre Karte korrekt zu
   konfigurieren und ggf. Ihre PIN zu ändern. Eine verbesserte
   Smartcard-Unterstützung für Kleopatra ist in Arbeit.

- Verwendung der Outlook-Programmerweiterung "GpgOL":

  * Sie sollten unbedingt Sicherheitskopien Ihrer alten
    verschlüsselten/signierten E-Mails machen; z.B. in PST-Dateien!

  * Verschlüsselte E-Mails unverschlüsselt auf E-Mail-Server:
    Es kann vorkommen, dass Teile von verschlüsselten E-Mails
    in entschlüsselter/unverschlüsselter Form auf dem E-Mail-Server
    (IMAP oder MAPI) zu liegen kommen, wenn man sie erstellt/liest.
    Betroffen sind nur der Inhalt des Anzeigefensters von Outlook,
    also der "E-Mail-Body".  Anhänge sind nicht betroffen.
    Schaltet man die Voransicht von Outlook ab, so
    verringert sich die Wahrscheinlichkeit dafür deutlich,
    aber es kann trotzdem noch passieren.
    Eine Lösung hierfür ist in Arbeit.

  * Senden von signierten oder verschlüsselten Nachrichten über ein
    Exchange basiertes Konto funktioniert nicht.

- Verwendung von GpgEX:

   * Es kann teilweise vorkommen, dass beim Versuch Dateien mit GpgEX
     aus dem Explorer zu signieren/verschlüsseln bzw. zu entschlüsseln/prüfen,
     Kleopatra und das aktive Explorerfenster nicht mehr reagiert.
     Sie sollten Kleopatra dann über den Task-Manager beendet und die
     Datei-Krypto-Opteration nicht über GpgEX sondern direkt über
     Kleopatra (per Datei-Menü) ausführen.

   * Probleme unter Windows x64:
     GpgEX ist eine (32bit) Erweiterung für den (32bit) Windows
     Explorer und läuft _nicht_ in einem 64bit Explorer
     (= voreingestellter Explorer in einem Windows 64bit System).

     Abhilfe: Starten Sie den 32bit Explorer, um GpgEX nutzen zu können.
     Klicken Sie auf "Start" -> "Ausführen" und geben Sie folgenden
     Befehl ein:
        C:\windows\syswow64\explorer.exe /separate
     Beachten Sie, dass Sie ggf. den Pfad zu Ihrer x64-basierten 
     Version von Windows anpassen müssen.
     Dieser separate Aufruf scheint aktuell in Win7/64bit defekt zu sein.

- Dateien signieren/verschlüsseln mit Archiv-Funktion:

   * Die Kleopatra-Funktion zum Signieren/Verschlüsseln 
     mehrerer Dateien als ein Archiv ist derzeit noch nicht 
     voll funktionsfähig und nur zum Testen für erfahrene Nutzer geeignet.
     Es wird ein separates Packprogramm benötigt; die Konfiguration
     des Pack-Befehls muss über die Konfigruationsdatei von Kleopatra erfolgen:
        C:\Programme\GNU\GnuPG\share\config\libkleopatrarc
     Exemplarisch die nötigen Konfigurationszeilen für das Programm
     "7-ZIP" (http://www.7-zip.org):
        [Archive Definition #0]
        Name=TAR (via 7-ZIP)
        id=7zip
        extensions=tar
        pack-command=7z a dummy -ttar -so

4. Versionshistorie
===================

Eine aktuelle deutschsprachige Übersicht der Änderungen finden Sie online
unter http://www.gpg4win.de/change-history-de.html .  Im weiteren
finden Sie die Einträge aus der englischen NEWS Datei:

!NEWSFILE!


5. Versionsnummern der einzelnen Programmteile
==============================================

Zur Übersicht sind hier die Prüfsummen sowie die Namen der einzelnen
Bestandteile aufgelistet.  Sie finden dieselben Informationen auch in
der Datei versioninfo.txt.

!VERSIONINFO!


6. Installer Optionen
=====================

Hinweis: Dies ist eine kurze Zusammenfassung. Beachten Sie bitte
auch die Hinweise zur Automatischen Installation im Anhang des
Gpg4win-Kompendiums.

In einigen Fällen (wie zum Beispiel für Software-Verteilungssysteme)
ist es hilfreich, wenn die Installation von Gpg4win ohne Dialoge
funktioniert, man aber trotzdem vorab alle Installationseinstellungen
bestimmen kann.

Der Standard-Installationspfad kann mit der Option /D=PFAD angegeben
werden, welche als letzte auf der Kommandozeile erscheinen muß.

Der Gpg4win Installer unterstützt die Option /S für automatischen
Ablauf der Installation, und die Option /C=INIFILE, durch welche eine
Steuerungsdatei (Name endet üblicherweise auf .ini) angegeben werden
kann.  Diese Datei sollte genau einen Abschnitt "[gpg4win]"
enthalten, in der absolute Pfade für die zu installierenden
Konfigurationsdateien vorgegeben werden.

Hier ist eine Beispieldatei, die zugleich alle erlaubten
Schlüsselworte zeigt: 

[gpg4win]
  ; Installationseinstellungen. Weg- oder leerlassen für 
  ; Voreinstellung
  inst_gpgol = true
  inst_gpgex = true
  inst_kleopatra = true
  inst_gpa = true
  inst_claws_mail = false
  inst_compendium_de = true
  inst_man_novice_en = true

  ; Die Stellen, an denen Verknüpfungen erzeugt werden sollen.
  inst_start_menu = true
  inst_desktop = false
  inst_quick_launch_bar = false

  ; Im Gegensatz zu den anderen Optionen überschreibt diese Option
  ; die Einstellung des Benutzers im Installationsassistenten.
  inst_start_menu_folder = Gpg4win

  ; Standard-Konfigurationsdateien.
  gpg.conf = D:\config\gpg-site.conf
  gpg-agent.conf = D:\config\gpg-agent-site.conf
  trustlist.txt = D:\config\trustlist-site.txt
  dirmngr.conf = D:\config\dirmngr-site.conf
  dirmngr_ldapserver.conf = D:\config\dirmngr_ldapserver-site.conf
  scdaemon.conf = D:\config\scdaemon-site.txt
  gpa.conf = D:\config\gpa-site.conf

Ein entsprechender Aufruf zur automatischen Installation könnte also
wie folgt aussehen:

gpg4win.exe /S /C=C:\TEMP\gpg4win.ini /D=D:\Programme\Gpg4win

Für den MSI installer gilt entsprechendes, mit folgenden Änderungen:
Automatischer Ablauf wird wie üblich mit der Option /qb- zu msiexec
erreicht.  Die Steuerungsdatei muss gpg4win.ini heißen und im
Systemverzeichnis (C:\WINDOWS) vorliegen.  Der Installationspfad kann
mit dem Eintrag "instdir" festgelegt werden.  Ausserdem können die
Einstellungen auch auf der Kommandozeile mittels INSTDIR=... und
INST_GPA=FALSE etc. angegeben werden (die Steuerungsdatei geht
allerdings vor).  Die Angabe von Standard-Konfigurationsdateien, sowie
die Angabe des Start Menu Verzeichnisses und die optionale Auswahl der
Verknüpfungen wird vom MSI installer momentan nicht unterstützt.


5. Rechtliche Hinweise zu den einzelnen Bestandteilen der Software
==================================================================

Gpw4win besteht aus einer ganzen Reihe von unabhängig entwickelten
Packeten, die teilweise unterschiedliche Lizenzen haben.  Der Großteil
dieser Software ist, wie Gpg4win selbst, steht unter der GNU General
Public License (GNU GPL).  Gemeinsam ist allen, daß die Software ohne
Restriktionen benutzt werden kann, verändert werden darf und
Änderungen weitergeben dürfen.  Wenn die Quelltexte (also
gpg4win-src-x.y.z.exe) mit weitergegeben werden und auf die die GNU
GPL hingewiesen wird, ist die Weitergabe in jedem Fall möglich.

Zur Übersicht folgt eine Liste der Copyright Erklärungen.


!PKG-COPYRIGHT!




Frohes GiPiGien,

  Ihr Gpg4win Team


*** Ende der Datei ***

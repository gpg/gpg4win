Wichtige Informationen zum Einsatz von Gpg4win 1.9-BETA
#######################################################

  Achtung: Dies ist eine BETA-Version von Gpg4win.
  Das bedeutet, dass der Funktionsumfang an einigen
  Stellen nicht vollständig implementiert ist oder auch
  noch Fehler vorliegen können.

  Eine BETA-Version dient dem Test durch erfahrene
  Anwender oder Administratoren um die künftige
  neue Version kennenzulernen und Verbesserungsvorschläge
  einzubringen.

Stand: Gpg4win-1.9.14 (20090303)

Hier finden sich wichtige Informationen die bei der
Entscheidung helfen sollen, ob Gpg4win 1.9 schon für
die individuellen Bedürfnisse ausreicht und einen
Beta-Test sinnvoll erscheinen läßt oder aber ob
Gpg4win 1.9 noch nicht weit genug dafür ist.

Ausserdem wird ein Ausblick gegeben, was mit
Gpg4win 2.0 an neuer Funktionalität zu erwarten ist.
Die 1.9er Versionen sind der Beta-Test-Zyklus. Ist er
abgeschlossen wird Version 2.0 freigegeben.

Änderungsinformationen gegenüber den vorherigen
Beta-Versionen finden sich am Ende dieses Dokumentes.

Hilfe bei der Benutzung von Gpg4win bietet Ihnen
das Gpg4win-Kompendium. Sie finden es nach der
Installation von Gpg4win-1.9.x im Gpg4win-Startmenü
unter 'Dokumentation' oder direkt online unter:

  http://gpg4win.de/handbuecher/gpg4win-compendium-de.html


Rückmeldung erwünscht!
  Bitte lassen Sie uns wissen ob sie Gpg4win 1.9
  erfolgreich getestet haben oder auch ob Sie auch
  Probleme (und welcher Gestalt) Sie getroffen sind.
  Am besten auf der deutschen Anwender Mailing Liste
  einschreiben und Berichte dorthin senden bzw. die
  Berichte der anderen lesen:

  http://lists.wald.intevation.org/mailman/listinfo/gpg4win-users-de


Inhalt dieses Dokumentes:

* Wichtige Hinweise zur vorliegenden Version
* Migration
* Wichtigste Änderungen von Gpg4win 1.9 gegenüber 1.1
* Wichtigste Änderungen von Gpg4win 1.9.14 gegenüber 1.9.13


Wichtige Hinweise zur vorliegenden Version
==========================================

- Installationpaket ca. 45 MByte:
  Das Paket ist noch nicht bzgl. Größe optimiert.
  Es wird angestrebt den Umfang mit der Zeit zu reduzieren.

- Verwendung von Outlook Plugin "GpgOL":

  * Sie sollten unbedingt Sicherheitskopien Ihrer alten
    verschlüsselten/signierten E-Mails machen; z.B. in PST-Dateien!

  * Verschlüsselte E-Mails unverschlüsselt auf E-Mail-Server:
    Es kann vorkommen, dass Teile von verschlüsselten E-Mails
    in entschlüsselter/unverschlüsselter Form auf dem E-Mail-Server
    (IMAP oder MAPI) zu liegen kommen, wenn man sie erstellt/liest.
    Betroffen sind nur der Inhalt des Anzeigefensters von Outlook,
    also der "E-Mail-Body". Anhänge sind nicht betroffen.
    Schaltet man die Voransicht von Outlook ab, so
    verringert sich die Wahrscheinlichkeit dafür deutlich,
    aber es kann trotzdem noch passieren.
    Eine Lösung hierfür ist in Arbeit.


Migration
=========

* Von einer älteren Gpg4win 1.9er Version:

  Ist eine alte Gpg4win-1.9.x Version vorher installiert
  gewesen, deinstallieren Sie diese bitte, bevor Sie die neue
  Gpg4win-Version installieren.

  Starten Sie Ihr System neu, sofern Sie nach der Installation dazu 
  aufgefordert werden. Andernfalls wird es zwangsläufig 
  zu Fehlfunktionen bei Verschlüsselungsoperationen kommen.

* Von einer Gpg4win 1.X  oder sonstigen GnuPG Version:

  Es wird dingend empfohlen zunächst Gpg4win-1.1.3 zu
  deinstallieren bevor anschließend Gpg4win-2.0.0 installiert wird.

  Starten Sie Ihr System neu, sofern Sie nach der Installation dazu 
  aufgefordert werden. Andernfalls wird es zwangsläufig 
  zu Fehlfunktionen bei Verschlüsselungsoperationen kommen.

Beachten Sie auch die Migrationshinweise im Anhang des Gpg4win Kompendiums.


Wichtigste Änderungen von Gpg4win 1.9 gegenüber 1.1
===================================================

Entfallen:
----------

- GpgEE: Dieses Modul wird ersetzt durch GpgEX (siehe unten)

- WinPT: Die Funktionalitäten wird nun durch Kleopatra abgedeckt
  (siehe unten).

- Handbücher "Gpg4win für Einsteiger" und "Gpg4win für Durckblicker":
  Diese werden ersetzt durch das "Gpg4win Kompendium" (siehe unten).

Aktualisiert:
-------------

- Claws Mail: Version 3.7.0
  Wesentliche Neuerungen: Unterstützung von SSL, NNTP und IMAP
  in der Windows-Version von Claws Mail.

- GpgOL: Diese Komponenten wurde am umfassendsten aktualisiert.

  * Wesentliche Neuerungen sind:

    - Unterstützung von OpenPGP/MIME:
      Bisher wurde nur das sog. "inline-PGP" unterstützt. Nun
      können unter anderem auch Anhänge direkt verarbeitet werden.

    - Unterstützung von S/MIME
      GpgOL unterstützt nun das auf X.509 basierende
      E-Mail Verschlüsselungsverfahren S/MIME.

    - Verwendung von Kleopatra für Grafische Benutzerdialoge:
      Anstatt eigene Dialog für die jeweiligen
      Verschlüsselungs-Operationen zu implementieren wird
      Kleopatra verwendet. Kleopatra bietet einheitliche
      Dialoge für Krypto-Operationen.

    - Unterstützung folgender Plattformen:
      Betriebssystem: Windows 2000, XP (32/64), Vista (32/64)
      Outlook: 2003, 2007

Neu:
----

- GpgEX: Das neue Plugin für Microsoft Explorer.

- Kleopatra: Der neue Zertifikatsmanager

  * Kleoaptra ist der bisherige S/MIME Zertifikatsmanager von KDE.
    Er ist zum einen um parallele Unterstützung von OpenPGP erweitert
    worden. Zum anderen fungiert Kleopatra als Grafische Oberfläche
    für sämtliche Kryptografischen Operationen und vereinheitlich
    damit die grafische Benutzerführung.

  * Kleopatra läuft in der Regel permanent als Dienst (siehe
    Icon im System-Tray), sobald dessen Dienste einmal im Verlauf
    der Sitzung abgefragt wurden.

  * Kleopatra ist noch in Entwicklung:
    Es fehlen noch einzelne Funktionalitäten für OpenPGP.
    Dafür kann alternativ auf GPA zurückgegriffen werden.

- Gpg4win Kompendium: Die neue Dokumentation zu Gpg4win.
  Es vereinigt die alten Handbücher "Einsteiger" und "Durchblicker".
  Desweiteren wurden sämtliche Kapitel für Gpg4win Version 2.0
  aktualisiert, also unter anderem angepasst auf Kleopatra, GpgEX und
  PGP/MIME sowie ergänzt um S/MIME bzw. X.509.


Wichtigste Änderungen von Gpg4win 1.9.14 gegenüber 1.9.13
=========================================================
 - Kleopatra:
    * verbesserte Fehlermeldungen und Layout für Dialog
     "BenutzerID hinzufügen"
    * nicht benötigte temporäre Dateiordner werden gelöscht
    * Reiternamen für "Importierte Zertifikate" reduziert
      (mit Pfad im Tooltip)
    * verbessertes Spalten-Verhalten im Hauptfenster (z.B. beim
      Verändern der Breite)
    * Inhabervertrauen: OK-Button deaktiviert solange keine Änderungen
      gemacht werden
    * Hauptfenster: Blendet Reiterleiste aus, wenn nur ein Reiter
      angezeigt wird
    * Datei->Beenden Meldung: "Nur das Fenster" als Voreinstellung gesetzt
    * "Datei->Symbolbenutzungs-Protokoll speichern" wird nur für die
      nächsten ca. 2 Beta-Versionen integriert. Unterstützt beim
      Bestimmen der benötigten KDE-Icons.
    * Zertifikatsimport: Ergebnisdialog nun stets im Vordergrund
    * Kleopatra benötigt beim Starten 75% weniger CPU
    * Kleo-Log-Ausgabe korrigiert
    * Übersetzungen ergänzt / korrigiert
    * diverse kleinere Stabilitäts- und GUI-Verbesserungen

 - GpgOL:
    * signiert/verschlüsselt-Status wird nun auch in "Entwürfe"
      gespeichert
    * im Anhang weitergeleitete E-Mails werden nicht mehr als
      gpgolXXX.dat sondern als *.eml Datei angezeigt
    * beim Verschlüsseln wird intern nun der Absender übergeben
      (Voraussetzung für automatische Verschlüsselung an sich selbst;
      Funktion folgt in nächsten Versionen)
    * Übersetzungen ergänzt / korrigiert

 - Gpg4win Kompendium:
    * weitere Überarbeitungen

 - Backend und Installer:
    * Deinstallation verbessert und Startmenü-Eintrag ergänzt
    * diverse kleinere Verbesserungen

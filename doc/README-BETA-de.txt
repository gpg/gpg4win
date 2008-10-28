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

Stand: Gpg4win-1.9.9 (20081028)

Hier finden sich wichtige Informationen die bei der
Entscheidung helfen sollen, ob Gpg4win 1.9 schon für
die individuellen Bedürfnisse ausreicht und einen
Beta-Test sinnvoll erscheinen läßt oder aber ob
Gpg4win 1.9 noch nicht weit genug dafür ist.

Ausserdem wird ein Ausblick gegeben, was mit
Gpg4win 2.0 an neuer Funktionalität zu erwarten ist.
Die 1.9er Versionen sind der Beta-Test-Zyklus. Ist er
abgeschlossen wird Version 2.0 freigegeben.

Änderungsinformationen gegenüber den Vorherigen
Beta-Versionen finden sich am Ende dieses Dokumentes.

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
* Wichtige Hinweise zur Verwendung von S/MIME
* Migration
* Wichtigste Änderungen von Gpg4win 1.9 gegenüber 1.1
* Wichtigste Änderungen von Gpg4win 1.9.9 gegenüber 1.9.8


Wichtige Hinweise zur vorliegenden Version
==========================================

- Installationpaket ca. 47 MByte:
  Derzeit sind die Programme mit umfangreichen
  Debug-Informationen ausgestattet, so dass bei auftauchen
  eines Fehlers unmittelbar eine Fehleranalyse
  durchgeführt werden kann. Für Version 2.0
  werden diese Debug-Informationen wieder entfernt
  und das Installationpaket deutlich kleiner (knapp 10 MByte,
  eventuell auch weniger).

- An sich selbst verschlüsseln:
  Es ist unbedingt empfehlenswert, dass Sie Ihre verschlüsselten
  OpenPGP- und S/MIME-Emails zusätzlich mit Ihrem Zertifikat
  an sich selbst verschlüsseln. Nur so können Sie diese Nachrichten
  später auch wieder entschlüsseln.
  Dazu in Kleopatra unter "Extras->GnuPG-Backend einrichten..." 
  jeweils in die Textfelder:
  "GPG for S/MIME: Auch an NAME verschlüsseln" und
  "GPG for OpenPGP: Auch an NAME verschlüsseln"
  den Fingerprint Ihres jeweiligen Zertifikates einfügen.

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

  * E-Mails werden auf dem Server in Microsoft-spezifischen
    Formaten gespeichert und können von anderen E-Mail-Programmen
    dann nicht mehr interpretiert und die Inhalte angezeigt werden.
    Eine Migrations-Lösung hierfür ist in Arbeit.


Wichtige Hinweise zur Verwendung von S/MIME
===========================================

S/MIME ist ein für Gpg4win 2.0 neu hinzukommendes
E-Mail Verschlüsselungsverfahren.

Grundsätzlich ist es empfehlenswert sich mit
dem Konzept von S/MIME auseinanderzusetzen bevor
man es einsetzt.

Konfiguration für S/MIME:
Für die Inbetriebnahme sind folgende Schritte
durchzuführen.

- S/MIME für GpgOL einschalten:
  Unter Outlook im Menü Extras->Optionen, Reiter "GpgOL"
  muss S/MIME explizit eingeschaltet werden.
  Beachten Sie den Warnhinweis, der darauf hin erscheint.
  Achtung: In der aktuellen Beta muss S/MIME auch für eine korrete Überprüfung
  einer OpenPGP-Signatur eingeschaltet sein. Dieses Problem ist bekannt
  und an einer Lösung wird gearbeitet.

- Neue S/MIME-Schlüssel herstellen:
  Unter Kleopatra im Menü Datei->Neues Zertifikat wählen Sie
  "X.509" aus. Sie werden mit Hilfe des Assisstenten durch die
  Zertifikatserstellung geleitet.
  Beachten Sie, dass Sie als Ergebnis nur eine Zertifikats-Anfrage
  (p10-Datei) erhalten. Sie müssen diese anschließend an Ihre
  Zertifizierungsstelle weiterleiten, um Ihr neues X.509-Zertifikat
  zu erhalten.

- S/MIME-Zertifikatskette für persönlichen Schlüssel importieren:
  Die zum geheimen Schlüssel zugehörige Zertifikatskette
  als P7C-Datei importieren (Menü Datei->Zertifikate importieren).
  Es werden auch andere Suffixes für solche Dateien verwendet.
  Typischerweise besteht die Kette aus dem Wurzel-Zertifkat,
  einem CA-Zertifikat und dem persönlichen Zertifikat.

- Geheimen S/MIME-Schlüssel importieren:
  Den persönlichen geheimen Schlüssel als P12-Datei
  über Kleopatra importieren (Menü Datei->Zertifikate
  importieren).

- S/MIME-Zertifkate der E-Mail Empfänger importieren:
  Alle sonstigen wichtigen Zertifikate (z.B. von
  Kommunikationspartner) auf die gleiche Weise importieren;
  am besten jeweils mit der kompletten Kette.

- Wurzelzertifikate als vertrauenswürdig markieren:
  Wenn Sie im Kleopatra-Menü "Extras->GnuPG Backend einrichten"
  unter "GpgAgent" die Option "erlaube Aufrufern Schlüssel als
  'vertrauenswürdig' zu markieren" aktivieren, so werden Sie
  beim Gebrauch eines bisher nicht vertrauenswürdig
  eingestuften Wurzel-Zertifkats gefragt, ob Sie es
  nun als vertrauenswürdig einstufen wollen.
  Beachten Sie, dass der gpg-agent neu gestartet
  werden muss, z.B: durch ausloggen und wieder einloggen.

- Systemweites Vetrauen für Wurzel-Zertifkate für DirMngr aussprechen:
  Die entsprechenden Wurzel-Zertifikate müssen als DER-Dateien
  mit Dateinamen-Endung ".crt" oder ".der" im Verzeichnis
  %ALLUSERSPROFILE%\Anwendungsdaten\GNU\etc\dirmngr\trusted-certs\
  abgelegt werden.

- Probleme mit Sperrlisten (CRLs):
  Das S/MIME Verfahren beinhaltet die Verwendung von
  Sperrlisten, um die Gültigkeit von Zertifkaten zu prüfen.

  Hierbei kann es zu verschiedenen Problemen kommen, die
  noch nicht alle mit aussagekräftigen Fehlermeldungen
  ausgestattet sind.

  Solle also eine S/MIME Operation (egal welche) nicht funktionieren,
  schalten sie testweise die Verwendung von Sperrlisten aus
  und prüfen Sie ob das Problem dann nicht mehr auftritt ist.
  Berichten Sie anschliessen Ihre Beobachtung an das Gpg4win
  Entwicklungs-Team, um eine Lösung zu finden.

  Man kann die CRL-Prüfungen wie folgt ausschalten:
  Im Kleopatra-Menü "Extras->GnuPG Backend einrichten"
  unter "GPG for S/MIME" die Option "Niemals eine CRL konsultieren"
  aktivieren. Danach neu einloggen, um die Änderung zu aktivieren.

- DirMngr Konfigurations-Dialog nicht editierbar:
  Der Konfigurationsdialog unter "DirectoryManager" im GnuPG Backend
  ist nicht editierbar, da deren Einstellungen nur vom Systemadministrator
  in den dazugehörigen systemweiten Konfigurations-Textdateien
  vorgenommen werden kann. Gleiches gilt für die Proxy-Einstellung im Menü
  "Einstellungen->Kleopatra einrichten..." unter "S/MIME-Prüfung".


Migration
=========

* Von einer älteren Gpg4win 1.9er Version:

  Ist eine alte Version der 1.9er vorher installiert
  gewesen, so muss unbedingt ein Neustart des Systems
  erfolgen wenn die Installationsroutine dies (durch Vorauswahl)
  empfohlen hat.
  Ansonsten wird es zwangsläufig zu Fehlfunktionen
  bei Verschlüsselungsoperationen kommen.

* Von einer Gpg4win 1.X  oder sonstigen GnuPG Version:

  Sollte Gpg4win 1.x oder irgendeine andere GnuPG Installation
  auf Ihrem System installiert gewesen sein, so muss ggf. noch
  zurückgebliebene Registry-Eintrage entfernt werden:
  HKCU\Software\GNU\GnuPG\gpgProgramm
  HKLM\Software\GNU\GnuPG\gpgProgramm


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

- Claws Mail: Version 3.6.0cvs7
  Wesentliche Neuerungen: Unterstützung von SSL, NNTP und IMAP
  in der Windows-Version von Claws Mail.

- GpgOL: Diese Komponenten wurde am umfassendsten aktualisiert.

  * Wesentliche Neuerungen sind:

    - Unterstützung von OpenPGP/MIME:
      Bisher wurde nur das sog. "inline-PGP" unterstützt.
      Nun können unter anderem auch
      Anhänge direkt verarbeitet werden.

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


Wichtigste Änderungen von Gpg4win 1.9.9 gegenüber 1.9.8
=======================================================

 - Kleopatra:
   Hinweis: [#xxxxxx] markiert im Folgenden die Kleopatra-Fehlermeldungs-Nummer.
            Details können mit dieser Nummer unter http://bugs.kde.org/ 
            eingesehen werden.
     * Im- und Export von *.p12-Dateien korrigiert [#173369;#172716]
     * Export öffentlicher Zertifikate neben *.asc/*.pem nun auch
       als *.gpg/*.der Dateien möglich [#172531;#172787]
     * Zertifikatsimportfilter korrigiert [#173676;#173677]
     * Signatur-Zertifikatsauswahl auf ausgewähltes Protokoll reduziert [#172786]
     * Farbe des Signaturprüfdialogs ("nicht genügend Informationen")
       ist nun gelb anstatt grün [#172350]
     * bessere Unterstützung des Protokollmodus "automatisch" von GpgOL
       zur Auswahl von PGP/MIME bzw. S/MIME [#166732]
     * Passphrase-Änderungen (für OpenPGP-Zertifikate) werden nun gespeichert 
       [#166139]
     * Übersetzungen ergänzt / korrigiert
       [#170244;#172731;#172732;#172734;#172735]
     * diverse kleinere Stabilitäts- und GUI-Verbesserungen

 - GpgOL:
     * Verifizieren und Entschlüsseln von InlinePGP-Nachrichten korrigiert
     * Tooltip für Verschlüsseln- und Signieren-Button umbenannt
     * Warndialog beim Versuch eine leere signierte oder verschlüsselte 
       Nachricht zu senden 
     * Weitergeleitete signierte Mails: keine "gpgol000.txt" Datei mehr
       im Anhang 

 - Backend:
     * DirMngr unterstützt nun anwenderspezifische Vertrauensdefinitionen für
       Wurzelzertifkate
     * DirMngr unterstützt zusätzlich *.der Dateien im Verzeichnis 
       'trusted-certs'
     * Umlaute in OpenPGP-Zertifikatsdetails auf Keyservern werden nun 
       korrekt dargestellt

 - Gpg4win Kompendium 3.0.0-beta1 Release (vom 22.10.2008) integriert

 - Backend und Installer: Es sind viele kleine und mittlere
   Probleme und Fehler behoben worden.

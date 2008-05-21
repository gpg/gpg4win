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

Stand: Gpg4win-1.9.1 (20080514)

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
* Wichtigste Änderungen von Gpg4win 1.9.1 gegenüber 1.9.0


Wichtige Hinweise zur vorliegenden Version
==========================================

- Firewall-Probleme:
  Ist eine strenge Firewall-Regel in Betrieb, kann es
  zu Problemen kommen, da Kleopatra über einen sog. Port
  an "localhost" mit den anderen Komponenten kommuniziert.
  Schalten Sie entsprechende Regeln Ihrer Firewall ggf. aus.

- Installationpaket knapp 40 MByte:
  Derzeit sind die Programme mit umfangreichen
  Debug-Informationen ausgestattet, so dass bei auftauchen
  eines Fehlers unmittelbar eine Fehleranalyse
  durchgeführt werden kann. Für Version 2.0
  werden diese Debug-Informationen wieder entfernt
  und das Installationpaket deutlich kleiner (knapp 10 MByte,
  eventuell auch weniger).

- Handbücher noch nicht aktualisiert:
  Die beiden Hanbücher "Gpg4win für Einsteiger" und "Gpg4win
  für Durchblicker" sind noch nicht vollständig aktualisiert.
  Die Versionen, die mit dem 1.9er Paket installiert werden,
  enthalten jedoch einige Erweiterungen und sollte der
  offiziell herunterladbaren Version 2.0.2 vorgezogen werden.

- An sich selbst verschlüsseln:
  Es ist unbedingt empfehlenswert für OpenPGP und S/MIME
  seine Zertifikate konfigurieren
  für die die Emails auch immer verschlüsselt werden sollen.
  Dazu jeweils im GnuPG Konfigurations-Dialog von Kleopatra
  "GPG for S/MIME: encrypt to user ID NAME as well" und
  "GPG for OpenPGP: encrypt to user ID NAME as well"
  jeweils den Fingerprint des jeweiligen Zertifikates
  einfügen.

- Verwendung von Outlook Plugin "GpgOL":

  * Sie Sollten unbedingt Sicherheitskopien Ihrere alten
    Verschlüsselten/Signierten E-Mails, z.B. in PST-Dateien
    machen!

  * Verschlüsselte E-Mails unverschlüsselt auf E-Mail-Server:
    Es kann vorkommen, dass Teile von verschlüsselten E-Mails
    in entschlüsselter/unverschlüsselter Form auf dem E-Mail-Server
    (IMAP oder MAPI) zu liegen kommen wenn man sie erstellt/liesst.
    Betroffen sind nur der Inhalt des Anzeigefensters von Outlook,
    also der "E-Mail-Body". Anhänge sind nicht betroffen.
    Schaltet man die Voransicht von Outlook ab, so
    verringert sich die Wahrscheinlichkeit dafür deutlich.

  * E-Mails werden auf dem Server in Microsoft-spezifischen
    Formaten gespeichert und können von anderen E-Mail-Programmen
    dann nicht mehr interpretiert und die Inhalte angezeigt werden.


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
  Beachten Sie den Warnhinweis der darauf hin erscheint.

- Neue S/MIME Schlüssel herstellen:
  Eine Erstellung *neuer* S/MIME-Schlüssel ist
  noch nicht vollständig in Kleopatra implementiert.

- S/MIME-Zertifikatskette für persönlichen Schlüssel importieren:
  Die zum geheimen Schlüssel zugehörige Zertifikatskette
  als P7C-Datei importieren (Menü Datei->Zertifikate importieren).
  Es werden auch andere Suffixes für solche Dateien verwendet.
  Typischerweise besteht die Kette aus dem Wurzel-Zertifkat,
  einem CA-Zertifikat und dem persönlichen Zertifikat.

- Geheimen S/MIME Schlüssel importieren:
  Den persönlichen geheimen Schlüssel als P12-Datei
  über Kleopatra importieren (Menü Datei->Zertifikate
  importieren).
  Achtung: Der P12 import funktioniert nur, wenn
  der vohergehende Schritt auch tatsächlich durchgeführt
  wurde.

- S/MIME-Zertifkate der E-Mail Empfänger importieren:
  Alle sonstigen wichtigen Zertifikate, z.B. von
  Kommunikationspartner auf die gleiche Weise importieren
  (am besten jeweils mit der kompletten Kette)

- Wurzelzertifikate als Vertrauenswürdig markieren:
  Wenn Sie "GnuPG Backend einrichten" Konfiguration-Dialog
  von Kleopatra "Gpg Agent: allow clients
  to mark keys as trusted" aktivieren, so werden Sie
  beim Gebrauch eines bisher nicht vertrauenswürdig
  eingestuften Wurzel-Zertifkats gefragt, ob Sie es
  nun als Vertrauenswürdig einstufen wollen.
  Beachten Sie, dass der gpg-agent neu gestartet
  werden muss, z.B: durch ausloggen und wieder einloggen.

- Vetrauen für Wurzel-Zertifkate für DirMngr aussprechen:
  Die entsprechenden Wurzel-Zertifikate müssen als DER-Dateien
  mit Dateinamen-Endung ".crt" im Verzeichnis
  %INSTALL_DIR%\etc\dirmngr\trusted-certs\
  abgelegt werden.

- Probleme mit Sperrlisten (CRLs):
  Das S/MIME Verfahren beinhaltet die Verwendung von
  Sperrlisten um die Gültigkeit von Zertifkaten zu prüfen.

  Hierbei kann es zu verschiedenen Problmen kommen, die
  noch nicht alle mit aussagekräftigen Fehlermeldungen
  ausgestattet sind.

  Solle also eine S/MIME Operation nicht funktionieren,
  schalten sie testweise die Verwendung von Sperrlisten aus
  und prüfen Sie ob das Problem dann nicht mehr auftritt ist.
  Berichten Sie anschliessen Ihre Beobachtung an das Gpg4win
  Entwicklungs-Team um eine Lösung zu finden.

  Man kann die CRL-Prüfungen so ausschalten:
  "GPG for S/MIME: never consult a CRL" aktivieren im
  "GnuPG Backend einrichten" Konfiguration-Dialog von Kleopatra.
  Danach neu einloggen um die Änderung zu aktivieren.


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
  auf Ihrem System installiert gewesen sein, so muss ein ggf. noch
  zurückgebliebener Registry-Eintrage entfernt werden:
  HKCU\Software\GNU\GnuPG\gpgProgramm


Wichtigste Änderungen von Gpg4win 1.9 gegenüber 1.1
===================================================


Entfallen:
----------

- GpgEE: Dieses Modul wird ersetzt durch GpgEX (siehe unten)


Aktualisiert:
-------------

- Claws Mail: Version 3.4.0
  NNTP- und IMAP-Unterstützung ist seitens Gpg4win ein Stück
  weiter vorbereitet, aber noch nicht verfügbar.
  Seitens Claws Mail ist die SSL-Unterstützung ebenfalls
  ein Stück weiter, allerdings bestehen aktuell noch Probleme für
  die Windows-Version.
  Im Verlauf von 2008 könnte die Integration von SSL, NNTP und
  IMAP in der Windows-Version von Claws Mail abgeschlossen werden.

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

  * WinPT und GPA werden erst aus dem Gpg4win Paket entfernt, wenn
    deren Funktionalität von Kleopatra vollständig abgedeckt wird.

  * Kleopatra läuft in der Regel permanent als Dienst (siehe
    Icon im System-Tray) sobald dessen Dienste einmal im Verlauf
    der Sitzung abgefragt wurden.

  * Kleopatra ist noch in Entwicklung:
    Es fehlen noch einzelne Funktionalitäten für OpenPGP.
    Dafür kann alternativ auf GPA oder WinPT zurückgegriffen werden.


Wichtigste Änderungen von Gpg4win 1.9.1 gegenüber 1.9.0
=======================================================

 * Claws Mail: Update von 3.1.0cvs370 auf 3.4.0

 * GpgOL: Verwendet nun Icons (toolbar etc)

 * Kleopatra:
  * Selbständiger Test auf mögliche Ausführungsprobleme
  * Prüfungsergebnis nun in eigenem Dialog; gleicht der
    in KMail verwendeten Form
  * Signatur/Verschlüsselung: Die Dialog-Sequenz wurde überarbeitet.
  * Audit-Log Unterstützung
  * Fortschrittsbalken bei der Behandlung von Dateien
  * Zwischenablage Unterstützung

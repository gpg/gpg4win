Wichtige Informationen zum Einsatz von Gpg4win 1.9-BETA
=======================================================

Stand: Gpg4win-1.9.0-svn753 (20080324)

Hier finden sich wichtige Informationen die bei der
Entscheidung helfen sollen, ob Gpg4win 1.9 schon für
die individuellen Bedürfnisse ausreicht und einen
Beta-Test sinnvoll erscheinen läßt oder aber ob
Gpg4win 1.9 noch nicht weit genug dafür ist.

Ausserdem wird ein Ausblick gegeben, was mit
Gpg4win 2.0 an neuer Funktionalität zu erwarten ist.
Die 1.9er Versionen sind der Beta-Test-Zyklus. Ist er
abgeschlossen wird Version 2.0 freigegeben.


Wichtige Hinweise zur vorliegenden Version
------------------------------------------

- Probleme mit Verzeichnisdienst "DirMngr":
  Es kann sein, dass der Dienst "DirMngr" bei
  S/MIME-Operationen sehr lange Laufzeiten zeigt.

  In diesem Fall sind für die Verwendung von S/MIME die CRL-Prüfungen
  auszuschalten: "GPG for S/MIME: never consult a CRL"
  und "Gpg Agent: allow clients to mark keys as trusted" zu aktivieren.
  (beides im "GnuPG Backend einrichten" Konfiguration-Dialog von Kleopatra)
  Danach neu einloggen um die Änderung zu aktivieren.

- Deutsche Sprachunterstützung:
  Ist noch nicht in allen Bereichen realisiert.
  Teilweise sind Dialoge daher in englisch oder
  deutsch/englisch gemischt.

- An sich selbst verschlüsseln:
  Es ist unbedingt empfehlenswert für OpenPGP und S/MIME
  seine Zertifikate konfigurieren
  für die die Emails auch immer verschlüsselt werden sollen.
  Dazu jeweils im GnuPG Konfigurations-Dialog von Kleopatra
  "GPG for S/MIME: encrypt to user ID NAME as well" und
  "GPG for OpenPGP: encrypt to user ID NAME as well"
  jeweils den Fingerprint des jeweiligen Zertifikates
  einfügen.

- Konfiguration für S/MIME:
  Für die Inbetriebnahme sind folgende Schritte
  durchzuführen:
  * Den persönlichen geheimen Schlüssel als P12-Datei
    über Kleopatra importieren (Menü Datei->Zertifikate
    importieren)
  * Die zum geheimen Schlüssel zugehörige Zertifikatskette
    als P7C-Datei importieren. Es werden auch andere
    Suffixes für solche Dateien verwendet. Einfach über
    das gleiche Menü wie die P12-Datei importieren.
    Typischerweise besteht die Kette aus dem Wurzel-Zertifkat,
    einem CA-Zertifikat und dem persönlichen Zertifikat.
  * Alle sonstigen wichtigen Zertifikate, z.B. von
    Kommunikationspartner auf die gleiche Weise importieren
    (am besten jeweils mit der kompletten Kette)
  * Wurzelzertifkate als Vertrauenswürdig markieren:
    Haben Sie wie oben beschrieben "Gpg Agent: allow clients
    to mark keys as trusted" aktiviert, so werden Sie
    beim Gebrauch eines bisher nicht vertrauenswürdig
    eingestuften Wurzel-Zertifkats gefragt, ob Sie es
    nun als Vertrauenswürdig einstufen wollen.
    Ansonsten wird das Vetrauen in Wurzel-Zertifkate wie folgt
    ausgesprochen:
    TODO
  * Hinweis: Eine Erstellung *neuer* S/MIME-Schlüssel ist
    noch nicht vollständig in Kleopatra implementiert.

Migration
---------

Ist eine alte Version der 1.9er vorher installiert
gewesen, so muss unbedingt ein Neustart des Systems
erfolgen wenn die Installationsroutine dies (durch Vorauswahl)
empfohlen hat.
Ansonsten wird es zwangsläufig zu Fehlfunktionen
bei Verschlüsselungsoperationen kommen.


Komponenten von Gpg4win 1.9 und ihr Status
------------------------------------------


Entfallen:

- GpgEE: Dieses Modul wird ersetzt durch GpgEX (siehe unten)


Aktualisiert:

- Claws Mail: Version 3.1.0cvs70
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
      E-Mail Verschlüsselungsverfahren.

    - Verwendung von Kleopatra für Grafische Benutzerdialoge:
      Anstatt eigene Dialog für die jeweiligen
      Verschlüsselungs-Operationen zu implementieren wird
      Kleopatra verwendet. Kleopatra bietet einheitliche
      Dialoge für Krypto-Operationen.

  * Zustand der Operationen
  * Folgende Operationen sind als grundsätzlich
    funktional gestestet (einfache E-Mails ohne Anhänge):
    - Signatur-Prüfung inline-OpenPGP
    - Signatur-Prüfung OpenPGP/MIME
    - Signatur-Prüfung S/MIME Opaque
    - Signatur-Prüfung S/MIME
    - Entschlüsselung inline-OpenPGP
    - Entschlüsselung OpenPGP/MIME
    - Entschlüsselung S/MIME Opaque
    - Entschlüsselung S/MIME
    - Signatur-Prüfung und Entschlüsselung inline-OpenPGP
    - Signatur-Prüfung und Entschlüsselung OpenPGP/MIME
    - Signatur-Prüfung und Entschlüsselung S/MIME Opaque
    - Signatur-Prüfung und Entschlüsselung S/MIME

    - Signatur OpenPGP/MIME
    - Signatur S/MIME
    - Verschlüsselung OpenPGP/MIME
    - Verschlüsselung S/MIME
    - Signatur und Verschlüsselung OpenPGP/MIME
    - Signatur und Verschlüsselung S/MIME

Neu:

- GpgEX: Das neue Plugin für Microsoft Explorer.

  Folgende Operationen sind als grundsätzlich
  funktional gestestet:

  * Verifizieren OpenPGP
  * Verifizieren S/MIME
  * Verschlüsseln OpenPGP
  * Verschlüsseln SMIME
  * Entschlüsseln OpenPGP
  * Entschlüsseln S/MIME
  * Signieren OpenPGP
  * Signieren S/MIME


- Kleopatra: Der neue Zertifikatsmanager

  * Kleoaptra ist der bisherige S/MIME Zertifikatsmanager von KDE.
    Es ist zum einen um parallele Unterstützung von OpenPGP erweitert
    worden. Zum anderen fungiert Kleaoptra als Grafische Oberfläche
    für sämtliche Kryptografischen Operationen und vereinheitlich
    damit die grafische Benutzerführung.

  * WinPT und GPA werden erst aus dem Gpg4win Paket entfernt, wenn
    deren Funktionalität von Kleopatra vollständig abgedeckt wird.

  * Kleopatra läuft in der Regel permanent als Dienst (siehe
    Icon im System-Tray) sobald dessen Dienste einmal im Verlauf
    der Sitzung abgefragt wurden.

  * Kleopatra ist noch in Entwicklung: Alle wesentlichen
    Funktionalitäten, aber es fehlen noch einzelne für S/MIME
    und diverse für OpenPGP. Für OpenPGP kann alternativ auf
    GPA oder WinPT zurückgegriffen werden.

  * Eine Überabreitung der einzelnen Krypto-Dialoge
    (z.B. für Verschlüsselung oder Signatur-Prüfung) ist derezit
    noch in Arbeit. Teilweise erscheinen sie daher nicht
    aufgeräumt/optimal.


Einige Bekannte Fehler
----------------------

Berichtet zu svn684:

* Improve GnuPG Config Check GUI
  http://bugs.kde.org/show_bug.cgi?id=156483

Berichtet zu svn615:

* Claws Mail: Freezes if password dialog is cancelled
  http://wald.intevation.org/tracker/index.php?func=detail&aid=548&group_id=11&atid=126

* The button to report a bug does not work
  http://bugs.kde.org/show_bug.cgi?id=153565

* Kleopatra: Check GpgConf results in error not finding config
  http://wald.intevation.org/tracker/index.php?func=detail&aid=556&group_id=11&atid=126

Wichtige Informationen zum Einsatz von Gpg4win 1.9-BETA
=======================================================

Stand: Gpg4win-1.9.0-svn709 (20080214)

Hier finden sich wichtige Informationen die bei der
Entscheidung helfen sollen, ob Gpg4win 1.9 schon für
die individuellen Bedürfnisse ausreicht und einen
Beta-Test sinnvoll erscheinen läßt oder aber ob
Gpg4win 1.9 noch nicht weit genug dafür ist.

Ausserdem wird ein Ausblick gegeben, was mit
Gpg4win 2.0 an neuer Funktionalität zu erwarten ist.
Die 1.9er Versionen sind der Beta-Test-Zyklus. Ist er
abgeschlossen wird Version 2.0 freigegeben.


Wesentliche Probleme der vorliegenden Version
---------------------------------------------

- Entschlüsselung InlinePGP: Die E-Mails werden
  einmnalig entschlüsselt, aber dann zerstört.
  Also unbedingt solche E-Mails vorher sichern.

- Für die Verwendung von S/MIME sind die CRL-Prüfungen
  auszuschalten: "GPG for S/MIME: never consult a CRL"
  und "Gpg Agent: allow clients to mark keys as trusted" zu aktivieren.
  (beides im GnuPG Konfiguration-Dialog von Kleopatra)
  Danach neu einloggen um die Änderung zu aktivieren.

- S/MIME Opak: Signierte und(!) verschlüsselte
  E-Mails können nicht verarbeitet werden.

- An sich selbst verschlüsseln: man muss unbedingt
  für OpenPGP und S/MIME seine Zertifikate konfigurieren
  für die die Emails auch immer verschlüsselt werden sollen.
  Dazu jeweils im GnuPG Konfigurations-Dialog von Kleopatra
  "GPG for S/MIME: encrypt to user ID NAME as well" und
  "GPG for OpenPGP: encrypt to user ID NAME as well"
  jeweils den Fingerprint des jeweiligen Zertifikates
  einfügen.


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

  * Zustand der Operationen (getestet: einfache E-Mails ohne Anhänge):
    - Signatur-Prüfung inline-OpenPGP: Grundsätzlich funktional
    - Signatur-Prüfung OpenPGP/MIME: Grundsätzlich funktional
    - Signatur-Prüfung S/MIME Opaque: Grundsätzlich funktional
    - Signatur-Prüfung S/MIME: Grundsätzlich funktional
    - Entschlüsselung inline-OpenPGP: Grundsätzlich funktional
    - Entschlüsselung OpenPGP/MIME: Grundsätzlich funktional
    - Entschlüsselung S/MIME Opaque: Grundsätzlich funktional
    - Entschlüsselung S/MIME: Grundsätzlich funktional
    - Signatur-Prüfung und Entschlüsselung inline-OpenPGP: nicht geprüft
      (Test-E-Mails nicht auf einfache Weise herstellbar)
    - Signatur-Prüfung und Entschlüsselung OpenPGP/MIME: Grundsätzlich funktional
    - Signatur-Prüfung und Entschlüsselung S/MIME Opaque: Funktion defekt
    - Signatur-Prüfung und Entschlüsselung S/MIME: Grundsätzlich funktional

    - Signatur OpenPGP/MIME: Grundsätzlich funktional
    - Signatur S/MIME: Grundsätzlich funktional
    - Verschlüsselung OpenPGP/MIME: Grundsätzlich funktional
    - Verschlüsselung S/MIME: Grundsätzlich funktional
    - Signatur und Verschlüsselung OpenPGP/MIME: Grundsätzlich funktional
    - Signatur und Verschlüsselung S/MIME: Grundsätzlich funktional

Neu:

- GpgEX: Das neue Plugin für Microsoft Explorer.

  Nicht funktionale OpenPGP Methoden müssen z.B. über GPA ausgeführt werden.
  Für S/MIME gibt es keine Alternative.

  * Verifizieren OpenPGP: Grundsätzlich funktional.
  * Verifizieren S/MIME: Grundsätzlich funktional.

  * Verschlüsseln OpenPGP: Grundsätzlich funktional.
  * Verschlüsseln SMIME: Grundsätzlich funktional

  * Entschlüsseln OpenPGP: Grundsätzlich funktional.
  * Entschlüsseln S/MIME: Grundsätzlich funktional

  * Signieren OpenPGP: Grundsätzlich funktional.
  * Signieren S/MIME: Grundsätzlich funktional.


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

  * Kleopatra ist noch in Entwicklung: Die bei Gpg4win enthaltene
    Version ist nicht in deutsch und bietet bisher nur die Liste der
    vorliegenden Zertifikate.

  * Die einzelnen Krypto-Dialoge sind noch nicht vollständig implementiert,
    stattdessen sind teilweise Platzhalter-Dialoge mit eingeschränkter
    Funktionalität enthalten.


Bekannte Fehler
---------------

Berichtet zu svn684:

* Improve GnuPG Config Check GUI
  http://bugs.kde.org/show_bug.cgi?id=156483

Berichtet zu svn615:

* GpgOL: does not decrypt inline-PGP received prior to Gpg4win-1.9.0
  https://bugs.g10code.com/gnupg/issue861

* Claws Mail: Freezes if password dialog is cancelled
  http://wald.intevation.org/tracker/index.php?func=detail&aid=548&group_id=11&atid=126

* The button to report a bug does not work
  http://bugs.kde.org/show_bug.cgi?id=153565

* Kleopatra: Check GpgConf results in error not finding config
  http://wald.intevation.org/tracker/index.php?func=detail&aid=556&group_id=11&atid=126

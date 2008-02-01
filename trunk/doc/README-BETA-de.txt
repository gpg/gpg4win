Wichtige Informationen zum Einsatz von Gpg4win 1.9-BETA
=======================================================

Stand: Gpg4win-1.9.0-svn701 (20080131)

Hier finden sich wichtige Informationen die bei der
Entscheidung helfen sollen, ob Gpg4win 1.9 schon für
die individuellen Bedürfnisse ausreicht und einen
Beta-Test sinnvoll erscheinen läßt oder aber ob
Gpg4win 1.9 noch nicht weit genug dafür ist.

Ausserdem wird ein Ausblick gegeben, was mit
Gpg4win 2.0 an neuer Funktionalität zu erwarten ist.
Die 1.9er Versionen sind der Beta-Test-Zyklus. Ist er
abgeschlossen wird Version 2.0 freigegeben.

Verbesserungen seit Gpg4win-1.9.0-svn684
----------------------------------------

- Die Notwendigkeit, Kleopatra gelgentlich mehrfach
  neu starten zu müssen ist entfallen.
  Die Start-Zeit wurde erheblich verkürzt, so dass
  GpgEX und GpgOL nun selbst ein Kleoaptra starten
  falls es gerade nicht läuft.

- Signaturprüfungen von (neu eintreffenden) S/MIME E-Mails
  sind jetzt funktional.

Behoben:

* Kleoaptra: Verification of S/MIME E-Mails fails
  http://bugs.kde.org/show_bug.cgi?id=154427

* Don't open DOS Boxes when importing P12 file
  https://bugs.g10code.com/gnupg/issue875

* Kleopatra: Don't open DOS-Box when importing P12 file
  http://bugs.kde.org/show_bug.cgi?id=155395

Verbesserungen seit Gpg4win-1.9.0-svn675
----------------------------------------

Behoben:

* DirMngr system service can not be started
  http://wald.intevation.org/tracker/index.php?func=detail&aid=580&group_id=11&atid=126

Verbesserungen seit Gpg4win-1.9.0-svn672
----------------------------------------

Behoben:

* Extend Menu of Tray-Kleopatra
  http://bugs.kde.org/show_bug.cgi?id=153566

Verbesserungen seit Gpg4win-1.9.0-svn651
----------------------------------------

- inline-PGP Entschlüsselung klappt besser, aber
  noch nicht vollständig.

- Signierung S/MIME E-Mail klappt besser, aber
  sehr hackelig.

- Graphische Oberfläche von Kleopatra erweitert.

- Import von P12-Dateien funktioniert nun über Kleopatra,
  aber etwas hackelig.

Behoben:

* Menu entry for Kleopatra lacks tooltip
  http://wald.intevation.org/tracker/index.php?func=detail&aid=563&group_id=11&atid=126

* Kleopatra: Tray Icon Menu: Shutdown crashes Kleopatra
  http://bugs.kde.org/show_bug.cgi?id=154423

Verbesserungen seit Gpg4win-1.9.0-svn639
----------------------------------------

Behoben:

* GpgEX: Verschlüsselung per OpenPGP nun funktional.

* GpgOL: OpenPGP/MIME Signatur-Erstellung nun funktional
  War unter anderem hier berichtet:
  GpgOL: Can not create OpenPGP Signature.
  https://bugs.g10code.com/gnupg/issue863

Verbesserungen seit Gpg4win-1.9.0-svn615
----------------------------------------

Behoben:

* GpgOL: Verschlüsselung mit OpenPGP/MIME nun funktional.

* In windows start menu: have "Documentation" submenu for Gpg4win
  http://wald.intevation.org/tracker/index.php?func=detail&aid=558&group_id=11&atid=129

* GpgOL: same title for different toolbar items
  https://bugs.g10code.com/gnupg/issue862


Migration:
----------

Wenn Sie eine Version Gpg4win 1.X installiert haben,
so deinstallieren Sie zuerst die alte Version bevor
Sie die neue Version intallieren.

Ansonsten kann es zu Problemen kommen, dass GpgEE
(wird bei 1.9 ersetzt durch GpgEX) übrig bleibt
und nicht mehr entfernt werden kann.

An einer Absicherung gegen versehentliches Installieren
ist in Arbeit:
http://wald.intevation.org/tracker/index.php?func=detail&aid=547&group_id=11&atid=126

Ist eine alte Version der 1.9er vorher installiert
gewesen, so muss unbedingt ein Neustart des Systems
erfolgen wenn die Installationsroutine dies (durch Vorauswahl)
empfohlen hat.
Ansonsten wird es zwangsläufig zu Fehlfunktionen
bei Verschlüsselungsoperationen kommen.

Insbesondere wenn eine 1.9er Version vor svn639 installiert
war, sollte diese zunächst deinstalliert werden, da sonst
das Gpg4win Menu zuviele Einträge zur Dokumentation enthält.

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

  * Achtung: Derzeit kann der Altbestand an signierten und
    verschlüsselten E-Mails nicht verarbeitet werden.
    Lediglich neue E-Mails die nach Installation von GpgOL
    eintreffen sind verarbeitbar.

  * Achtung: In verschiedenen Fällen passiert es, dass
    die "Gesendeten Objekte" kaputt sind, man also
    keine heile Kopie von versandten E-Mails hat.

  * Grundsätzlich hängt die Menge der funktionierenden Operationen
    wesentlich vom gegenwärtigen Entwicklungsstand von Kleopatra ab.

  * Zustand der Operationen (getestet: einfache E-Mails ohne Anhänge):
    - Signatur-Prüfung inline-OpenPGP: Grundsätzlich funktional
    - Signatur-Prüfung OpenPGP/MIME: Grundsätzlich funktional
    - Signatur-Prüfung S/MIME Opaque: funktioniert nicht (nicht angebunden)
    - Signatur-Prüfung S/MIME: Grundsätzlich funktional
    - Entschlüsselung inline-OpenPGP: Entschlüsselung erfolgreich,
      aber kann scheinbar nur ein einziges mal ausgeführt werden.
    - Entschlüsselung OpenPGP/MIME: Grundsätzlich funktional
    - Entschlüsselung S/MIME Opaque: Grundsätzlich funktional
    - Entschlüsselung S/MIME: Grundsätzlich funktional
    - Signatur-Prüfung und Entschlüsselung inline-OpenPGP: nicht geprüft
      (Test-E-Mails nicht auf einfache Weise herstellbar)
    - Signatur-Prüfung und Entschlüsselung OpenPGP/MIME: Grundsätzlich funktional
    - Signatur-Prüfung und Entschlüsselung S/MIME Opaque: Funktion defekt
    - Signatur-Prüfung und Entschlüsselung S/MIME: Grundsätzlich funktional

    - Signatur OpenPGP/MIME: Grundsätzlich funktional
    - Signatur S/MIME: Funktion defekt: Der E-Mail selbst fehlt die Signatur,
      die Kopie in gesendete Objekte ist kaputt. Es wird ein GPGME Fehler gemeldet.
    - Verschlüsselung OpenPGP/MIME: Grundsätzlich funktional
    - Verschlüsselung S/MIME: Funktion defekt: Kleopatra kann Verschlüsselung
      nicht erfolgreich durchführen (dirmngr Fehler wird gemeldet).
    - Signatur und Verschlüsselung OpenPGP/MIME: Funktion defekt: Kleopatra hängt.
    - Signatur und Verschlüsselung S/MIME: Funktion defekt:  Kleopatra hängt.

Neu:

- GpgEX: Das neue Plugin für Microsoft Explorer.

  Nicht funktionale OpenPGP Methoden müssen z.B. über GPA ausgeführt werden.
  Für S/MIME gibt es keine Alternative.

  * Verifizieren OpenPGP: Dateien auf Endung ".asc" werden
    derzeit nicht automatisch als Detached Signature erkannt.
    Man muss die zugehörige Datei im Verifikationsdialog dann
    händisch angeben.
  * Verifizieren S/MIME: nicht getestet.

  * Verschlüsseln OpenPGP: Grundsätzlich funktional.
    Es bleiben temporäre Dateien im jeweiligen Verzeichnis zurück.
  * Verschlüsseln SMIME: nicht funktional (Absturz Kleopatra)

  * Entschlüsseln OpenPGP: Grundsätzlich funktional.
    Es bleiben temporäre Dateien im jeweiligen Verzeichnis zurück.
  * Entschlüsseln S/MIME: nicht getestet.

  * Signieren OpenPGP: Nicht funktional
  * Signieren S/MIME: Nicht funktional


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

* During update installation: claws should be checked by default if installed last time
  http://wald.intevation.org/tracker/index.php?func=detail&aid=583&group_id=11&atid=126

Berichtet zu svn672:

* Kleopatra: Creating S/MIME Signature raises GPGME error
  http://bugs.kde.org/show_bug.cgi?id=155404

* Kleopatra: Lacks GPGME backend configuration dialog in current SVN version
  http://bugs.kde.org/show_bug.cgi?id=155403

Berichtet zu svn651:

* Kleopatra: Tray menu: toggle Open and Close
  http://bugs.kde.org/show_bug.cgi?id=154424

* Kleoapatra: Message and interaction dialogs should
  always raise in foreground (MS Windows)
  http://bugs.kde.org/show_bug.cgi?id=154430

* GpgOL: emails in sent-folder can not be verified
  https://bugs.g10code.com/gnupg/issue867

Berichtet zu svn615:

* GpgOL: does not decrypt inline-PGP received prior to Gpg4win-1.9.0
  https://bugs.g10code.com/gnupg/issue861

* Claws Mail: Freezes if password dialog is cancelled
  http://wald.intevation.org/tracker/index.php?func=detail&aid=548&group_id=11&atid=126

* The button to report a bug does not work
  http://bugs.kde.org/show_bug.cgi?id=153565

* Kleopatra: Check GpgConf results in error not finding config
  http://wald.intevation.org/tracker/index.php?func=detail&aid=556&group_id=11&atid=126

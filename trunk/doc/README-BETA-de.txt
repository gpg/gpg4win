Wichtige Informationen zum Einsatz von Gpg4win 1.9-BETA
=======================================================

Stand: Gpg4win-1.9.0-svn615 (20071130)

Hier finden sich wichtige Informationen die bei der
Entscheidung helfen sollen, ob Gpg4win 1.9 schon für
die individuellen Bedürfnisse ausreicht und einen
Beta-Test sinnvoll erscheinen läßt oder aber ob
Gpg4win 1.9 noch nicht weit genug dafür ist.

Ausserdem wird ein Ausblick gegeben, was mit
Gpg4win 2.0 an neuer Funktionalität zu erwarten ist.
Die 1.9er Versionen sind der Beta-Test-Zyklus. Ist er
abgeschlossen wird Version 2.0 freigegeben.


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
Ansonsten wird es zwangläufig zu Fehlfunktionen
bei Verschlüsselungsoperationen kommen.


Komponenten von Gpg4win 1.9 und ihr Status
------------------------------------------


Entfallen:

- GpgEE: Dieses Modul wird ersetzt durch GpgEX (siehe unten)


Aktualisiert:

- Claws Mail: Version 3.0.2.
  NNTP- und IMAP-Unterstützung ist seitens Gpg4win ein Stück
  weiter vorbereitet, aber noch nicht verfügbar.
  Seitens Claws Mail ist die SSL-Unterstützung ebenfalls
  ein Stück weiter, allerdings erst ab Version 3.1.0 verfügbar.
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

  * Achtung: Es kann gelegentlich vorkommen, dass Kleopatra beendet
    wird (kein Schlüsselsymbol mehr in Task-Leiste oder Symbol
    verschwindet in dem Moment wo man mit der Maus darüber fährt).
    In diesem Fall kann es zu Fehlern bei GpgOL kommen.
    Kleopatra sollte über das Startmenü neu gestartet werden.

  * Hinweis: Der Import einer von P12- und PEM-Dateien ist
    derzeit nur über die Kommandozeile möglich, z.B.:
    gpgsm --import datei.p12

  * Grundsätzlich hängt die Menge der funktionierenden Operationen
    wesentlich vom gegenwärtigen Entwicklungsstand von Kleopatra ab.

  * Zustand der Operationen (einfache E-Mails ohne Anhänge):
    - Signatur-Prüfung inline-OpenPGP: Grundsätzlich funktional,
      muss aber noch verbessert werden
    - Signatur-Prüfung OpenPGP/MIME: Grundsätzlich funktional,
      muss aber noch verbessert werden
    - Signatur-Prüfung S/MIME Opaque: funktioniert nicht (nicht angebunden)
    - Signatur-Prüfung S/MIME: Funktion defekt
    - Entschlüsselung inline-OpenPGP: Bearbeitung scheint erfolgreich,
      aber entschlüsselter Text kann nicht angezeigt werden.
    - Entschlüsselung OpenPGP/MIME: Grundsätzlich funktional, muss aber
      noch verbessert werden
    - Entschlüsselung S/MIME Opaque: Grundsätzlich
      funktional, muss aber noch verbessert werden
    - Entschlüsselung S/MIME: Grundsätzlich
      funktional, muss aber noch verbessert werden
    - Signatur-Prüfung und Entschlüsselung inline-OpenPGP: nicht geprüft
      (Test-E-Mails nicht auf einfache Weise herstellbar)
    - Signatur-Prüfung und Entschlüsselung OpenPGP/MIME: Grundsätzlich
      funktional, muss aber noch verbessert werden
    - Signatur-Prüfung und Entschlüsselung S/MIME Opaque: Funktion defekt
    - Signatur-Prüfung und Entschlüsselung S/MIME: Grundsätzlich
      funktional, muss aber noch verbessert werden

    - Signatur OpenPGP/MIME: Funktion defekt: Signatur wird nicht erstellt
    - Signatur S/MIME: Funktion defekt: Signatur wird nicht erstellt
    - Verschlüsselung OpenPGP/MIME: Funktion defekt: Absturz von Kleopatra
    - Verschlüsselung S/MIME: Funktione defekt: Absturz von Kleopatra
    - Signatur und Verschlüsselung OpenPGP/MIME: Funktion defekt
    - Signatur und Verschlüsselung S/MIME: Funktion defekt: Absturz von Kleopatra

Neu:

- GpgEX: Das neue Plugin für Microsoft Explorer.

  * Entschlüsseln/Verifizieren: Dateien auf Endung ".asc" werden
    derzeit nicht automatisch als Detached Signature erkannt.
    Man muss die zugehörige Datei im Verifikationsdialog dann
    händisch angeben.
    Der Dialog ist noch nicht die endgültige Fassung sondern
    eine temporärer Ersatz.

  * Verschlüsseln/Signieren: Kleopatra-Aufrufe noch nicht aktiv.
    Derzeit muss diese Operation z.B. über GPA ausgeführt werden.

- Kleopatra: Der neue Zertifikatsmanager

  * Kleoaptra ist der bisherige S/MIME Zertifikatsmanager von KDE.
    Es ist zum einen um parallele Unterstützung von OpenPGP erweitert
    worden. Zum anderen fungiert Kleaoptra als Grafische Oberfläche
    für sämtliche Kryptografischen Operationen und vereinheitlich
    damit die grafische Benutzerführung.

  * WinPT und GPA werden erst aus dem Gpg4win Paket entfernt, wenn
    deren Funktionalität von Kleopatra vollständig abgedeckt wird.

  * Kleopatra läuft in der Regel permanent als Dienst (siehe
    Icon im System-Tray).
    Derzeit wird für leichteres Debugging bei direktem Start von
    Kleopatra eine Konsole (DOS-Box) geöffnet während Kleopatra
    in Betrieb ist.

  * Kleopatra ist noch in Entwicklung: Die bei Gpg4win enthaltene
    Version ist nicht in deutsch und bietet bisher nur die Liste der
    vorliegenden Zertifikate.

  * Die einzelnen Krypto-Dialoge sind noch nicht vollständig implementiert,
    stattdessen sind teilweise Platzhalter-Dialog mit eingeschränkter
    Funktionalität enthalten.


Bekannte Fehler
---------------

* GpgOL: does not decrypt inline-PGP received prior to Gpg4win-1.9.0
  https://bugs.g10code.com/gnupg/issue861

* GpgOL: same title for different toolbar items
  https://bugs.g10code.com/gnupg/issue862

* GpgOL: Can not create OpenPGP Signature.
  https://bugs.g10code.com/gnupg/issue863

* Claws Mail: Freezes if password dialog is cancelled
  http://wald.intevation.org/tracker/index.php?func=detail&aid=548&group_id=11&atid=126

* The button to report a bug does not work
  http://bugs.kde.org/show_bug.cgi?id=153565

* Extend Menu of Tray-Kleopatra
  http://bugs.kde.org/show_bug.cgi?id=153566

* Kleopatra: Check GpgConf results in error not finding config
  http://wald.intevation.org/tracker/index.php?func=detail&aid=556&group_id=11&atid=126

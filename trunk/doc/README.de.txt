;; README.de.txt                             -*- coding: latin-1; -*-
;; This is the README installed with gpg4win (German version).  Lines
;; with a ; in the first column are considered a comment and not
;; included in the actually installed version.  Certain keywords are
;; replaced by the Makefile; those words are enclosed by exclamation
;; marks.

                  Deutsche README Datei for Gpg4Win
                  =================================
                                   
Dies ist GnuPG for Windows, Version !VERSION!.

Inhalt:

     1. Wichtige Hinweise
     2. Änderungen
     3. Versionsnummern
     4. Installer Optionen
     5. Rechtliche Hinweise




1. Wichtige Hinweise
====================

Informationen zur Benutzung sind den Handbüchern "Gpg4Win für
Einsteiger" und "Gpg4Win für Durchblicker" zu entnehmen.  Diese können
Sie auch, in einer möglicherweise bereits überarbeiteten Fassung,
online unter http://www.gpg4win.de lesen.




3. Liste der Änderungen an Gpg4Win
==================================

Eine aktuelle deutschsprachige Übersicht der Änderungen finden online
unter http://www.gpg4win.de/change-history-de.html .  Im weiteren
finden Sie die Einträge aus der englischen NEWS Datei:

!NEWSFILE!




3. Versionsnummern der einzenen Bestandteile
============================================

Zur Übersicht sind hier die Prüfsummen sowie die Namen der einzelnen
Bestandteile aufgelistet.  Sie finden dieselben Informationen auch in
der Datei versioninfo.txt.

!VERSIONINFO!




4. Installer Optionen
=====================

Der Standard-Installationspfad kann mit der Option /D=PFAD angegeben
werden, welche als letzte auf der Kommandozeile erscheinen muß.  Der
Installer unterstützt die Option /S für automatischen Ablauf der
Installation, und die Option /C=INIFILE, durch welche eine .ini Datei
angegeben werden kann, die genau einen Abschnitt "[gpg4win]" enthalten
sollte, in der absolute Pfade zu Konfigurationsdateien enthalten sein
sollten, die mit installiert werden.  Hier ist eine Beispieldatei, die
zugleich alle erlaubten Schlüssel zeigt:

[gpg4win]
  gpg.conf = D:\config\gpg-site.conf
  gpg-agent.conf = D:\config\gpg-agent-site.conf
  trustlist.txt = D:\config\trustlist-site.txt
  dirmngr.conf = D:\config\dirmngr-site.conf
  dirmngr_ldapserver.conf = D:\config\dirmngr_ldapserver-site.conf
  scdaemon.conf = D:\config\scdaemon-site.txt
  gpa.conf = D:\config\gpa-site.conf



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

  Ihr Gpg4Win Team


*** Ende der Datei ***

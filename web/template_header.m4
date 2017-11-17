m4_dnl                                                        -*-html-*-
m4_dnl THIS IS INCLUDED BY `template.m4'
m4_dnl DONT USE THIS FILE DIRECTLY
m4_ifdef(`__TMPL_ROOT',,`m4_define(`__TMPL_ROOT',`')')

m4_define(`__TITLE',m4_dnl
I18N(`EN',`Secure E-Mail and File Encryption using GnuPG for Windows')`'m4_dnl
I18N(`DE',`Sichere E-Mail- und Datei-Verschlüsselung mit GnuPG für Windows'))

m4_ifdef(`__TMPL_PAGE_TITLE',,`m4_define(`__TMPL_PAGE_TITLE',`Gpg4win - 'TITLE)')

m4_define(`LINK',
    `m4_ifelse($1, NO_LINK_FOR,
        `$2',
        `<a href="$1">$2</a>')')
m4_define(`RQ',`m4_changequote(<,>)m4_dnl`
'm4_changequote`'')m4_dnl trick for inserting right quotes from http://mbreen.com/m4.html#quotemacro

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="keywords" content="Gpg4win, GnuPG, GPA, GpgOL, E-Mail, Email, Windows, PGP, GPG, OpenPGP, S/MIME, Outlook, I18N(`EN', `Encryption, secure, security') I18N(`DE', `Verschlüsselung, sicher, Sicherheit')">
  <link rel="stylesheet" type="text/css" href="__TMPL_ROOT`'gpg4win.css">
  <link rel="shortcut icon" href="__TMPL_ROOT`'favicon.png" type="image/png" />
  <title>__TMPL_PAGE_TITLE</title>
 </head>
 <body>
 <a name="top"></a>
 <div class="wrapper">
 <div class="header">
  <div class="language_select">
   <img src="img/english.png"> LANG_LINK(`EN',`English', EN_FILE) |
   <img src="img/german.png"> LANG_LINK(`DE',`Deutsch', DE_FILE)
  </div>
 </div>
 m4_ifdef(`EN_FILE', `m4_define(`LANG_DE', `1')', `m4_define(`LANG_DE', `0')')
 <div id="menu">
  <ul>
   <li class="mlogo">
    m4_ifelse(LANG_DE, `1', `<a href="index-de.html" title="Startseite"></a>', `<a href="index.html" title="Home"></a>')
   </li>
   <li class="mwhatsnew">
    m4_ifelse(LANG_DE, `1', `<a href="version3-de.html" title="Was ist in Version 3 neu"><div>Was ist neu</br>Version 3</div></a>', `<a href="version3.html" title="What is new in version 3"><div>What`'RQ()s new</br>Version 3</div></a>')
   </li>
   <li class="mbetween">
    m4_ifelse(LANG_DE, `1', `<a href="index-de.html" title="Startseite"></a>', `<a href="index.html" title="Home"></a>')
   </li>
   MENU(`about', `Über Gpg4win', `About Gpg4win', `about', MAIN, LANG_DE)
    <ul>
     MENU(`about', `Über Gpg4win', `About Gpg4win', `about', SUB, LANG_DE)
     MENU(`features', `Funktionen', `Features', `features', SUB, LANG_DE)
     MENU(`system-requirements', `Systemvoraussetzungen', `System Requirements', `system-requirements', SUB, LANG_DE)
     MENU(`documentation', `Dokumentation', `Documentation', `documentation', SUB, LANG_DE)
     MENU(`screenshots', `Screenshots', `Screenshots', `screenshots', SUB, LANG_DE)
     <li class="subcap"></li>
    </ul>
   </li>
   MENU(`community', `Gemeinschaft', `Community', `community', MAIN, LANG_DE)
    <ul>
     MENU(`community', `Gemeinschaft', `Community', `community', SUB, LANG_DE)
     MENU(`contribute', `Zu Gpg4win beitragen', `Contribute to Gpg4win', `contribute', SUB, LANG_DE)
     <li class="subcap"></li>
    </ul>
   </li>
   MENU(`support', `Support', `Support', `support', MAIN, LANG_DE)
   </li>
   <li class="mdonate">
    m4_ifelse(LANG_DE, `1', `<a href="get-gpg4win-de.html">Download</a>', `<a href="get-gpg4win.html">Download</a>')
    </li>
  </ul>
 </div>
  m4_include(`header.m4')
  <div class="content">
   m4_divert(999)
  <br clear="all" />
  </div>
  </div>

  <div id="footer">
   <br>
   <div id="sitemap">
    <ul>
     <li><a href="index-de.html"></a></li>
     MENU(`download', `Alle Downloads', `All Downloads', `download', MAIN, LANG_DE)
     <li>
       <a href="https://twitter.com/gpg4win" target="_blank" title="Follow @gpg4win">
         <img src="img/twitter-icon.png" class="social-icon">
       </a>
       <a href="https://flattr.com/thing/2053326/Gpg4win-Secure-email-and-file-encryption-with-GnuPG-for-Windows"
           target="_blank" title="Flattr this">
         <img src="img/flattr-icon.png" class="social-icon">
       </a>
       <a href="http://git.gnupg.org/cgi-bin/gitweb.cgi?p=gpg4win.git;a=summary" target="_blank" title="Gpg4win git repository">
         <img src="img/git-icon.png" class="social-icon">
       </a>
     </li>
    </ul>

    <ul>
     <li><b>
     m4_ifelse(LANG_DE, `1', `Über Gpg4win', `About Gpg4win')
     </b></li>
     MENU(`about', `Über Gpg4win', `About Gpg4win', `about', MAIN, LANG_DE)
     MENU(`features', `Funktionen', `Features', `features', MAIN, LANG_DE)
     MENU(`system-requirements', `System Voraussetzungen', `System Requirements', `system-requirements', SUB, LANG_DE)
     MENU(`documentation', `Dokumentation', `Documentation', `documentation', SUB, LANG_DE)
     MENU(`screenshots', `Screenshots', `Screenshots', `screenshots', MAIN, LANG_DE)
    </ul>
    <ul>
     <li><b>
     m4_ifelse(LANG_DE, `1', `Gemeinschaft', `Community')
     </b></li>
     MENU(`community', `Gemeinschaft', `Community', `community', SUB, LANG_DE)
     MENU(`contribute', `Zu Gpg4win beitragen', `Contribute to Gpg4win', `contribute', SUB, LANG_DE)
     MENU(`reporting-bugs', `- Probleme melden', `- Reporting Bugs', `reporting-bugs', SUB, LANG_DE)
     MENU(`build-installer', `- Bau von Gpg4win', `- Building of Gpg4win', `build-installer', SUB, LANG_DE)
     MENU(`website-maintenance', `- Website pflegen', `- Maintaining Website', `website-maintenance', SUB, LANG_DE)
     </li>
     m4_ifelse(LANG_DE, `1', `<li><a href="localize-gpg4win.html">- Gpg4win übersetzen</a></li>', `<li><a href="localize-gpg4win.html">- Translating Gpg4win</a></li>')
    </ul>
    <ul>
     <li><b>Support</b></li>
     MENU(`support', `Support', `Support', `support', MAIN, LANG_DE)
    </ul>
    <ul>
     <li><b>
     m4_ifelse(LANG_DE, `1', `Diverses', `Misc')
     </b></li>
     MENU(`donate', `Spenden', `Donate', `donate', SUB, LANG_DE)
     MENU(`license', `Lizenz', `License', `license', SUB, LANG_DE)
     m4_ifelse(LANG_DE, `1', `<li><a href="http://git.gnupg.org/cgi-bin/gitweb.cgi?p=gpg4win.git;a=summary">Quellcode</a></li>',
         `<li><a href="http://git.gnupg.org/cgi-bin/gitweb.cgi?p=gpg4win.git;a=summary">Source Code</a></li>')
     <li><a href="http://wiki.gnupg.org">Wiki</a></li>
     m4_ifelse(LANG_DE, `1', `<li><a href="http://wald.intevation.org/projects/gpg4win/">Entwicklungsplattform</a></li>',
         `<li><a href="http://wald.intevation.org/projects/gpg4win/">Development Platform</a></li>')
     m4_ifelse(LANG_DE, `1', `<li><a href="Kurzstudie-Nachhaltige-FS-Beispiel-Gpg4win.html">Kurzstudie Gpg4win</a></li>',
         `<li><a href="ShortStudy-Sustainable-FS-example-Gpg4win.html">Short Study Gpg4win</a></li>')
     MENU(`links', `Links', `Links', `links', SUB, LANG_DE)
     MENU(`contributors', `Mitwirkende', `Contributors', `contributors', SUB, LANG_DE)
     MENU(`impressum', `Impressum', `Legal Notice', `impressum', SUB, LANG_DE)
    </ul>
  </div>
  </div>
   </body>
</html>
m4_divert

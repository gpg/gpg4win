m4_dnl -*-html-*-
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

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta name="keywords" content="Gpg4win, GnuPG, WinPT, GPA, GPGol, GPGee, Claws Mail, E-Mail, Email, Windows, WinXP, XP, 2000, PGP, GPG, GnuPP, OpenPGP, Outlook, I18N(`EN', `Encryption, Secure') I18N(`DE', `Verschlüsselung, sicher, sichere, Sicherheit')">
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
    m4_ifelse(LANG_DE, `1', `<a href="index-de.html"></a>', `<a href="index.html"></a>')
   </li>
   MENU(`about', `Über Gpg4win', `About Gpg4win', `about', MAIN, LANG_DE)
    <ul>
     MENU(`about', `Über Gpg4win', `About Gpg4win', `about', SUB, LANG_DE)
     MENU(`features', `Funktionen', `Features', `features', SUB, LANG_DE)
     MENU(`screenshots', `Screenshots', `Screenshots', `screenshots', SUB, LANG_DE)
     <li class="subcap"></li>
    </ul>
   </li>
   MENU(`documentation', `Dokumentation', `Documentation', `using', MAIN, LANG_DE)
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
    m4_ifelse(LANG_DE, `1', `<a href="donate-de.html">Spenden!</a>', `<a href="donate.html">Donate</a>')
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
     <li><a href="index-de.html"><img src="img/logo_footer.png" alt="" /></a></li>
     <li><a href="download-de.html">Download</a></li>
    </ul>
    <ul>
     <li><b>
     m4_ifelse(LANG_DE, `1', `Über Gpg4win', `About Gpg4win')
     </b></li>
     MENU(`about', `Über Gpg4win', `About Gpg4win', `about', MAIN, LANG_DE)
     MENU(`features', `Funktionen', `Features', `features', MAIN, LANG_DE)
     MENU(`screenshots', `Screenshots', `Screenshots', `screenshots', MAIN, LANG_DE)
    </ul>
    <ul>
     <li><b>
     m4_ifelse(LANG_DE, `1', `Dokumentation', `Documentation')
     </b></li>
     MENU(`documentation', `Dokumentation', `Documentation', `documentation', SUB, LANG_DE)
    </ul>
    <ul>
     <li><b>
     m4_ifelse(LANG_DE, `1', `Gemeinschaft', `Community')
     </b></li>
     MENU(`community', `Gemeinschaft', `Community', `community', SUB, LANG_DE)
     MENU(`contribute', `Zu Gpg4win beitragen', `Contribute to Gpg4win', `contribute', SUB, LANG_DE)
     MENU(`reporting-bugs', `- Problemen melden', `- Reporting Bugs', `reporting-bugs', SUB, LANG_DE)
     MENU(`build-installer', `- Bau von Gpg4win', `- Build of Gpg4win', `build-installer', SUB, LANG_DE)
     </li>
     m4_ifelse(LANG_DE, `1', `<li><a href="localize-gpg4win.html">- Gpg4win übersetzen</a></li>', `<li><a href="localize-gpg4win.html">- Translate Gpg4win</a></li>')
    </ul>
    <ul>
     <li><b>Support</b></li>
     MENU(`support', `Professioneller Support', `Professional Support', `support', MAIN, LANG_DE)     
    </ul>
    <ul>
     <li><b>
     m4_ifelse(LANG_DE, `1', `Diverses', `Misc')     
     </b></li>
     MENU(`donate', `Spenden', `Donate', `donate', SUB, LANG_DE)
     MENU(`license', `Lizenz', `License', `license', SUB, LANG_DE)
     MENU(`links', `Links', `Links', `links', SUB, LANG_DE)
     m4_ifelse(LANG_DE, `1', `<li><a href="Kurzstudie-Nachhaltige-FS-Beispiel-Gpg4win.html">Kurzstudie Gpg4win</a></li>', 
         `<li><a href="ShortStudy-Sustainable-FS-example-Gpg4win.html">Short Study Gpg4win</a></li>')
     <li><a href="http://wald.intevation.org/projects/gpg4win/">Entwicklungsplattform</a></li>
     MENU(`contributors', `Mitwirkende', `Contributors', `contributors', SUB, LANG_DE)
     MENU(`impressum', `Impressum', `Impressum', `impressum', SUB, LANG_DE)
    </ul>
  </div>
  </div>

 </body>
</html>
m4_divert

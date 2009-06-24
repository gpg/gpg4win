m4_dnl -*-html-*-
m4_dnl THIS IS INCLUDED BY `template.m4'
m4_dnl DONT USE THIS FILE DIRECTLY
m4_ifdef(`__TMPL_ROOT',,`m4_define(`__TMPL_ROOT',`')')

m4_define(`__TITLE',m4_dnl
I18N(`EN',`EMail-Security using GnuPG for Windows')`'m4_dnl
I18N(`DE',`EMail-Sicherheit mit GnuPG für Windows'))

m4_ifdef(`__TMPL_PAGE_TITLE',,`m4_define(`__TMPL_PAGE_TITLE',`Gpg4win - '__TITLE)')

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta name="keywords" content="Gpg4win, GnuPG, WinPT, GPA, GPGol, GPGee, Claws Mail, E-Mail, Email, Windows, WinXP, XP, 2000, PGP, GPG, GnuPP, OpenPGP, Outlook, I18N(`EN', `Encryption, Secure') I18N(`DE', `Verschlüsselung, sicher, sichere, Sicherheit')">
    <link rel="stylesheet" type="text/css" href="__TMPL_ROOT`'gpg4win.css">
    <title>__TMPL_PAGE_TITLE</title>
  </head>
  <body>
  <div id="header">
    <table id="navbar">
      <tr valign="bottom">
        <td style="width:172px; text-align: left; padding-bottom: 8px;">
          <a href="I18N(`EN', `index.html') I18N(`DE', `index-de.html')"
            ><img src="pix/logo.png" alt="Gpg4win"></a>
        </td>
        <td style="text-align: left;">
          <h1>__TITLE</h1>
        </td>
        <td>
          LANG_LINK(`EN',`english', EN_FILE) |
          LANG_LINK(`DE',`deutsch', DE_FILE)
        </td>
      </tr>
    </table>
    <table id="bigbar">
      <tr><td id="vertable" style="white-space: nowrap;">
      I18N(`EN',`Version VERSION (<a href="change-history.html">Change History</a>) includes:')
      I18N(`DE',`Version VERSION (<a href="change-history-de.html">Änderungshistorie</a>) enthält:')
           <pre class="swlist">SOFTWARE</pre>
          </td>
          <td class="center">
            <a href="DLPAGE" class="dlbutton">Download<br> 
              <span class="version">Gpg4win VERSION <small>(DL_DATE)</small><br>Gpg4win 2.0.0 RC1 <small>(2009-06-23)</small><br></a>
                &nbsp;&nbsp;<a href="I18N(`EN', `./package-integrity.html') I18N(`DE', `./package-integrity-de.html')"
                  >SHA1/MD5/OpenPGP-Sig</a>
      </td></tr>
    </table>
  </div>
m4_include(I18N(`DE', `template_link_boxes_de.m4')`'m4_dnl
I18N(`EN', `template_link_boxes_en.m4'))
    <div id="main">
m4_divert(999)
    </div>
  </body>
</html>
m4_divert

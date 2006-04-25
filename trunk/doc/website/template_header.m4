m4_dnl -*-html-*-
m4_dnl THIS IS INCLUDED BY `template.m4'
m4_dnl DONT USE THIS FILE DIRECTLY
m4_ifdef(`__TMPL_ROOT',,`m4_define(`__TMPL_ROOT',`')')

m4_define(`__TITLE',m4_dnl
I18N(`EN',`EMail-Security using GnuPG for Windows')`'m4_dnl
I18N(`DE',`EMail-Sicherheit mit GnuPG für Windows'))

m4_ifdef(`__TMPL_PAGE_TITLE',,`m4_define(`__TMPL_PAGE_TITLE',`gpg4win - '__TITLE)')

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" type="text/css" href="__TMPL_ROOT`'gpg4win.css">
    <title>__TMPL_PAGE_TITLE</title>
  </head>
  <body>
    <table id="navbar">
      <tr valign="bottom">
        <td style="width:172px; text-align: left; padding-bottom: 8px;">
          <a href="I18N(`EN', `index.html') I18N(`DE', `index-de.html')"
            ><img src="pix/logo.png" alt="gpg4win"></a>
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
      I18N(`EN',`Version VERSION (DL_DATE) includes:')
      I18N(`DE',`Version VERSION (DL_DATE) enthält:')
            <br><pre class="swlist">SOFTWARE</pre>
          </td>
          <td class="center">
            <a href="DOWNLOAD_URL" class="dlbutton">Download<br> 
              <span class="version">gpg4win VERSION<br>
                I18N(`EN',`Size: ')I18N(`DE',`Größe: ')DL_SIZE</span></a>
                &nbsp;&nbsp;<a href="I18N(`EN', `./package-integrity.html') I18N(`DE', `./package-integrity-de.html')"
                  >SHA1/MD5/OpenPGP-Sig</a>
      </td></tr>
    </table>
    <div id="main">
m4_divert(999)
    </div>
  </body>
</html>
m4_divert

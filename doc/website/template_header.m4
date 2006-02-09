m4_dnl -*-html-*-
m4_dnl THIS IS INCLUDED BY `template.m4'
m4_dnl DONT USE THIS FILE DIRECTLY
m4_ifdef(`__TMPL_ROOT',,`m4_define(`__TMPL_ROOT',`')')
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" type="text/css" href="__TMPL_ROOT`'gpg4win.css">
    <title>gpg4win</title>
  </head>
  <body>
    <table id="navbar"><tr valign="bottom">
        <td style="width:172px; text-align: left; padding-bottom: 8px;">
          <img src="pix/logo.png">
        </td>
        <td style="text-align: left;">
          I18N(`EN',`<h1>EMail-Security using GnuPG for Windows</h1>')
          I18N(`DE',`<h1>EMail-Sicherheit mit GnuPG für Windows</h1>')
        </td>
        <td>
          LANG_LINK(`EN',`english',`index.html') |
          LANG_LINK(`DE',`deutsch',`index-de.html')
        </td>
    </table>
    <table id="bigbar">
      <tr><td id="vertable" style="white-space: nowrap;">
      I18N(`EN',`Current Version VERSION includes:')
      I18N(`DE',`Aktuelle Version VERSION enthält:' )
            <br><pre class="swlist">SOFTWARE</pre>
          </td>
          <td class="center">
            <a href="DOWNLOAD_URL" class="dlbutton">Download<br> 
              <span class="version">gpg4win VERSION</span></a>
      </td></tr>
    </table>
    <div id="main">
m4_divert(999)
    </div>
  </body>
</html>
m4_divert

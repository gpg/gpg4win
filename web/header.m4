  m4_ifdef(`FANCY_HEADER', `
  <div class="fancy_intro">
   <div id="download-button-container">
    <div id="download_button">
      m4_ifelse(LANG_DE, `1', `
      <a href="get-gpg4win-de.html">
      <span class="text">
        Download<br />Gpg4win VERSION
      </span></a>', `
      <a href="get-gpg4win.html">
      <span class="text">
        Download<br />Gpg4win VERSION
      </span></a>')
    </div>
    <div class="download_button_links">
      m4_ifelse(LANG_DE, `1', `
      <a href="download-de.html">Details</a>', `
      <a href="download.html">Details</a>')
      &middot;
      m4_ifelse(LANG_DE, `1', `
      <a href="change-history-de.html">Änderungshistorie</a>', `
      <a href="change-history.html">Change History</a>')
      &middot;
      m4_ifelse(LANG_DE, `1', `
      <a href="package-integrity-de.html">Integrität prüfen</a>', `
      <a href="package-integrity.html">Check integrity</a>')
    </div>
   </div>
   <a href="img/intro_screenshot.png" alt="Screenshot GpgOL & Kleopatra">
    <img src="img/intro_screenshot.png" id="fancy_bg"/>
   </a>
   <br/>
<!-- BETA
   <div id="download_button_mini">
     m4_ifelse(LANG_DE, `1', `
     <a class="dmini_button" href="version3.1.3-de.html">
     <span class="text">
      Try BETA_VERSION
     </span></a>', `
     <a class="dmini_button" href="version3.1.3.html">
     <span class="text">
      Try BETA_VERSION
     </span></a>')
   </div>
   <div class="h_text_beta">
-->
   <div class="h_text">
   <small>2023-07-14</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt"" />
     m4_ifelse(LANG_DE, `1', `
      <a href="version4.2-de.html">Gpg4win 4.2.0 veröffentlicht</a></span>',`
      <a href="version4.2.html">
        Gpg4win 4.2.0 released
      </a></span>')
   <p></p>
   <small>2022-12-20</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt"" />
     m4_ifelse(LANG_DE, `1', `
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce-de/2022/000062.html">
      Gpg4win 4.1.0 veröffentlicht</a>
      </span>',`
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce/2022/000099.html">
        Gpg4win 4.1.0 released
      </a>
      </span>')
   <p></p>
   <small>2022-10-17</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt"" />
     m4_ifelse(LANG_DE, `1', `
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce-de/2022/000061.html">
      Gpg4win 4.0.4 veröffentlicht</a>
      </span>',`
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce/2022/000098.html">
        Gpg4win 4.0.4 released
      </a>
      </span>')
   <p></p>
   <div class="limiter"></div>
   <p>
     m4_ifelse(LANG_DE, `1', `
     <a href="newsarchive-de.html">Newsarchiv</a>', `
     <a href="newsarchive.html">Archived News</a>')
    </p>
    <div class="limiter"></div>
    <div style="display: flex">
     m4_ifelse(LANG_DE, `1', `
     <h3 style="margin-right: 8pt;">Folgen Sie uns auf</h3>', `
     <h3 style="margin-right: 8pt;">Follow us on</h3>')
     <a style="display: flex;" href="https://mstdn.social/@GnuPG" target="_blank" rel="me" title="Follow @GnuPG@mstdn.social">
      <img id="mastodon-logo" src="img/src/logo_mastodon_yellow.svg" />
     </a>
    </div>
   </div>
  </div>', `
  <div class="mini_intro">
   <div id="breadcrum">m4_ifelse(LANG_DE, `1', `<a href="index-de.html">', `<a
   href="index.html">')Home</a> &raquo;
   m4_ifelse(LANG_DE, `1', `
   m4_ifelse(MAIN, `about', `Über Gpg4win')
   m4_ifelse(MAIN, `doc', `Dokumentation')
   m4_ifelse(MAIN, `community', `Gemeinschaft')
   m4_ifelse(MAIN, `support', `Support')
   m4_ifelse(MAIN, `download', `Download')
   m4_ifelse(MAIN, `donate', `Spenden')
   ')
   m4_ifelse(LANG_DE, `0', `
   m4_ifelse(MAIN, `about', `About Gpg4win')
   m4_ifelse(MAIN, `doc', `Documentation')
   m4_ifelse(MAIN, `community', `Community')
   m4_ifelse(MAIN, `support', `Support')
   m4_ifelse(MAIN, `download', `Download')
   m4_ifelse(MAIN, `donate', `Donate')
   ')
   </div>
   </div><br clear="all" />
  ')

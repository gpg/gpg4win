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
   <img src="img/fancy_bg.png" id="fancy_bg"/>
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
   <small>2022-07-12</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt"" />
     m4_ifelse(LANG_DE, `1', `
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce-de/2022/000060.html">Gpg4win 4.0.3 veröffentlicht</a></span>',`
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce/2022/000097.html">
        Gpg4win 4.0.3 released
      </a></span>')
   <p></p>
   <small>2022-04-22</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt"" />
     m4_ifelse(LANG_DE, `1', `
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce-de/2022/000059.html">
      Gpg4win 4.0.2 veröffentlicht</a>
      </span>',`
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce/2022/000095.html">
        Gpg4win 4.0.2 released
      </a>
      </span>')
   <p></p>
   <small>2021-12-21</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt"" />
     m4_ifelse(LANG_DE, `1', `
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce-de/2021/000058.html">
      Gpg4win 4.0.0 veröffentlicht</a>
      </span>',`
      <a href="https://lists.wald.intevation.org/pipermail/gpg4win-announce/2021/000094.html">
        Gpg4win 4.0.0 released
      </a>
      </span>')
   <p></p>
   <div class="limiter"></div>
   <p>
     m4_ifelse(LANG_DE, `1', `
     <a href="newsarchive-de.html">Newsarchiv</a>', `
     <a href="newsarchive.html">Archived News</a>')
    </p>
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

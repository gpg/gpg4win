  m4_ifdef(`FANCY_HEADER', `
  <div class="fancy_intro">
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
   <div class="h_text">
   <p><span class="heading">News</span></p>
   <small>2017-09-20</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt"" />
     m4_ifelse(LANG_DE, `1', `
      <a href="version3-de.html">
        Gpg4win 3.0.0 veröffentlicht
      </a></span>
      <br><small><a href="https://files.gpg4win.org/press/3.0/PM-Gpg4win-3.0.pdf">Pressemitteilung</a></small>',`
      <a href="version3.html">
        Gpg4win 3.0.0 released
      </a></span>')
   <p></p>
   <small>2017-08-24</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt"" />
     m4_ifelse(LANG_DE, `1', `
       <a href="http://lists.wald.intevation.org/pipermail/gpg4win-announce/2017-August/000072.html">
         Gpg4win 3.0 erreicht Release Candidate Status
       </a></span>',`
       <a href="http://lists.wald.intevation.org/pipermail/gpg4win-announce/2017-August/000072.html">
         Gpg4win 3.0 has release candidate status
       </a></span>')
   <p></p>
   <div class="limiter"></div>
   <p>
     m4_ifelse(LANG_DE, `1', `
     Ältere Meldungen im <a href="newsarchive-de.html">Newsarchiv</a>.', `
     Older messages in <a href="newsarchive.html">news archive</a>.')
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
   <div id="download_button_mini"></div></div><br clear="all" />
  ')

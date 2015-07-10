  m4_ifdef(`FANCY_HEADER', `
  <div class="fancy_intro">
   <div id="download_button">
     m4_ifelse(LANG_DE, `1', `
     <a href="download-de.html">
     <span class="text">
      Download<br />Gpg4win
     </span></a>', `
     <a href="download.html">
     <span class="text">
      Download<br />Gpg4win
     </span></a>')
   </div>
   <div class="download_button_links">
     m4_ifelse(LANG_DE, `1', `
     <a href="change-history-de.html">Änderungshistorie</a>', `
     <a href="change-history.html">Change History</a>')
     -
     m4_ifelse(LANG_DE, `1', `
     <a href="package-integrity-de.html">Integrität prüfen</a>', `
     <a href="package-integrity.html">Check integrity</a>')
   </div>
   <div class="h_text">
   <p><span class="heading">News</span></p>
   <small>2015-07-10</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt="" />
     m4_ifelse(LANG_DE, `1', `
     <a href="download-de.html">Gpg4win 2.2.5 veröffentlicht</a></span>', `
     <a href="download.html">Gpg4win 2.2.5 released</a></span>')
   <p></p>
   <small>2015-03-18</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt="" />
     m4_ifelse(LANG_DE, `1', `
     <a href="http://lists.wald.intevation.org/pipermail/gpg4win-announce-de/2015-March/000027.html">Gpg4win 2.2.4 veröffentlicht</a></span>', `
     <a href="http://lists.wald.intevation.org/pipermail/gpg4win-announce/2015-March/000063.html">Gpg4win 2.2.4 released</a></span>')
   <p></p>
   <small>2014-11-26</small><br>
   <span class="serif_word"><img src="img/bulletin.png" alt="" />
     m4_ifelse(LANG_DE, `1', `
     <a href="http://lists.wald.intevation.org/pipermail/gpg4win-announce-de/2014-November/000026.html">Gpg4win 2.2.3 veröffentlicht</a></span>', `
     <a href="http://lists.wald.intevation.org/pipermail/gpg4win-announce/2014-November/000062.html">Gpg4win 2.2.3 released</a></span>')
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
  m4_ifdef(`NO_DOWNLOAD_HEADER',`
   <div id="download_button_mini"></div></div><br clear="all" />', `
   <div id="download_button_mini">
    m4_ifelse(LANG_DE, `1', `
    <a class="dmini_button" href="download-de.html">
    ', `
    <a class="dmini_button" href="download.html">
    ')
     <span class="text">
      Download Gpg4win 
     </span>
    </a>
    <br>
    <span class="links">
     m4_ifelse(LANG_DE, `1', `
     <a href="change-history-de.html">Änderungshistorie</a>', `
     <a href="change-history.html">Change History</a>')
     -
     m4_ifelse(LANG_DE, `1', `
     <a href="package-integrity-de.html">Integrität prüfen</a>', `
     <a href="package-integrity.html">Check integrity</a>')
    </span>
   </div>
  </div>
  <br clear="all" />
  ')')

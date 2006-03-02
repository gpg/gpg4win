<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
     "http://www.w3.org/TR/html4/strict.dtd">
m4_dnl $Id: template.m4,v 1.3 2005/05/02 09:03:34 wilde Exp $

m4_dnl ------------------------------------------------------------
m4_dnl Macros to use in Pages

m4_include(`versions.m4')

m4_define(`LANG_LINK',`m4_ifdef(`$1',`$2',`<a href="$3">$2</a>')')
m4_define(`I18N',`m4_ifdef(`$1',`$2')')

m4_define(`PAGE_TITLE',`m4_define(`__TMPL_PAGE_TITLE',`$1')')
m4_define(`PAGE_ROOT',`m4_define(`__TMPL_ROOT',`$1')')
m4_define(`PAGE_START',`m4_include(`template_header.m4')')
m4_define(`PAGE_BOXES',`m4_divert(1)</div><div id="boxes">')
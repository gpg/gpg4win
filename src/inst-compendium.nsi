# inst-compendium.nsi - Installer snippet       -*- coding: latin-1; -*-
# Copyright (C) 2008 g10 Code GmbH
# 
# This file is part of Gpg4win.
# 
# Gpg4win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# Gpg4win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.


!ifdef prefix
!undef prefix
!endif


${MementoSection} "$(DESC_Name_compendium)" SEC_compendium
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  # No need to include anything as the manuals are part of gpg4win
!else

  SetOutPath "$INSTDIR\share\gpg4win"
  File "${BUILD_DIR}/../doc/manual/gpg4win-compendium-*.pdf"
!endif
${MementoSectionEnd}


# The name of the installer component.
LangString DESC_Name_compendium ${LANG_ENGLISH} \
   "Gpg4win Compendium"
# The description text used in the installer components dialog.
LangString DESC_SEC_compendium ${LANG_ENGLISH} \
   "The Gpg4win documentation (English and German)"

# The name of the PDF version of the link
LangString DESC_Name_compendium_de_pdf ${LANG_ENGLISH} \
   "Gpg4win Compendium (pdf, German)"
LangString DESC_Name_compendium_en_pdf ${LANG_ENGLISH} \
   "Gpg4win Compendium (pdf, English)"

# The name of the HTML version of the link
LangString DESC_Name_compendium_de_html ${LANG_ENGLISH} \
   "Gpg4win Compendium (html, German)"
LangString DESC_Name_compendium_en_html ${LANG_ENGLISH} \
   "Gpg4win Compendium (html, English)"

# The string displayed in the startmenu for the PDF version.
LangString DESC_Menu_compendium_de_pdf ${LANG_ENGLISH} \
   "Show the Gpg4win Compendium (pdf, German)"
LangString DESC_Menu_compendium_en_pdf ${LANG_ENGLISH} \
   "Show the Gpg4win Compendium (pdf, English)"

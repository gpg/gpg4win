# g4wihelp.nsi - Access g4wihelp.dll.      -*- coding: latin-1; -*-
# Copyright (C) 2005 g10 Code GmbH
# 
# This file is part of GPG4Win.
# 
# GPG4Win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# GPG4Win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA


LangString T_AlreadyRunning ${LANG_ENGLISH} \
   "An instance of this installer is already running."
LangString T_AlreadyRunning ${LANG_GERMAN} \
   "Ein Exemplar dieses Installers läuft bereits."


#Function G4wTest
#  Push $R0
#  Push $R1
#  StrCpy $R0 "mein argument 0"
#  StrCpy $R1 "mein argument 1"
#  g4wihelp::dummy 
#  Pop $R1
#  Pop $R0
#FunctionEnd

Function G4wRunOnce
  Push $R0
  StrCpy $R0 "gpg4win"
  g4wihelp::runonce
  StrCmp $R0 0 +3
     MessageBox MB_OK $(T_AlreadyRunning)
     Abort
  Pop $R0
FunctionEnd


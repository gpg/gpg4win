# g4wihelp.nsi - Access g4wihelp.dll.      -*- coding: latin-1; -*-
# Copyright (C) 2005, 2023 g10 Code GmbH
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


# AddToPath - Adds the given dir to the search path.
#        Input - head of the stack
Function G4wAddToPath
  ClearErrors
  UserInfo::GetName
  IfErrors add_admin
  Pop $0
  UserInfo::GetAccountType
  Pop $1
  StrCmp $1 "Admin" add_admin add_user

add_admin:
  Exch $0
  g4wihelp::path_add "$0" "0"
  goto add_done
add_user:
  Exch $0
  g4wihelp::path_add "$0" "1"
  goto add_done

add_done:
  StrCmp $R5 "0" add_to_path_done
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
  add_to_path_done:
  Pop $0
FunctionEnd


# RemoveFromPath - Remove a given dir from the path
#     Input: head of the stack
Function G4wRemoveFromPath
  ClearErrors
  UserInfo::GetName
  IfErrors remove_admin
  Pop $0
  UserInfo::GetAccountType
  Pop $1
  StrCmp $1 "Admin" remove_admin remove_user

remove_admin:
  Exch $0
  g4wihelp::path_remove "$0" "0"
  goto remove_done
remove_user:
  Exch $0
  g4wihelp::path_remove "$0" "1"
  goto remove_done

remove_done:
  StrCmp $R5 "0" remove_from_path_done
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
  remove_from_path_done:
  Pop $0
FunctionEnd

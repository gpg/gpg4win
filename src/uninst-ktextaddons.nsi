# Copyright (C) 2024 g10 Code GmbH
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
; Uninstaller section.
Section "-un.ktextaddons"
  Delete "$INSTDIR\bin\libKF6TextAddonsWidgets.dll"
  Delete "$INSTDIR\bin\libKF6TextAutoCorrectionCore.dll"
  Delete "$INSTDIR\bin\libKF6TextAutoCorrectionWidgets.dll"
  Delete "$INSTDIR\bin\libKF6TextCustomEditor.dll"
  Delete "$INSTDIR\bin\libKF6TextEditTextToSpeech.dll"
  Delete "$INSTDIR\bin\libKF6TextEmoticonsCore.dll"
  Delete "$INSTDIR\bin\libKF6TextEmoticonsWidgets.dll"
  Delete "$INSTDIR\bin\libKF6TextGrammarCheck.dll"
  Delete "$INSTDIR\bin\libKF6TextSpeechToText.dll"
  Delete "$INSTDIR\bin\libKF6TextTranslator.dll"
  Delete "$INSTDIR\bin\libKF6TextUtils.dll"
  RmDir "$INSTDIR\bin"
SectionEnd

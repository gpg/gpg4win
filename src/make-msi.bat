REM Usage: make-msi.bat [-L{de|en}] [FILE]
REM Defaults: -Len gpg4win.wix
REM 
set WIXPATH=%ProgramFiles%\"Windows Installer XML v3"\bin

set LANG=en-us
IF NOT "%1"=="-Lde" GOTO langde
  shift
  set LANG=de-de
  GOTO langset
:langde
IF NOT "%1"=="-Len" GOTO langen
  shift
  set LANG=en-us
  GOTO langset
:langen

:langset


set FILE=gpg4win.wix
IF "%1"=="" GOTO nofile
  set FILE=%1
:nofile


REM We want to catch error, so always clean.
del msi-custom-license.wixobj
del msi-custom-ui.wixobj
del %FILE%.wixobj
del %FILE%.msi

%WIXPATH%\candle.exe msi-custom-license.wxs
IF ERRORLEVEL 1 GOTO End
%WIXPATH%\candle.exe msi-custom-ui.wxs
IF ERRORLEVEL 1 GOTO End
%WIXPATH%\candle.exe %FILE%.wxs
IF ERRORLEVEL 1 GOTO End
REM Validity tests disabled with -sval due to non-advertised shortcuts.
%WIXPATH%\light.exe -sval -ext WixUIExtension -ext WixUtilExtension -cultures:%LANG% msi-custom-license.wixobj msi-custom-ui.wixobj %FILE%.wixobj -out %FILE%.msi
IF ERRORLEVEL 1 GOTO End

:End

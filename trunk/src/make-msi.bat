REM Usage: make-msi.bat [-L{de|en}] [FILE]
REM Defaults: -Len gpg4win.wix
REM 
set WIXPATH=C:\"Program Files"\"Windows Installer XML v3"\bin

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

%WIXPATH%\candle.exe %FILE%
%WIXPATH%\light.exe -ext WixUIExtension -cultures:%LANG% %FILE%obj

%WIXPATH%\candle.exe %FILE%
%WIXPATH%\light.exe -ext WixUIExtension -cultures:%LANG% %FILE%obj

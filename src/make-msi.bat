set WIXPATH=C:\"Program Files"\"Windows Installer XML v3"\bin

%WIXPATH%\candle.exe gpg4win.wix
%WIXPATH%\light.exe -ext WixUIExtension -cultures:en-us gpg4win.wixobj

@echo off
setlocal EnableDelayedExpansion

echo --- Migrating your OpenPGP Certificates (Public Keys) to the new Keyboxd format ---
echo Shutting down Kleopatra...
TASKKILL /F /IM kleopatra.exe 2>NUL
echo Shutting down background processes...
gpgconf --kill all
FOR /F "tokens=*" %%g IN ('gpgconf -L homedir') do (set GPGH=%%~g)
if "!GPGH!" == "" echo Failed to find homedir && exit /b 1
echo Using "!GPGH!" as GnuPG Homedir.
echo Exporting OpenPGP certificates to !GPGH!\keyboxd-migration-bkp-openpgp.gpg"
gpg --export-options backup --export > "!GPGH!\keyboxd-migration-bkp-openpgp.gpg" || echo Failed to export OpenPGP certs && exit /B 1
echo Exporting X509 certificates to !GPGH!\keyboxd-migration-bkp-x509.pem"
gpgsm --export -a > "!GPGH!\keyboxd-migration-bkp-x509.pem" || echo Failed to export X509 certs && exit /B 1

if exist "!GPGH!\common.conf" (
    echo Backing up common.conf to common.conf_sik
    copy /Y "!GPGH!\common.conf" "!GPGH!\common.conf_sik"
)

echo Enabling keyboxd in common.conf
echo use-keyboxd > "!GPGH!\common.conf"

echo Importing OpenPGP certificates... this might take a while
rem in tests with larger keyrings error handling resulted in too many false positive errors see: T6596
gpg --no-auto-check-trustdb --import-options keep-ownertrust,bulk-import,restore --import "!GPGH!\keyboxd-migration-bkp-openpgp.gpg"
rem || echo Failed to import OpenPGP keys. Please report this to https://dev.gnupg.org/u/rgpg4win && del "!GPGH!\common.conf" && exit /B 1
echo Importing X509 certificates... this might take a while
gpgsm --disable-dirmngr --import "!GPGH!\keyboxd-migration-bkp-X509.pem"
rem || echo Failed to import X509 certs. Please report the output to https://dev.gnupg.org/u/rgpg4win && del "!GPGH!\common.conf" && exit /B 1

echo Checking database..
gpg --check-trustdb
echo All done.
echo Your certificates are now stored in "!GPGH!\public-keys.d"
echo Please report issues https://dev.gnupg.org/u/rgpg4win

echo If you encounter issues you can switch back by using "gpg-disable-keyboxd"

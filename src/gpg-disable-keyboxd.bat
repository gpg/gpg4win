@echo off
setlocal EnableDelayedExpansion

echo --- Migrating your OpenPGP Certificates (Public Keys) from Keyboxd to the old format ---
echo --- If this fails or produces empty results your certificates are in the state where you migrated to keybox in the first place ---
echo Shutting down Kleopatra...
TASKKILL /F /IM kleopatra.exe 2>NUL
echo Shutting down background processes...
gpgconf --kill all
FOR /F "tokens=*" %%g IN ('gpgconf -L homedir') do (set GPGH=%%~g)
if "!GPGH!" == "" echo Failed to find homedir && exit /b 1
echo Using "!GPGH!" as GnuPG Homedir.
echo Exporting OpenPGP certificates to !GPGH!\pubring-migration-bkp-openpgp.gpg"
gpg --export-options backup --export > "!GPGH!\pubring-migration-bkp-openpgp.gpg" || echo Failed to export OpenPGP certs && exit /B 1
echo Exporting X509 certificates to !GPGH!\pubring-migration-bkp-x509.pem"
gpgsm --export -a > "!GPGH!\pubring-migration-bkp-x509.pem" || echo Failed to export X509 certs && exit /B 1

echo Disabling keyboxd by deleting common.conf
del "!GPGH!\common.conf"

echo Importing OpenPGP certificates... this might take a while
rem in tests with larger keyrings error handling resulted in too many false positive errors see: T6596
gpg --no-auto-check-trustdb --import-options keep-ownertrust,bulk-import,restore --import "!GPGH!\pubring-migration-bkp-openpgp.gpg"
rem || echo Failed to import OpenPGP keys. Please report this to https://dev.gnupg.org/u/rgpg4win && del "!GPGH!\common.conf" && exit /B 1
echo Importing X509 certificates... this might take a while
gpgsm --disable-dirmngr --import "!GPGH!\pubring-migration-bkp-X509.pem"
rem || echo Failed to import X509 certs. Please report the output to https://dev.gnupg.org/u/rgpg4win && del "!GPGH!\common.conf" && exit /B 1

echo Checking database..
gpg --check-trustdb
echo All done.

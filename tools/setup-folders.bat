@echo off
setlocal

set SERVER_PATH=C:\FXServer\server

echo FiveM mappenstructuur maken in %SERVER_PATH%

mkdir "%SERVER_PATH%" 2>nul
mkdir "%SERVER_PATH%\resources" 2>nul
mkdir "%SERVER_PATH%\resources\[qb]" 2>nul
mkdir "%SERVER_PATH%\resources\[ox]" 2>nul
mkdir "%SERVER_PATH%\resources\[standalone]" 2>nul
mkdir "%SERVER_PATH%\resources\[jv]" 2>nul
mkdir "%SERVER_PATH%\backups" 2>nul

echo Klaar.
pause

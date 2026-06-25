@echo off
setlocal

set SERVER_PATH=C:\FXServer\server
set BACKUP_PATH=%SERVER_PATH%\backups\backup

echo Backup maken naar %BACKUP_PATH%
mkdir "%BACKUP_PATH%" 2>nul

xcopy "%SERVER_PATH%\resources" "%BACKUP_PATH%\resources" /E /I /Y
copy "%SERVER_PATH%\server.cfg" "%BACKUP_PATH%\server.cfg" /Y

echo Backup klaar.
pause

@echo off
setlocal

REM =========================================================
REM Jv420 FiveM Server Starter
REM Pas FXSERVER_PATH aan naar jouw FXServer map.
REM =========================================================

set FXSERVER_PATH=C:\FXServer\server
set ARTIFACT_EXE=%FXSERVER_PATH%\FXServer.exe
set SERVER_CFG=%FXSERVER_PATH%\server.cfg

title Jv420 FiveM Server
color 0A

echo ========================================
echo      Jv420 FiveM Server Starter
echo ========================================
echo.

if not exist "%ARTIFACT_EXE%" (
  echo [FOUT] FXServer.exe niet gevonden:
  echo %ARTIFACT_EXE%
  echo.
  echo Pas FXSERVER_PATH aan in start-server.bat
  pause
  exit /b 1
)

if not exist "%SERVER_CFG%" (
  echo [FOUT] server.cfg niet gevonden:
  echo %SERVER_CFG%
  echo.
  echo Kopieer server.cfg.example naar server.cfg en vul je key in.
  pause
  exit /b 1
)

cd /d "%FXSERVER_PATH%"
"%ARTIFACT_EXE%" +exec server.cfg

echo.
echo Server is gestopt.
pause

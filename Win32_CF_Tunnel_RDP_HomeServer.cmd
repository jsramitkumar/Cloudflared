::cloudflared access rdp --hostname hq-srv-jsr.endusercompute.in --url rdp://localhost:3381


@echo off
setlocal enabledelayedexpansion

:: RDP Connection Script via Cloudflared
:: Configure these variables for your setup
set CLOUDFLARED_PATH=C:\Program Files (x86)\cloudflared\cloudflared.exe
set TUNNEL_HOSTNAME=hq-srv-jsr.endusercompute.in
set RDP_LOCAL_PORT=3381
set RDP_HOST=localhost
set RDP_USERNAME=Administrator

echo ====================================
echo   RDP via Cloudflared Connection Tool
echo ====================================
echo.

:: Check if cloudflared exists
if not exist "%CLOUDFLARED_PATH%" (
    echo ERROR: Cloudflared executable not found at specified path.
    echo Please edit this script and update the CLOUDFLARED_PATH variable.
    echo.
    pause
    exit /b 1
)

:: Start cloudflared connection in background
echo Starting Cloudflared tunnel to %TUNNEL_HOSTNAME%...
start "" "%CLOUDFLARED_PATH%" access rdp --hostname %TUNNEL_HOSTNAME% --url localhost:%RDP_LOCAL_PORT%
echo Waiting for tunnel to establish...
timeout /t 3 /nobreak > nul

:: Launch RDP connection
echo Launching RDP connection to %RDP_HOST%:%RDP_LOCAL_PORT%...
start "" mstsc.exe /v:%RDP_HOST%:%RDP_LOCAL_PORT% /admin /f

echo.
echo Connection established. You can close this window once you're done with your RDP session.
echo To fully disconnect, you may need to end the cloudflared process from Task Manager.
echo.
pause
exit /b 0
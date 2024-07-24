@echo off
setlocal

:: Get the directory path of the batch file
set "BASEPATH=%~dp0"

:: Save the path to the scripts directory
set "MITMPROXYSCRIPTFOLDER=%BASEPATH%scripts"

:: Start the Node.js project
start cmd.exe /k "cd /d "%BASEPATH%" && npm install && npx tsc && npm run dev"

:: Check if mitmproxy is installed in the install directory
if exist "C:\Program Files\mitmproxy\bin\mitmweb.exe" (
    start cmd.exe /k "cd /d "%MITMPROXYSCRIPTFOLDER%" && "C:\Program Files\mitmproxy\bin\mitmweb.exe" --mode wireguard --set connection_strategy=lazy --allow-hosts gc-openapi-zinny3.kakaogames.com --allow-hosts gc-infodesk-zinny3.kakaogames.com --allow-hosts na.wdfp.kakaogames.com --allow-hosts patch.wdfp.kakaogames.com -s mitm-redirect-traffic.py"
) else (
    start cmd.exe /k "cd /d "%MITMPROXYSCRIPTFOLDER%" && echo mitmproxy is not installed at 'C:\Program Files\mitmproxy'. Install from https://mitmproxy.org"
)

echo Starting both Node.js server and mitmweb...
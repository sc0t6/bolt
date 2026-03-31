@echo off
echo Disabling Multi-Plane Overlay (MPO)...

reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" ^
/v OverlayTestMode /t REG_DWORD /d 5 /f

echo Done. Restart required.
pause
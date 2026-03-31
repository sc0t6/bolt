@echo off
echo Disabling IPv6...

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" ^
/v DisabledComponents /t REG_DWORD /d 255 /f

echo Done. Restart required.
pause
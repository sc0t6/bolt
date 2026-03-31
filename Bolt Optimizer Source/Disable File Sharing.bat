@echo off
title Disable File Sharing & Remote Access

echo Disabling administrative shares...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" ^
/v AutoShareWks /t REG_DWORD /d 0 /f >nul 2>&1

echo Stopping and disabling Server service (file sharing)...
net stop LanmanServer >nul 2>&1
sc config LanmanServer start= disabled >nul 2>&1

echo Disabling SMBv1 (legacy protocol)...
dism /online /norestart /disable-feature /featurename:SMB1Protocol >nul 2>&1

echo Disabling Remote Desktop...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" ^
/v fDenyTSConnections /t REG_DWORD /d 1 /f >nul 2>&1

echo Disabling Remote Desktop firewall rules...
netsh advfirewall firewall set rule group="remote desktop" new enable=No >nul 2>&1

echo Disabling Network Discovery...
netsh advfirewall firewall set rule group="Network Discovery" new enable=No >nul 2>&1

echo Disabling File and Printer Sharing firewall rules...
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No >nul 2>&1

echo Disabling Remote Registry service...
net stop RemoteRegistry >nul 2>&1
sc config RemoteRegistry start= disabled >nul 2>&1

echo Done. Restart recommended.
pause
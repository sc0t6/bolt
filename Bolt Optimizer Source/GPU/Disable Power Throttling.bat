@echo off
echo Disabling power throttling...

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" ^
/v PowerThrottlingOff /t REG_DWORD /d 1 /f

echo Done. Restart required.
pause
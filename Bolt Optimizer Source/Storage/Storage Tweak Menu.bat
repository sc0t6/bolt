@echo off
:: ==== ADMIN CHECK ====
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Storage Tweaks made by zippo.
color 0B

:menu
cls
echo ================================
echo        STORAGE TWEAKS
echo ================================
echo.
echo 1. Performance tweaks (NTFS + caching)
echo 2. Reduce background disk usage
echo 3. Storage cleanup
echo 4. SSD tweaks
echo 5. HDD tweaks
echo 6. Reduce disk writes
echo 7. Health checks
echo 8. Apply ALL tweaks
echo 9. Exit
echo.
set /p c=Select option (1-9): 

if "%c%"=="1" goto perf
if "%c%"=="2" goto bg
if "%c%"=="3" goto clean
if "%c%"=="4" goto ssd
if "%c%"=="5" goto hdd
if "%c%"=="6" goto writes
if "%c%"=="7" goto health
if "%c%"=="8" goto all
if "%c%"=="9" exit
goto menu

:perf
echo Applying performance tweaks...
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1
echo Done.
pause
goto menu

:bg
echo Disabling background disk services...
sc stop SysMain >nul 2>&1
sc config SysMain start=disabled >nul 2>&1
sc stop WSearch >nul 2>&1
sc config WSearch start=disabled >nul 2>&1
echo Done.
pause
goto menu

:clean
echo Cleaning storage...
del /s /f /q "%temp%\*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*" >nul 2>&1
net stop wuauserv >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution" >nul 2>&1
net start wuauserv >nul 2>&1
cleanmgr /sageset:1
cleanmgr /sagerun:1
echo Done.
pause
goto menu

:ssd
echo Applying SSD tweaks...
fsutil behavior set DisableDeleteNotify 0
echo TRIM enabled.
pause
goto menu

:hdd
echo Applying HDD tweaks...
fsutil behavior set memoryusage 2
powercfg -change -disk-timeout-ac 0
echo Done.
pause
goto menu

:writes
echo Reducing disk writes...
powercfg -h off
echo Hibernation disabled.
pause
goto menu

:health
echo Drive SMART status:
wmic diskdrive get status
echo.
echo Checking filesystem (online scan)...
chkdsk C: /scan
pause
goto menu

:all
echo Applying ALL tweaks...
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1

sc stop SysMain >nul 2>&1
sc config SysMain start=disabled >nul 2>&1
sc stop WSearch >nul 2>&1
sc config WSearch start=disabled >nul 2>&1

del /s /f /q "%temp%\*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*" >nul 2>&1
net stop wuauserv >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution" >nul 2>&1
net start wuauserv >nul 2>&1

fsutil behavior set DisableDeleteNotify 0
fsutil behavior set memoryusage 2
powercfg -change -disk-timeout-ac 0
powercfg -h off

echo ALL tweaks applied. Reboot recommended.
pause
goto menu

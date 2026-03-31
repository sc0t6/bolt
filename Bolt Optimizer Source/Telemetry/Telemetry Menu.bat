@echo off
title zippos telemetry cleaner
color 1F

:menu
cls
echo ===========================================
echo          	Telemetry Cleaner
echo ===========================================
echo.
echo 1. Disable Windows Telemetry Services
echo 2. Clear Windows Diagnostic & Telemetry Logs
echo 3. Disable Cortana Data Collection
echo 4. Disable Feedback Notifications
echo 5. Clear Microsoft Store App Cache
echo 6. Clear OneDrive Activity Logs
echo 7. Clear Microsoft Edge Tracking Data
echo 8. Clean EVERYTHING (cleans all from the options)
echo 9. Exit
echo.
set /p choice="Select an option (1-9): "

if "%choice%"=="1" goto disable_telemetry
if "%choice%"=="2" goto clear_logs
if "%choice%"=="3" goto disable_cortana
if "%choice%"=="4" goto disable_feedback
if "%choice%"=="5" goto clear_store
if "%choice%"=="6" goto clear_onedrive
if "%choice%"=="7" goto clear_edge
if "%choice%"=="8" goto clean_all
if "%choice%"=="9" goto exit
echo Invalid choice, try again.
pause
goto menu

:disable_telemetry
echo Disabling Windows Telemetry services...
sc stop "DiagTrack"
sc config "DiagTrack" start= disabled
sc stop "dmwappushservice"
sc config "dmwappushservice" start= disabled
echo Telemetry services disabled.
pause
goto menu

:clear_logs
echo Clearing diagnostic and telemetry logs...
wevtutil cl Microsoft-Windows-Diagnostics-Performance/Operational
wevtutil cl Microsoft-Windows-WindowsUpdateClient/Operational
wevtutil cl Microsoft-Windows-Diagnostics-Networking/Operational
del /f /s /q "%ProgramData%\Microsoft\Diagnosis\*.*"
echo Logs cleared.
pause
goto menu

:disable_cortana
echo Disabling Cortana data collection...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
echo Cortana data collection disabled.
pause
goto menu

:disable_feedback
echo Disabling feedback notifications...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_QWORD /d 0 /f
echo Feedback notifications disabled.
pause
goto menu

:clear_store
echo Clearing Microsoft Store cache...
wsreset.exe
echo Microsoft Store cache cleared.
pause
goto menu

:clear_onedrive
echo Clearing OneDrive activity logs...
del /f /s /q "%LocalAppData%\Microsoft\OneDrive\logs\*.*"
echo OneDrive activity logs cleared.
pause
goto menu

:clear_edge
echo Clearing Microsoft Edge tracking and cache...
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*.*"
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cookies"
echo Edge tracking and cache cleared.
pause
goto menu

:clean_all
echo Running ALL safe cleanup tasks...
call :disable_telemetry
call :clear_logs
call :disable_cortana
call :disable_feedback
call :clear_store
call :clear_onedrive
call :clear_edge
echo ===========================================
echo All safe telemetry and cache cleanup tasks completed!
pause
goto menu

:exit
echo Exiting Ultimate Telemetry Cleaner...
pause
exit
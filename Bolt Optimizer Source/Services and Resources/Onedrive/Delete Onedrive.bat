@echo off
title Uninstall OneDrive

echo Killing OneDrive process...
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1

echo Detecting system architecture...
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo Uninstalling OneDrive (x64)...
    %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall
) else (
    echo Uninstalling OneDrive (x86)...
    %SYSTEMROOT%\System32\OneDriveSetup.exe /uninstall
)

echo Disabling OneDrive sync via registry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\OneDrive" /v PreventNetworkTrafficPreUserSignIn /t REG_DWORD /d 1 /f

echo Deleting OneDrive scheduled tasks...
SCHTASKS /Delete /TN "OneDrive Standalone Update Task" /F > NUL 2>&1
SCHTASKS /Delete /TN "OneDrive Standalone Update Task v2" /F > NUL 2>&1

echo Done.
pause
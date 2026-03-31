@echo off
:: ============================================================
::  Disable AI Services - Cortana, Copilot, Bing Search
::  Applies registry settings for Windows 10 and 11
:: ============================================================

:: Check for administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: This script must be run as Administrator.
    echo Right-click the file and select "Run as administrator".
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  Disabling AI Services (Cortana, Copilot, Bing Search)
echo ============================================================
echo.

:: ------------------------------------------------------------
::  Windows AI and Copilot Registry Settings
:: ------------------------------------------------------------
echo [1/2] Applying Windows AI and Copilot settings...

:: Disable AI Data Analysis (HKCU)
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: HKCU WindowsAI - DisableAIDataAnalysis) else echo   [OK] HKCU WindowsAI - DisableAIDataAnalysis

:: Disable AI Data Analysis (HKLM)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: HKLM WindowsAI - DisableAIDataAnalysis) else echo   [OK] HKLM WindowsAI - DisableAIDataAnalysis

:: Hide Copilot button from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: ShowCopilotButton) else echo   [OK] ShowCopilotButton = 0

:: Disable Edge Copilot / AI features
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v DefaultBrowserSettingsCampaignEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: Edge - DefaultBrowserSettingsCampaignEnabled) else echo   [OK] Edge - DefaultBrowserSettingsCampaignEnabled = 0

reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ComposeInlineEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: Edge - ComposeInlineEnabled) else echo   [OK] Edge - ComposeInlineEnabled = 0

:: Turn off Windows Copilot (HKCU)
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: HKCU WindowsCopilot - TurnOffWindowsCopilot) else echo   [OK] HKCU WindowsCopilot - TurnOffWindowsCopilot = 1

:: Turn off Windows Copilot (HKLM)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: HKLM WindowsCopilot - TurnOffWindowsCopilot) else echo   [OK] HKLM WindowsCopilot - TurnOffWindowsCopilot = 1

:: ------------------------------------------------------------
::  Disable Cortana, Web Search, and Search History
:: ------------------------------------------------------------
echo.
echo [2/2] Disabling Cortana, web search, and search history...

:: Disable device search history
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDeviceSearchHistoryEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: IsDeviceSearchHistoryEnabled) else echo   [OK] IsDeviceSearchHistoryEnabled = 0

:: Cortana and web search policies (HKLM)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: AllowCortana) else echo   [OK] AllowCortana = 0

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: DisableWebSearch) else echo   [OK] DisableWebSearch = 1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: ConnectedSearchUseWeb) else echo   [OK] ConnectedSearchUseWeb = 0

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWebOverMeteredConnections /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: ConnectedSearchUseWebOverMeteredConnections) else echo   [OK] ConnectedSearchUseWebOverMeteredConnections = 0

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: AllowCloudSearch) else echo   [OK] AllowCloudSearch = 0

:: Search history and location (HKCU)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v HistoryViewEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: HistoryViewEnabled) else echo   [OK] HistoryViewEnabled = 0

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v DeviceHistoryEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: DeviceHistoryEnabled) else echo   [OK] DeviceHistoryEnabled = 0

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: AllowSearchToUseLocation) else echo   [OK] AllowSearchToUseLocation = 0

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: BingSearchEnabled) else echo   [OK] BingSearchEnabled = 0

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (echo   [WARN] Failed: CortanaConsent) else echo   [OK] CortanaConsent = 0

:: ------------------------------------------------------------
::  Done
:: ------------------------------------------------------------
echo.
echo ============================================================
echo  All done! A restart may be required for changes to take
echo  full effect.
echo ============================================================
echo.
pause

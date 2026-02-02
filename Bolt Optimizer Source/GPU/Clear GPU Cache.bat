@echo off
:: Request admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
title GPU Cache Cleaner
color 0A

:menu
cls
echo ===============================
echo        GPU CACHE CLEANER
echo ===============================
echo.
echo 1. Clear NVIDIA GPU cache
echo 2. Clear AMD GPU cache
echo 3. Clear Intel GPU cache
echo 4. Clear DirectX shader cache (Recommended)
echo 5. Clear ALL GPU caches (Recommended)
echo 6. Exit
echo.
set /p choice=Select an option (1-6): 

if "%choice%"=="1" goto nvidia
if "%choice%"=="2" goto amd
if "%choice%"=="3" goto intel
if "%choice%"=="4" goto dx
if "%choice%"=="5" goto all
if "%choice%"=="6" exit
goto menu

:nvidia
echo Clearing NVIDIA cache...
taskkill /f /im explorer.exe >nul 2>&1
rd /s /q "%LOCALAPPDATA%\NVIDIA\DXCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\NVIDIA\GLCache" >nul 2>&1
rd /s /q "%PROGRAMDATA%\NVIDIA Corporation\NV_Cache" >nul 2>&1
start explorer.exe
pause
goto menu

:amd
echo Clearing AMD cache...
taskkill /f /im explorer.exe >nul 2>&1
rd /s /q "%LOCALAPPDATA%\AMD\DxCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\AMD\GLCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\AMD\VkCache" >nul 2>&1
start explorer.exe
pause
goto menu

:intel
echo Clearing Intel cache...
taskkill /f /im explorer.exe >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Intel\ShaderCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Intel\GfxCache" >nul 2>&1
start explorer.exe
pause
goto menu

:dx
echo Clearing DirectX shader cache...
taskkill /f /im explorer.exe >nul 2>&1
rd /s /q "%LOCALAPPDATA%\D3DSCache" >nul 2>&1
start explorer.exe
pause
goto menu

:all
echo Clearing ALL GPU caches...
taskkill /f /im explorer.exe >nul 2>&1

:: NVIDIA
rd /s /q "%LOCALAPPDATA%\NVIDIA\DXCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\NVIDIA\GLCache" >nul 2>&1
rd /s /q "%PROGRAMDATA%\NVIDIA Corporation\NV_Cache" >nul 2>&1

:: AMD
rd /s /q "%LOCALAPPDATA%\AMD\DxCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\AMD\GLCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\AMD\VkCache" >nul 2>&1

:: Intel
rd /s /q "%LOCALAPPDATA%\Intel\ShaderCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Intel\GfxCache" >nul 2>&1

:: DirectX
rd /s /q "%LOCALAPPDATA%\D3DSCache" >nul 2>&1

:: Temp
rd /s /q "%TEMP%" >nul 2>&1
md "%TEMP%" >nul 2>&1

start explorer.exe
echo Done. Reboot recommended to get the full effect :) , Also your explorer might refresh so the gpu cache is correctly applied.
pause
goto menu

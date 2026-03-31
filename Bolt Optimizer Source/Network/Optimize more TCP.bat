@echo off
echo Disabling heuristics and tuning RSS...

netsh int tcp set heuristics disabled
netsh int tcp set global rss=enabled
netsh int tcp set global rsc=disabled
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" ^
/v DefaultSendWindow /t REG_DWORD /d 65536 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" ^
/v DefaultReceiveWindow /t REG_DWORD /d 65536 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" ^
/v MaxUserPort /t REG_DWORD /d 65534 /f

@echo off
echo Reducing TIME_WAIT delay...

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" ^
/v TcpTimedWaitDelay /t REG_DWORD /d 30 /f

for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"') do (
    reg add "%%i" /v TcpDelAckTicks /t REG_DWORD /d 0 /f >nul 2>&1
)

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" ^
/v "Priority" /t REG_DWORD /d 6 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" ^
/v "Scheduling Category" /t REG_SZ /d "High" /f

powercfg -setacvalueindex SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg -setactive SCHEME_CURRENT

echo Done. Restart required.
pause

echo Done.
pause
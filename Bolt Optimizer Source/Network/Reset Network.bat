@echo off
echo Resetting network stack...

ipconfig /flushdns
ipconfig /release
ipconfig /renew
netsh winsock reset
netsh int ip reset

echo Done. Restart required.
pause
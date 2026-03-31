@echo off
echo Disabling Large Send Offload...

netsh int tcp set global tso=disabled

echo Done.
pause
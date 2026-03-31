@echo off
echo Disabling TCP autotuning...

netsh int tcp set global autotuninglevel=disabled

echo Done.
pause
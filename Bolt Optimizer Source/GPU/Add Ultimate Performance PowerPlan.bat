@echo off
echo Enabling Ultimate Performance mode...

powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 > nul
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

echo Done.
pause
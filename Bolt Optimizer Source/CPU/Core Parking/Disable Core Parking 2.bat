@echo off
echo Disabling CPU core parking...

powercfg -attributes SUB_PROCESSOR CPMINCORES -ATTRIB_HIDE
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100
powercfg -setactive SCHEME_CURRENT

echo Done.
pause
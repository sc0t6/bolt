@echo off
echo Setting high timer resolution...

bcdedit /set useplatformclock true
bcdedit /set disabledynamictick yes

echo Done. Restart required.
pause
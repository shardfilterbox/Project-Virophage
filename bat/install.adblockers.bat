@echo off
color 4f
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
cls
rem end header

echo Adblock Plus for IE
start "" "c:\acr\app\adblockplusie.exe"

goto chrome

:chrome

goto chrome.adblock.plus

:chrome.adblock.plus
if exist "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data\Default\Extensions\cfhdojbkjhnklbpkdaibdccddilifddb" goto skip.chrome.adblock.plus
echo Adblock Plus for Chrome

:install.chrome.adblock.plus
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/adblock-plus/cfhdojbkjhnklbpkdaibdccddilifddb"
if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/adblock-plus/cfhdojbkjhnklbpkdaibdccddilifddb"
if exist "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\Application\chrome.exe" "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/adblock-plus/cfhdojbkjhnklbpkdaibdccddilifddb"
if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "https://chrome.google.com/webstore/detail/adblock-plus/cfhdojbkjhnklbpkdaibdccddilifddb"
goto firefox

:skip.chrome.adblock.plus
echo Adblock Plus for Chrome appears to already be installed

:firefox
echo Adblock Plus for Firefox
if exist "C:\Program Files\Mozilla Firefox\firefox.exe" "C:\Program Files\Mozilla Firefox\firefox.exe" "https://adblockplus.org/en/firefox"
if exist "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" "https://adblockplus.org/en/firefox"
echo (vp) AdBlockers installed on all Browsers (DATE: %date% %time:~0,-6% USER:%USERNAME%)>>%virlog%

:exit
exit

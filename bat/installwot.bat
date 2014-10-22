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


if exist "C:\Program Files\WOT\WOT.dll" goto skip.ie
if exist "C:\Program Files (x86)\WOT\WOT.dll" goto skip.ie

echo WOT for IE
start "" "c:\acr\app\wotie.msi"
goto chrome

:skip.ie
echo WOT for IE appears to already be installed.

:chrome
if exist "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data\Default\Extensions\bhmmomiinigofkjcapegjjndpbikblnp" goto skip.chrome
echo WOT for Chrome

if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" "C:\Program Files\Google\Chrome\Application\chrome.exe" "http://www.mywot.com/"
if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" "http://www.mywot.com/"
if exist "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\Application\chrome.exe" "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\Application\chrome.exe" "http://mywot.com"
if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://www.mywot.com"
goto firefox

:skip.chrome
echo WOT for Chrom appears to already be installed

:firefox
echo WOT for Firefox
if exist "C:\Program Files\Mozilla Firefox\firefox.exe" "C:\Program Files\Mozilla Firefox\firefox.exe" "http://www.mywot.com/"
if exist "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" "http://www.mywot.com/"
echo (vp) WOT installed on all Browsers (DATE: %date% %time:~0,-6% USER:%USERNAME%)>>%virlog%

:exit
exit

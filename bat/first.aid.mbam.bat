REM ===== START HEADER =====
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
for /f "delims=" %%x in (c:\acr\var\os.version.name.var) do set "version=%%x"
cls
REM ===== END HEADER =====

if "%ERRORLEVEL%"=="0" goto exit
%virdir%app\mbam-setup.exe /SP- /SILENT /NOCANCEL

if exist "c:\acr\var\mbam.var" goto exit
if exist "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
if exist "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
if exist "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
tasklist /FI "IMAGENAME eq mbamgui.exe" 2>NUL | find /I /N "mbamgui.exe">NUL


:skip.mbam.install
echo Starting up chrome to get licenses...
echo Login for interns is:
echo user: interns@authorizedcomputers.com
echo pass: !pass1234
echo ========================================
pause
echo.
echo.
start /min %virbat%mbamchrome.bat

echo Paste ID
set /p ID=
echo Paste KEY
set /p KEY=
echo Please wait while Malwarebytes is registered
if exist "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%
if exist "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%
if exist "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%

echo When Malwarebytes opens, please go to 
echo the Protection tab and activate it.
echo Sometimes it does not allow.  I believe
echo that will resolve itself on next boot.
echo ========================================
pause

if exist "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe"
if exist "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe"
if exist "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe"
echo Malware Bytes ID: %ID%  Key: %KEY% >%virvar%mbam.var

:exit
exit
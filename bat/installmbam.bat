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

rem figure out how many license files there are and set to max
setlocal enabledelayedexpansion
dir /b /s /A-d c:\acr\bat\mbm\ | find "" /v /n /c >c:\acr\var\mbm.num.var
set /p max=<c:\acr\var\mbm.num.var
pause
set /a ran = %random% %% %max% + 1

if %ran% lss 10 set ran=0%ran%
if %ran% lss 100 set ran=0%ran%

echo %ran% >c:\acr\var\ran.var
echo %ran%
pause


echo installmbamreg >%virvar%resume.var
if exist "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
if exist "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
if exist "C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" goto skip.mbam.install
%virdir%app\mbam-setup.exe /SP- /SILENT /NOCANCEL

:skip.mbam.install
set ID=4ZN87-J89UE
set KEY=NRKR-2DPD-VDL2-4JUX

if exist "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" start "" "%programfiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%
if exist "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" start "" "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" /register %ID% %KEY%


echo Malware Bytes ID: %ID%  Key: %KEY% >%virvar%mbam.var

pause

:exit

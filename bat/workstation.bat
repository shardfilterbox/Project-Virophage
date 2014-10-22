REM ===== START HEADER =====
@echo off
color 4f
set Virophage.Source = %~dp0
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
for /f "delims=" %%x in (c:\acr\bat\version.var) do set "version=%%x"
cls
REM ===== END HEADER =====

xcopy "%Virophage.Source%bat\*" "c:\acr\bat\" /dsiy
start "Install Latest Version" "c:\acr\bat\install.latest.version.bat"



::detect Virophage Workstation task, and create if it doesn't exist
schtasks /query /tn "Virophage Workstation" | find "Virophage Workstation" > nul
if %errorlevel% == 0 goto virophage.workstation.already.exists
:create task
schtasks /create /tn "Virophage Workstation" /tr "c:\acr\bat\workstation.bat" /sc DAILY /st 06:00:00
start "Virophage Workstation" "c:\acr\bat\workstation.bat"
goto exit
:virophage.workstation.already.exists
cls

echo Scheduled Task OK

::detect evernote tasks, and create if it doesn't exist
schtasks /query /tn "Evernote Morning" | find "Evernote Morning" > nul
if %errorlevel% == 0 goto evernote.morning.already.exists
:create task
schtasks /create /tn "Evernote Morning" /tr "c:\acr\bat\start.evernote.bat" /sc DAILY /st 09:00:00

schtasks /create /tn "Evernote 12" /tr "c:\acr\bat\start.evernote.bat" /sc DAILY /st 12:00:00

schtasks /create /tn "Evernote 4" /tr "c:\acr\bat\start.evernote.bat" /sc DAILY /st 4:00:00


goto exit
:evernote.morning.already.exists
cls


::Update Virophage



:exit
exit
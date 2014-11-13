REM ===== START HEADER =====
@echo off
color 4f
title Virophage.Main.Window
nircmdc win setsize ititle "Virophage.Main.Window" 0 0 650 800
::set windows mode
set windows.mode=Normal
if defined safeboot_option set windows.mode=%safeboot_option%
if NOT %windows.mode%==Normal set windows.mode=Safe
set virdir=C:\acr\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
set logname=ACR%job.number%Log
set virapp=%virdir%app\
set virbat=c:\acr\bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
for /f "delims=" %%x in (c:\acr\var\os.version.name.var) do set "version=%%x"
cls
REM ===== END HEADER =====

:check.computer.name
echo install.gotoassist >%virvar%resume.var
echo Computer Name:%computername%
if %computername:~0,4%==1ACR goto install.gotoassist
echo Computer name does not appear to match the required naming convention.  Please change it to "1ACR-Firstname-Lastname" and then reboot the computer.  It will automatically truncate the name, which is fine.  I will now open system properties for you
pause
sysdm.cpl
goto exit


:install.gotoassist
if not exist c:\acr\app\gotoassist.exe xcopy "c:\acr\app\gotoassist.exe" "C:\acr\app\" /dsiy
start /wait "Install Gotoassist" "c:\acr\app\gotoassist.exe"


:exit
exit
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
echo install.crashplan >%virvar%resume.var
echo I will open the Disk Management for you 
echo to assign the xHD to X:
echo.
echo.
echo Please plug in the xHD before continuing
echo.
echo.
pause
start /wait "" "diskmgmt.msc"
mkdir x:\ACRBackups
echo Created directory X:\ACRBackups
echo.
echo Crashplan will now start installing.
echo .
echo Make sure to use the customers email
echo and phone number, with a default
echo password of 5107867103
echo.
pause

:check.architecture.crashplan
set architecture=%processor_architecture%
echo %architecture%

if NOT "%architecture%"=="%architecture:32=%" goto crashplan.32
if NOT "%architecture%"=="%architecture:86=%" goto crashplan.32
if NOT "%architecture%"=="%architecture:64=%" goto crashplan.64


:set.architecture.crashplan
echo Architecture? (32 or 64)
echo (system variable says %processor_architecture%)
set /p architecture=

goto check.architecture.crashplan

:crashplan.32
	echo Crashplan 32
	%virdir%app\Crashplan32.exe
	goto installed
:crashplan.64
	echo Crashplan 64
	%virdir%app\Crashplan64.exe
	goto installed

:installed

echo Make sure you chose all pertinent data,
echo and backup to the x:\ACRBackups folder.
save




goto exit


:exit
exit
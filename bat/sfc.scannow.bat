REM ===== START HEADER =====
@echo off
color 4f
title Virophage.Main.Window
C:\acr\bat\nircmdc win setsize ititle "System File Checker" 0 0 400 450

::set windows mode
set windows.mode=Normal
if defined safeboot_option set windows.mode=%safeboot_option%
if NOT %windows.mode%==Normal set windows.mode=Safe
rem if %windows.mode%=Safe nircmdc win setsize ititle "Virophage.Main.Window" 0 0 
set virdir=C:\acr\
set virapp=%virdir%app\
set virbat=c:\acr\bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname=ACR %first.name% %last.name% Q%job.number% Log
set virlog="c:\acr\%logname%.txt"
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
for /f "delims=" %%x in (c:\acr\var\os.version.name.var) do set "version=%%x"
cls
REM ===== END HEADER =====


sfc /scannow
pause


:exit
exit
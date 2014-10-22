REM ===== START HEADER =====
title Log.File
nircmdc win setsize ititle "Log.File" 410 0 390 450
::set windows mode
set windows.mode=Normal
if defined safeboot_option set windows.mode=%safeboot_option%
if NOT %windows.mode%==Normal set windows.mode=Safe

@echo off
color 4f
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




:loop
cls
echo %virlog%
========================================
type %virlog%
if not exist %virvar%os.version.number.var goto check.for.main
for /f "delims=" %%x in (%virvar%os.version.number.var) do set "os.version.number=%%x"
if %os.version.number% == 2 goto if.xp
goto if.not.xp

:if.xp
ping 127.0.0.1 -n 10 > nul
goto check.for.main

:if.not.xp
Timeout 10 >nul

:check.for.main
TASKLIST /v | find "Virophage.Main.Window" >nul
IF ERRORLEVEL 1 goto exit
goto loop

:exit
exit
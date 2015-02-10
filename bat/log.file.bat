::Begin Header
::Call header.bat
xcopy "%~dp0bat\header.bat" "c:\acr\bat" /dsiy
set window.name=%~nx0
CALL c:\acr\bat\header.bat %~nx0

set Virophage.Source = %~dp0
set virdir=C:\acr\
set virver=v100
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"

:set.log.name
set logname=ACR %first.name% %last.name% Q%job.number% Log
set virlog="c:\acr\%logname%.txt"

set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
cls
::End Header

C:\acr\bat\nircmdc win setsize 500 0 400 450




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
TASKLIST /v | find "virophage.main.window.bat" >nul
IF ERRORLEVEL 1 goto exit
goto loop

:exit
exit
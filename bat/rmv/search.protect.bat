::Sat 06/07/2014  7:27:25.67
::start.header 
::set.virophage
@echo off
color 4f
set Virophage.Source = %~dp0
if not exist c:\acr\bat\nircmdc.exe xcopy "%Virophage.Source%bat\nircmdc.exe" "c:\acr\bat\*" /dsiy
if "%path%"=="%path:acr=%" setx path "%path%;c:\acr\bat;c:\acr\app" 
CALL :error.log %errorlevel%
::set.windows.mode
set windows.mode=Normal
if defined safeboot_option set windows.mode=%safeboot_option%
if NOT %windows.mode%==Normal set windows.mode=Safe
set virdir=C:\acr\
set virapp=%virdir%app\
set virbat=c:\acr\bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname=ACR%first.name%%last.name%%job.number%
set virlog="c:\acr\%logname%.txt"
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
for /f "delims=" %%x in (c:\acr\var\os.version.name.var) do set "version=%%x"

::set.window
C:\acr\bat\nircmdc win setsize %~nx0 0 0 400 450
%~nx0
rem if %windows.mode%=Safe nircmdc win setsize %~nx0 0 0 

cls
::end.header





taskkill /F /IM "cltmng*" /T

"C:\PROGRA~2\SearchProtect\Main\bin\uninstall.exe" /S


::start.footer Sat 06/07/2014  7:25:23.27 
:error.log
echo %~1
echo %date%,%time% - %~1 >>c:\acr\log\error.log.txt
exit /b 0
main.menu
::end.footer

:exit
exit
::Sat 06/07/2014  7:27:25.67
::Begin Header
::Call header.bat
@echo off

xcopy "%~dp0bat\header.bat" "c:\acr\bat" /dsiy
pause
CALL c:\acr\bat\header.bat %~nx0


set Virophage.Source = %~dp0
set virdir=C:\acr\
set virver=v100
for /f "delims=" %%x in (%virvar%job.number.var) do set "job.number=%%x"
for /f "delims=" %%x in (%virvar%first.name.var) do set "first.name=%%x"
for /f "delims=" %%x in (%virvar%last.name.var) do set "last.name=%%x"
set logname="ACR%job.number%Log"
set virlog="c:\acr\ACR%job.number%Log.txt"

set virapp=%virdir%app\
set virbat=%virdir%bat\
set virzip=%virdir%zip\
set virvar=%virdir%var\
if not exist %virdir%var md %virdir%var
if not exist %virdir%bak md %virdir%bak
cls
::End Header

echo What IP Address or hostname would you like to ping?
set /p ip.address=

:start.ping
ping %ip.address% -t
goto start.ping


::start.footer Sat 06/07/2014  7:25:23.27 
:error.log
echo %~1
echo %date%,%time% - %~1 >>c:\acr\log\error.log.txt
exit /b 0
main.menu
::end.footer

:exit
exit
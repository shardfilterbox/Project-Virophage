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
for /f "delims=" %%x in (c:\acr\bat\version.var) do set "version=%%x"
cls
REM ===== END HEADER =====

if "%~dp0" == "c:\acr\bat" goto run.process

:reopen
xcopy "%~dp0workstation.map.network.drives.bat" c:\acr\bat /dsiy
start "Map Network Drives" "c:\acr\bat\workstation.map.network.drives.bat"
goto exit

:run.process
echo Please close any open connections to the N.A.D.S. or Curupira
pause
net use n: \\66.117.141.46\nads /USER:Guest
net use z: \\66.117.141.39\Curupira\IQP /USER:locrian pl3vus /persistent:yes
pause

:exit
exit
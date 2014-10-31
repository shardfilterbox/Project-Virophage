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